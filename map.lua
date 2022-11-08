--[[
  * Re-maps a number from one range to another. The number '25' in a range of 110..1000 is converted from
  * a value in the range 0..100 into a value that ranges from the left edge (0) to the right edge (width) of the screen.
  * Numbers outside the range are not clamped to 0 and 1, because out-of-range values are often intentional and useful.
  *
  * @param {float} value        The incoming value to be converted
  * @param {float} istart       Lower bound of the value's current range
  * @param {float} istop        Upper bound of the value's current range
  * @param {float} ostart       Lower bound of the value's target range
  * @param {float} ostop        Upper bound of the value's target range
  *
  * @returns {float}
  *
  * @see norm
  * @see lerp
  * by Haeyong Chung
]]
  function map (value, istart, istop, ostart, ostop) 
    return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
  end

  --print(map(25, 110, 1000, 0, 100 ))