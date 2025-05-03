from enum import Enum
from typing import Any, Optional

from flet.core.constrained_control import ConstrainedControl
from flet.core.control import OptionalNumber
from flet.core.control_event import ControlEvent
from flet.core.event_handler import EventHandler
from flet.core.ref import Ref
from flet.core.types import OptionalEventCallable

class FletZxing(ConstrainedControl):
    """
    FletZxing ConstrainedControl description.
    """

    def __init__(
        self,
        #
        # Control
        #
        ref: Optional[Ref] = None,
        opacity: OptionalNumber = None,
        visible: Optional[bool] = None,
        data: Any = None,
        #
        # ConstrainedControl
        #
        left: OptionalNumber = None,
        top: OptionalNumber = None,
        right: OptionalNumber = None,
        bottom: OptionalNumber = None,
        #
        # FletZxing specific
        #
        isMultiScan: Optional[bool] = False,
        on_scan_success: OptionalEventCallable["ScanSuccessEvent"] = None,
        on_multi_scan_mode_changed: OptionalEventCallable["MultiScanModeChangedEvent"] = None,
    ):
        ConstrainedControl.__init__(
            self,
            ref=ref,
            opacity=opacity,
            visible=visible,
            data=data,
            left=left,
            top=top,
            right=right,
            bottom=bottom,
        )

        self.__on_scan_success = EventHandler(lambda e: ScanSuccessEvent(e))
        self._add_event_handler("OnScanSuccess", self.__on_scan_success.get_handler())

        self.__on_multi_scan_mode_changed = EventHandler(lambda e: MultiScanModeChangedEvent(e))
        self._add_event_handler("OnMultiScanModeChanged", self.__on_multi_scan_mode_changed.get_handler())

        self.isMultiScan = isMultiScan
        self.on_scan_success = on_scan_success
        self.on_multi_scan_mode_changed = on_multi_scan_mode_changed

    def _get_control_name(self):
        return "flet_zxing"

    @property
    def version(self) -> Optional[str]:
        return self._get_attr("version", data_type="str")

    @property
    def isMultiScan(self) -> Optional[bool]:
        return self._get_attr("isMultiScan", data_type="bool")

    @isMultiScan.setter
    def isMultiScan(self, value: Optional[bool]):
        self._set_attr("isMultiScan", value)

    @property
    def on_scan_success(self) -> OptionalEventCallable["ScanSuccessEvent"]:
        return self.__on_scan_success.handler

    @on_scan_success.setter
    def on_scan_success(self, handler: OptionalEventCallable["ScanSuccessEvent"]):
        self.__on_scan_success.handler = handler

    @property
    def on_multi_scan_mode_changed(self) -> OptionalEventCallable["MultiScanModeChangedEvent"]:
        return self.__on_multi_scan_mode_changed.handler

    @on_multi_scan_mode_changed.setter
    def on_multi_scan_mode_changed(self, handler: OptionalEventCallable["MultiScanModeChangedEvent"]):
        self.__on_multi_scan_mode_changed.handler = handler


class ScanSuccessEvent(ControlEvent):
    def __init__(self, e: ControlEvent):
        super().__init__(e.target, e.name, eval(e.data), e.control, e.page)


class MultiScanModeChangedEvent(ControlEvent):
    def __init__(self, e: ControlEvent):
        super().__init__(e.target, e.name, eval(e.data), e.control, e.page)
