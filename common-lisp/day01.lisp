(defpackage advent-of-code-2022
  (:use :cl)
  (:export day1))
(in-package :advent-of-code-2022)

(defun read-elves (stream)
    (let ((elves '()))
        (loop for line = (read-line stream nil :eof)
                  until (eq line :eof)
                  if (or (null elves) (= (length line) 0))
                  do (push '() elves)
                  if (> (length line) 0)
                  do (push (parse-integer line) (car elves)))
        elves))

(defun sum (lst)
    (reduce '+ lst))

(defun part1 (elves)
    (loop for calories in (mapcar 'sum elves) maximizing calories))

(defun part2 (elves)
    (sum (subseq (sort (mapcar 'sum elves) '>) 0 3)))

(defun day1 (file-path)
  (with-open-file (stream file-path)
        (let ((elves (read-elves stream)))
            (print (part1 elves))
            (print (part2 elves)))))