#!/bin/bash
echo "Welcome to the Guessing Game"

read -p "Who is the President of the USA?"  answer

correct_answer="Trump"


while [ "$answer" != "$correct_answer" ]; do
    read -p "Wrong answer! Who is the President of USA?" answer

done

echo "Great! You are correct $answer is the President!"
