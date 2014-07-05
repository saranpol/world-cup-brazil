#!/usr/bin/env python
# -*- coding: utf-8 -*-
import webapp2
import json
import random

    
table = {'data':[
# {'m':1,'t1':'BRAZIL','t2':'CROATIA','time':'2014-06-12T17:00-03:00','winner':1},
# {'m':2,'t1':'MEXICO','t2':'CAMEROON','time':'2014-06-13T13:00-03:00','winner':1},
# {'m':3,'t1':'SPAIN','t2':'NETHERLANDS','time':'2014-06-13T16:00-03:00','winner':2},
# {'m':4,'t1':'CHILE','t2':'AUSTRALIA','time':'2014-06-13T18:00-04:00','winner':1},
# {'m':5,'t1':'COLOMBIA','t2':'GREECE','time':'2014-06-14T13:00-03:00','winner':1},
# {'m':6,'t1':'URUGUAY','t2':'COSTA RICA','time':'2014-06-14T16:00-03:00','winner':2},
# {'m':7,'t1':'ENGLAND','t2':'ITALY','time':'2014-06-14T18:00-04:00','winner':2},
# {'m':8,'t1':'CÔTE D\'IVOIRE','t2':'JAPAN','time':'2014-06-14T22:00-03:00','winner':1},
# {'m':9,'t1':'SWITZERLAND','t2':'ECUADOR','time':'2014-06-15T13:00-03:00','winner':1},
# {'m':10,'t1':'FRANCE','t2':'HONDURAS','time':'2014-06-15T16:00-03:00','winner':1},
# {'m':11,'t1':'ARGENTINA','t2':'BOSNIA AND HERZEGOVINA','time':'2014-06-15T19:00-03:00','winner':1},
# {'m':12,'t1':'GERMANY','t2':'PORTUGAL','time':'2014-06-16T13:00-03:00','winner':1},
# {'m':13,'t1':'IRAN','t2':'NIGERIA','time':'2014-06-16T16:00-03:00','winner':1},
# {'m':14,'t1':'GHANA','t2':'USA','time':'2014-06-16T19:00-03:00','winner':2},
# {'m':15,'t1':'BELGIUM','t2':'ALGERIA','time':'2014-06-17T13:00-03:00','winner':1},
# {'m':16,'t1':'BRAZIL','t2':'MEXICO','time':'2014-06-17T16:00-03:00','winner':1},
# {'m':17,'t1':'RUSSIA','t2':'KOREA REPUBLIC','time':'2014-06-17T18:00-04:00','winner':0},
# {'m':18,'t1':'AUSTRALIA','t2':'NETHERLANDS','time':'2014-06-18T13:00-03:00','winner':2},
# {'m':19,'t1':'SPAIN','t2':'CHILE','time':'2014-06-18T16:00-03:00','winner':1},
# {'m':20,'t1':'CAMEROON','t2':'CROATIA','time':'2014-06-18T18:00-04:00','winner':2},
# {'m':21,'t1':'COLOMBIA','t2':'CÔTE D\'IVOIRE','time':'2014-06-19T13:00-03:00','winner':2},
# {'m':22,'t1':'URUGUAY','t2':'ENGLAND','time':'2014-06-19T16:00-03:00','winner':2},
# {'m':23,'t1':'JAPAN','t2':'GREECE','time':'2014-06-19T19:00-03:00','winner':0},
# {'m':24,'t1':'ITALY','t2':'COSTA RICA','time':'2014-06-20T13:00-03:00','winner':1},
# {'m':25,'t1':'SWITZERLAND','t2':'FRANCE','time':'2014-06-20T16:00-03:00','winner':2},
# {'m':26,'t1':'HONDURAS','t2':'ECUADOR','time':'2014-06-20T19:00-03:00','winner':1},
# {'m':27,'t1':'ARGENTINA','t2':'IRAN','time':'2014-06-21T13:00-03:00','winner':1},
# {'m':28,'t1':'GERMANY','t2':'GHANA','time':'2014-06-21T16:00-03:00','winner':1},
# {'m':29,'t1':'NIGERIA','t2':'BOSNIA AND HERZEGOVINA','time':'2014-06-21T18:00-04:00','winner':1},
# {'m':30,'t1':'BELGIUM','t2':'RUSSIA','time':'2014-06-22T13:00-03:00','winner':0},
# {'m':31,'t1':'KOREA REPUBLIC','t2':'ALGERIA','time':'2014-06-22T16:00-03:00','winner':1},
# {'m':32,'t1':'USA','t2':'PORTUGAL','time':'2014-06-22T18:00-04:00','winner':2},
#{'m':33,'t1':'NETHERLANDS','t2':'CHILE','time':'2014-06-23T13:00-03:00','winner':1},
#{'m':34,'t1':'AUSTRALIA','t2':'SPAIN','time':'2014-06-23T13:00-03:00','winner':2},
#{'m':35,'t1':'CAMEROON','t2':'BRAZIL','time':'2014-06-23T17:00-03:00','winner':2},
#{'m':36,'t1':'CROATIA','t2':'MEXICO','time':'2014-06-23T17:00-03:00','winner':0},
#{'m':37,'t1':'ITALY','t2':'URUGUAY','time':'2014-06-24T13:00-03:00','winner':1},
#{'m':38,'t1':'COSTA RICA','t2':'ENGLAND','time':'2014-06-24T13:00-03:00','winner':2},
#{'m':39,'t1':'JAPAN','t2':'COLOMBIA','time':'2014-06-24T16:00-04:00','winner':1},
#{'m':40,'t1':'GREECE','t2':'CÔTE D\'IVOIRE','time':'2014-06-24T17:00-03:00','winner':1},
#{'m':41,'t1':'NIGERIA','t2':'ARGENTINA','time':'2014-06-25T13:00-03:00','winner':0},
#{'m':42,'t1':'BOSNIA AND HERZEGOVINA','t2':'IRAN','time':'2014-06-25T13:00-03:00','winner':1},
#{'m':43,'t1':'HONDURAS','t2':'SWITZERLAND','time':'2014-06-25T16:00-04:00','winner':1},
#{'m':44,'t1':'ECUADOR','t2':'FRANCE','time':'2014-06-25T17:00-03:00','winner':2},
#{'m':45,'t1':'PORTUGAL','t2':'GHANA','time':'2014-06-26T13:00-03:00','winner':1},
#{'m':46,'t1':'USA','t2':'GERMANY','time':'2014-06-26T13:00-03:00','winner':2},
#{'m':47,'t1':'KOREA REPUBLIC','t2':'BELGIUM','time':'2014-06-26T17:00-03:00','winner':1},
#{'m':48,'t1':'ALGERIA','t2':'RUSSIA','time':'2014-06-26T17:00-03:00','winner':0},
#{'m':49,'t1':'BRAZIL','t2':'CHILE','time':'2014-06-28T13:00-03:00','winner':1},
#{'m':50,'t1':'COLOMBIA','t2':'URUGUAY','time':'2014-06-28T17:00-03:00','winner':1},
#{'m':51,'t1':'NETHERLANDS','t2':'MEXICO','time':'2014-06-29T13:00-03:00','winner':1},
#{'m':52,'t1':'COSTA RICA','t2':'GREECE','time':'2014-06-29T17:00-03:00','winner':2},
#{'m':53,'t1':'FRANCE','t2':'NIGERIA','time':'2014-06-30T13:00-03:00','winner':1},
{'m':54,'t1':'GERMANY','t2':'ALGERIA','time':'2014-06-30T17:00-03:00','winner':2},
{'m':55,'t1':'ARGENTINA','t2':'SWITZERLAND','time':'2014-07-01T13:00-03:00','winner':2},
{'m':56,'t1':'BELGIUM','t2':'USA','time':'2014-07-01T17:00-03:00','winner':1},
{'m':57,'t1':'FRANCE','t2':'GERMANY','time':'2014-07-04T13:00-03:00','winner':1},
{'m':58,'t1':'BRAZIL','t2':'COLOMBIA','time':'2014-07-04T17:00-03:00','winner':2},
{'m':59,'t1':'ARGENTINA','t2':'BELGIUM','time':'2014-07-05T13:00-03:00','winner':1},
{'m':60,'t1':'NETHERLANDS','t2':'COSTA RICA','time':'2014-07-05T17:00-03:00','winner':2},
{'m':61,'t1':'BRAZIL','t2':'GERMANY','time':'2014-07-08T17:00-03:00','winner':1},
{'m':62,'t1':'[W59]','t2':'ARGENTINA','time':'2014-07-09T17:00-03:00','winner':2},
{'m':63,'t1':'[L61]','t2':'[L62]','time':'2014-07-12T17:00-03:00','winner':2},
{'m':64,'t1':'[W61]','t2':'[W62]','time':'2014-07-13T16:00-03:00','winner':1},
]}




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


class GetStar(webapp2.RequestHandler):
    def get(self):
        self.process()
    def post(self):
        self.process()
    def process(self):
    	star = [{'name':'Alexis Sanchez','url':'http://world-cup-brazil.appspot.com/images/Alexis-Sanchez.jpg'},
    	{'name':'Andrea Pirlo','url':'http://world-cup-brazil.appspot.com/images/Andrea-Pirlo.jpg'},
    	{'name':'Andres Iniesta','url':'http://world-cup-brazil.appspot.com/images/Andres-Iniesta.jpg'},
    	{'name':'Antonio Valencia','url':'http://world-cup-brazil.appspot.com/images/Antonio-Valencia.jpg'},
    	{'name':'Arjen Robben','url':'http://world-cup-brazil.appspot.com/images/Arjen-Robben.jpg'},
    	{'name':'Bastian Schweinsteiger','url':'http://world-cup-brazil.appspot.com/images/Bastian-Schweinsteiger.jpg'},
    	{'name':'Claudio Marchisio','url':'http://world-cup-brazil.appspot.com/images/Claudio-Marchisio.jpg'},
    	{'name':'Cristiano Ronaldo','url':'http://world-cup-brazil.appspot.com/images/Cristiano-Ronaldo.jpg'},
    	{'name':'Daniel Sturridge','url':'http://world-cup-brazil.appspot.com/images/Daniel-Sturridge.jpg'},
    	{'name':'Danny Welbeck','url':'http://world-cup-brazil.appspot.com/images/Danny-Welbeck.jpg'},
    	{'name':'David Luiz','url':'http://world-cup-brazil.appspot.com/images/David-Luiz.jpg'},
    	{'name':'Didier Drogba','url':'http://world-cup-brazil.appspot.com/images/Didier-Drogba.jpg'},
    	{'name':'Fernando Torres','url':'http://world-cup-brazil.appspot.com/images/Fernando-Torres.jpg'},
    	{'name':'Gerard Pique','url':'http://world-cup-brazil.appspot.com/images/Gerard-Pique.jpg'},
    	{'name':'Gervinho','url':'http://world-cup-brazil.appspot.com/images/Gervinho.jpg'},
    	{'name':'Hulk','url':'http://world-cup-brazil.appspot.com/images/Hulk.jpg'},
    	{'name':'Iker Casillas','url':'http://world-cup-brazil.appspot.com/images/Iker-Casillas.jpg'},
    	{'name':'Javier Hernandez','url':'http://world-cup-brazil.appspot.com/images/Javier-Hernandez.jpg'},
    	{'name':'Karim Benzema','url':'http://world-cup-brazil.appspot.com/images/Karim-Benzema.jpg'},
    	{'name':'Keisuke Honda','url':'http://world-cup-brazil.appspot.com/images/Keisuke-Honda.jpg'},
    	{'name':'Kyle Beckerman','url':'http://world-cup-brazil.appspot.com/images/Kyle-Beckerman.jpg'},
    	{'name':'Lionel Messi','url':'http://world-cup-brazil.appspot.com/images/Lionel-Messi.jpg'},
    	{'name':'Luis Suarez','url':'http://world-cup-brazil.appspot.com/images/Luis-Suarez.jpg'},
    	{'name':'Luka Modric','url':'http://world-cup-brazil.appspot.com/images/Luka-Modric.jpg'},
    	{'name':'Lukas Podolski','url':'http://world-cup-brazil.appspot.com/images/Lukas-Podolski.jpg'},
    	{'name':'Marcelo','url':'http://world-cup-brazil.appspot.com/images/Marcelo.jpg'},
    	{'name':'Marco Reus','url':'http://world-cup-brazil.appspot.com/images/Marco-Reus.jpg'},
    	{'name':'Mario Balotelli','url':'http://world-cup-brazil.appspot.com/images/Mario-Balotelli.jpg'},
    	{'name':'Mario Gotze','url':'http://world-cup-brazil.appspot.com/images/Mario-Gotze.jpg'},
    	{'name':'Marouane Fellaini','url':'http://world-cup-brazil.appspot.com/images/Marouane-Fellaini.jpg'},
    	{'name':'Mesut Ozil','url':'http://world-cup-brazil.appspot.com/images/Mesut-Ozil.jpg'},
    	{'name':'Michael Essien','url':'http://world-cup-brazil.appspot.com/images/Michael-Essien.jpg'},
    	{'name':'Neymar','url':'http://world-cup-brazil.appspot.com/images/Neymar.jpg'},
    	{'name':'Olivier Giroud','url':'http://world-cup-brazil.appspot.com/images/Olivier-Giroud.jpg'},
    	{'name':'Pepe','url':'http://world-cup-brazil.appspot.com/images/Pepe.jpg'},
    	{'name':'Raheem Sterling','url':'http://world-cup-brazil.appspot.com/images/Raheem-Sterling.jpg'},
    	{'name':'Robin Van Persie','url':'http://world-cup-brazil.appspot.com/images/Robin-Van-Persie.jpg'},
    	{'name':'Romelu Lukaku','url':'http://world-cup-brazil.appspot.com/images/Romelu-Lukaku.jpg'},
    	{'name':'Sergio Aguero','url':'http://world-cup-brazil.appspot.com/images/Sergio-Aguero.jpg'},
    	{'name':'Shinji Kagawa','url':'http://world-cup-brazil.appspot.com/images/Shinji-Kagawa.jpg'},
    	{'name':'Steven Gerrard','url':'http://world-cup-brazil.appspot.com/images/Steven-Gerrard.jpg'},
    	{'name':'Tim Cahill','url':'http://world-cup-brazil.appspot.com/images/Tim-Cahill.jpg'},
    	{'name':'Wayne Rooney','url':'http://world-cup-brazil.appspot.com/images/Wayne-Rooney.jpg'},
    	{'name':'Wesley Sneijder','url':'http://world-cup-brazil.appspot.com/images/Wesley-Sneijder.jpg'},
    	]
        out_json(self, random.choice(star))



app = webapp2.WSGIApplication([
    ('/', MainHandler),
    ('/get_table', GetTable),
    ('/get_star', GetStar),
], debug=True)
