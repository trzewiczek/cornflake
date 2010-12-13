/**
 * The purpose for this class is to make a wrapper 
 * around x and y position not to change it after
 * object initialization. It's not possible in P5 though. 
 *
 * TODO: split this clas into two classes:
 *   Map - informatin and calculations about the map
 *   MapPoint - information and calculations about single positions
 */

public class MapPoint
{
    private float _x;
    private float _y;

    private float _map_width = 600;
    private float _map_height = 563;

    private float _w2h_ratio = _map_width / _map_height;
    private float _h2w_ratio = _map_height / _map_width;

    public MapPoint( float x, float y )
    {
        _x = x;
        _y = y;
    }


    // if only one dimension of the map is known set the other to 0 or less 
    // it's going to be computed by the ratio of the map
    public MapPoint( float x, float y, float map_width, float map_height )
    {
        _x = x;
        _y = y;

        if( map_width <= 0 )
        {
            _map_width = map_height * _h2w_ratio;
            _map_height = map_height;
        }
        else
        {
            _map_width = map_width;
            _map_height = map_width * _w2h_ratio;
        }        
    }

    
    
    // returns x on the current map
    public float x()
    {
        return _x * _map_width;
    }


    // returns x on the current map
    public float y()
    {
        return _y * _map_height;
    }


    // returns normalized x in range (0.0-1.0)
    // the map is not square so take care about it
    public float normalizedX()
    {
        return _x;
    }


    // returns normalized y in range (0.0-1.0)
    // the map is not square so take care about it
    public float normalizedY()
    {
        return _y;
    }
}

