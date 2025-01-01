using AssortiveMatingABM
using Documenter

DocMeta.setdocmeta!(
    AssortiveMatingABM,
    :DocTestSetup,
    :(using AssortiveMatingABM);
    recursive = true
)

makedocs(;
    authors = "itsdfish",
    sitename = "AssortiveMatingABM.jl",
    format = Documenter.HTML(
        assets = [
            asset(
            "https://fonts.googleapis.com/css?family=Montserrat|Source+Code+Pro&display=swap",
            class = :css
        )
        ],
        collapselevel = 1
    ),
    modules = [
        AssortiveMatingABM
    # Base.get_extension(AssortiveMatingABM, :TuringExt),  
    ],
    pages = [
        "Home" => "index.md",
        "Example" => "example.md",
        "API" => "api.md"
    ]
)

deploydocs(;
    repo = "github.com/itsdfish/AssortiveMatingABM.jl.git",
    branch = "gh-pages"
)
