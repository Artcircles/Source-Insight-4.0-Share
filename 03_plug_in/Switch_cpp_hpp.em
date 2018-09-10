/*
** cpp文件和h头文件之间切换
**
*/

macro err_not_support()
{
    var buf
    buf = GetCurrentBuf()
    var filename
    filename = GetBufName( buf)
    var err
    err = cat(filename, " does not support switch")
    msg( err)
    stop
}

macro getSwitchToFile( buf,ntime)
{
    var filename

    //buf = GetCurrentBuf()
    filename = GetBufName( buf)

    var pos1
    var pos2
    var ext
    pos1 = strrchr( filename, "\\")
    pos2 = strrchr( filename, ".")
    ext = strmid( filename, pos2+1, strlen( filename))
    filename = strmid( filename, pos1+1, pos2);
    filename = cat( filename, ".")

    if( ntime == 0)
    {
        if( ext == "cpp")
        {
            filename = cat( filename, "h")
        }
    }
    else if( ntime == 1)
    {
        if( ext == "h")
        {
            filename = cat( filename, "cpp")
        }
    }
    else if( ntime == 2)
    {
        if( ext == "cc"
        {
            filename = cat( filename, "h")
        }
    }
    else if( ntime == 3)
    {
        if( ext == "h"
        {
            filename = cat( filename, "cc")
        }
    }
    else if( ntime == 4)
    {
        if( ext == "inl"
        {
            filename = cat( filename, "h")
        }
    }
    else if( ntime == 5)
    {
        if( ext == "h"
        {
            filename = cat( filename, "inl")
        }
    }
    else if( ntime == 6)
    {
        if( ext == "h"
        {
            filename = cat( filename, "c")
        }
    }
    else if( ntime == 7)
    {
        if( ext == "c"
        {
            filename = cat( filename, "h")
        }
    }
    else
    {
        err_not_support()
    }
    return filename
}

macro try_open( filename)
{
    var buf
    var res
    buf = OpenBuf( filename)
    if( buf != hNil)
    {
        SetCurrentBuf( buf)
        res = True
    }
    else
    {
        res = False
    }
    return res
}

macro switch_cpp_hpp()
{
    var curbuf
    var filename
    var i
    var count
    var res

    curbuf = GetCurrentBuf()
    if(hNil == curbuf)
        stop

    i = 0
    count = 0
    while(i < 8)
    {
        filename = getSwitchToFile(curbuf, i)
        res = try_open( filename)
        if( res )
        {
            count = count + 1
        }
        i = i + 1
    }

    if(1 < count)
        runcmd("Window List")

    if(0 == count)
        err_not_support()
}

//not used in this case, but it show how op project, for files 124, the efficiency is good
macro openSwitchFile(fileto)
{
    var hprj
    hprj = GetCurrentProj()
    var count
    count = GetProjFileCount(hprj)

    var i
    i = 0
    var filename
    while( i < count)
    {
        filename = GetProjFileName( hprj, i)
        if( fileto == filename)
        {
            var buf
            buf = OpenBuf( filename)
            SetCurrentBuf( buf)
            stop
        }
        i = i + 1
    }
    var err
    err = cat("can not find the file ", fileto)
    msg( err)
    stop
}

macro strchr( s, c)
{
	var len
    var i
    len = strlen( s)
    i = 0
    while( i < len)
    {
        if( c == s[i])
            return i;
        i = i + 1
    }
    return -1;
}

macro strrchr( s, c)
{
    var len
    var i
    len = strlen( s)
    i = len -1
    while( i >= 0)
    {
        if( c == s[i])
            return i;
        i = i - 1
    }
    return -1;
}

macro strchrn( s, c, b)
{
    var len
    var i
    len = strlen( s)
    i = b
    while( i < len)
    {
        if( c == strmid( s, i, i+1))
            return i;
        i = i + 1
    }
    return -1;
}

macro split( s, c)
{
    var len
    var i
    len = strlen( s)
    i = 0

    var buf
    buf = NewBuf()

    var index
    index = 0
    var s
    s = ""
    while( i < len)
    {
        if( c == strmid( s, i, i+1))
        {
            if( i != 0)
            {
                AppendBufLine( buf,  s)
            }
            if( i == len -1)
                return buf
        }
        s = cat( s, c)
        i = i + 1
    }
    AppendBufLine( buf,  s)
    return buf
}