QUERY='(cat:hep-ex+AND+cat:cs.CV)+OR+(cat:hep-ex+AND+cat:cs.AI)+OR+(cat:hep-ex+AND+cat:cs.LG)+OR+(cat:hep-ex+AND+cat:cs.NE)+OR+(cat:hep-ex+AND+cat:stat.ML)+OR+(cat:nucl-ex+AND+cat:cs.CV)+OR+(cat:nucl-ex+AND+cat:cs.AI)+OR+(cat:nucl-ex+AND+cat:cs.LG)+OR+(cat:nucl-ex+AND+cat:cs.NE)+OR+(cat:nucl-ex+AND+cat:stat.ML)+OR+(cat:hep-ph+AND+cat:cs.CV)+OR+(cat:hep-ph+AND+cat:cs.AI)+OR+(cat:hep-ph+AND+cat:cs.LG)+OR+(cat:hep-ph+AND+cat:cs.NE)+OR+(cat:hep-ph+AND+cat:stat.ML)+OR+(hep-lat+AND+cat:cs.CV)+OR+(hep-lat+AND+cat:cs.AI)+OR+(hep-lat+AND+cat:cs.LG)+OR+(hep-lat+AND+cat:cs.NE)+OR+(hep-lat+AND+cat:stat.ML)+OR+(cat:physics.data-an+AND+cat:cs.CV)+OR+(cat:physics.data-an+AND+cat:cs.AI)+OR+(cat:physics.data-an+AND+cat:cs.LG)+OR+(cat:physics.data-an+AND+cat:cs.NE)+OR+(cat:physics.data-an+AND+cat:stat.ML)+OR+(cat:astro-ph.HE+AND+cat:cs.CV)+OR+(cat:astro-ph.HE+AND+cat:cs.AI)+OR+(cat:astro-ph.HE+AND+cat:cs.LG)+OR+(cat:astro-ph.HE+AND+cat:cs.NE)+OR+(cat:astro-ph.HE+AND+cat:stat.ML)+OR+ti:jet+OR+ti:"heavy+flavour"+OR+all:beauty+OR+all:charm'

QUERY2='(ti:jet+AND+ti:flavour)+OR+((all:beauty+OR+all:charm)+AND+cat:nucl-ex)'


Q_PHYS_ML="((cat:hep-ex+AND+cat:cs.CV)+OR+(cat:hep-ex+AND+cat:cs.AI)+OR+(cat:hep-ex+AND+cat:cs.LG)+OR+(cat:hep-ex+AND+cat:cs.NE)+OR+(cat:hep-ex+AND+cat:stat.ML)+OR+(cat:nucl-ex+AND+cat:cs.CV)+OR+(cat:nucl-ex+AND+cat:cs.AI)+OR+(cat:nucl-ex+AND+cat:cs.LG)+OR+(cat:nucl-ex+AND+cat:cs.NE)+OR+(cat:nucl-ex+AND+cat:stat.ML)+OR+(cat:hep-ph+AND+cat:cs.CV)+OR+(cat:hep-ph+AND+cat:cs.AI)+OR+(cat:hep-ph+AND+cat:cs.LG)+OR+(cat:hep-ph+AND+cat:cs.NE)+OR+(cat:hep-ph+AND+cat:stat.ML)+OR+(hep-lat+AND+cat:cs.CV)+OR+(hep-lat+AND+cat:cs.AI)+OR+(hep-lat+AND+cat:cs.LG)+OR+(hep-lat+AND+cat:cs.NE)+OR+(hep-lat+AND+cat:stat.ML)+OR+(cat:physics.data-an+AND+cat:cs.CV)+OR+(cat:physics.data-an+AND+cat:cs.AI)+OR+(cat:physics.data-an+AND+cat:cs.LG)+OR+(cat:physics.data-an+AND+cat:cs.NE)+OR+(cat:physics.data-an+AND+cat:stat.ML)+OR+(cat:astro-ph.HE+AND+cat:cs.CV)+OR+(cat:astro-ph.HE+AND+cat:cs.AI)+OR+(cat:astro-ph.HE+AND+cat:cs.LG)+OR+(cat:astro-ph.HE+AND+cat:cs.NE)+OR+(cat:astro-ph.HE+AND+cat:stat.ML))"

Q_HF_JETS="((ti:jet+OR+abs:jet)+AND+(ti:flavo+OR+abs:flavo))"

Q_LHC_JETS="((all:ALICE+OR+all:ATLAS+OR+all:CMS+OR+all:LHCb+OR+all:LHC)+AND+abs:jet)"

Q_LHC_HIC="((all:ATLAS+OR+all:CMS+OR+all:LHCb)+AND+((all:heavy+AND+all:ion+OR+all:heavy-ion)+OR+(all:Pb+OR+all:Au)))"

Q_HEP_HIC="((cat:hep-ex+OR+cat:hep-ph)+AND+(cat:nucl-ex))"

#QUERY="${Q_HF_JETS}+OR+${Q_LHC_JETS}+OR+${Q_LHC_HIC}+OR+${Q_HEP_HIC}"

python fetch_papers.py --results-per-iteration 50 --max-index 200 --search-query $Q_HF_JETS 
python fetch_papers.py --results-per-iteration 50 --max-index 200 --search-query $Q_LHC_HIC
python fetch_papers.py --results-per-iteration 50 --max-index 200 --search-query $Q_LHC_JETS
python fetch_papers.py --results-per-iteration 50 --max-index 200 --search-query $Q_HEP_HIC
python fetch_papers.py --results-per-iteration 50 --max-index 200 --search-query $Q_PHYS_ML

python download_pdfs.py
python parse_pdf_to_text.py
python thumb_pdf.py
python analyze.py
python buildsvm.py
python make_cache.py

echo "\n\n\n Starting mongo... \n\n\n"
sudo service mongod start

date
python serve.py
