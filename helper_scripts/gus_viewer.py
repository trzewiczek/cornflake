# read gus file
f = open( "../TableModel/data/polish_regional_entities.csv", 'r' )
codes_list = f.readlines()
codes_list.sort()


for i in range( len( codes_list ) ):
    # skip double entities
    if i > 0 and codes_list[ i-1 ] == codes_list[ i ]:
        continue

    # get rid of new line char while spliting
    id, name = codes_list[ i ][:-1].split( ';' );


    if int( id[:1] ) != 0 and int( id[1:] ) == 0:
        print name

    elif int( id[1:3] ) != 0 and int( id[3:] ) == 0:
        print "  ", name
        
    elif int( id[3:5] ) != 0 and int( id[5:] ) == 0:
        print "    ", name

    elif int( id[5:7] ) != 0 and int( id[7:] ) == 0:
        pass

    else:
        pass
