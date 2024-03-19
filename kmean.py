import math

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

num_clusters = len(centroids)

def euclidean_distance(point1, point2):
    return math.sqrt(sum((p1 - p2)**2 for p1, p2 in zip(point1, point2)))

def assign_to_clusters(data_points, centroids):
    num_points = len(data_points)
    assignments = [0] * num_points

    for i in range(num_points):
        min_distance = float('inf')
        cluster_assignment = -1

        for j in range(num_clusters):
            distance = euclidean_distance(data_points[i], centroids[j])
            if distance < min_distance:
                min_distance = distance
                cluster_assignment = j

        assignments[i] = cluster_assignment

    return assignments

def calculate_average_distance(data_points, assignments, centroids):
    total_distance = 0.0
    num_points = len(assignments)

    for i in range(num_points):
        cluster_index = assignments[i]
        centroid = centroids[cluster_index]
        total_distance += euclidean_distance(data_points[i], centroid)

    average_distance = total_distance / num_points

    return average_distance

def update_centroids(data_points, assignments, num_clusters):
    updated_centroids = [[0.0, 0.0] for _ in range(num_clusters)]
    cluster_sizes = [0] * num_clusters

    for i in range(len(assignments)):
        cluster_index = assignments[i]
        for dim in range(2):
            updated_centroids[cluster_index][dim] += data_points[i][dim]
        cluster_sizes[cluster_index] += 1

    for j in range(num_clusters):
        if cluster_sizes[j] > 0:
            for dim in range(2):
                updated_centroids[j][dim] /= cluster_sizes[j]

    return updated_centroids

def kmeans(data_points, centroids, num_clusters, max_iterations):
    prev_average_distance = float('inf')

    for iteration in range(1, max_iterations + 1):
        # Assign data points to clusters
        assignments = assign_to_clusters(data_points, centroids)

        # Calculate the average distance for the current assignments
        average_distance = calculate_average_distance(data_points, assignments, centroids)
        print(f"Iteration {iteration} - Average Distance: {average_distance}")

        # Update centroids based on current assignments
        updated_centroids = update_centroids(data_points, assignments, num_clusters)

        # Check for convergence
        if average_distance >= prev_average_distance:
            print("Converged!")
            return assignments, prev_average_distance, centroids

        # Update for the next iteration
        centroids = [list(coord) for coord in updated_centroids]
        prev_average_distance = average_distance

    print("Reached maximum iterations without convergence.")
    return assignments, average_distance, updated_centroids

# Initial assignments, average distance, and centroids
assignments = assign_to_clusters(data_points, centroids)
print(f"First Cluster Assignments: {assignments}")

average_distance = calculate_average_distance(data_points, assignments, centroids)
print(f"First Average Distance: {average_distance}")

centroids = update_centroids(data_points, assignments, num_clusters)
print(f"First Updated Centroids: {centroids}")

# Run k-means algorithm
max_iterations = 100
final_assignments, final_average_distance, final_centroids = kmeans(data_points, centroids, num_clusters, max_iterations)

print("Final Assignments: ", final_assignments)
print("Final Average Distance: ", final_average_distance)
print("Final Centroids: ", final_centroids)
