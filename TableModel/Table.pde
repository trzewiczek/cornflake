import java.lang.String.*;

public class Table
{
    public Table( PApplet processing, String fileName, boolean hasTotal )
    {
        String[][] data = parseFile( fileName );

        _rows = new Row[ data.length ];
        _minimum = Float.MAX_VALUE;
        _maximum = Float.MIN_VALUE;

        CodeCreator cc = new CodeCreator( processing );
        for( int i = 0; i < data.length; ++i )
        {
            RegionalEntity re = cc.createCode( data[ i ][ 0 ] );
            float[] vals = new float[ data[ i ].length - 2 ];
            
            for( int v = 2, inx = 0; v < data[ i ].length; ++v )
                vals[ inx++ ] = Float.parseFloat( data[ i ][ v ] );

            _rows[ i ] = new Row( re, hasTotal, vals ); 

            if( _rows[ i ].max() > _maximum )
                _maximum = _rows[ i ].max();

            if( _rows[ i ].min() < _minimum )
                _minimum = _rows[ i ].min();
        }
    }


    public Row getRow()
    {
        if( _iterator >= _rows.length )
            _iterator = 0;

        return _rows[ _iterator ];
    }


    public Row getRow( int index )
    {
        if( index < 0 || index >= _rows.length )
        {
            println( "Index out of table, Dude!" );
            return null;
        }
        
        return _rows[ index ];
    }


    public Row getNextRow()
    {
        if( _iterator < _rows.length )
            return _rows[ _iterator++ ];

        return null;
    }


    public boolean hasNextRow()
    {
        if( _iterator < _rows.length )
            return true;

        return false;
    }


    public Row getPreviousRow()
    {
        if( _iterator > 0 )
            return _rows[ _iterator-- ];

        return null;
    }


    public boolean hasPreviousRow()
    {
        if( _iterator > 0 )
            return true;

        return false;
    }


    public void resetIterator()
    {
        _iterator = 0;
    }


    public float min()
    {
        return _minimum;
    }


    public float max()
    {
        return _maximum;
    }


    private String[][] parseFile( String fileName )
    {
        String[] data = loadStrings( fileName );
        String[][] rows = new String[ data.length ][];

        for( int i = 0; i < data.length; ++i )
        {
            String l = data[ i ].replaceAll( "\"", "" ).replaceAll( " ", "" );
            
            if( l.indexOf( ';' ) != -1 )
            {
                String[] cells;
                
                if( l.endsWith( ";" ) )    
                    cells = split( l.substring( 0, l.length() - 1 ), ';' );
                else
                    cells = split( l, ';' );
                
                rows[ i ] = cells;
            }
        }
        return rows;
    }


    private Row[] _rows;
    private int _iterator = 0;

    private float _maximum;
    private float _minimum;
}
