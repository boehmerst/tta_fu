package TTA_Regfile
import Chisel._

case object DataWidth extends Field[Int]
case object RfSize extends Field[Int]
case object ModuleNameSuffix extends Field[String]


class rf_1wr_1rd_always_1_guarded_0 extends Module with UsesParameters {
  val dataw   = params(DataWidth)
  val rf_size = params(RfSize)

  val io = new Bundle {
    val glock    = Bool(INPUT)
    val r1load   = Bool(INPUT)
    val r1opcode = Bits(INPUT, log2Up(rf_size))
    val t1data   = UInt(INPUT, dataw)
    val t1load   = Bool(INPUT)
    val t1opcode = Bits(INPUT, log2Up(rf_size))
    val r1data   = UInt(OUTPUT, dataw)
    val guard    = Bits(OUTPUT, rf_size)
  }

  val suffix : String = params(ModuleNameSuffix)

  if (suffix != "") {
    setModuleName(getClass.getName.split('.').last + suffix)
  }

  /* TODO: maybe adapt backend to use mem with reset as rocket does?? otherwise use Vec of Reg */
  val rf = Vec.fill(rf_size){ Reg(UInt(width = dataw), init = UInt(0)) } 
  //val rf = Mem(UInt(width = dataw), rf_size)

  when (!io.glock) {
    when (io.t1load) {
      rf(io.t1opcode) := io.t1data
    }
  }

  val guard = rf.zipWithIndex.map {
    case(r, i) => {
      Mux(io.t1load && io.t1opcode === UInt(i), io.t1data, r).orR
    }
  }

  io.r1data := rf(io.r1opcode)
  io.guard  := Vec(guard).toBits
}


class DefaultConfig(name : String = "") extends ChiselConfig (
  topDefinitions = { (pname,site,here) => 
    type PF = PartialFunction[Any,Any]
    def findBy(sname:Any):Any = here[PF](site[Any](sname))(pname)
    pname match {
      case DataWidth => Knob("DataWidth")
      case RfSize => Knob("RfSize")
      case ModuleNameSuffix => name
    }
  },
  knobValues = {
    case "DataWidth" => 32
    case "RfSize" => 16
  }
)

class IsBoolean extends ChiselConfig(knobValues = {case "DataWidth" => 1})
class Has2Entries extends ChiselConfig(knobValues = {case "RfSize" => 2})
class Has5Entries extends ChiselConfig(knobValues = {case "RfSize" => 5})
class Has32Entries extends ChiselConfig(knobValues = {case "RfSize" => 32})

class cfg_32b_5e extends ChiselConfig(new Has5Entries ++ new DefaultConfig("_32b_5e"))
class cfg_32b_16e extends DefaultConfig(name = "_32b_16e")
class cfg_32b_32e extends ChiselConfig(new Has32Entries ++ new DefaultConfig("_32b_32e"))

class cfg_bool_2e extends ChiselConfig(new Has2Entries ++ new IsBoolean ++ new DefaultConfig("_bool_2e"))
class cfg_bool_5e extends ChiselConfig(new Has5Entries ++ new IsBoolean ++ new DefaultConfig("_bool_5e"))
class cfg_bool_16e extends ChiselConfig(new IsBoolean ++ new DefaultConfig("_bool_16e"))
class cfg_bool_32e extends ChiselConfig(new Has32Entries ++ new IsBoolean ++ new DefaultConfig("_bool_32e"))


object rf_1wr_1rd_always_1_guarded_0_run {
  def main(args: Array[String]): Unit = {
    chiselMain.run(args, () => new rf_1wr_1rd_always_1_guarded_0)
  }
}

