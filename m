From: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] HID: usbhid: Add HID_QUIRK_NO_INIT_REPORTS for Oculus Rift CV1
Date: Wed,  7 Jun 2017 07:54:35 +0200
Message-ID: <20170607055435.25988-2-philipp.zabel@gmail.com>
References: <20170607055435.25988-1-philipp.zabel@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170607055435.25988-1-philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

When plugging in an Oculus Rift CV1 HMD, it takes a long time until the hidraw
devices appear, specifically two control transfers time out querying the HID
report descriptors:

    $ echo 1 > /sys/module/hid/parameters/debug

    usb 1-3.1: new full-speed USB device number 11 using xhci_hcd
    usb 1-3.1: New USB device found, idVendor=2833, idProduct=0031
    usb 1-3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
    usb 1-3.1: Product: Rift
    usb 1-3.1: Manufacturer: Oculus VR, Inc.
    drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
    hid-generic 0003:2833:0031.0005: Kicking head 1 tail 0
    drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0101 wIndex=0x0000 wLength=62
    drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010b wIndex=0x0000 wLength=64

    [10 s delay]

    drivers/hid/usbhid/hid-core.c: timeout waiting for ctrl or out queue to clear
    drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010c wIndex=0x0000 wLength=64
    hid-generic 0003:2833:0031.0005: usb_submit_urb(ctrl) failed: -1
    hid-generic 0003:2833:0031.0005: timeout initializing reports
    hid-generic 0003:2833:0031.0005: hiddev0,hidraw0: USB HID v1.10 Device [Oculus VR, Inc. Rift] on usb-0000:00:14.0-3.1/input0
    drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1
    hid-generic 0003:2833:0031.0006: Kicking head 1 tail 0
    drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0101 wIndex=0x0001 wLength=62
    drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010b wIndex=0x0001 wLength=64

    [10 s delay]

    drivers/hid/usbhid/hid-core.c: timeout waiting for ctrl or out queue to clear
    drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010c wIndex=0x0001 wLength=64
    hid-generic 0003:2833:0031.0006: usb_submit_urb(ctrl) failed: -1
    hid-generic 0003:2833:0031.0006: timeout initializing reports
    hid-generic 0003:2833:0031.0006: hiddev0,hidraw1: USB HID v1.10 Device [Oculus VR, Inc. Rift] on usb-0000:00:14.0-3.1/input1
    usbcore: registered new interface driver usbhid
    usbhid: USB HID core driver

These timeouts disappear when setting HID_QUIRK_NO_INIT_REPORTS. The hidraw
devices appear quickly and are functional.

Signed-off-by: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/usbhid/hid-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 6316498b7812..7b2df4042167 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -111,6 +111,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_OCULUSVR, USB_DEVICE_ID_RIFT_CV1, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
