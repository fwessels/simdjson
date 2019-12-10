function report_perf() {
    algorithm=$1
    architecture=$2
    iterations=$3
    for run in {1..2}
    do
        for file in "${@:4}"
        do
            ./parse -f $EXTRAARGS -n $iterations jsonexamples/$file.json | grep "stage 1 instructions" | sed -E "s/stage 1 instructions:\s*([0-9]+)\s+cycles:\s*([0-9]+).+mis. branches:\s*([0-9]+).+/| $architecture | $file | $algorithm | \2 | \1 | \3 |/"
        done
    done
}
git checkout master
make parse
report_perf fastvalidate "$@"

git checkout jkeiser/lookup_arm
make parse
report_perf lookup "$@"

git checkout jkeiser/lookup2
make parse
report_perf lookup2 "$@"
