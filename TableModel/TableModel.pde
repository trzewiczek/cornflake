import processing.pdf.*;

void setup()
{
    size( 680, 5203 );

//    beginRecord( PDF, "/home/trzewiczek/Pulpit/zarobki_tagi.pdf" );

//    println( PFont.list() );

    background( 255 );
    smooth();

    textFont( createFont( "DejaVu Sans Mono", 10 ) );
    PShape mapa = loadShape( "../data/map_of_poland.svg" );
    mapa.disableStyle();
    noFill();
    stroke( 240 );
//    fill( 50 );
    noFill();
//    shape( mapa, 0, 0, 600, 563 );

//    Table t = new Table( this, "../data/migracje_pobyt_staly_zagraniczne_1995-2003.csv", false );
//    Table t = new Table( this, "../data/rozwodu_ogolem_wojewodztwa_1999_2009.csv", false );
    Table t = new Table( this, "../data/srednia_krajowa.csv", false );

    float totalMin = Float.MAX_VALUE;
    float totalMax = Float.MIN_VALUE;

    while( t.hasNextRow() )
    {
        float total = abs( t.getNextRow().getTotal() );
        if( total < totalMin ) totalMin = total;
        if( total > totalMax ) totalMax = total;
    }

    int xp = 30;
    t.resetIterator();
    while( t.hasNextRow() )
    {
        Row r = t.getNextRow();

        if( r._entity.entityType != 3 )
            continue;

        float total = r.getTotal();
        float xPos = r._entity.getPosition().x();
        float yPos = r._entity.getPosition().y();

        float radius = map( abs( total ), totalMin, totalMax, 10, 100 );

        noStroke();
        if( total < 100 ) 
            fill( 200, 100, 100, 100 );
        else
            fill( 100, 100, 200, 100 );

        textFont( createFont( "DejaVu Sans Mono", radius / 2 ) );
        xp += ( radius / 2 ) * 1.1;

        textAlign( RIGHT );
        if( total > 0 )
            text( int( total ) + "%", 190, xp );
        else
        {
            String num = "" + int( total );
            num = num.substring( 1 );
            text( num, 190, xp );
        }

        textAlign( LEFT );
        text( r._entity.getName(), 200, xp );






//        ellipse( xPos, yPos, radius, radius );

//        fill( 255 );
//        rect( xPos, yPos - 3, textWidth( "+" + int( total ) + "::" + r._entity.getName() ), -11 );

        float labelX = cos( radians( -45 ) ) * radius / 2;
        float labelY = sin( radians( -45 ) ) * radius / 2;

/*        if( total > 0 )
        {
            fill( 0, 150 );
            text( "+" + int( total ), labelX + xPos, labelY + yPos );
            text( "::" + r._entity.getName(), labelX + xPos + textWidth( "+" + int( total ) ), labelY + yPos );
        }
        else
        {
            fill( 0, 150 );
            text( int( total ) + " ", labelX + xPos, labelY + yPos);
            text( "::" + r._entity.getName(), labelX + xPos + textWidth( "" + int( total ) ) + 4, labelY + yPos );
        }
*/
    }        


    endRecord();
}



/*

//        Row r = t.getNextRow();
//        r.plot( 100, 400, 300, 300, range, t.min(), t.max() );


    int u = 5;
    stroke( 230 );
    for( int i = 0; i < 5; i++ )
    {
        line( 90, 100 + ( i * ( 150 / u ) ), 100, 100 + ( i * ( 150 / u ) ) );
        line( 90, 400 - ( i * ( 150 / u ) ), 100, 400 - ( i * ( 150 / u ) ) );
        line( 400, 100 + ( i * ( 150 / u ) ), 410, 100 + ( i * ( 150 / u ) ) );
        line( 400, 400 - ( i * ( 150 / u ) ), 410, 400 - ( i * ( 150 / u ) ) );
    }
    line( 70, 250, 100, 250 );
    line( 400, 250, 430, 250 );

    while( t.hasNextRow() )
    {
        pushMatrix();

        Row r = t.getNextRow();
        float step = r.getStep( 300 );

        translate( 100, 350 );  

        beginShape();
        for( int i = 0; r.hasNextValue(); ++i )
        {
            float value = r.getNextValue();
            float y = map( value, -range, range, 250, -250 );

            if( value == t.min() || value == t.max() )
            {
                pushStyle();

                fill( 50 );
                text( int( value ), step * i + 3, y - 3 );
                text( " :: " + r._entity.getName(), step * i + textWidth( "" + int(value) ) + 3, y - 3 );
                noFill();
                stroke( 50 );
                ellipse( step * i, y, 5, 5 );
                
                popStyle();
            }
            vertex( step * i, y );
        }
        endShape();

        popMatrix();
    }
    */


/*
//------------------------------------------------------------------------------
//    PShape mapa = loadShape( "../data/map_of_poland.svg" );
//    mapa.disableStyle();
//    fill( 50 );
//    shape( mapa, 25, 25 , 600, 563 );

    String[] data = loadStrings( "../data/polish_regional_data.csv");
    String[] codes = new String[ data.length ];

    for( int i = 0; i < data.length; ++i )
    {
        String[] c = split( data[ i ], ';' );
        codes[ i ] = c[ 0 ];
    }

    CodeCreator cc = new CodeCreator( this );
    RegionalEntity[] c = new RegionalEntity[ codes.length ];

    for( int i = 0; i < codes.length; ++i )
        c[ i ] = cc.createCode( codes[ i ] );

    for( int i = 0; i < c.length; ++i )
    {
        float w = 600;
        float h = 563;

        switch( c[i].getType() )
        {
        case 1:
            fill( 255, 255, 0 );
            ellipse( 25 + c[ i ].getPosition().x(), 25 + c[ i ].getPosition().y(), 8, 8 );
            break;

        case 2:
            fill( 0, 255, 255 );
            ellipse( 25 + c[ i ].getPosition().x(), 25 + c[ i ].getPosition().y(), 5, 5 );
            break;

        case 3:
            fill( 255, 0, 0 );
            ellipse( 25 + c[ i ].getPosition().x(), 25 + c[ i ].getPosition().y(), 2, 2 );
            break;
        }
    }


}

*/






// --------------- PLOT -----------------

/*

    noStroke();
    fill( 50 );

    pushMatrix();
    pushStyle();
    noStroke();

    translate( 100, 100 );

    for( int i = 0; i < 11; ++i )
    {
        stroke( 0, 10 );
        line( i * ( 300 / 10 ), 0,i * ( 300 / 10 ), 300 );
    }
        
    popStyle();
    popMatrix();

//    Table t = new Table( this, "../data/migracje_pobyt_staly_zagraniczne_1995-2003.csv", false );
    Table t = new Table( this, "../data/rozwodu_ogolem_wojewodztwa_1999_2009.csv", false );
    float range = max( abs( t.min() ), t.max() );

    Plotter plotter = new Plotter( t, 100, 400, 300, 300 );

    stroke( 250, 100, 100 );
    noFill();

    while( t.hasNextRow() )
    {
        Row r = t.getNextRow();
        plotter.plot( r, range );
    }

    stroke( 200 );
    fill( 100 );
    plotter.drawAxis();
    plotter.drawExtremes();

*/