module Achlioptas
    using Types

    import Metrics

    function generateProjectionMatrix(k::Int64, d::Int64)
        W::Matrix{W_Matrix_Int_Type} = Matrix{W_Matrix_Int_Type}(k, d)

        print("Generating W  ")

        for i in 1:k
          for j in 1:d
              r = rand()

              if r < 1 / 6
                  W[i, j] = 1
              elseif r < 5 / 6
                  W[i, j] = 0
              else
                  W[i, j] = -1
              end
          end
        end

        return W
    end

    function project(W::Matrix{W_Matrix_Int_Type}, M::Matrix{M_Matrix_Int_Type}, numDocs::Int64)
        M_ach::Matrix{M_Matrix_Float_Type}

        print("Projecting W  ")

        M_ach = *(W, M) * sqrt(3 / size(W, 1))

        return M_ach
    end

    function run(numDocs::Int64, k::Int64, M::Matrix{M_Matrix_Int_Type}, M_dist::Array{M_Matrix_Float_Type})
        d::Int64                         = size(M, 1)
        M_ach::Matrix{M_Matrix_Float_Type}        = Matrix{M_Matrix_Float_Type}(k, numDocs)
        M_ach_dist::Matrix{M_Matrix_Float_Type}   = Matrix{M_Matrix_Float_Type}(numDocs, numDocs)

        println("============ Achlioptas =============")

        @time W::Matrix{W_Matrix_Int_Type} = generateProjectionMatrix(k ,d)

        @time M_ach = project(W, M, numDocs)

        @time M_ach_dist = Metrics.calculate(numDocs, M_ach)

        Metrics.printNoiseData(M_dist, M_ach_dist)
    end
end
