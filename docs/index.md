# Introduction

Zxing for Flet.

## Examples

```
import flet as ft

from fletzxing import FletZxing


def main(page: ft.Page):
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    page.add(
        ft.Container(height=150, width=300, alignment = ft.alignment.center, bgcolor=ft.Colors.PURPLE_200,
            content=FletZxing(
            tooltip="My new FletZxing Control tooltip",
        ),),
    )


ft.app(main)
```

## Classes

[FletZxing](FletZxing.md)


