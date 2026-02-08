import sys
try:
    import chemmcp
    print(f"Successfully imported chemmcp version: {chemmcp.__version__}")
    from chemmcp.tools import WebSearch
    print("Successfully imported WebSearch tool")
except ImportError as e:
    print(f"Import failed: {e}")
    sys.exit(1)
except Exception as e:
    print(f"An error occurred: {e}")
    # Don't exit with 1 if it's just missing keys
