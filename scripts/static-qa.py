#!/usr/bin/env python3
from pathlib import Path
import csv, re, sys
ROOT = Path(__file__).resolve().parents[1]
errors=[]; notes=[]
def require(cond,msg):
    if not cond: errors.append(msg)
require((ROOT/'README.md').is_file(),'missing root README.md')
chapters=sorted((ROOT/'chapters').glob('ch[0-9][0-9].sql'))
require(len(chapters)==24,f'expected 24 chapter SQL files, found {len(chapters)}')
for n in range(1,25):
    require((ROOT/'chapters'/f'ch{n:02d}.sql').is_file(),f'missing chapters/ch{n:02d}.sql')
    require((ROOT/'exercises/questions'/f'ch{n:02d}.md').is_file(),f'missing question file ch{n:02d}.md')
    require((ROOT/'exercises/solutions'/f'ch{n:02d}.md').is_file(),f'missing solution file ch{n:02d}.md')
csv_files=sorted((ROOT/'datasets/marketledger').glob('*.csv'))
require(len(csv_files)==13,f'expected 13 MarketLedger CSV tables, found {len(csv_files)}')
schema=(ROOT/'database/postgresql/schema/001_marketledger_schema.sql').read_text(encoding='utf-8')
for table in ['branches','employees','customers','suppliers','categories','products','supplier_products','orders','order_items','payments','inventory_movements','deliveries','returns']:
    require(re.search(rf'CREATE\s+TABLE\s+{re.escape(table)}\b',schema,re.I) is not None,f'schema missing table {table}')
for path in ROOT.rglob('*.sql'):
    text=path.read_text(encoding='utf-8')
    require('orders.total_amount' not in text.lower(),f'unsupported orders.total_amount in {path.relative_to(ROOT)}')
    require(text.endswith('\n'),f'file lacks final newline: {path.relative_to(ROOT)}')
prohibited_terms=['O'+'CP','N'+'IIT']
for term in prohibited_terms:
    for path in ROOT.rglob('*'):
        if path.is_file() and '.git' not in path.parts and path.resolve() != Path(__file__).resolve():
            try: text=path.read_text(encoding='utf-8')
            except UnicodeDecodeError: continue
            require(re.search(rf'\b{re.escape(term)}\b',text,re.I) is None,f'prohibited provider/credential term {term} in {path.relative_to(ROOT)}')
unsafe_delete=re.compile(r'^\s*DELETE\s+FROM\s+[A-Za-z_][A-Za-z0-9_]*\s*;\s*$',re.I|re.M)
for path in chapters:
    require(unsafe_delete.search(path.read_text(encoding='utf-8')) is None,f'unrestricted DELETE in {path.relative_to(ROOT)}')
seed=(ROOT/'database/postgresql/seed/001_marketledger_seed.sql').read_text(encoding='utf-8')
for table in ['branches','employees','customers','suppliers','categories','products','orders','order_items','payments','inventory_movements','deliveries','returns']:
    require(f"pg_get_serial_sequence('{table}'" in seed,f'seed does not advance identity sequence for {table}')
inv=ROOT/'docs/quality/manuscript-sql-inventory.csv'
require(inv.is_file(),'missing manuscript SQL inventory')
if inv.is_file():
    with inv.open(encoding='utf-8',newline='') as f: rows=list(csv.DictReader(f))
    require(len(rows)>0,'manuscript SQL inventory is empty')
    represented={int(r['chapter']) for r in rows}
    missing=sorted(set(range(1,25))-represented)
    notes.append(f'manuscript SQL blocks inventoried: {len(rows)}')
    notes.append(f'chapters with no fenced SQL in manuscript (conceptual text is allowed): {missing}')
if errors:
    print('STATIC QA: FAIL')
    for e in errors: print('ERROR:',e)
    for n in notes: print('NOTE:',n)
    sys.exit(1)
print('STATIC QA: PASS')
for n in notes: print('NOTE:',n)
