#!/bin/bash

W=$(curl -s https://wttr.in/Manaus?format="%t\n" | head -n 3)
echo "$W"
