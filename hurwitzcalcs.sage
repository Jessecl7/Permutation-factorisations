import sys
from sage.all import *

def oneparthurwitz(start, target, l, n):  #A non-recursive program to calculate the number of products of transpositions that equal a given permutation.  This uses the in-built tuple type from Sage.
    facts = []
    G = SymmetricGroup(n)
    transpos = "(1,2)"
    transclass = G.conjugacy_class(G(transpos)).list()
    allfacts = Tuples(transclass, l).list()
    for i in range(len(allfacts)):
        allfacts[i] = tuple(allfacts[i])
        productoffact = start
        currentfact = allfacts[i]
        for j in range(l):
            productoffactprev = G(productoffact)
            productoffact = G(productoffact)*G(currentfact[j])
        #print(productoffact)
        if str(productoffact) == target:
            facts.append(currentfact)
    #print(facts)
    print(str(len(facts)))
    

def monotonehurwitz(start, target, l, n): #A version of the above function that only counts monotone factorisations, which are factorisations with an increasing upper sequence.
    facts = 0
    G = SymmetricGroup(n)
    targetclass = G.conjugacy_class(G(target)).list()
    transpos = "(1,2)"
    transclass = G.conjugacy_class(G(transpos)).list()
    allfacts = Tuples(transclass, l).list()
    cuts = [0]*l
    for i in range(len(allfacts)):
        cut = 100
        allfacts[i] = tuple(allfacts[i])
        productoffact = start
        currentfact = allfacts[i]
        if isincreasing(currentfact):
            for j in range(l):
                productoffactprev = G(productoffact)
                productoffact = G(productoffact)*G(currentfact[j])
                if countcycles(productoffact) > countcycles(productoffactprev):
                    cut = j
            #print(productoffact)
            if G(productoffact) in targetclass:
                facts += 1
                cuts[cut] = cuts[cut]+1
    print(facts)
    print(cuts)
    
    
def countcycles(perm):
    perm = perm.cycle_tuples(singletons=True)
    perm = str(perm)
    return perm.count("(")
    
def isincreasing(nums):
    testseq = [0]*(len(nums))
    for i in range(len(nums)):
        temp = str(nums[i])
        temp = tuple(temp)
        testseq[i] = int(temp[3])
    output = true
    for i in range(len(nums)-1):
        if testseq[i] > testseq[i+1]:
            output = false
    return output

def parkingfacts(targetelt, seq, l, n):  #Outputs all tuples of l transpositions which have product equal to some target element, and a given upper sequence.
    count = 0
    G = SymmetricGroup(n)
    allfacts = []
    nums = []
    for i in range(n):
        nums.append(str(i+1))
    alltuples = Tuples(nums, l)
    alltuples = list(alltuples)
    newalltuples = []
    for i in range(len(alltuples)):
        testtuple = alltuples[i]
        testtuple = list(testtuple)
        #show(testtuple)
        for j in range(len(testtuple)):
            testtuple[j] = int(testtuple[j])
            #print(str(testtuple[j]))
        alltuples[i] = testtuple
        remove = false
        for j in range(len(seq)):
            if testtuple[j] <= seq[j]:
                remove = true
        if remove == false and testtuple not in newalltuples:
            newalltuples.append(testtuple)
    for testtuple in newalltuples:
        testtarget = "()"
        outputfact = ""
        for i in range(l):
            temptranspos = "(" + str(seq[i]) + "," + str(testtuple[i]) + ")"
            outputfact = outputfact+ temptranspos
            testtarget = G(testtarget) * G(temptranspos)
        if str(testtarget) == str(targetelt):
            H=graphs.EmptyGraph()
            for j in range(n):
                H.add_vertex(j+1)
            for i in range(l):
                H.add_edge(seq[i],testtuple[i])
            H.remove_multiple_edges()
            if H.is_connected():
                print(outputfact)
                count += 1
    print(str(count))  