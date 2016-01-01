package TTA_BasicAlu
import Chisel._


case object DataWidth extends Field[Int]
case object ShiftWidth extends Field[Int]
case object Latency extends Field[Int]
case object ModuleNameSuffix extends Field[String]

object fu_add_and_eq_gt_gtu_ior_shl_shr_shru_sub_sxhw_sxqw_xor {
  val OPC_ADD  = UInt(0)
  val OPC_AND  = UInt(1)
  val OPC_EQ   = UInt(2)
  val OPC_GT   = UInt(3)
  val OPC_GTU  = UInt(4)
  val OPC_IOR  = UInt(5)
  val OPC_SHL  = UInt(6)
  val OPC_SHR  = UInt(7)
  val OPC_SHRU = UInt(8)
  val OPC_SUB  = UInt(9)
  val OPC_SXHW = UInt(10)
  val OPC_SXQW = UInt(11)
  val OPC_XOR  = UInt(12)
}

import fu_add_and_eq_gt_gtu_ior_shl_shr_shru_sub_sxhw_sxqw_xor._

class fu_add_and_eq_gt_gtu_ior_shl_shr_shru_sub_sxhw_sxqw_xor extends Module with UsesParameters {
  val dataw   = params(DataWidth)
  val shiftw  = params(ShiftWidth)
  val latency = params(Latency)

  val suffix : String = params(ModuleNameSuffix)
  if (suffix != "") {
    setModuleName(getClass.getName.split('.').last + suffix)
  }

  val io = new Bundle {
    val t1data   = UInt(INPUT, dataw)
    val t1opcode = Bits(INPUT, 4)
    val t1load   = Bool(INPUT)
    val o1data   = UInt(INPUT, dataw)
    val o1load   = Bool(INPUT)
    val r1data   = UInt(OUTPUT, dataw)
    val glock    = Bool(INPUT)
  }

  require(latency == 1 || latency == 2)

  def shiftRight(value : UInt, shamt : UInt, padding : Bool) = {
    var shift = value
    for (i <- shiftw-1 to 0 by -1) {
      var size = 1 << i
      shift = Mux(shamt(i), Cat( Fill(size, padding), shift(dataw-1, size) ), shift)
    }
    shift
  }

  def signExtend(value : UInt, sign : Bool, width : Int) = {
    if (width == value.getWidth) { value } else { Cat(Fill(width-value.getWidth, sign), value) }
  }

  /* arithmetic logic unit */
  val alu_a  = UInt(width = dataw)
  val alu_b  = UInt(width = dataw)
  val opcode = Bits(width = 4)

  val sum         = alu_a + Mux(opcode === OPC_ADD, alu_b, -alu_b)

  val shift_in    = Mux(opcode === OPC_SHL, Reverse(alu_a), alu_a)
  val shift_right = shiftRight(shift_in, alu_b, Mux(opcode === OPC_SHR, Bool(true), Bool(false)))
  val shift_left  = Reverse(shift_right)

  val equal       = sum === UInt(0)

  val cmp = 
    Mux(opcode === OPC_EQ, equal,
    Mux(alu_a(dataw-1) === alu_b(dataw-1), !sum(dataw-1) & !equal,
    Mux(opcode === OPC_GTU, !alu_b(dataw-1), !alu_a(dataw-1))))

  val alu_out = 
    Mux(opcode === OPC_ADD || opcode === OPC_SUB,  sum,
    Mux(opcode === OPC_SHR || opcode === OPC_SHRU, shift_right,
    Mux(opcode === OPC_SHL,                        shift_left, 
    Mux(opcode === OPC_AND,                        alu_a & alu_b,
    Mux(opcode === OPC_IOR,                        alu_a | alu_b,
    Mux(opcode === OPC_XOR,                        alu_a ^ alu_b,
    Mux(opcode === OPC_SXQW,                       signExtend(alu_a(7,0), alu_a(7), dataw),
    Mux(opcode === OPC_SXHW,                       signExtend(alu_a(dataw/2-1,0), alu_a(dataw/2-1), dataw),
    /* compare results */                          cmp))))))))


  /* data path logic */
  val t1_en      = !io.glock & io.t1load
  val t1reg      = RegEnable(updateData = io.t1data,   resetData = UInt(0), enable = t1_en)
  val opc1reg    = RegEnable(updateData = io.t1opcode, resetData = UInt(0), enable = t1_en)

  val o1_en      = !io.glock & io.o1load
  val o1reg_in   = 
    if (latency == 2) {
      val o1shadow = RegEnable(updateData = io.o1data, resetData = UInt(0), enable = o1_en)
      Mux(io.o1load, io.t1opcode, o1shadow)
    } else {
      io.o1data
    }

  val o1reg_en   = if (latency == 2) {t1_en} else {o1_en}
  val o1reg      = RegEnable(updateData = o1reg_in, resetData = UInt(0), enable = o1reg_en)

  /* drive arithmetic logic unit */
  alu_a  := t1reg
  alu_b  := o1reg
  opcode := opc1reg

  /* drive module output */
  io.r1data := {if (latency == 2) {
    val r1reg = RegEnable(updateData = alu_out, resetData = UInt(0), 
                          enable = RegEnable(updateData = io.t1load, resetData = Bool(false), enable = !io.glock))
    r1reg
  } else {
    alu_out
  }}
}

class DefaultConfig(name : String = "") extends ChiselConfig (
  topDefinitions = { (pname,site,here) => 
    type PF = PartialFunction[Any,Any]
    def findBy(sname:Any):Any = here[PF](site[Any](sname))(pname)
    pname match {
      case DataWidth => Knob("DataWidth")
      case ShiftWidth => Knob("ShiftWidth")
      case Latency => Knob("Latency")
      case ModuleNameSuffix => name
    }
  },
  knobValues = {
    case "DataWidth" => 32
    case "ShiftWidth" => 5
    case "Latency" => 1
  }
)

class HasLatency2 extends ChiselConfig(knobValues = {case "Latency" =>2})

class cfg_32b_always_1 extends DefaultConfig(name = "_32b_always_1")
class cfg_32b_always_2 extends ChiselConfig(new HasLatency2 ++ new DefaultConfig(name = "_32b_always_2"))

object fu_add_and_eq_gt_gtu_ior_shl_shr_shru_sub_sxhw_sxqw_xor_run {
  def main(args: Array[String]): Unit = {
    chiselMain.run(args, () => new fu_add_and_eq_gt_gtu_ior_shl_shr_shru_sub_sxhw_sxqw_xor)
  }
}

