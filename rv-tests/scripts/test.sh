NAMES=$(cat  riscvui-test/rv-tests/build/NAMES.txt)
for i in ${NAMES[@]}; do
  echo "====== TEST FOR $(basename "$i") ======"
  echo '`define FILE_PATH' "\"$i\"" > vsrc/define.v
  make -s TOPNAME=machine sim
done
