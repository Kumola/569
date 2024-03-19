using CSV
using DataFrames
#using PrettyTables

file_path="data/data_with_classes.csv"
df = CSV.read(file_path, DataFrame)

global matclass1=[]
global matclass2=[]
global matclass3=[]

for row in eachrow(df)
    
    class = row.Class  
    if class == 1
        push!(matclass1, row)
    elseif class == 2
        push!(matclass2, row)
    elseif class == 3
        push!(matclass3, row)
    else
        println("Unexpected label: ", class)
    end
end

println(matclass1[1])
println(matclass2[1])
println(matclass3[1])