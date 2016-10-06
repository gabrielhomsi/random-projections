module Metrics
    using Types

    function distance{T<:Number}(X::Array{T}, Y::Array{T})
        return sqrt(sum((X - Y) .^ 2))
    end

    function calculate{T<:Number}(numDocs::Int64, M::Matrix{T})
        M_dist::Matrix{M_Matrix_Float_Type} = zeros(numDocs, numDocs)

        print("Calc. Dist.   ")

        for i in 1:numDocs
             for j in (i + 1):numDocs
                 M_dist[i, j] = distance(M[:, i], M[:, j])
             end
         end

         return M_dist
    end

    function printNoiseData(M_dist::Matrix{M_Matrix_Float_Type}, M_projected_dist::Matrix{M_Matrix_Float_Type})
        numDocs::Int64 = size(M_dist, 1)
        maxNoiseJL::Float64 = 0
        maxNoise::Float64 = 0

        for i in 1:numDocs
            for j in (i + 1):numDocs
                maxNoiseJL = max(maxNoiseJL, abs( ^(M_projected_dist[i, j],2) / ^(M_dist[i, j],2) - 1))
                maxNoise = max(maxNoise, abs(M_projected_dist[i, j] - M_dist[i, j]))
            end
        end

        @printf "maxNoiseJL      = %.5lf\n" maxNoiseJL
        @printf "maxNoise        = %.5lf\n" maxNoise
    end
end
