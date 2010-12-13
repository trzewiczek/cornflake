public class RegionalEntity
{
    HashMap names;
    HashMap codes;
    String fullCodeLabel;
    int entityType; // 0 - region, 1 - province, 2 - subregion, 3 - district, 4 - entity
    
    MapPoint coordinates;
  
    public RegionalEntity( int[] eCodes, String[] eNames, MapPoint coord, int eType )
    {
        if( eCodes.length != 5 || eNames.length != 5 )
            println( "--------------->> ERROR in Code.pde" );

        entityType = eType; 
        coordinates = coord;
    
        names = new HashMap();
        names.put( "region", eNames[ 0 ] );
        names.put( "province", eNames[ 1 ] );
        names.put( "wojewodztwo", eNames[ 1 ] );
        names.put( "subregion", eNames[ 2 ] );
        names.put( "podregion", eNames[ 2 ] );
        names.put( "district", eNames[ 3 ] );
        names.put( "powiat", eNames[ 3 ] );
        names.put( "entity", eNames[ 4 ] );
        names.put( "jednostka", eNames[ 4 ] );

        codes = new HashMap();
        codes.put( "region", eCodes[ 0 ] );
        codes.put( "province", eCodes[ 1 ] );
        codes.put( "wojewodztwo", eCodes[ 1 ] );
        codes.put( "subregion", eCodes[ 2 ] );
        codes.put( "podregion", eCodes[ 2 ] );
        codes.put( "district", eCodes[ 3 ] );
        codes.put( "powiat", eCodes[ 3 ] );
        codes.put( "entity", eCodes[ 4 ] );
        codes.put( "jednostka", eCodes[ 4 ] );

        fullCodeLabel = "" + eCodes[ 0 ] + eCodes[ 1 ] + eCodes[ 2 ] + eCodes[ 3 ] + eCodes[ 4 ];
    }

    public void render()
    {
        Iterator c = codes.values().iterator();
        Iterator n = names.values().iterator();
        
        while( c.hasNext() && n.hasNext() )
            println( c.next() + "\t::\t" + n.next() );
    }

    public MapPoint getPosition()
    {
        return coordinates;
    }


    public String getName()
    {
        switch( entityType )
        {
        case 0:
            return (String)names.get( "region" );
        case 1:
            return (String)names.get( "province" );
        case 2:
            return (String)names.get( "subregion" );
        case 3:
            return (String)names.get( "district" );
        case 4:
            return (String)names.get( "entity" );
        default:
            return "";
        }
    }


    public String getName( String entity )
    {
        return (String)names.get( entity );
    }
    

    public int getId( String entity )
    {
        return (Integer)codes.get( entity );
    }
    
    public int getType()
    {
      return entityType;
    } 
}

