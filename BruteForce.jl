module BruteForce
    using Types

    import Metrics

    function run(numDocs::Int64, M::Matrix{M_Matrix_Int_Type})
        M_dist::Matrix{M_Matrix_Float_Type}  = zeros(numDocs, numDocs)

        println("Brute-force Distance")

        @time M_dist = Metrics.calculate(numDocs, M)

        return M_dist
    end
end
