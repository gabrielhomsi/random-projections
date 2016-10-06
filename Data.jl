module Data
    using Types
    
    function read(numDocs::Int64)
        print("Reading data...")

        open("data.txt") do data
            M::Matrix{M_Matrix_Int_Type} = zeros(0, 0)

            line::Int64 = 1

            for ln in eachline(data)
                if line == 1
                    # skip
                elseif line == 2
                    d::Int64 = parse(Int64, ln)
                    M        = zeros(d, numDocs)
                    M_dist   = zeros(numDocs, numDocs)
                elseif line == 3
                    # skip
                elseif line >= 4
                    splitted::Array{ASCIIString} = convert(Array{ASCIIString}, split(ln))
                    docId::Int64                 = parse(Int64, splitted[1])
                    wordId::Int64                = parse(Int64, splitted[2])
                    count::M_Matrix_Int_Type     = parse(M_Matrix_Int_Type, splitted[3])

                    if docId > numDocs
                        break
                    end

                    # println("M[$(docId), $(wordId)] = $(count)")

                    M[wordId, docId] = count
                else
                    # println("Finished reading")

                    break
                end

                line += 1
            end

            return M
        end
    end
end
