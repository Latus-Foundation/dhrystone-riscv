MEMORY
{
  ram (wxar) : ORIGIN = 0x8000000, LENGTH = 256M
  rom (rx)      : ORIGIN = 0x10000, LENGTH = 2M
}

SECTIONS
{
  .text :
  {
    *(.text)
  } > rom

  .data :
  {
    _global_start = .; /* Define a symbol for the start of the .data section */
    *(.data)
    _global_end = .; /* Define a symbol for the end of the .data section */
  } > ram

  .bss :
  {
    *(.bss)
  } > ram

  .stack :
  {
    . = ALIGN(4);
    _stack_start = .; /* Define a symbol for the start of the .stack section */
    . = . + 0x200000; /* Reserve 8KB for the stack */
    . = ALIGN(4);
    _stack_top = .; /* Define a symbol for the top of the .stack section */
  } > ram
}