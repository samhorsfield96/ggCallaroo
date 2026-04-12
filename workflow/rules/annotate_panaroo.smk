rule annotate_dna_CDS:
    """Propagate bakta_proteins annotations to panaroo CDS output files."""
    input:
        bakta_tsv=config["output_dir"] + "/bakta_proteins/proteins.tsv",
        pan_ref=config["output_dir"] + "/panaroo/pan_genome_reference.fa",
    output:
        config["output_dir"] + "/annotated/combined_DNA_CDS.fasta"
    params:
        panaroo_dir=config["output_dir"] + "/panaroo",
        output_type="dna_cds",
    log:
        config["output_dir"] + "/logs/annotate_panaroo_dna_CDS.log",
    threads: 1
    conda:
        "envs/bakta.yaml"
    shell:
        "python ../scripts/annotate_panaroo.py --bakta_tsv {input.bakta_tsv} --output {output} --logfile {log} --output_type {params.output_type} --panaroo_dir {params.panaroo_dir}"

rule annotate_panaroo:
    """Propagate bakta_proteins annotations onto all key panaroo output files."""
    input:
        bakta_tsv=config["output_dir"] + "/bakta_proteins/proteins.tsv",
        pan_ref=config["output_dir"] + "/panaroo/pan_genome_reference.fa",
    output:
        pan_ref=config["output_dir"] + "/annotated/pan_genome_reference.fa",
        dna_cds=config["output_dir"] + "/annotated/combined_DNA_CDS.fasta",
        prot_cds=config["output_dir"] + "/annotated/combined_protein_CDS.fasta",
        gene_data=config["output_dir"] + "/annotated/gene_data.csv",
        gpa=config["output_dir"] + "/annotated/gene_presence_absence.csv",
        gpa_roary=config["output_dir"] + "/annotated/gene_presence_absence_roary.csv",
        gml=config["output_dir"] + "/annotated/final_graph.gml",
    params:
        panaroo_dir=config["output_dir"] + "/panaroo",
    log:
        config["output_dir"] + "/logs/annotate_panaroo.log",
    conda:
        "envs/bakta.yaml"
    script:
        "../scripts/annotate_panaroo.py"
