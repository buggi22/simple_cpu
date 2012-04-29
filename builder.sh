name="$1"
iverilog -o ${name}_tb ${name}.v ${name}_tb.v -y . && \
vvp ${name}_tb
