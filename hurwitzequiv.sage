import sys
from sage.all import *

#Various programs which test the 'equivalence' of various permutation factorisations.

def equivfacts(startelts, targetelt, n, factlen):
    totalfacts = 0
    equivfacts = 0
    G = SymmetricGroup(n)
    transpos = "(1,2)"
    testelts = G.conjugacy_class(G(transpos)).list()
    startset = G.conjugacy_class(G(startelts)).list() 
    allfacts = Tuples(testelts, factlen).list()
    for k in range(len(startset)):
        distinctfacts = []
        for i in range(len(allfacts)):
            productoffact = startset[k]
            currentfact = allfacts[i]
            for j in range(factlen):
                productoffact = G(productoffact)*G(currentfact[j])
            if str(productoffact) == str(targetelt):
                totalfacts += 1
                currentfactset = set(currentfact)
                if currentfactset not in distinctfacts:
                    distinctfacts.append(currentfactset)
                    #show(currentfactset)
                    #show(startset[k])
        equivfacts += len(distinctfacts)
    print(str(equivfacts))
    print(str(totalfacts))
    
    
def equivswapfacts(startelts, targetelt, n, factlen):
    totalfacts = 0
    equivfacts = 0
    G = SymmetricGroup(n)
    transpos = "(1,2)"
    testelts = G.conjugacy_class(G(transpos)).list()
    startset = G.conjugacy_class(G(startelts)).list() 
    allfacts = Tuples(testelts, factlen).list()
    for k in range(len(startset)):
        distinctfacts = []
        for i in range(len(allfacts)):
            productoffact = startset[k]
            currentfact = allfacts[i]
            for j in range(factlen):
                productoffact = G(productoffact)*G(currentfact[j])
            if str(productoffact) == str(targetelt):
                totalfacts += 1
                if len(distinctfacts) != 0:
                    for i in range(len(distinctfacts)):
                        if testifswapequiv(currentfact, distinctfacts[i], n) == true:
                            break
                        if i == len(distinctfacts) - 1:
                            distinctfacts.append(currentfact)
                        #show(currentfactset)
                        #show(startset[k])
                else:
                    distinctfacts.append(currentfact)
        equivfacts += len(distinctfacts)
        #show(distinctfacts)
        #print(str(startset[k]))
    print(str(equivfacts))
    print(str(totalfacts))
    
def testifswapequiv(a, b, n):
    output = true
    for i in range(len(a)):
        a[i] = str(a[i])
        b[i] = str(b[i])
    for i in range(n):
        testa = []
        testb = []
        for j in range(len(a)):
            if str(i+1) in a[j]:
                testa.append(a[j])
            if str(i+1) in b[j]:
                testb.append(b[j])
        if testa != testb:
            output = false
            break
    return output
        
        
    
    