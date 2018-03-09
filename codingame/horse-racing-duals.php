<?

fscanf(STDIN, "%d",
    $N
);
for ($i = 0; $i < $N; $i++)
{
    fscanf(STDIN, "%d",
        $Pi
    );
    
    $P[$i] = $Pi;
}

sort($P);
$prev = 0;
$min = PHP_INT_MAX;
foreach ($P as $k => $v) {
    $diff = $v <=> $prev;
    if ($diff > 0) {
        $diff_val = $v - $prev;
    } else if ($diff < 0) {
        $diff_val = $prev - $v;
    } else { 
        $diff_val = 0;
    }
    
    if ($diff_val < $min) {
        $min = $diff_val;
    }
    $prev = $v;
}
echo ($min);