using AssortiveMatingABM
using Documenter

DocMeta.setdocmeta!(AssortiveMatingABM, :DocTestSetup, :(using AssortiveMatingABM); recursive=true)

makedocs(;
    modules=[AssortiveMatingABM],
    authors="itsdfish <itsdfish@gmail.com> and contributors",
    sitename="AssortiveMatingABM.jl",
    format=Documenter.HTML(;
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
