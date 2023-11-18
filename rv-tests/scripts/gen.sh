mkdir -p build/generate
cp data/* build/generate
NAMES=$(realpath $(find build/generate | grep -E "rv32ui-p-\w+_d.hex"))
rm -rf build/NAMES.txt
for i in ${NAMES[@]}; do
  echo + transfer $(basename $i)
  build/transfer "$i"
  echo "$i" | sed -E "s/_d\.hex//" >> build/NAMES.txt
done
echo + generate main names in $(realpath build/NAMES.txt)
