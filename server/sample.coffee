Meteor.methods
    generateSamples: (total) ->
        randomDate = (start, end) ->
            new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()))
        getRandom = undefined
        i = undefined
        i = 0
        getRandom = (arr) ->
            randomIndex = undefined
            randomIndex = Math.floor(Math.random() * arr.length)
            arr[randomIndex]

        while i < total
            Visits.insert
                date: randomDate(new Date(2015, 0, 1), new Date())
                pos: getRandom([
                    "ja"
                    "ko"
                    "au"
                    "cn"
                    "hk"
                    "tw"
                    "in"
                    "th"
                    "my"
                    "nz"
                    "sg"
                    "ph"
                    "vn"
                    "id"
                    "asia"
                ])
                channel: getRandom([
                    "seo"
                    "sem"
                    "aff"
                    "tms"
                    "gco"
                    "brand"
                    "app"
                ])
                platform: getRandom([
                    "desk"
                    "mobile"
                    "tablet"
                ])
            i++
