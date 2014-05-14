#!/usr/bin/env python
# -*- coding: utf-8 -*-
import webapp2
import json


    
table = {'data':[
{'m':1,'t1':'BRAZIL','t2':'CROATIA','time':'2014-06-12T17:00-03:00'},
{'m':2,'t1':'MEXICO','t2':'CAMEROON','time':'2014-06-13T13:00-03:00'},
{'m':3,'t1':'SPAIN','t2':'NETHERLANDS','time':'2014-06-13T16:00-03:00'},
{'m':50,'t1':'AAAA','t2':'BBBN','time':'2014-05-14T05:58-03:00'},
]}

'''

13 JUN 2014 - 18:00 Local time
GROUP B
Arena Pantanal
Cuiaba
ChileCHILEAustraliaAUSTRALIA
18:00
Saturday 14 June
Change to your time
14 JUN 2014 - 13:00 Local time
GROUP C
Estadio Mineirao
Belo Horizonte
ColombiaCOLOMBIAGreeceGREECE
13:00
14 JUN 2014 - 16:00 Local time
GROUP D
Estadio Castelao
Fortaleza
UruguayURUGUAYCosta RicaCOSTA RICA
16:00
14 JUN 2014 - 18:00 Local time
GROUP D
Arena Amazonia
Manaus
EnglandENGLANDItalyITALY
18:00
14 JUN 2014 - 22:00 Local time
GROUP C
Arena Pernambuco
Recife
Côte d'IvoireCÔTE D'IVOIREJapanJAPAN
22:00
Sunday 15 June
Change to your time
15 JUN 2014 - 13:00 Local time
GROUP E
Estadio Nacional
Brasilia
SwitzerlandSWITZERLANDEcuadorECUADOR
13:00
15 JUN 2014 - 16:00 Local time
GROUP E
Estadio Beira-Rio
Porto Alegre
FranceFRANCEHondurasHONDURAS
16:00
15 JUN 2014 - 19:00 Local time
GROUP F
Maracanã - Estádio Jornalista Mário Filho
Rio De Janeiro
ArgentinaARGENTINABosnia and HerzegovinaBOSNIA AND HERZEGOVINA
19:00
Monday 16 June
Change to your time
16 JUN 2014 - 13:00 Local time
GROUP G
Arena Fonte Nova
Salvador
GermanyGERMANYPortugalPORTUGAL
13:00
16 JUN 2014 - 16:00 Local time
GROUP F
Arena da Baixada
Curitiba
IranIRANNigeriaNIGERIA
16:00
16 JUN 2014 - 19:00 Local time
GROUP G
Estadio das Dunas
Natal
GhanaGHANAUSAUSA
19:00
Tuesday 17 June
Change to your time
17 JUN 2014 - 13:00 Local time
GROUP H
Estadio Mineirao
Belo Horizonte
BelgiumBELGIUMAlgeriaALGERIA
13:00
17 JUN 2014 - 16:00 Local time
GROUP A
Estadio Castelao
Fortaleza
BrazilBRAZILMexicoMEXICO
16:00
17 JUN 2014 - 18:00 Local time
GROUP H
Arena Pantanal
Cuiaba
RussiaRUSSIAKorea RepublicKOREA REPUBLIC
18:00
Wednesday 18 June
Change to your time
18 JUN 2014 - 13:00 Local time
GROUP B
Estadio Beira-Rio
Porto Alegre
AustraliaAUSTRALIANetherlandsNETHERLANDS
13:00
18 JUN 2014 - 16:00 Local time
GROUP B
Maracanã - Estádio Jornalista Mário Filho
Rio De Janeiro
SpainSPAINChileCHILE
16:00
18 JUN 2014 - 18:00 Local time
GROUP A
Arena Amazonia
Manaus
CameroonCAMEROONCroatiaCROATIA
18:00
Thursday 19 June
Change to your time
19 JUN 2014 - 13:00 Local time
GROUP C
Estadio Nacional
Brasilia
ColombiaCOLOMBIACôte d'IvoireCÔTE D'IVOIRE
13:00
19 JUN 2014 - 16:00 Local time
GROUP D
Arena de Sao Paulo
Sao Paulo
UruguayURUGUAYEnglandENGLAND
16:00
19 JUN 2014 - 19:00 Local time
GROUP C
Estadio das Dunas
Natal
JapanJAPANGreeceGREECE
19:00
Friday 20 June
Change to your time
20 JUN 2014 - 13:00 Local time
GROUP D
Arena Pernambuco
Recife
ItalyITALYCosta RicaCOSTA RICA
13:00
20 JUN 2014 - 16:00 Local time
GROUP E
Arena Fonte Nova
Salvador
SwitzerlandSWITZERLANDFranceFRANCE
16:00
20 JUN 2014 - 19:00 Local time
GROUP E
Arena da Baixada
Curitiba
HondurasHONDURASEcuadorECUADOR
19:00
Saturday 21 June
Change to your time
21 JUN 2014 - 13:00 Local time
GROUP F
Estadio Mineirao
Belo Horizonte
ArgentinaARGENTINAIranIRAN
13:00
21 JUN 2014 - 16:00 Local time
GROUP G
Estadio Castelao
Fortaleza
GermanyGERMANYGhanaGHANA
16:00
21 JUN 2014 - 18:00 Local time
GROUP F
Arena Pantanal
Cuiaba
NigeriaNIGERIABosnia and HerzegovinaBOSNIA AND HERZEGOVINA
18:00
Sunday 22 June
Change to your time
22 JUN 2014 - 13:00 Local time
GROUP H
Maracanã - Estádio Jornalista Mário Filho
Rio De Janeiro
BelgiumBELGIUMRussiaRUSSIA
13:00
22 JUN 2014 - 16:00 Local time
GROUP H
Estadio Beira-Rio
Porto Alegre
Korea RepublicKOREA REPUBLICAlgeriaALGERIA
16:00
22 JUN 2014 - 18:00 Local time
GROUP G
Arena Amazonia
Manaus
USAUSAPortugalPORTUGAL
18:00
Monday 23 June
Change to your time
23 JUN 2014 - 13:00 Local time
GROUP B
Arena de Sao Paulo
Sao Paulo
NetherlandsNETHERLANDSChileCHILE
13:00
23 JUN 2014 - 13:00 Local time
GROUP B
Arena da Baixada
Curitiba
AustraliaAUSTRALIASpainSPAIN
13:00
23 JUN 2014 - 17:00 Local time
GROUP A
Estadio Nacional
Brasilia
CameroonCAMEROONBrazilBRAZIL
17:00
23 JUN 2014 - 17:00 Local time
GROUP A
Arena Pernambuco
Recife
CroatiaCROATIAMexicoMEXICO
17:00
Tuesday 24 June
Change to your time
24 JUN 2014 - 13:00 Local time
GROUP D
Estadio das Dunas
Natal
ItalyITALYUruguayURUGUAY
13:00
24 JUN 2014 - 13:00 Local time
GROUP D
Estadio Mineirao
Belo Horizonte
Costa RicaCOSTA RICAEnglandENGLAND
13:00
24 JUN 2014 - 16:00 Local time
GROUP C
Arena Pantanal
Cuiaba
JapanJAPANColombiaCOLOMBIA
16:00
24 JUN 2014 - 17:00 Local time
GROUP C
Estadio Castelao
Fortaleza
GreeceGREECECôte d'IvoireCÔTE D'IVOIRE
17:00
Wednesday 25 June
Change to your time
25 JUN 2014 - 13:00 Local time
GROUP F
Estadio Beira-Rio
Porto Alegre
NigeriaNIGERIAArgentinaARGENTINA
13:00
25 JUN 2014 - 13:00 Local time
GROUP F
Arena Fonte Nova
Salvador
Bosnia and HerzegovinaBOSNIA AND HERZEGOVINAIranIRAN
13:00
25 JUN 2014 - 16:00 Local time
GROUP E
Arena Amazonia
Manaus
HondurasHONDURASSwitzerlandSWITZERLAND
16:00
25 JUN 2014 - 17:00 Local time
GROUP E
Maracanã - Estádio Jornalista Mário Filho
Rio De Janeiro
EcuadorECUADORFranceFRANCE
17:00
Thursday 26 June
Change to your time
26 JUN 2014 - 13:00 Local time
GROUP G
Estadio Nacional
Brasilia
PortugalPORTUGALGhanaGHANA
13:00
26 JUN 2014 - 13:00 Local time
GROUP G
Arena Pernambuco
Recife
USAUSAGermanyGERMANY
13:00
26 JUN 2014 - 17:00 Local time
GROUP H
Arena de Sao Paulo
Sao Paulo
Korea RepublicKOREA REPUBLICBelgiumBELGIUM
17:00
26 JUN 2014 - 17:00 Local time
GROUP H
Arena da Baixada
Curitiba
AlgeriaALGERIARussiaRUSSIA
17:00

ROUND OF 16
Saturday 28 June
Change to your time
28 JUN 2014 - 13:00 Local time
ROUND OF 16
Estadio Mineirao
Belo Horizonte
[1A][2B]
13:00
28 JUN 2014 - 17:00 Local time
ROUND OF 16
Maracanã - Estádio Jornalista Mário Filho
Rio De Janeiro
[1C][2D]
17:00
Sunday 29 June
Change to your time
29 JUN 2014 - 13:00 Local time
ROUND OF 16
Estadio Castelao
Fortaleza
[1B][2A]
13:00
29 JUN 2014 - 17:00 Local time
ROUND OF 16
Arena Pernambuco
Recife
[1D][2C]
17:00
Monday 30 June
Change to your time
30 JUN 2014 - 13:00 Local time
ROUND OF 16
Estadio Nacional
Brasilia
[1E][2F]
13:00
30 JUN 2014 - 17:00 Local time
ROUND OF 16
Estadio Beira-Rio
Porto Alegre
[1G][2H]
17:00
Tuesday 01 July
Change to your time
01 JUL 2014 - 13:00 Local time
ROUND OF 16
Arena de Sao Paulo
Sao Paulo
[1F][2E]
13:00
01 JUL 2014 - 17:00 Local time
ROUND OF 16
Arena Fonte Nova
Salvador
[1H][2G]
17:00
QUARTER-FINALS
Friday 04 July
Change to your time
04 JUL 2014 - 13:00 Local time
QUARTER-FINALS
Maracanã - Estádio Jornalista Mário Filho
Rio De Janeiro
[W53][W54]
13:00
04 JUL 2014 - 17:00 Local time
QUARTER-FINALS
Estadio Castelao
Fortaleza
[W49][W50]
17:00
Saturday 05 July
Change to your time
05 JUL 2014 - 13:00 Local time
QUARTER-FINALS
Estadio Nacional
Brasilia
[W55][W56]
13:00
05 JUL 2014 - 17:00 Local time
QUARTER-FINALS
Arena Fonte Nova
Salvador
[W51][W52]
17:00
SEMI-FINALS
Tuesday 08 July
Change to your time
08 JUL 2014 - 17:00 Local time
SEMI-FINALS
Estadio Mineirao
Belo Horizonte
[W57][W58]
17:00
Wednesday 09 July
Change to your time
09 JUL 2014 - 17:00 Local time
SEMI-FINALS
Arena de Sao Paulo
Sao Paulo
[W59][W60]
17:00
PLAY-OFF FOR THIRD PLACE
Saturday 12 July
Change to your time
12 JUL 2014 - 17:00 Local time
PLAY-OFF FOR THIRD PLACE
Estadio Nacional
Brasilia
[L61][L62]
17:00
FINAL
Sunday 13 July
Change to your time
13 JUL 2014 - 16:00 Local time
FINAL
Maracanã - Estádio Jornalista Mário Filho
Rio De Janeiro
[W61][W62]
16:00
'''


def out_json(c, data):
    c.response.headers['Content-Type'] = 'application/json'   
    c.response.out.write(json.dumps(data))

def out_json_beauty(c, data):
    c.response.headers['Content-Type'] = 'application/json'   
    c.response.out.write(json.dumps(data,indent=4))

class MainHandler(webapp2.RequestHandler):
    def get(self):
        self.response.write('Hello world!')

class GetTable(webapp2.RequestHandler):
    def get(self):
        self.process()
    def post(self):
        self.process()
    def process(self):
        out_json(self, table)


app = webapp2.WSGIApplication([
    ('/', MainHandler),
    ('/get_table', GetTable),
], debug=True)
