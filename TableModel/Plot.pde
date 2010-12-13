public class Plotter
{
    public Plotter( Table table, float x, float y, float w, float h )
    {
        _table = table;

        _x = x;
        _y = y;
        _w = w;
        _h = h;

        _bothSigns = ( _table.min() * _table.max() < 0 ) ? true : false;
    }


    public void plot( Row row )
    {
        plot( row, _h );
    }


    public void plot( Row row, float range )
    {
        row.resetIterator();

        float step = row.getStep( _w );
        boolean bothSigns = ( _table.min() * _table.max() < 0 ) ? true : false;

        pushMatrix();

        if( bothSigns )
            translate( _x, _y - ( _h / 2.0 ) );
        else
            translate( _x, _y );

        beginShape();
        for( int i = 0; row.hasNextValue(); ++i )
        {
            float value = row.getNextValue();
            float yPos;
            if( bothSigns )
            {
                yPos = map( value, -range, range, _h / 2, -_h / 2 );                    
            }
            else
            {
                yPos =  value < 0 ? map( value, 0, -range, _h, 0 ) : map( value, 0, range, 0, -_h );
            }
            vertex( step * i, yPos );
        }
        endShape();
        popMatrix();
    }


    public void drawExtremes()
    {
        boolean bothSigns = ( _table.min() * _table.max() < 0 ) ? true : false;
        float range = max( abs( _table.min() ), _table.max() );

        pushMatrix();

        if( bothSigns )
            translate( _x, _y - ( _h / 2.0 ) );
        else
            translate( _x, _y );

        _table.resetIterator();

        while( _table.hasNextRow() )
        {
            Row row = _table.getNextRow();
            float step = row.getStep( _w );

            row.resetIterator();

            for( int i = 0; row.hasNextValue(); ++i )
            {
                float value = row.getNextValue();
                if( value == _table.min() || value == _table.max() )
                {
                    float yPos;
                    if( bothSigns )
                    {
                        yPos = map( value, -range, range, _h / 2, -_h / 2 );                    
                    }
                    else
                    {
                        yPos =  value < 0 ? map( value, 0, -range, _h, 0 ) : map( value, 0, range, 0, -_h );
                    }

                    pushStyle();
                    fill( 100 );

                    if( value == _table.max() )
                    {
                        text( int( value ), step * i + 4, yPos - 3 );
                        text( " :: " + row._entity.getName(), step * i + textWidth( "" + int( value ) ) + 4, yPos - 3 );
                    }
                    else
                    {
                        text( int( value ), step * i + 4, yPos + 5 );
                        text( " :: " + row._entity.getName(), step * i + textWidth( "" + int( value ) ) + 4, yPos + 5 );
                    }

                    noFill();
                    stroke( 50 );
                    ellipse( step * i, yPos, 5, 5 );
                    
                    popStyle();
                }
            }
        }
        popMatrix();
    }


    public void drawAxis()
    {
        pushMatrix();
        translate( _x, _y );

        // vertical lines
        line( 0, 0, 0, -_h );
        line( _w, 0, _w, -_h );

        // value indicators from bottom to top
        line( -10, 0, 0, 0 );
        line( _w, 0, _w+10, 0 );
        
        line( -10, -_h / 2, 0, -_h / 2 );
        line( _w, -_h / 2, _w+10, -_h / 2 );

        line( -10, -_h, 0,  -_h );
        line( _w, -_h, _w+10, -_h );


        textFont( createFont( "DejaVu Sans Mono", 10 ) );

        if( _bothSigns )
        {
            float range = max( abs( _table.min() ), _table.max() );

            textAlign( RIGHT );
            text( int( -range ), -14, 0 ); 
            text( "0", -14, ( -_h / 2 ) + 3 ); 
            text( int( range ), -14, -_h + 6 ); 

            textAlign( LEFT );
            text( int( -range ), _w + 14, 0 ); 
            text( "0", _w + 14, ( -_h / 2 ) + 3 ); 
            text( int( range ), _w + 14, -_h + 6 ); 
        }
        else
        {
            textAlign( RIGHT );
            text( "0", -14, 0 ); 
            text( int( ( _table.max() + _table.min() ) / 2), -14, ( -_h / 2 ) + 3 ); 
            text( int(_table.max()), -14, -_h + 6 ); 

            textAlign( LEFT );
            text( "0", _w + 14, 0 ); 
            text( int( ( _table.max() + _table.min() ) / 2), _w + 14, ( -_h / 2 ) + 3 ); 
            text( int( _table.max() ), _w + 14, -_h + 6 ); 
        }

        popMatrix();
    }


    public void resize( float w, float h )
    {
        _w = w;
        _h = h;
    }


    public void reposition( float x, float y )
    {
        _x = x;
        _y = y;
    }


    private float _x;
    private float _y;
    private float _w;
    private float _h;

    private Table _table;
    private boolean _bothSigns;
}