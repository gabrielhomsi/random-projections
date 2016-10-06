push!(LOAD_PATH, ".")

using Types

import Data
import BruteForce
import Metrics
import Achlioptas
import Gaussian

function main()
    srand(1234)

    # numDocs::Int64 = 1000
    numDocs::Int64 = 1000

    @time M::Matrix{M_Matrix_Int_Type} = Data.read(numDocs)

    println()

    M_dist::Matrix{M_Matrix_Float_Type} = BruteForce.run(numDocs, M)

    for i in 1:8
        k = 4 ^ i # k << d

        println("=====================================")

        println("    k = $(k)")

        println("=====================================")

        Achlioptas.run(numDocs, k, M, M_dist)

        println()

        Gaussian.run(numDocs, k, M, M_dist)

        println("")
    end
end

@time main()
