##process bar
library(pbapply)



#extract_text_from_html <- function(df, html_column_name, new_column_name) {
#   # Function to extract text from HTML content
#   extract_text <- function(html_text) {
#     parsed_html <- read_html(html_text)
#     
#     
#     
#     #follwoing siblings 
#     # Extracting section titles containing the word "Leben"
#     section_title <- parsed_html %>%
#       html_nodes(xpath = "//h2[span[contains(@class, 'mw-headline')]]")
#     
#     # Extracting section texts for sections containing the word "Leben"
#     relevant_paragraphs <- list()
#     
#     for (title in section_title) {
#       current_text <- parsed_html %>%
#         html_nodes(xpath = paste("//span[@class='mw-headline' and text()='", title, "']/following::p", sep = "")) %>%
#         html_text() %>%
#         toString() # Convert to character
#       # Remove comma between paragraphs
#       current_text <- gsub(", $", "", current_text)
#       section_texts[[title]] <- current_text
#     }
#     
#     # Concatenate the section texts
#     concatenated_text <- unlist(section_texts)
#     return(paste(concatenated_text, collapse = "\n"))
#   }
#   
#   # Apply the extract_text function to each row of the data frame
#   df[[new_column_name]] <- sapply(df[[html_column_name]], extract_text)
#   
#   return(df)
# }
#   
#   # Apply the extract_text function to each row of the data frame
#   df[[new_column_name]] <- sapply(df[[html_column_name]], extract_text)
#   
#   return(df)
# }


df <- head(deu_html_text,10)




# html_text <- '<div class="mw-content-ltr mw-parser-output" lang="de" dir="ltr"><p><b>Achim Großmann</b> (* <a href="/wiki/17._April" title="17. April">17. April</a> <a href="/wiki/1947" title="1947">1947</a> in <a href="/wiki/Aachen" title="Aachen">Aachen</a>; † <a href="/wiki/14._April" title="14. April">14. April</a> <a href="/wiki/2023" title="2023">2023</a> in <a href="/wiki/W%C3%BCrselen" title="Würselen">Würselen</a><sup id="cite_ref-1" class="reference"><a href="#cite_note-1">&#91;1&#93;</a></sup>) war ein <a href="/wiki/Deutschland" title="Deutschland">deutscher</a> <a href="/wiki/Politiker" title="Politiker">Politiker</a> (<a href="/wiki/Sozialdemokratische_Partei_Deutschlands" title="Sozialdemokratische Partei Deutschlands">SPD</a>). Er war von 1998 bis 2009 <a href="/wiki/Parlamentarischer_Staatssekret%C3%A4r" title="Parlamentarischer Staatssekretär">Parlamentarischer Staatssekretär</a> beim <a href="/wiki/Bundesministerium_f%C3%BCr_Verkehr,_Bau-_und_Wohnungswesen" class="mw-redirect" title="Bundesministerium für Verkehr, Bau- und Wohnungswesen">Bundesminister für Verkehr, Bau- und Wohnungswesen</a> bzw. ab 2005 <a href="/wiki/Bundesministerium_f%C3%BCr_Verkehr,_Bau_und_Stadtentwicklung" class="mw-redirect" title="Bundesministerium für Verkehr, Bau und Stadtentwicklung">Bundesminister für Verkehr, Bau und Stadtentwicklung</a>. </p> <div id="toc" class="toc" role="navigation" aria-labelledby="mw-toc-heading"><input type="checkbox" role="button" id="toctogglecheckbox" class="toctogglecheckbox" style="display:none" /><div class="toctitle" lang="de" dir="ltr"><h2 id="mw-toc-heading">Inhaltsverzeichnis</h2><span class="toctogglespan"><label class="toctogglelabel" for="toctogglecheckbox"></label></span></div> <ul> <li class="toclevel-1 tocsection-1"><a href="#Leben_und_Beruf"><span class="tocnumber">1</span> <span class="toctext">Leben und Beruf</span></a></li> <li class="toclevel-1 tocsection-2"><a href="#Partei"><span class="tocnumber">2</span> <span class="toctext">Partei</span></a></li> <li class="toclevel-1 tocsection-3"><a href="#Abgeordneter"><span class="tocnumber">3</span> <span class="toctext">Abgeordneter</span></a></li> <li class="toclevel-1 tocsection-4"><a href="#Öffentliche_Ämter"><span class="tocnumber">4</span> <span class="toctext">Öffentliche Ämter</span></a></li> <li class="toclevel-1 tocsection-5"><a href="#Kabinette"><span class="tocnumber">5</span> <span class="toctext">Kabinette</span></a></li> <li class="toclevel-1 tocsection-6"><a href="#Veröffentlichungen"><span class="tocnumber">6</span> <span class="toctext">Veröffentlichungen</span></a></li> <li class="toclevel-1 tocsection-7"><a href="#Auszeichnungen"><span class="tocnumber">7</span> <span class="toctext">Auszeichnungen</span></a></li> <li class="toclevel-1 tocsection-8"><a href="#Weblinks"><span class="tocnumber">8</span> <span class="toctext">Weblinks</span></a></li> <li class="toclevel-1 tocsection-9"><a href="#Einzelnachweise"><span class="tocnumber">9</span> <span class="toctext">Einzelnachweise</span></a></li> </ul> </div> <h2><span class="mw-headline" id="Leben_und_Beruf">Leben und Beruf</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=1" title="Abschnitt bearbeiten: Leben und Beruf" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=1" title="Quellcode des Abschnitts bearbeiten: Leben und Beruf"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <p>Nach dem <a href="/wiki/Abitur" title="Abitur">Abitur</a> 1966 am <a href="/wiki/Kaiser-Karls-Gymnasium" title="Kaiser-Karls-Gymnasium">Kaiser-Karls-Gymnasium</a> in Aachen absolvierte Großmann ein Studium der <a href="/wiki/Psychologie" title="Psychologie">Psychologie</a> an der <a href="/wiki/RWTH_Aachen" title="RWTH Aachen">TH Aachen</a>, welches er 1972 als Diplom-Psychologe beendete. Er war dann bis 1986 als Erziehungsberater an der Beratungsstelle für Eltern, Kinder und Jugendliche in <a href="/wiki/Alsdorf" title="Alsdorf">Alsdorf</a> tätig, seit 1979 als deren Leiter. Parallel dazu hat er einige Semester als Dozent für Verwaltungspsychologie an der Fachhochschule für öffentliche Verwaltung in Aachen gearbeitet. </p><p>Achim Großmann war geschieden und hatte zwei Kinder. </p> <h2><span class="mw-headline" id="Partei">Partei</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=2" title="Abschnitt bearbeiten: Partei" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=2" title="Quellcode des Abschnitts bearbeiten: Partei"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <p>Seit 1971 war er Mitglied der SPD. Von 1982 bis 1996 war er Vorsitzender des SPD-Unterbezirks <a href="/wiki/Kreis_Aachen" title="Kreis Aachen">Kreis Aachen</a> und gehörte von 1983 bis 1995 dem SPD-Bezirksvorstand Mittelrhein an. </p> <h2><span class="mw-headline" id="Abgeordneter">Abgeordneter</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=3" title="Abschnitt bearbeiten: Abgeordneter" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=3" title="Quellcode des Abschnitts bearbeiten: Abgeordneter"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <p>Von 1975 bis 1998 war Großmann Ratsherr der Stadt <a href="/wiki/W%C3%BCrselen" title="Würselen">Würselen</a>. </p><p>Von 1987 bis 2009 war er <a href="/wiki/Mitglied_des_Deutschen_Bundestages" title="Mitglied des Deutschen Bundestages">Mitglied des Deutschen Bundestages</a>. Hier gehörte er von 1991 bis 1998 als wohnungspolitischer Sprecher dem Vorstand der SPD-<a href="/wiki/Fraktion_(Bundestag)" title="Fraktion (Bundestag)">Bundestagsfraktion</a> an. </p><p>Achim Großmann war stets als direkt gewählter Abgeordneter des <a href="/wiki/Wahlkreis" title="Wahlkreis">Wahlkreises</a> <a href="/wiki/Bundestagswahlkreis_Kreis_Aachen" class="mw-redirect" title="Bundestagswahlkreis Kreis Aachen">Kreis Aachen</a> in den <a href="/wiki/Deutscher_Bundestag" title="Deutscher Bundestag">Bundestag</a> eingezogen. Bei der <a href="/wiki/Bundestagswahl_2005" title="Bundestagswahl 2005">Bundestagswahl 2005</a> erreichte er hier 46,0&#160;% der <a href="/wiki/Erststimme" title="Erststimme">Erststimmen</a>. Bei der <a href="/wiki/Bundestagswahl_2009" title="Bundestagswahl 2009">Bundestagswahl 2009</a> bewarb sich Großmann nicht mehr um ein Mandat.<sup id="cite_ref-verkehrsrundschau_2-0" class="reference"><a href="#cite_note-verkehrsrundschau-2">&#91;2&#93;</a></sup> </p> <h2><span id=".C3.96ffentliche_.C3.84mter"></span><span class="mw-headline" id="Öffentliche_Ämter">Öffentliche Ämter</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=4" title="Abschnitt bearbeiten: Öffentliche Ämter" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=4" title="Quellcode des Abschnitts bearbeiten: Öffentliche Ämter"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <p>Nach der <a href="/wiki/Bundestagswahl_1998" title="Bundestagswahl 1998">Bundestagswahl 1998</a> wurde er am 27. Oktober 1998 als Parlamentarischer Staatssekretär beim Bundesminister für Verkehr, Bau- und Wohnungswesen in die von <a href="/wiki/Bundeskanzler_(Deutschland)" title="Bundeskanzler (Deutschland)">Bundeskanzler</a> <a href="/wiki/Gerhard_Schr%C3%B6der" title="Gerhard Schröder">Gerhard Schröder</a> geführte <a href="/wiki/Bundesregierung_(Deutschland)" title="Bundesregierung (Deutschland)">Bundesregierung</a> berufen. Nach Bildung der <a href="/wiki/Gro%C3%9Fe_Koalition" title="Große Koalition">Großen Koalition</a> unter Bundeskanzlerin <a href="/wiki/Angela_Merkel" title="Angela Merkel">Angela Merkel</a> wurde das Ministerium umbenannt in Bundesministerium für Verkehr, Bau und Stadtentwicklung. Nach der Bundestagswahl 2009 und dem folgenden Regierungswechsel schied Großmann im Oktober 2009 aus dem Amt. In den elf Jahren seiner Tätigkeit diente er unter fünf verschiedenen Bau- und Verkehrsministern.<sup id="cite_ref-verkehrsrundschau_2-1" class="reference"><a href="#cite_note-verkehrsrundschau-2">&#91;2&#93;</a></sup> </p><p>Als Parlamentarischer Staatssekretär war Achim Großmann Aufsichtsratsmitglied der <a href="/wiki/Deutsche_Bahn" title="Deutsche Bahn">Deutschen Bahn</a> und an den Vorbereitungen des Börsengangs beteiligt. </p> <h2><span class="mw-headline" id="Kabinette">Kabinette</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=5" title="Abschnitt bearbeiten: Kabinette" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=5" title="Quellcode des Abschnitts bearbeiten: Kabinette"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <ul><li><a href="/wiki/Kabinett_Schr%C3%B6der_I" title="Kabinett Schröder I">Kabinett Schröder I</a> – <a href="/wiki/Kabinett_Schr%C3%B6der_II" title="Kabinett Schröder II">Kabinett Schröder II</a> – <a href="/wiki/Kabinett_Merkel_I" title="Kabinett Merkel I">Kabinett Merkel I</a></li></ul> <h2><span id="Ver.C3.B6ffentlichungen"></span><span class="mw-headline" id="Veröffentlichungen">Veröffentlichungen</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=6" title="Abschnitt bearbeiten: Veröffentlichungen" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=6" title="Quellcode des Abschnitts bearbeiten: Veröffentlichungen"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <ul><li><cite style="font-style:italic">Würselen – Geschichte(n) in alten Bildern</cite>.<span class="Z3988" title="ctx_ver=Z39.88-2004&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook&amp;rfr_id=info:sid/de.wikipedia.org:Achim+Gro%C3%9Fmann&amp;rft.btitle=W%C3%BCrselen+-+Geschichte%28n%29+in+alten+Bildern&amp;rft.genre=book" style="display:none">&#160;</span></li> <li><cite style="font-style:italic">Würselener Ansichten</cite>. 1. Auflage. Buchhandlung <a href="/wiki/Martin_Schulz" title="Martin Schulz">Martin Schulz</a>, Würselen 1987 (zusammen mit Josef Amberg).<span class="Z3988" title="ctx_ver=Z39.88-2004&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook&amp;rfr_id=info:sid/de.wikipedia.org:Achim+Gro%C3%9Fmann&amp;rft.btitle=W%C3%BCrselener+Ansichten&amp;rft.date=1987&amp;rft.edition=1.&amp;rft.genre=book&amp;rft.place=W%C3%BCrselen&amp;rft.pub=Buchhandlung+Martin+Schulz" style="display:none">&#160;</span></li> <li><cite style="font-style:italic">Die rothen Gesellen im schwarzen Westen. Die frühe Geschichte der sozialdemokratischen Bewegung in der Aachener Region</cite>. Hahne &amp; Schloemer Verlag, Düren 2014, <a href="/wiki/Spezial:ISBN-Suche/9783942513241" class="internal mw-magiclink-isbn">ISBN 978-3-942513-24-1</a>.<span class="Z3988" title="ctx_ver=Z39.88-2004&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook&amp;rfr_id=info:sid/de.wikipedia.org:Achim+Gro%C3%9Fmann&amp;rft.btitle=Die+rothen+Gesellen+im+schwarzen+Westen.+Die+fr%C3%BChe+Geschichte+der+sozialdemokratischen+Bewegung+in+der+Aachener+Region&amp;rft.date=2014&amp;rft.genre=book&amp;rft.isbn=9783942513241&amp;rft.place=D%C3%BCren&amp;rft.pub=Hahne+%26+Schloemer+Verlag" style="display:none">&#160;</span></li> <li><cite style="font-style:italic">Zigarren aus Würselen</cite>. Hahne &amp; Schloemer Verlag, Düren 2015.<span class="Z3988" title="ctx_ver=Z39.88-2004&amp;rft_val_fmt=info%3Aofi%2Ffmt%3Akev%3Amtx%3Abook&amp;rfr_id=info:sid/de.wikipedia.org:Achim+Gro%C3%9Fmann&amp;rft.btitle=Zigarren+aus+W%C3%BCrselen&amp;rft.date=2015&amp;rft.genre=book&amp;rft.place=D%C3%BCren&amp;rft.pub=Hahne+%26+Schloemer+Verlag" style="display:none">&#160;</span></li></ul> <h2><span class="mw-headline" id="Auszeichnungen">Auszeichnungen</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=7" title="Abschnitt bearbeiten: Auszeichnungen" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=7" title="Quellcode des Abschnitts bearbeiten: Auszeichnungen"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <ul><li>2009 – <a href="/w/index.php?title=Weinritter&amp;action=edit&amp;redlink=1" class="new" title="Weinritter (Seite nicht vorhanden)">Weinritter</a> – Auszeichnung der Stadt <a href="/wiki/Oppenheim" title="Oppenheim">Oppenheim</a></li> <li>2015 – <a href="/wiki/Baesweiler" title="Baesweiler">Baesweiler</a>-Löwe</li> <li>2015 – <a href="/wiki/Rheinlandtaler" title="Rheinlandtaler">Rheinlandtaler</a> des Landschaftsverbandes Rheinland (LVR)</li></ul> <h2><span class="mw-headline" id="Weblinks">Weblinks</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=8" title="Abschnitt bearbeiten: Weblinks" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=8" title="Quellcode des Abschnitts bearbeiten: Weblinks"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <ul><li><a rel="nofollow" class="external text" href="https://portal.dnb.de/opac.htm?method=simpleSearch&amp;query=1030018618">Literatur von und über Achim Großmann</a> im Katalog der <a href="/wiki/Deutsche_Nationalbibliothek" title="Deutsche Nationalbibliothek">Deutschen Nationalbibliothek</a></li> <li><a rel="nofollow" class="external text" href="http://webarchiv.bundestag.de/archive/2010/0427/bundestag/abgeordnete/bio/G/grossac0.html">Biographie</a> beim <a href="/wiki/Deutscher_Bundestag" title="Deutscher Bundestag">Deutschen Bundestag</a></li></ul> <h2><span class="mw-headline" id="Einzelnachweise">Einzelnachweise</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;veaction=edit&amp;section=9" title="Abschnitt bearbeiten: Einzelnachweise" class="mw-editsection-visualeditor"><span>Bearbeiten</span></a><span class="mw-editsection-divider"> | </span><a href="/w/index.php?title=Achim_Gro%C3%9Fmann&amp;action=edit&amp;section=9" title="Quellcode des Abschnitts bearbeiten: Einzelnachweise"><span>Quelltext bearbeiten</span></a><span class="mw-editsection-bracket">]</span></span></h2> <ol class="references"> <li id="cite_note-1"><span class="mw-cite-backlink"><a href="#cite_ref-1">↑</a></span> <span class="reference-text"><a rel="nofollow" class="external text" href="https://www.aachener-zeitung.de/lokales/nordkreis/ehemaliger-staatssekretaer-achim-grossmann-ist-gestorben_aid-88750337"><i>Ehemaliger Staatssekretär Achim Großmann ist gestorben</i></a>, in: <a href="/wiki/Aachener_Zeitung" title="Aachener Zeitung">Aachener Zeitung</a> vom 18. April 2023</span> </li> <li id="cite_note-verkehrsrundschau-2"><span class="mw-cite-backlink">↑ <sup><a href="#cite_ref-verkehrsrundschau_2-0">a</a></sup> <sup><a href="#cite_ref-verkehrsrundschau_2-1">b</a></sup></span> <span class="reference-text">Verkehrsrundschau.de: <a rel="nofollow" class="external text" href="https://www.verkehrsrundschau.de/nachrichten/transport-logistik/verkehrs-staatssekretaer-grossmann-tritt-ab-3022916"><i>Verkehrs-Staatssekretär Großmann tritt ab</i>.</a> 9. Juli 2008</span> </li> </ol> <div id="normdaten" class="catlinks normdaten-typ-p">Normdaten&#160;(Person): <a href="/wiki/Gemeinsame_Normdatei" title="Gemeinsame Normdatei">GND</a>: <span class="plainlinks-print"><a rel="nofollow" class="external text" href="https://d-nb.info/gnd/1030018618">1030018618</a></span> <span class="noprint">(<a rel="nofollow" class="external text" href="https://lobid.org/gnd/1030018618">lobid</a>, <a rel="nofollow" class="external text" href="https://swb.bsz-bw.de/DB=2.104/SET=1/TTL=1/CMD?retrace=0&amp;trm_old=&amp;ACT=SRCHA&amp;IKT=2999&amp;SRT=RLV&amp;TRM=1030018618">OGND</a>)</span>  &#124; <a href="/wiki/Library_of_Congress_Control_Number" title="Library of Congress Control Number">LCCN</a>: <span class="plainlinks-print"><a rel="nofollow" class="external text" href="https://lccn.loc.gov/no2016104338">no2016104338</a></span>  &#124; <a href="/wiki/Virtual_International_Authority_File" title="Virtual International Authority File">VIAF</a>: <span class="plainlinks-print"><a rel="nofollow" class="external text" href="https://viaf.org/viaf/295874549/">295874549</a></span> &#124; <span class="noprint"><a class="external text" href="https://persondata.toolforge.org/p/Achim_Gro%C3%9Fmann">Wikipedia-Personensuche</a></span><span class="metadata"></span></div> <table class="metadata rahmenfarbe1" id="Vorlage_Personendaten" style="border-style: solid; margin-top: 20px;"> <tbody><tr> <th colspan="2"><a href="/wiki/Hilfe:Personendaten" title="Hilfe:Personendaten">Personendaten</a> </th></tr> <tr> <td style="color: #aaa;">NAME </td> <td style="font-weight: bold;">Großmann, Achim </td></tr> <tr> <td style="color: #aaa;">KURZBESCHREIBUNG </td> <td>deutscher Politiker (SPD), MdB </td></tr> <tr> <td style="color: #aaa;">GEBURTSDATUM </td> <td>17. April 1947 </td></tr> <tr> <td style="color: #aaa;">GEBURTSORT </td> <td><a href="/wiki/Aachen" title="Aachen">Aachen</a> </td></tr> <tr> <td style="color: #aaa;">STERBEDATUM </td> <td>14. April 2023 </td></tr> <tr> <td style="color: #aaa;">STERBEORT </td> <td><a href="/wiki/W%C3%BCrselen" title="Würselen">Würselen</a> </td></tr></tbody></table> <!--  NewPP limit report Parsed by mw1404 Cached time: 20240205031728 Cache expiry: 2592000 Reduced expiry: false Complications: [show‐toc] CPU time usage: 0.113 seconds Real time usage: 0.157 seconds Preprocessor visited node count: 2940/1000000 Post‐expand include size: 7271/2097152 bytes Template argument size: 538/2097152 bytes Highest expansion depth: 8/100 Expensive parser function count: 0/500 Unstrip recursion depth: 0/20 Unstrip post‐expand size: 1257/5000000 bytes Lua time usage: 0.039/10.000 seconds Lua memory usage: 3112129/52428800 bytes Number of Wikibase entities loaded: 1/400 --> <!-- Transclusion expansion time report (%,ms,calls,template) 100.00%  132.462      1 -total  38.42%   50.886      4 Vorlage:Literatur  35.97%   47.643      1 Vorlage:Normdaten  18.63%   24.677      1 Vorlage:Biographie_beim_Deutschen_Bundestag   4.08%    5.401      2 Vorlage:Wikidata-Registrierung   3.37%    4.459      1 Vorlage:Str_find   3.19%    4.220      1 Vorlage:Personendaten   1.84%    2.433      1 Vorlage:DNB-Portal --> <!-- Saved in parser cache with key dewiki:pcache:idhash:174000-0!canonical and timestamp 20240205031728 and revision id 233654834. Rendering was triggered because: api-parse  --> </div>'
# test <- read_html(html_text)
# 
# #section_title <- test %>%#
# section_title <- test %>%
#   html_nodes(xpath = "//h2[span[contains(@id, 'Leben')]]/following-sibling::p[preceding-sibling::h2[1][span[contains(@id, 'Leben')]] and following-sibling::h2[span[contains(@class, 'mw-headline')]]]")

#flo: //h2[contains(span, 'Leben')]/following-sibling::p[preceding-sibling::h2[contains(span, 'Leben')][1]]



library(rvest)

# Load the webpage
url <- "https://de.wikipedia.org/wiki/Adis_Ahmetovic"
page <- read_html(url)

# Define the XPath expressions for the starting and ending elements
start_xpath <- '/html/body/div[3]/div[3]/div[5]/div[1]/h2[1]/span[1]'
end_xpath <- '/html/body/div[3]/div[3]/div[5]/div[1]/h2[2]/span[1]'

# Find the starting and ending elements
start_element <- html_node(page, xpath = start_xpath)
end_element <- html_node(page, xpath = end_xpath)

# Define the XPath expression for selecting paragraphs
paragraphs_xpath <- paste0(start_xpath, '/following::p[following::span[@id="Politische Tätigkeiten"]]')

# Select the paragraphs
paragraphs <- html_nodes(page, xpath = paragraphs_xpath)

# Extract the text content of the paragraphs
paragraphs_text <- html_text(paragraphs)

# Print the text content of the paragraphs
cat(paragraphs_text, sep = "\n")

##############Funktion um urls zu adden

library(rvest)

# Funktion zur Generierung der Wikipedia-URL basierend auf dem Seitentitel
generate_wikipedia_url <- function(title) {
  base_url <- "https://de.wikipedia.org/wiki/"
  # Ersetzt Leerzeichen durch Unterstriche und fügt den Titel zur Basis-URL hinzu
  full_url <- paste0(base_url, gsub(" ", "_", title))
  return(full_url)
}

# Angenommen, Ihr DataFrame heißt df und hat eine Spalte namens wiki_title
# Erstellen Sie eine neue Spalte namens wiki_url, die die vollständigen URLs enthält
# df <- df %>%
#   mutate(wiki_url = sapply(wikititle, generate_wikipedia_url))

deu_core <- deu_core %>%
  mutate(wiki_url = sapply(wikititle, generate_wikipedia_url))

#########funktion um Text zu extrahieren

library(rvest)
library(dplyr)
library(purrr)

# Funktion zur Extraktion des Textes zwischen den definierten XPaths für eine URL
extract_paragraphs_text <- function(url, start_xpath, end_xpath, following_xpath) {
  
  Sys.sleep(runif(1, 1, 2))
  
  rvest_session <- session(url, 
                           add_headers(`From` = "hannahschweren@gmail.com", 
                                       `User-Agent` = R.Version()$version.string))
  
  page <- tryCatch({
    read_html(url)
  }, error = function(e) {
    return(NA)
  })
  
  if (!is.na(page)) {
    start_element <- html_node(page, xpath = start_xpath)
    end_element <- html_node(page, xpath = end_xpath)
    
    # Überprüfung, ob Start- und Ende-Elemente gefunden wurden
    if (!is.na(start_element) && !is.na(end_element)) {
      paragraphs_xpath <- paste0(start_xpath, following_xpath)
      paragraphs <- html_nodes(page, xpath = paragraphs_xpath)
      paragraphs_text <- html_text(paragraphs) %>% paste(collapse = "\n")
      return(paragraphs_text)
    } else {
      return(NA)
    }
  } else {
    return(NA)
  }
}

# Funktion zum Hinzufügen der extrahierten Inhalte zu einer neuen Spalte im DataFrame
add_extracted_content_to_df <- function(df, start_xpath, end_xpath, following_xpath) {
  df <- df %>%
    rowwise() %>%
    mutate(extracted_text = list(extract_paragraphs_text(wiki_url, start_xpath, end_xpath, following_xpath))) %>%
    ungroup() # Entfernen der rowwise Gruppierung
  
  return(df)
}

# define paths
start_xpath <- '/html/body/div[3]/div[3]/div[5]/div[1]/h2[1]/span[1]'
end_xpath <- '/html/body/div[3]/div[3]/div[5]/div[1]/h2[2]/span[1]'
following_xpath <- '/following::p[following::span[@id="Politik"] or following::span[@id="Partei"] or following::span[@id="Beruf"] or following::span[@id="Politische Tätigkeiten"] or following::span[@id="Partien"] or following::span[@id="Abgeordneter"]]'
# 


# 
# df <- df %>%
#   mutate(extracted_text = pblapply(wiki_url, possibly(~extract_paragraphs_text(.x, start_xpath, end_xpath, following_xpath), NA)))
# df$extracted_text <- unlist(df$extracted_text)


deu_core <- deu_core %>%
  mutate(extracted_text = pblapply(wiki_url, possibly(~extract_paragraphs_text(.x, start_xpath, end_xpath, following_xpath), NA)))
deu_core$extracted_text <- unlist(deu_core$extracted_text)


anzahl_erfolgreich_extrahiert <- sum(!is.na(deu_core$extracted_text) & deu_core$extracted_text != "")
gesamtanzahl_zeilen <- nrow(df)

# Berechnung des Anteils
anteil_erfolgreich_extrahiert <- anzahl_erfolgreich_extrahiert / gesamtanzahl_zeilen

# Ausgabe des Anteils
print(anzahl_erfolgreich_extrahiert)

#write.csv(deu_core, file = "raw_data/deu_leben_text.csv", row.names = FALSE)



print(head(deu_text,5))


#################mit string extrahieren, funktioniert besser

library(stringr)

extract_content <- function(text) {
  tryCatch({
    parts <- str_split(text, "\\[Bearbeiten \\| Quelltext bearbeiten\\]")[[1]]
    
    if (length(parts) >= 3) {
      content_between = parts[2]
      paragraph_positions <- str_locate_all(content_between, "\n\n")[[1]][,1]
      
      if (length(paragraph_positions) > 0) {
        last_paragraph_pos <- max(paragraph_positions, na.rm = TRUE)
        return(substr(content_between, 1, last_paragraph_pos))
      } else {
        return(content_between)
      }
    } else {
      return(NA)
    }
  }, error = function(e) { 
    NA 
  })
}


library(dplyr)
library(tidyverse)


# Beispiel-DataFrame (ersetzen Sie dies durch Ihren tatsächlichen DataFrame)
# deu_text <- data.frame(Text = c("Text vor Quelltext bearbeiten Erster Abschnitt Quelltext bearbeiten Zweiter Abschnitt Quelltext bearbeiten"))

# Funktion auf jede Zeile in der Spalte "Text" anwenden und in neuer Spalte "extracted_text" speichern
deu_text <- deu_text %>%
  mutate(extracted_text = map_chr(plain_text, possibly(extract_content, otherwise = NA_character_)))

print(head(deu_text$extracted_text, 10))
