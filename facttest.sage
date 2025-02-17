import sys
from sage.all import *

#A recursive program that counts the number of tuples of a given number of transpositions that have a certain cycle type.

def checkclass(conjclasselt, cycleno, testset, n):
    G = SymmetricGroup(n)
    C = G.conjugacy_class(G(conjclasselt)).set()
    Clen = len(C)
    testlen = len(testset)
    for i in range(testlen):
        testset[i] = G(testset[i])
    factno = cycleno
    occur = [0] * Clen
    occurmax = [0] * Clen
    listone = [0] * factno
   
    recur(listone, 0, factno, testlen, G, testset, C, Clen, occur, occurmax, n)
    
    for i in range(Clen):
        occur[i] = str(occur[i])+" transitive factorisations of "+str(C[i])
        occurmax[i] = str(occurmax[i])+" of these have each symbol occuring at most twice "+str(C[i])
    return occur + occurmax   

def recur(eltlist, k, factno, testlen, G, testset, C, Clen, occur, occurmax, n):
      
    if k < factno:
        for l in range(testlen):
            temp = eltlist
            temp[k] = testset[l]
            recur(temp, k+1, factno, testlen, G, testset, C, Clen, occur, occurmax, n)
    else:
        testelt = "1"
        for i in range(len(eltlist)):
            testelt = G(testelt)*G(eltlist[i])
        for i in range(Clen):
            if testelt == C[i]:
                H=graphs.EmptyGraph()
                for j in range(n):
                    H.add_vertex(j+1)
                for k in range(len(eltlist)):
                    edge = str(eltlist[k])
                    edge = tuple(edge)
                    H.add_edge(int(edge[1]),int(edge[3]))
                H.remove_multiple_edges()
                #if H.size() == testlen:
                if H.is_connected():
                    #H.show()
                    occur[i] = occur[i] + 1
                    j=0
                    while j < len(testset):
                        if eltlist.count(testset[j]) > 2:
                            break
                        else:
                            j = j+1
                            if j == len(testset):
                                occurmax[i] += 1
                        
                    #print(eltlist)                   
                                  
    return

#A slightly altered version which gives all the factorisations of a given element

def factofeltdouble(conjclasselt, cycleno, testset, n):
    G = SymmetricGroup(n)
    elt = conjclasselt
    testlen = len(testset)
    for i in range(testlen):
        testset[i] = G(testset[i])
    factno = cycleno
    listone = [0] * factno
    startset = G.conjugacy_class(G(elt))
    recurdub(listone, 0, factno, testlen, G, testset, n, elt, startset)     
    return

def recurdub(eltlist, k, factno, testlen, G, testset, n, elt, startset):      
    if k < factno:
        for l in range(testlen):
            temp = eltlist
            temp[k] = testset[l]
            recurdub(temp, k+1, factno, testlen, G, testset, n, elt, startset)
    else:
        for testelt in startset:
            starttestelt = testelt
            for i in range(len(eltlist)):
                testelt = G(testelt)*G(eltlist[i])
            #print(testelt)
            #print("and " + elt)
            if str(testelt) == str(elt):
                #print("hi")
                H=graphs.EmptyGraph()
                for j in range(n):
                    H.add_vertex(j+1)
                for k in range(len(eltlist)):
                    edge = str(eltlist[k])
                    edge = tuple(edge)
                    H.add_edge(int(edge[1]),int(edge[3]))
                if H.is_connected():
                    #show(eltlist)
                    factstr = ""
                    for l in range(len(eltlist)):
                        factstr = factstr + " " + str(eltlist[l])                            
                    print(str(starttestelt) + factstr)
    return                     
