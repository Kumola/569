import csv

file_path = "data/data_with_classes.csv"

matclass1 = []
matclass2 = []
matclass3 = []

with open(file_path, 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        label = int(row['Class'])
        if label == 1:
            matclass1.append(row)
        elif label == 2:
            matclass2.append(row)
        elif label == 3:
            matclass3.append(row)
        else:
            print("Unexpected label:", label)

print(matclass1[0])
print(matclass2[0])
print(matclass3[0])
