`define DefaultAddrSize 15
`define DefaultMemAndIOAddrSize 15
`define DefaultProgAddrSize 15
`define DefaultWordSize 16

`define ClockPulseWidth 2

/* ----------------------------------
 * instruction-set constants
 * ---------------------------------- */
`define AddrOrComputeInstructionBit 	15
   /* bits 14 and 13 are unused for "compute" instructions */
`define ARegisterOrMemoryBit		12
`define ControlBit1			11
`define ControlBit2			10
`define ControlBit3			9
`define ControlBit4			8
`define ControlBit5			7
`define ControlBit6			6
`define DestABit			5
`define DestDBit			4
`define DestMBit			3
`define JumpGTBit			2
`define JumpEQBit			1
`define JumpLTBit			0
