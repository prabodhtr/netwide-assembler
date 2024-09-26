all: find_largest_in_array read_print_array sort_array sort_array_2

find_largest_in_array:
	nasm -felf find_largest_in_array.asm
	ld -melf_i386 find_largest_in_array.o -o find_largest_in_arra

read_print_array:
	nasm -felf read_print_array.asm
	ld -melf_i386 read_print_array.o -o read_print_array

sort_array:
	nasm -felf sort_array.asm
	ld -melf_i386 sort_array.o -o sort_array

sort_array_2:
	nasm -felf sort_array_2.asm
	ld -melf_i386 sort_array_2.o -o sort_array_2
