-- Define your function that returns a random string from an array
local function my_function()
  -- Array of strings
  local strings = {
    "وَٱتَّقُوا۟ يَوْمًا لَّا تَجْزِى نَفْسٌ عَن نَّفْسٍ شَيْـًٔا وَلَا يُقْبَلُ مِنْهَا شَفَٰعَةٌ وَلَا يُؤْخَذُ مِنْهَا عَدْلٌ وَلَا هُمْ يُنصَرُونَ",
    "يَوْمَ تَجِدُ كُلُّ نَفْسٍ مَّا عَمِلَتْ مِنْ خَيْرٍ مُّحْضَرًا وَمَا عَمِلَتْ مِن سُوٓءٍ تَوَدُّ لَوْ أَنَّ بَيْنَهَا وَبَيْنَهُۥٓ أَمَدًۢا بَعِيدًا وَيُحَذِّرُكُمُ ٱللَّهُ نَفْسَهُۥ وَٱللَّهُ رَءُوفٌۢ بِٱلْعِبَادِ",
"يَوْمَ تَبْيَضُّ وُجُوهٌ وَتَسْوَدُّ وُجُوهٌ فَأَمَّا ٱلَّذِينَ ٱسْوَدَّتْ وُجُوهُهُمْ أَكَفَرْتُم بَعْدَ إِيمَٰنِكُمْ فَذُوقُوا۟ ٱلْعَذَابَ بِمَا كُنتُمْ تَكْفُرُونَ",
    "وَلِلَّهِ غَيْبُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ وَمَآ أَمْرُ ٱلسَّاعَةِ إِلَّا كَلَمْحِ ٱلْبَصَرِ أَوْ هُوَ أَقْرَبُ إِنَّ ٱللَّهَ عَلَىٰ كُلِّ شَىْءٍ قَدِيرٌ",
    "يَوْمَ يَدْعُوكُمْ فَتَسْتَجِيبُونَ بِحَمْدِهِۦ وَتَظُنُّونَ إِن لَّبِثْتُمْ إِلَّا قَلِيلًا",
    "وَأَنذِرْهُمْ يَوْمَ ٱلْحَسْرَةِ إِذْ قُضِىَ ٱلْأَمْرُ وَهُمْ فِى غَفْلَةٍ وَهُمْ لَا يُؤْمِنُونَ",
    "إِنَّ ٱلسَّاعَةَ ءَاتِيَةٌ أَكَادُ أُخْفِيهَا لِتُجْزَىٰ كُلُّ نَفْسٍۭ بِمَا تَسْعَىٰ"

  }

  -- Get a random index
  local random_index = math.random(1, #strings)

  -- Return the random string
  return strings[random_index]
end

-- Define a timer to run the function every 30 minutes
local function start_timer()
  -- Define the interval in milliseconds (30 minutes = 30 * 60 * 1000 milliseconds)
  local interval = 1000 * 60 * 30

  -- Start the timer
  local timer = vim.loop.new_timer()

  if not timer then
    return
  end

  local function timer_callback()
    -- Call the function
    local random_string = my_function()
    vim.notify(random_string, 'info', {
      title = 'Doaa',
      timeout = 1000 * 60
    })
  end

  -- Start the timer initially
  timer:start(interval, interval, function()
    -- Call the timer callback function
    timer_callback()

    -- Reschedule the timer to run again after the interval
    timer:again()
  end)
end

-- Start the timer
start_timer()
