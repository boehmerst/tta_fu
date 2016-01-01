import Chisel._


object RegEnable
{
  def apply[T <: Data](updateData: T, enable: Bool) = {
    val r = Reg(updateData)
    when (enable) { r := updateData }
    r
  }
  def apply[T <: Data](updateData: T, resetData: T, enable: Bool) = {
    val r = RegInit(resetData)
    when (enable) { r := updateData }
    r
  }
  def apply[T <: Data](updateData: T, resetData: T, enable: Bool, init: Bool) = {
    val r = RegInit(resetData)
    when (enable) { when (init) { r := resetData } .otherwise { r := updateData } }
    r
  }
}

