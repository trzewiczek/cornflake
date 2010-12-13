public class CodeCreator
{
    String[] codesList;
    XMLElement codes_xml;
    int[] codes;

    public CodeCreator( PApplet mainApplet )
    {
        codes_xml = new XMLElement( mainApplet, "../data/polish_regional_data.xml" );
    }


    public RegionalEntity createCode( String codeLabel )
    {
        codes = new int[ 5 ];

        codes[ 0 ] = Integer.parseInt( codeLabel.substring( 0, 1 ) );
        codes[ 1 ] = Integer.parseInt( codeLabel.substring( 1, 3 ) );
        codes[ 2 ] = Integer.parseInt( codeLabel.substring( 3, 5 ) );
        codes[ 3 ] = Integer.parseInt( codeLabel.substring( 5, 7 ) );
        codes[ 4 ] = Integer.parseInt( codeLabel.substring( 7 ) );    

        // iterate through all  R E G I O N S
        XMLElement[] regions = codes_xml.getChildren();
        for( int region = 0; region < regions.length; ++region )
        {
            if( regions[ region ].getIntAttribute( "id" ) != codes[ 0 ] )
                continue;

            if( rest( 1 ) == 0 )
            {
                int[] eCodes = { regions[ region ].getIntAttribute( "id" ), 
                                 0, 0, 0, 0
                }; 
          
                String[] eNames = { regions[ region ].getStringAttribute( "name" ), 
                                    "", "", "", "" 
                }; 

                MapPoint map_point = new MapPoint( regions[ region ].getFloatAttribute( "x" ),
                                                   regions[ region ].getFloatAttribute( "y" ) );
                return new RegionalEntity( eCodes, eNames, map_point, 0 );
            }
      
            // iterate through all  P R O V I N C E S
            XMLElement[] provinces = regions[ region ].getChildren();
            for( int province = 0; province < provinces.length; ++province )
            {
                if( provinces[ province ].getIntAttribute( "id" ) != codes[ 1 ] )
                    continue;

                if( rest( 2 ) == 0 )
                {
                    int[] eCodes = { regions[ region ].getIntAttribute( "id" ), 
                                     provinces[ province ].getIntAttribute( "id" ),
                                     0, 0, 0
                    }; 
            
                    String[] eNames = { regions[ region ].getStringAttribute( "name" ), 
                                        provinces[ province ].getStringAttribute( "name" ),
                                        "", "", ""
                    }; 

                    MapPoint map_point = new MapPoint( provinces[ province ].getFloatAttribute( "x" ),
                                                       provinces[ province ].getFloatAttribute( "y" ) );
                    return new RegionalEntity( eCodes, eNames, map_point, 1 );
                }

                // iterate through all  S U B R E G I O N S          
                XMLElement[] subregions = provinces[ province ].getChildren();
                for( int subregion = 0; subregion < subregions.length; ++subregion )
                {
                    if( subregions[ subregion ].getIntAttribute( "id" ) != codes[ 2 ] )
                        continue;

                    if( rest( 3 ) == 0 )
                    {
                        int[] eCodes = { regions[ region ].getIntAttribute( "id" ), 
                                         provinces[ province ].getIntAttribute( "id" ),
                                         subregions[ subregion ].getIntAttribute( "id" ),
                                         0, 0
                        }; 
              
                        String[] eNames = { regions[ region ].getStringAttribute( "name" ), 
                                            provinces[ province ].getStringAttribute( "name" ),
                                            subregions[ subregion ].getStringAttribute( "name" ),
                                            "", ""
                        }; 

                        MapPoint map_point = new MapPoint( subregions[ subregion ].getFloatAttribute( "x" ),
                                                           subregions[ subregion ].getFloatAttribute( "y" ) );
                        return new RegionalEntity( eCodes, eNames, map_point, 2 );
   
                    }

                    // iterate through all  D I S T R I C T S                  
                    XMLElement[] districts = subregions[ subregion ].getChildren();        
                    for( int district = 0; district < districts.length; ++district )
                    {
                        if( districts[ district ].getIntAttribute( "id" ) != codes[ 3 ] )
                            continue;


                        if( rest( 4 ) == 0 )
                        {
                            int[] eCodes = { regions[ region ].getIntAttribute( "id" ), 
                                             provinces[ province ].getIntAttribute( "id" ),
                                             subregions[ subregion ].getIntAttribute( "id" ),
                                             districts[ district ].getIntAttribute( "id" ),
                                             0
                            }; 
                
                            String[] eNames = { regions[ region ].getStringAttribute( "name" ), 
                                                provinces[ province ].getStringAttribute( "name" ),
                                                subregions[ subregion ].getStringAttribute( "name" ),
                                                districts[ district ].getStringAttribute( "name" ),
                                                ""
                            }; 
                            MapPoint map_point = new MapPoint( districts[ district ].getFloatAttribute( "x" ),
                                                               districts[ district ].getFloatAttribute( "y" ) );
                            return new RegionalEntity( eCodes, eNames, map_point, 3 );
                        }
              
                        // iterate through all  E N T I T I E S  
                        XMLElement[] entities = districts[ district ].getChildren();   
                        for( int entity = 0; entity < entities.length; ++entity )
                        {
                            if( entities[ entity ].getIntAttribute( "id" ) != codes[ 4 ] )
                                continue;
                
                
                            int[] eCodes = { regions[ region ].getIntAttribute( "id" ), 
                                             provinces[ province ].getIntAttribute( "id" ), 
                                             subregions[ subregion ].getIntAttribute( "id" ), 
                                             districts[ district ].getIntAttribute( "id" ), 
                                             entities[ entity ].getIntAttribute( "id" ) 
                            }; 
              
                            String[] eNames = { regions[ region ].getStringAttribute( "name" ), 
                                                provinces[ province ].getStringAttribute( "name" ), 
                                                subregions[ subregion ].getStringAttribute( "name" ), 
                                                districts[ district ].getStringAttribute( "name" ), 
                                                entities[ entity ].getStringAttribute( "name" ) 
                            }; 

                            MapPoint map_point = new MapPoint( entities[ entity ].getFloatAttribute( "x" ),
                                                               entities[ entity ].getFloatAttribute( "y" ) );
                            return new RegionalEntity( eCodes, eNames, map_point, 4 );
                        }
                    }
                }
            }    
        }
    
        println( ">> SORRY BUT I COULDN'T CREATE A CODE\n>> IS YOUR XML FILE CORRECT?" );
        return null;
    }
  
  
    private int rest( int i )
    {
        int sum = 0;
        while( i < codes.length )
            sum += codes[ i++ ];
        
        return sum;
    }
}

