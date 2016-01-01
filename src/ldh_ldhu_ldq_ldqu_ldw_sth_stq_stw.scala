package TTA_BasicLoadStore

import Chisel._

case object DataWidth extends Field[Int]
case object AddrWidth extends Field[Int]
case object Latency extends Field[Int]
case object Endian extends Field[String]
case object ModuleNameSuffix extends Field[String]

object ldh_ldhu_ldq_ldqu_ldw_sth_stq_stw {
  val OPC_X    = Bits("b???")
  val OPC_LDH  = UInt(0)
  val OPC_LDHU = UInt(1)
  val OPC_LDQ  = UInt(2)
  val OPC_LDQU = UInt(3)
  val OPC_LDW  = UInt(4)
  val OPC_STH  = UInt(5)
  val OPC_STQ  = UInt(6)
  val OPC_STW  = UInt(7)

  def isLoad(opcode : Bits) = {
    opcode === OPC_LDH  || opcode === OPC_LDHU ||
    opcode === OPC_LDQ  || opcode === OPC_LDQU ||
    opcode === OPC_LDW
  }

  def isStore(opcode : Bits) = {
    opcode === OPC_STH || opcode === OPC_STQ ||
    opcode === OPC_LDQ || opcode === OPC_STW
  }
}

import ldh_ldhu_ldq_ldqu_ldw_sth_stq_stw._

/* TODO: data width currently fixed to 32 bit */
class MemUtils(dataw : Int, endian : String) {
  require(endian == "Big Endian" || endian == "Little Endian")

  def alignMemLoad(data : UInt, size : UInt, addr : UInt) = {
    if (endian == "Big Endian") {
      val value = UInt(width = dataw)
      value := data

      switch (size) {
        is (OPC_LDQU) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(24, UInt(0)), data(31, 24)) }
            is (Bits("b01")) { value := Cat(Fill(24, UInt(0)), data(23, 16)) }
            is (Bits("b10")) { value := Cat(Fill(24, UInt(0)), data(15,  8)) }
            is (Bits("b11")) { value := Cat(Fill(24, UInt(0)), data( 7,  0)) }
          }
        }
        is (OPC_LDQ) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(24, data(31)), data(31, 24)) }
            is (Bits("b01")) { value := Cat(Fill(24, data(23)), data(23, 16)) }
            is (Bits("b10")) { value := Cat(Fill(24, data(15)), data(15,  8)) }
            is (Bits("b11")) { value := Cat(Fill(24, data( 7)), data( 7,  0)) }
          }
        }
        is (OPC_LDHU) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(16, UInt(0)), data(31, 16)) }
            is (Bits("b10")) { value := Cat(Fill(16, UInt(0)), data(15,  0)) }
          }
        }
        is (OPC_LDH) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(16, data(31)), data(31, 16)) }
            is (Bits("b10")) { value := Cat(Fill(16, data(15)), data(15,  0)) }
          }
        }
      }
      value
    } else {
      val value = UInt(width = data.getWidth)
      value := data

      switch (size) {
        is (OPC_LDQU) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(24, UInt(0)), data( 7,  0)) }
            is (Bits("b01")) { value := Cat(Fill(24, UInt(0)), data(15,  8)) }
            is (Bits("b10")) { value := Cat(Fill(24, UInt(0)), data(23, 16)) }
            is (Bits("b11")) { value := Cat(Fill(24, UInt(0)), data(31, 24)) }
          }
        }
        is (OPC_LDQ) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(24, data( 7)), data( 7,  0)) }
            is (Bits("b01")) { value := Cat(Fill(24, data(15)), data(15,  8)) }
            is (Bits("b10")) { value := Cat(Fill(24, data(23)), data(23, 16)) }
            is (Bits("b11")) { value := Cat(Fill(24, data(31)), data(31, 24)) }
          }
        }
        is (OPC_LDHU) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(16, UInt(0)), data(15,  0)) }
            is (Bits("b10")) { value := Cat(Fill(16, UInt(0)), data(31, 16)) }
          }
        }
        is (OPC_LDH) {
          switch (addr) {
            is (Bits("b00")) { value := Cat(Fill(16, data(15)), data(15,  0)) }
            is (Bits("b10")) { value := Cat(Fill(16, data(31)), data(31, 16)) }
          }
        }
      }
      value
    }
  }

  def alignMemStore(data : UInt, size : UInt) = {
    val value = UInt(width = dataw)
    value := data

    /* TODO: check if this violates any memory protocols (e.g. AXI) */
    switch (size) {
      is (OPC_STQ) { value := Fill(4, data( 7, 0)) }
      is (OPC_STH) { value := Fill(2, data(15, 0)) }
    }
    value
  }

  def MemStoreMask(addr : UInt, size : UInt) = {
    if (endian == "Big Endian") {
      val value = UInt(width = 4)
      value := Bits("b1111")

      switch (size) {
        is (OPC_STQ) { value := Bits("b1000") >> addr }
        is (OPC_STH) { value := Bits("b1100") >> addr }
      } 
      value
    } else {
      val value = UInt(width = 4)
      value := Bits("b1111")

      switch (size) {
        is (OPC_STQ) { value := Bits("b0001") << addr }
        is (OPC_STH) { value := Bits("b0011") << addr }
      }
      value
    }
  }
}


class ldh_ldhu_ldq_ldqu_ldw_sth_stq_stw extends Module with UsesParameters {
  val dataw   = params(DataWidth)
  val addrw   = params(AddrWidth)
  val endian  = params(Endian)
  val latency = params(Latency)

  val suffix : String = params(ModuleNameSuffix)
  if (suffix != "") {
    setModuleName(getClass.getName.split('.').last + suffix)
  }

  val io = new Bundle {
    val t1data    = UInt(INPUT,  width = addrw)
    val t1load    = Bool(INPUT)
    val t1opcode  = Bits(INPUT,  width = OPC_X.getWidth)
    val o1data    = UInt(INPUT,  width = dataw)
    val o1load    = Bool(INPUT)
    val r1data    = UInt(OUTPUT, width = dataw)

    val data_in   = UInt(INPUT,  width = dataw)
    val data_out  = UInt(OUTPUT, width = dataw)
    val addr      = UInt(OUTPUT, width = addrw-2)
    val mem_en_x  = Bool(OUTPUT)
    val wr_en_x   = Bool(OUTPUT)
    val wr_mask_x = UInt(OUTPUT, width = dataw)

    val glock     = Bool(INPUT)
  }

  /* just to be compatible with TTA testbench generator */
  io.addr.setName("addr")
  io.data_out.setName("data_out")
  io.data_in.setName("data_in")
  io.mem_en_x.setName("mem_en_x")
  io.wr_en_x.setName("wr_en_x")
  io.wr_mask_x.setName("wr_mask_x")

  class TransferTag extends Bundle {
    val opcode    = Bits(width = OPC_X.getWidth)
    val alignment = Bits(width = 2)
    override def clone: this.type = new TransferTag().asInstanceOf[this.type]
  }

  object TransferTag {
    def apply(oc : Bits, al : Bits) = {
      val v = new TransferTag
      v.opcode    := oc
      v.alignment := al
      v
    }

    def dflt = {
      val reg = new TransferTag
      reg.opcode    := OPC_STW
      reg.alignment := Bits(0)
      reg
    }
  }

  val mem_util         = new MemUtils(dataw, endian)

  val glock_n          = !io.glock
  val transfer_en      = glock_n & io.t1load
  val transfer_tag_en  = Vec(transfer_en, glock_n)
  val transfer_tag_in  = Vec.fill(latency-1){new TransferTag}
  val transfer_tag_pip = Vec.tabulate(latency-1){i => RegEnable(updateData = transfer_tag_in(i), resetData = TransferTag.dflt, enable = transfer_tag_en(i))}
  
  transfer_tag_in.zipWithIndex.foreach{
    case(t, i) => if (i == 0) t := TransferTag(io.t1opcode, io.t1data(1,0)) else t := transfer_tag_pip(i-1)
  }
  
  val o1shadow_reg = RegEnable(updateData = io.o1data,            resetData = UInt(0), enable = glock_n & io.o1load)
  val addr_reg     = RegEnable(updateData = io.t1data(addrw-1,2), resetData = UInt(0), enable = transfer_en)
  val mem_en_reg   = RegEnable(updateData = io.t1load,            resetData = Bits(0), enable = glock_n)
  val wr_en_reg    = RegEnable(updateData = isStore(io.t1opcode), resetData = Bits(0), enable = transfer_en)

  val wr_mask_reg  = RegEnable(updateData = mem_util.MemStoreMask(io.t1data(1,0), io.t1opcode) & Fill(4, isStore(io.t1opcode)), 
                               resetData  = Bits(0), enable = transfer_en)

  val data_out_reg = RegEnable(updateData = mem_util.alignMemStore(Mux(io.o1load, io.o1data, o1shadow_reg), io.t1opcode), 
                               resetData  = UInt(0), enable = transfer_en)

  val rdata_en     = glock_n & isLoad(transfer_tag_pip.last.opcode)
  val rdata_reg    = RegEnable(updateData = mem_util.alignMemLoad(io.data_in, transfer_tag_pip.last.opcode, transfer_tag_pip.last.alignment), 
                               resetData  = UInt(0), enable = rdata_en)

  /* drive module output */
  io.mem_en_x  := !mem_en_reg | io.glock
  io.wr_en_x   := !wr_en_reg
  io.wr_mask_x := Fill(8, ~wr_mask_reg(3)) ## Fill(8, ~wr_mask_reg(2)) ## Fill(8, ~wr_mask_reg(3)) ## Fill(8, ~wr_mask_reg(0))
  io.addr      := addr_reg
  io.data_out  := data_out_reg
  io.r1data    := rdata_reg
}

class DefaultConfig(name : String = "") extends ChiselConfig (
  topDefinitions = { (pname,site,here) => 
    type PF = PartialFunction[Any,Any]
    def findBy(sname:Any):Any = here[PF](site[Any](sname))(pname)
    pname match {
      case DataWidth => Knob("DataWidth")
      case AddrWidth => Knob("AddrWidth")
      case Latency => 3
      case Endian => "Big Endian"
      case ModuleNameSuffix => name
    }
  },
  knobValues = {
    case "DataWidth" => 32
    case "AddrWidth" => 16
  }
)

class has24bitaddr extends ChiselConfig(knobValues = {case "AddrWidth" => 24})

class cfg_32b_16b extends DefaultConfig(name = "_32b_16b")
class cfg_32b_24b extends ChiselConfig(new has24bitaddr ++ new DefaultConfig(name = "_32b_24b"))


object ldh_ldhu_ldq_ldqu_ldw_sth_stq_stw_run {
  def main(args: Array[String]): Unit = {
    chiselMain.run(args, () => new ldh_ldhu_ldq_ldqu_ldw_sth_stq_stw)
  }
}

