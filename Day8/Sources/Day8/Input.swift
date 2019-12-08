let input = """
222202222222222212222222022222122122022222210222122202212202222022222220122222202222222220122002120222222222222222222022222222202222222222222222212222222222222222212202222222022220122022022222210222122212202202222122222220222222212222222222122212220222222222222222222222222222212222222222222222202222222212222222222212222222022220022222222222211222122212202202222122222220222222212222222221022202022222222222222222222022222221002222122222222222202222222212222222212202222222122222122022222222201222122222222202222222222220022222212222222220022212022222222222222222222222222222202222122222222222202222222222222222222212222222122220022022122222221222022222222212222022222220022222212222222221222222120222222222222222222122222222022222222222222222222222222212222222212202222222222220022022022222212222222212222202220122222222222222222222222222222012121222222222222222222122222220022222222222222222211222222212222222202202222222122221022222222222210222022212202222221222222221222221212222222221022022120222222222222222222222222221012222022222222222222222222202222222202212222222012222122222122222221222122202212222221221222221020222212222222222222012121222222222222222222122222222022222222222222222222222222222222222212202222222012220122022222222210222122212212212221220222222220222202222222220122102122222222222222222222222222220202222122222222222210222222202222222202202222222112221002222222222221222222202212222222020222220120221222222222220022022020222222222222222222222222220102222122202222222201222222212222222202212222222112222122022022222200222022222212202222121222220020221212222222221122202022222222222222222222122222220212222122212222222201222222212222222222212222222012222112022122222220222122212212202221120222222120222222220222222122112221222222222222222222022222221122222022202222222202222222022222222202222222222012220012122222222200222222212202222222221222221221221202201222220122202021222222222222222222222222220022222222222222222220222222112222222202222222222102221112022122220210222222202202202220022222222222220212201222222112112102222222222222222222022222221102222122122222222201222222102222222212212222222002220022022122220200222122212212212220220222222220220222211222221012022212222222222222222222122222222112222222112222222202222222102222222202202222222012220222222122220202222222222202222221021222222220221202210222220112012211222222222222222222022222221222222022202222222221222222112222222212202222222102222202222222222212222122221212202221022222221020220212201222220002112201222222222222222222222220222022222022122222222220222222112222222222202222222022221222122222220221222122220212222222222222220120221212210222221012102022222222222222222222122220221212222222002222222222222222122222222202202222222122222122022222211212222222222202202220222222221020222212211222220112022110222222222222222222022220220112222122112222222211222222122222222212222222222002220012022222220202222022222212202220122222221122220222202222220222102210222222222222222222222220221112222122102222222210222222112222222222212222222212220202122022011211222222220222212222220222222120220222212222220202022212212222222222222222022221222212222122112222222202222222012222220222222222221220221212122222021210222222211202222222222222220022220222211222221122112010202222222222222222022220222002222222102222222210222222212222221222212222220220220002122122120201222222222202222222021222221220222212222222221102022111212222222222222222122221220212222122222222222220222222112222221222202222222021222012022122102212222022210212202220121222221220222202220222222122222112202222222222222222122220220212222122022222222222222222222222222202202222220221221112022122012212222222221222222220120222220221222222222222221212102002212222222222222222222221222122222022102222222220222222012222222222222222221202220022222122212220222222222222222222020222221002221212201222222102022021222222220222222222022221220202222022112222222220222222102222220202202222222021222122122122202220222222210222212221121222222211220222222222222102222022222222220222222222022222220112222222212122222222222222122222221212202222221121221122222122000201222222211212222222120222222122220212201212221112102212222222200222222222122222220222222022112122222202222222212222220222222222221101220022122222101210222022210202212222121222222012222202220222222022202012222222212222222222022221221122222122122122222212222222222222220222222222220212220002122122202212222122211202202221221222221022222202220212222022202001212222200222222222122222221022222222202122222222222222122222221212222222221222221112122022021201222222201202202221122222221000220222201202222012002101222222202222222222122220222002202222122122222202222222112222222212202222220020222122222022020221222222200212212221221222222100220222200222221012012200212222211222222222022221221102202122002022222221222222002222221202212222220022220002222222020212222022201202212221121222222120222212202202220112122110202222211222222222022221221022222222222122222211222222212222221222222222221010022222122222211212222222201202222222022222220000221202210202221202002222212222210222222222222222222122202022122202022222222222112222222222202222221202122012022022210202222222202202202221222222221012222222201202222022102002212222202222222222222221220212212022112022022201122222222222222222222222221100221012022022012210222022222202212220222222222222221212210202220012222112212222211222212222022222220212202222202212222202022222102222222202222222222202122102122022102220222022221212222222020222220211220212211212222212122120212222210222212222122220222211212222122202222212222222112222221222202222221201021112022222210210222222211202202221122222221010221212211212221212122112222222220122222222222221220120202022122112022212122222122222220222222222222110122112222122211200222122222212212221120222220000221212202202222002222000212222221122222222222221222212222122122112222201122222202222222212202222222210122102122022110220222222201212212222222222220002222212220202220122112011222222221022202222222221220112222122012222222211022222022222220202202222221002022202122222211212222122211212212220020222221122222202222202202012002201212222202122212222022220222211202022212222022211222222202222220202202222221200020122122222201200222022002222202221221222222022221202200202222002002202202022202122212222222221221211212222122222122200122222112222222212222222222112220122222212002202222022102222222220222222222120221222212222222012102200202222221022202222022220222202202222122112222201222222212222221222222222222212120002222212021211222022211222202222121222220011221212202212210002022222202122200022212222122220221010212222022212022212122222122222221222212222221212220102122102121220222022010202212220020222220112220222222222202212102002212222200122202222022220220101202022102122022202122222012222222222202222222020022122022112000221222022212222212221020222220120221212212212212122212121202222201222222222022220221000202222122222022210120222112222222212212222222012120212122012112212222202000202222220121222222122220222201222200212202101012022222122202222222221222121222022022002022200122222102222220212222222222111222212222122121220222102112222212222022222220000221222220212221112202220012222221122202222222221220110222122022202222220221222122222220202202222220220221112002212002201222012221202212220122222222001220202222222212122212012002222220022212222022221221020202122202212022222221222022222220202202222221011220002202222010201222102002202202222120222222221220202202222210002212122022022210222202222022222221012212222202202022202021222122222220202212222222122020202022022010220222212220202222222120222222202222222210012210222212111122022221222200222022222221111202022022022222200021222202222220222202222220120021212122022112202222102120222212220021222220012220212211122212002222210212022211022221222022221222100212022222212022222221222022222220202222222221112020002122212221210222122210202202220022222222100220212202122201212122201002222221022200222222220022120222122022122022222222222102222220222112222221110122002102122101202222002011212222222022222220002221202200112201112222121002012220122212222122221222210202222012112222202221222012222221202112222220211022022222212012220222002220222202221020222221011221202200212222102122021222022202022222222122220020120212122202022022202121222112222221222222222222110120112222112121201222222101212212220021222220200220202212002211022222120012002201022200222022220021211212222212112222200020222102222222212102222221012022202202112220220222022121202212222120222220121220202220102121122002120202012222122201222022221121202222022202222022212021222212222220202202222222010222022222222211202222022102212212222120222222020221222201102220022002011112102210121212212022221220202222022222012222221120222002222222202112222221101121202202202100202222012201202212222221222222212222212200112201002002002222022212221221222222220220122212122112022222200120222112222021212102222222111222102202122012202222102101222202121122222221220221202221212101102122111222122221022212212122221222221222222022012022200021222022222021202002222220212121122212112022222222002102212212210020222221120222222220222222112112222102112210022200212222222222222202222022012022202221222122222222202122222220121121112012122202200222202100222222102221222221101222222220212120112202211122122222221222212222221120212222222022122122202022222022222120202222222222002120112202202200202222002022222222012021222222202220202202122002012202202122002100022222212022220020202202022212212022201121222122222220212102222212202022102202112120221202202211212202021020222222122221201200102222012222201202112021220201222222220120012222022002212022211021222112222222222012222210101021012222112120212222212211212222010221222221210221211220012101012112002202212201020221222222222221212222122112022222222121222122222122222212222210012120202122102002202222102201012222202020222220200220210210102212202002111212002120120021222122222021022222222212012022211022222112222121202102222202012221202022212121202202202122012222200020222222002220111220212010122102112022102022122012212222220122200212122212202022201221222112212220222022222220201121122012222201200222212021212202122020222221221221002210212121022102102212212120220111202022221022220212002012202222200222222002212021202202222222101121002012212120210202002220202222202220222220200222022201202011022202111012212211021110222020222020122212022212002222200021222212222122212222222211022220202022012110220212222202112202222222222221012222101222222110112102100022122121020111202021220021002202202012122122222021222022222222222122222202002022122102212022212212222001102222211120222221212221020000012020002022202022002112120212212020222221202212022012101122201020222212212120202212222222222221222222002110221222112102122222101021222022210221120022012102022102200222212201120220222222220122202202212002112022211121222012222021222001222221202121002222002001221222222112012222011122222221110221112122112101102212001012022010122002202222221220100202212002210122220020222212202021222020222220021021202122022011202212222200222222110220222222211221121100212000002122211222212000021011222021221221011212112212212122210122222202212122222111222212210120002012112102221222102022122222110022222122020220211100202100012022212212202101021011212220220122122222220012021022202222222012202022222021222200012220002202122201211222022200002222020222222022001222012222002201222112001202212120022210202220220121002202212102200022212220222222222122202211222200220220112112202120202212002001012222012022222122120221002202112011122122022222122011120012222121221221220212210112212222212022222102212120222122222222111120002212112010212212012111022202211221222121121220220112212102102012011202222121021112212121222121121202000112000122220222222112202022222211202200011122212012102012222222012000222212122022202222121221100020202101112112200202102110222001212222220021000202000212210122220220222012202022222210222210001220122002202220010212202111012202110122202120221220222112222210022022020202112211020101210120220121210202212222112022202221222102222022222122212201201220202022112200202202112000002212010120212021010222200121202120222012021022122102122210211220221220120222200122110022220221222010112021202202212210100020100122112221122212002211002222120221202001001222021210002112102022020122222202120120220021221222202202201212001222202122222200222222222210202201021221211022022100120202012120102222212220212012101222200002112010022102110022012121021112212020220020012202100212100022202121222010122220222121202211201022111122022021220222222212002212012021202112001221121120102020212212111112212220221200200020222020022222101122021122200010222020220122222121202212201121111002102210011202002101112012001120212210221222002210212210022112100022102012120202220021220022020212202202010222201120222120211022212012202201222120012122122111121212122212222202212021222102102220121200112221202002112112112201121100201222220020212212211002212122220222222112210221212010202201201021202222102221102212212221012012011122222100211221221121212221021022121002022001020102211002220120202222022012221122212211222122022120212221222120020220120122222202221222202020222022200022202022001221111212102121010212121202012221220022200010222222011212202112222222212220222111220120212210202120112022111222222000010222002221112222010222202102102221102111222001210002220122202112022002210102222220211202201012220122211120222002210120212200222102221122202002012202011202122001102222012121202001202220011110012112212112221012112220120010210120221121201202110002220222200011222001101122202202202002122120200212122110022222002022122112211022202112022222121111012200202202011202112010022012201002220220221202100022220022022210222001110021222220222221002120100012222022201202122222022012021122222002012222001210002202121202121122102220220200200220220221020222200112100222221002222122212121222121202000220211201122212102120222212111012022101222201201211221121121222000221002200212122211020012221200220222001222121102211222122010222120222021212012222222120202112222002012212212022120122022200100221020101220220102222110221112122222002101020020200212200121101212002012211122210221222001000120222212202022111201221112112021210212022200202122221120212000100222112210212001012212011212122020020210212110212122020222012212201222201121221222010221202221212002011021011202222202102212012120102102200010210210111220001102120220010012101002112011122002211200202021002222101102122222202122221220212121202000212021212021200102012211021222002212122122101021221211220222102121102222221112200102122120021110221010212220111222210022102122001102220101120221202120222221022110202202202121111212122100222112111120200210021222110001201112101102121012222012221000212110210222022212222222001022022001222212120021212222222022020211001202210110212212112201122112201100200122221222222102122210210202111202200020122011212222211022012202121002101222222210012220200112000022021000011202211221221212100020101012020020201112022001111110122021212101221220202200001100201111012121100001012021010220001200122201
"""
