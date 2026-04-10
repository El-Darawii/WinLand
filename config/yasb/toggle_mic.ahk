; Toggle microphone mute with Win+Backspace
#Backspace::
{
    ; Send the mute toggle key (usually F20 or a specific key)
    ; This uses the Windows built-in mic mute functionality
    Send {Volume_Mute}
    
    ; Alternative: Use SoundSet to toggle microphone
    SoundSet, +1, MASTER, mute, 2
    return
}
