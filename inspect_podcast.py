
try:
    import podcast_creator
    print(f"podcast_creator version: {podcast_creator.__version__}")
    # Try to find supported TTS providers
    if hasattr(podcast_creator, "supported_tts_providers"):
        print(f"Supported providers: {podcast_creator.supported_tts_providers}")
    else:
        print(dir(podcast_creator))
        
    # Check if there is a tts module
    if hasattr(podcast_creator, "tts"):
        print(f"TTS module: {dir(podcast_creator.tts)}")
        
except ImportError:
    print("podcast_creator not found")
