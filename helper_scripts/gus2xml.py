from xml.dom.minidom import Document


# read gus file
f = open( "../TableModel/data/polish_regional_entities.csv", 'r' )
codes_list = f.readlines()
codes_list.sort()


# start XML document
doc = Document()
country = doc.createElement( "country" )
country.setAttribute( "name", "Polska" )
doc.appendChild( country )

# it's non idiomatic pythonic style of list iteration
# but I'm a Java programmer adjusting to Python
for i in range( len( codes_list ) ):
    # skip double entities
    if i > 0 and codes_list[ i-1 ] == codes_list[ i ]:
        continue

    # to be extended to provide map position info
    # get rid of new line char while spliting
    id, name, x, y = codes_list[ i ][:-1].split( ';' );


    if int( id[:1] ) != 0 and int( id[1:] ) == 0:
        region = doc.createElement( "region" )
        region.setAttribute( "id", id[:1] )
        region.setAttribute( "name", name )
        region.setAttribute( "x", x )
        region.setAttribute( "y", y )
        country.appendChild( region )

    elif int( id[1:3] ) != 0 and int( id[3:] ) == 0:
        province = doc.createElement( "province" )
        province.setAttribute( "id", id[1:3] )
        province.setAttribute( "name", name )
        province.setAttribute( "x", x )
        province.setAttribute( "y", y )
        region.appendChild( province )

    elif int( id[3:5] ) != 0 and int( id[5:] ) == 0:
        subregion = doc.createElement( "subregion" )
        subregion.setAttribute( "id", id[3:5] )
        subregion.setAttribute( "name", name )
        subregion.setAttribute( "x", x )
        subregion.setAttribute( "y", y )
        province.appendChild( subregion )

    elif int( id[5:7] ) != 0 and int( id[7:] ) == 0:
        district = doc.createElement( "district" )
        district.setAttribute( "id", id[5:7] )
        district.setAttribute( "name", name )
        district.setAttribute( "x", x )
        district.setAttribute( "y", y )
        subregion.appendChild( district )        

    else:
        entity = doc.createElement( "entity" )
        entity.setAttribute( "id", id[7:] )
        entity.setAttribute( "name", name )
        entity.setAttribute( "x", x )
        entity.setAttribute( "y", y )
        district.appendChild( entity )

# print the output xml to stdout
print doc.toprettyxml( indent = "  " )

