public class Row
{
    /**
     * Row class represents the single row of a table. It provides a set
     * of functions for rapid data visualization like min/max, avarage etc.
     *
     * @param entity regional entity that row reffers to
     * @param hasTotal does the table contains total as a separate column
     * @param values actual values of the row
     */
    public Row( RegionalEntity entity, boolean hasTotal, float[] values )
    {
        _entity = entity;

        if( hasTotal )
        {
            _values = new float[ values.length - 1 ];
            arrayCopy( values, 1, _values, 0, values.length );

            _total = values[ 0 ];
        }
        else
        {
            _values = new float[ values.length ];
            arrayCopy( values, _values );

            _total = 0;
            for( int i = 0; i < _values.length; ++i )
                _total += _values[ i ];
        }

        _minimum = getMinimum();
        _maximum = getMaximum();
        _avarage = _total / _values.length;

        _intervals = getIntervals();
    }


    public float getTotal()
    {
        return _total;
    }


    public float getValue()
    {
        if( _iterator >= _values.length )
            _iterator = 0;

        return _values[ _iterator ];
    }


    public float getValue( int index )
    {
        if( index < 0 || index >= _values.length )
        {
            println( "Index out of table, Dude!" );
            return Float.MIN_VALUE;
        }
        
        return _values[ index ];
    }


    public float getNextValue()
    {
        if( _iterator < _values.length )
            return _values[ _iterator++ ];

        return Float.MIN_VALUE;
    }


    public boolean hasNextValue()
    {
        if( _iterator < _values.length )
            return true;

        return false;
    }


    public float getPreviousValue()
    {
        if( _iterator > 0 )
            return _values[ _iterator-- ];

        return Float.MIN_VALUE;
    }

    
    public float getStep( float w )
    {
        return w / ( _values.length - 1 ); 
    }


    public boolean hasPreviousValue()
    {
        if( _iterator > 0 )
            return true;

        return false;
    }


    public void resetIterator()
    {
        _iterator = 0;
    }


    public int numberOfValues()
    {
        return _values.length;
    }


    public float min()
    {
        return _minimum;
    }


    public float max()
    {
        return _maximum;
    }


    public int getContext()
    {
        return _intervals[ _iterator ];
    }


    public float avarage()
    {
        return _avarage;
    }


    private float getMinimum()
    {
        float min = Integer.MAX_VALUE;

        for( int i = 0; i < _values.length; ++i )
            if( _values[ i ] < min )
                min = _values[ i ];

        return min;
    }


    private float getMaximum()
    {
        float max = Integer.MIN_VALUE;

        for( int i = 0; i < _values.length; ++i )
            if( _values[ i ] > max )
                max = _values[ i ];

        return max;
    }


    /**
     * @return array of with description of every value:
     *         -1 - turning point (lower)
     *          0 - normal value
     *          1 - turning point (upper)
     */
    private int[] getIntervals()
    {
        int[] intervals = new int[ _values.length ];
        int tendency = 1;
        int[][] matrix = { { GOING_UP, ENTER_UPPER_PLATEAU, UPPER_PEAK }, 
                           { LEAVE_LOWER_PLATEAU, INSIDE_PLATEAU, LEAVE_UPPER_PLATEAU },
                           { LOWER_PEAK, ENTER_LOWER_PLATEAU, GOING_DOWN } };
 
        if( _values.length < 1 )
            return null;
   
        for ( int i = 0; i < _values.length - 1; i++ )
        {   
            int relation = 1;
            if ( _values[ i ] < _values[ i + 1 ] )
                relation = 0;
            if ( _values[ i ] > _values[ i + 1 ] )
                relation = 2;
   
            intervals[ i ] = matrix[ tendency ][ relation ];
   
            tendency = relation;
        } 
        return intervals;
    }


    public void plot( float x, float y, float w, float h )
    {
        plot( x, y, w, h, h, 0, 0 );
    }


    public void plot( float x, float y, float w, float h, float range, float min, float max )
    {
        float step = this.getStep( w );

        pushMatrix();

        if( min * max > 0 )
        {
            translate( x, y );  
            beginShape();
            for( int i = 0; i < _values.length; ++i )
            {
                float value = _values[ i ];
                float yPos = value < 0 ? map( value, 0, -range, h, 0 ) : map( value, 0, range, 0, -h );
                
                vertex( step * i, yPos );
            }
            endShape();
        }
        else
        {
            translate( x, y - ( h / 2 ) );  
            beginShape();
            for( int i = 0; i < _values.length; ++i )
            {
                float value = _values[ i ];
                float yPos = map( value, -range, range, h/2, -h/2 );

                vertex( step * i, yPos );
            }
            endShape();
        }
        popMatrix();
    }


    public int GOING_UP = 0;
    public int ENTER_UPPER_PLATEAU = 1;
    public int UPPER_PEAK = 2;
    public int LEAVE_LOWER_PLATEAU = 3;
    public int INSIDE_PLATEAU = 4;
    public int LEAVE_UPPER_PLATEAU = 5;
    public int LOWER_PEAK = 6;
    public int ENTER_LOWER_PLATEAU = 7;
    public int GOING_DOWN = 8;

    private RegionalEntity _entity;
            
    private float[] _values;
    private int[] _intervals; // -1, 0, 1 turning points
                
    private float _total;
    private float _minimum;
    private float _maximum;
    private float _avarage;
    
    private int _iterator = 0;
}
                                                                                                                  

