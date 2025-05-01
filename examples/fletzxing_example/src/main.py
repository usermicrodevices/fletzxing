import logging, flet, platform

from flet_zxing import ScanSuccessEvent, MultiScanModeChangedEvent, FletZxing

if flet.utils.platform_utils.is_mobile() and platform.system() in ['Linux', 'Android']:
    from third_party.chaquopy.stream import redirect_stdout_stderr
    redirect_stdout_stderr()

def main(page: flet.Page):
    page.vertical_alignment = flet.MainAxisAlignment.CENTER
    page.horizontal_alignment = flet.CrossAxisAlignment.CENTER

    ver = f'‼Zxing version: {fz.version}'
    logging.debug(ver)
    version = flet.Text(ver)

    status = flet.Text(platform.system())

    def on_scansuccess(evt: ScanSuccessEvent):
        msg = f'‼ZXING VERSION: {evt.control.version}; ‼DATA: {evt.data}'
        logging.debug(msg)
        status.value = msg
        status.update()

    def on_multiscanmode_changed(evt: MultiScanModeChangedEvent):
        msg = f'‼ZXING VERSION: {evt.control.version}; ‼MultiScanMode: {evt.data}'
        logging.debug(msg)
        status.value = msg
        status.update()

    fz = FletZxing(
        on_scan_success = on_scansuccess,
        on_multi_scan_mode_changed = on_multiscanmode_changed
    )

    page.add(
        flet.Container(height=150,
            width=300,
            alignment = flet.alignment.center,
            bgcolor=flet.Colors.GREY_200,
            content=fz,
        ),
        version,
        status
    )


flet.app(main)
