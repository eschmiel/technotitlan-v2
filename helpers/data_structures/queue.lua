function createQueue()
    local queue = { count=0 }

    function queue:enqueue(value)
        local newLink = createLink(value)
        if(not self.first) then 
            self.first = newLink
            self.last = newLink
        else 
            self.last.nextLink = newLink
            self.last = newLink
        end

        self.count+=1
    end

    function queue:dequeue()
        local first = self.first
        self.first = first.nextLink

        self.count-=1
        
        return first.value
    end

    return queue
end