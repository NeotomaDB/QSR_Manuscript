import csv
import requests
import sys

args = sys.argv

fout = args[1]

print "Writing Neotoma scrape to file: " + fout

f = open(fout, 'w')

writer = csv.writer(f, lineterminator = "\n")

datasets = requests.get("http://api.neotomadb.org/v1/data/datasets").json()

sets = datasets['data']

print "Got sets"

for ds in sets:
    dsid = ds['DatasetID']
    endpoint = "http://api.neotomadb.org/v1/data/downloads/" + str(dsid)
    try:
        dwnld = requests.get(endpoint).json()
        dat = dwnld['data']
        taxa = len(dat[0]['Samples'][0]['SampleData'])
        levels = len(dat[0]['Samples'])
        occs = levels*taxa
        date = dat[0]['NeotomaLastSub']
        t = dat[0]['DatasetType']
        s = [dsid, levels, taxa, occs, date, t]
    except Exception as e:
        s = [dsid, 0, 0, 0, "1/1/1970", e]
        print str(e)
    writer.writerow(s)
    print s

print "[[[END PROCESS]]]"