# fletzxing
FletZxing control for Flet

## Installation

Add dependency to `pyproject.toml` of your Flet app:

* **Git dependency**

Link to git repository:

```
dependencies = [
  "fletzxing @ git+https://github.com/usermicrodevices/fletzxing",
  "flet>=0.27.6",
]
```

* **PyPi dependency**  

If the package is published on pypi.org:

```
dependencies = [
  "fletzxing",
  "flet>=0.27.6",
]
```

Build your app:
```
flet build macos -v
```

## Documentation

[Link to documentation](https://usermicrodevices.github.io/fletzxing/)


## Debug on android
adb -s [DEVICE] shell logcat > debug.log
cmd package list packages -f com.github.fletzxing.flet_zxing_example
dumpsys window windows | grep fletzxing
am start -S -D -W -n com.github.fletzxing.flet_zxing_example/com.github.fletzxing.flet_zxing_example.MainActivity
