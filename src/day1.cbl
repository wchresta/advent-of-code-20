       identification division.
       program-id. day1.
       author. Wanja Chresta.
       date-written. 12-JAN-2025.

       environment division.
       input-output section.
       file-control.
           select input-file assign to 'inputs/day1'
               organization is line sequential.

       data division.
       file section.
       fd input-file.
       01 input-record.
          05 input-number pic 9(4).

       working-storage section.
       01 numbers-class.
           05 numbers-el pic 9(4)
              occurs 200 times indexed by numbers-idx.
       01 finder-class.
           05 lower-idx   pic 9(3).
           05 upper-idx   pic 9(3).
           05 lower-bound pic 9(3).
           05 sum-result  pic 9(4).
           05 prod-result pic 9(9).
           05 found       pic x(1) value 'n'.
       01 end-of-file  pic x(1) value 'n'.

       procedure division.
           open input input-file.
           perform read-num until end-of-file = 'Y'.
           close input-file.
           perform find-200.
           stop run.

       read-num.
           read input-file
               at end move 'y' to end-of-file
               not at end perform store-element
           end-read.

       store-element.
           move input-number to numbers-el(numbers-idx)
           compute numbers-idx = numbers-idx + 1.

       find-200.
           perform varying lower-idx
                   from 1 by 1 until lower-idx > 199 or found = 'y'

               add 1 to lower-idx giving lower-bound
               perform varying upper-idx from lower-bound
                           by 1 until upper-idx > 200 or found = 'y'
                   add numbers-el(lower-idx) to numbers-el(upper-idx)
                           giving sum-result
                   if sum-result = 2020
                       move 'y' to found
                       exit perform
                   end-if
               end-perform
           end-perform.

           multiply numbers-el(lower-idx) by numbers-el(upper-idx)
               giving prod-result.

           display "found sum 2020, product: " prod-result.
