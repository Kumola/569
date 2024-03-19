data_points = [
    [2.0, 5.0],
    [3.0, 2.0],
    [3.0, 3.0],
    [3.0, 4.0],
    [4.0, 3.0],
    [4.0, 4.0],
    [6.0, 3.0],
    [6.0, 4.0],
    [6.0, 6.0],
    [7.0, 2.0],
    [7.0, 5.0],
    [7.0, 6.0],
    [7.0, 7.0],
    [8.0, 6.0],
    [8.0, 7.0]
]

centroids = [
    [2.0, 2.0],
    [4.0, 6.0],
    [6.0, 5.0],
    [8.0, 8.0]
]

num_clusters = length(centroids)
#---------------------------------------------------------------------

#---------------------------------------------------------------------
function euclidean_distance(point1, point2)
return sqrt(sum((point1 .- point2).^2))
end
#---------------------------------------------------------------------

#---------------------------------------------------------------------
function assign_to_clusters(data_points, centroids)
num_points = size(data_points, 1)
assignments = zeros(Int, num_points)

for i in 1:num_points
    min_distance = Inf
    cluster_assignment = -1

    for j in 1:num_clusters
        distance = euclidean_distance(data_points[i], centroids[j])
        if distance < min_distance
            min_distance = distance
            cluster_assignment = j
        end
    end

    assignments[i] = cluster_assignment
end

return assignments
end
#---------------------------------------------------------------------

#---------------------------------------------------------------------
function calculate_average_distance(data_points, assignments, centroids)
    total_distance = 0.0
    num_points = length(assignments)
    
    for i in 1:num_points
        cluster_index = assignments[i]
        centroid = centroids[cluster_index]
        total_distance += euclidean_distance(data_points[i], centroid)
    end
    
    average_distance = total_distance / num_points
    
    return average_distance
end
#---------------------------------------------------------------------

#---------------------------------------------------------------------
function update_centroids(data_points, assignments, num_clusters)
    updated_centroids = zeros(Float64, num_clusters, 2)
    cluster_sizes = zeros(Int, num_clusters)
    
    for i in 1:length(assignments)
        cluster_index = assignments[i]
        updated_centroids[cluster_index, :] .+= data_points[i]
        cluster_sizes[cluster_index] += 1
    end
    
    for j in 1:num_clusters
        if cluster_sizes[j] > 0
            updated_centroids[j] /= cluster_sizes[j]
        end
    end
    
    return updated_centroids
end
#---------------------------------------------------------------------

#---------------------------------------------------------------------
function kmeans(data_points, centroids, num_clusters, max_iterations)
    prev_average_distance = average_distance
    
    for iteration in 1:max_iterations
        # Assign data points to clusters
        assignments = assign_to_clusters(data_points, centroids)
        
        # Calculate the average distance for the current assignments
        average_distance = calculate_average_distance(data_points, assignments, centroids)
        println("Iteration $iteration - Average Distance: $average_distance")
        
        # Update centroids based on current assignments
        updated_centroids = update_centroids(data_points, assignments, num_clusters)
        
        # Check for convergence 
        if average_distance >= prev_average_distance
        	println("Converged!")
            return assignments, prev_average_distance, centroids
        end
        
        # Update for the next iteration
        centroids = copy(updated_centroids)
        prev_average_distance = average_distance
    end
    
    println("Reached maximum iterations without convergence.")
    return assignments, average_distance, updated_centroids
end
#---------------------------------------------------------------------

#---------------------------------------------------------------------

assignments = assign_to_clusters(data_points, centroids)
println("First Cluster Assignments: $assignments")

average_distance = calculate_average_distance(data_points, assignments, centroids)
println("First Average Distance: $average_distance")

centroids = update_centroids(data_points, assignments, num_clusters)
println("First updated centroids: $centroids")

max_iterations = 100
# Run k-means algorithm
final_assignments, final_average_distance, final_centroids = kmeans(data_points, centroids, num_clusters, max_iterations, tolerance)

println("Final Assignments: ", final_assignments)
println("Final Average Distance: ", final_average_distance)
println("Final Centroids: ", final_centroids)