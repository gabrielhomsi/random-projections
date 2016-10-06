module Gaussian
    using Types
    using Distributions

    import Metrics

    function generateProjectionMatrix(numDocs::Int64, k::Int64, d::Int64)
        W::Matrix{W_Matrix_Float_Type} = Matrix{W_Matrix_Float_Type}(k, d)

        print("Generating W  ")

        dist = Normal(0.0, 1.0 / sqrt(k))

        for i in 1:k
            for j in 1:d
                W[i, j] = rand(dist)
            end
        end

        return W
    end

    function project(W::Matrix{W_Matrix_Float_Type}, M::Matrix{M_Matrix_Int_Type})
        M_gauss::Matrix{M_Matrix_Float_Type}

        print("Projecting W  ")

        M_gauss = *(W, M)

        return M_gauss
    end


    function run(numDocs::Int64, k::Int64, M::Matrix{M_Matrix_Int_Type}, M_dist::Array{M_Matrix_Float_Type})
        d::Int64                           = size(M, 1)
        M_gauss::Matrix{M_Matrix_Float_Type}        = Matrix{M_Matrix_Float_Type}(k, numDocs)
        M_gauss_dist::Matrix{M_Matrix_Float_Type}   = Matrix{M_Matrix_Float_Type}(numDocs, numDocs)

        println("============ Gaussian   =============")

        @time W::Matrix{W_Matrix_Float_Type} = generateProjectionMatrix(numDocs, k, d)

        @time M_gauss = project(W, M)

        @time M_gauss_dist = Metrics.calculate(numDocs, M_gauss)

        Metrics.printNoiseData(M_dist, M_gauss_dist)
    end
end
