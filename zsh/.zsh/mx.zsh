function mx {
    subcommand=$1 
    if [[ $subcommand == "code" ]]; then
        searchTerm=$2
        results=$(gh api "search/code?q=$searchTerm+in:file+org:maxsystems")

        gh api --method=GET search/code -f \
        q="$searchTerm org:maxsystems" \
        --jq '.items[] | [.repository.full_name,.path,.sha] | @tsv'
    elif [[ $subcommand == "repos" ]]; then
        topic=$2
        results=$(gh search repos --owner=maxsystems --topic=$topic)
        echo $results
    fi
}
