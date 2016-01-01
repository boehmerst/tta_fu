// See LICENSE for license details.

package Chisel

class TTABackend extends VerilogBackend {
  val resetIdentifier = "negedge"

  override def emitRegs(c: Module): StringBuilder = {
    val res        = new StringBuilder
    val clkDomains = (c.clocks map (_ -> new StringBuilder)).toMap
    val resets     = c.resets.values.toList

    c.nodes.zipWithIndex foreach { case(m, i) => m.clock match {
      case Some(clk) if clkDomains contains clk =>
        val (hasReset, resetName, dom) = emitReg(m, resets)
        if(!dom.isEmpty) {
          val reset = { if(hasReset) " or " + resetIdentifier + " " + resetName else "" }
          res.append("  always @(posedge " + emitRef(clk) + reset + ") begin\n")
          res.append(dom)
          res.append("  end\n")
        }
      case _ => 
    }}
    res
  }

  def emitReg(node: Node, resets: List[Node]): (Boolean, String, String) = {
    var hasReset    : Boolean = false
    var resetName   : String  = new String

    def emitCond(node: Node) = {
      val resetList = resets.filter(x => x.name == node.name)
      if(!resetList.isEmpty) {
        hasReset = true
        resetName = node.name
        if (resetIdentifier == "posedge") emitRef(node) else "!" + emitRef(node) /* is reset condition */
      } else {
        emitRef(node) /* not a reset condition */
      }
    }

    val res = node match {
      case reg: Reg =>
        def cond(c: Node) = List("if(", emitCond(c), ") begin").mkString
        def uncond = "begin"
        def sep = "\n      "
        def assign(r: Reg, x: Node) = List(emitRef(r), " <= ", emitRef(x), ";\n").mkString
        def traverseMuxes(r: Reg, x: Node): List[String] = x match {
          case m: Mux => (cond(m.inputs(0)) + sep + assign(r, m.inputs(1))) :: traverseMuxes(r, m.inputs(2))
          case _ => if (x eq r) Nil else List(uncond + sep + assign(r, x))
        }
        reg.next match { 
          case _: Mux =>  
            List("    ", traverseMuxes(reg, reg.next) mkString "    end else ", "    end\n").mkString
          case _ => 
            List("    ", assign(reg, reg.next)).mkString
        }

      case m: MemWrite if m.mem.isInline => List(
        "    if (", emitRef(m.cond), ")\n",
        "      ", emitRef(m.mem), "[", emitRef(m.addr), "] <= ", emitRef(m.data), ";\n").mkString

      case _ =>
        ""
    }
    (hasReset, resetName, res)
  }
}

class TTAActiveHighBackend extends TTABackend {
  override val resetIdentifier = "posedge"
}


