From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: usbhid: Add HID_QUIRK_NO_INIT_REPORTS for
 Oculus Rift CV1
Date: Wed, 7 Jun 2017 09:11:01 +0200
Message-ID: <20170607071100.GC16591@mail.corp.redhat.com>
References: <20170607055435.25988-1-philipp.zabel@gmail.com>
 <20170607055435.25988-2-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdFGHLF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Jun 2017 03:11:05 -0400
Content-Disposition: inline
In-Reply-To: <20170607055435.25988-2-philipp.zabel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Philip,

On Jun 07 2017 or thereabouts, Philipp Zabel wrote:
> When plugging in an Oculus Rift CV1 HMD, it takes a long time until the hidraw
> devices appear, specifically two control transfers time out querying the HID
> report descriptors:
> 
>     $ echo 1 > /sys/module/hid/parameters/debug
> 
>     usb 1-3.1: new full-speed USB device number 11 using xhci_hcd
>     usb 1-3.1: New USB device found, idVendor=2833, idProduct=0031
>     usb 1-3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>     usb 1-3.1: Product: Rift
>     usb 1-3.1: Manufacturer: Oculus VR, Inc.
>     drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
>     hid-generic 0003:2833:0031.0005: Kicking head 1 tail 0
>     drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0101 wIndex=0x0000 wLength=62
>     drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010b wIndex=0x0000 wLength=64
> 
>     [10 s delay]
> 
>     drivers/hid/usbhid/hid-core.c: timeout waiting for ctrl or out queue to clear
>     drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010c wIndex=0x0000 wLength=64
>     hid-generic 0003:2833:0031.0005: usb_submit_urb(ctrl) failed: -1
>     hid-generic 0003:2833:0031.0005: timeout initializing reports
>     hid-generic 0003:2833:0031.0005: hiddev0,hidraw0: USB HID v1.10 Device [Oculus VR, Inc. Rift] on usb-0000:00:14.0-3.1/input0
>     drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1
>     hid-generic 0003:2833:0031.0006: Kicking head 1 tail 0
>     drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0101 wIndex=0x0001 wLength=62
>     drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010b wIndex=0x0001 wLength=64
> 
>     [10 s delay]
> 
>     drivers/hid/usbhid/hid-core.c: timeout waiting for ctrl or out queue to clear
>     drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x010c wIndex=0x0001 wLength=64
>     hid-generic 0003:2833:0031.0006: usb_submit_urb(ctrl) failed: -1
>     hid-generic 0003:2833:0031.0006: timeout initializing reports
>     hid-generic 0003:2833:0031.0006: hiddev0,hidraw1: USB HID v1.10 Device [Oculus VR, Inc. Rift] on usb-0000:00:14.0-3.1/input1
>     usbcore: registered new interface driver usbhid
>     usbhid: USB HID core driver
> 
> These timeouts disappear when setting HID_QUIRK_NO_INIT_REPORTS. The hidraw
> devices appear quickly and are functional.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---

2 things:
- the 2 patches should be squashed together. There is no point having a
  single patch for just 2 defines not used anywhere else.
- I believe you don't even need this quirk in the development version of
  the hid tree. Would you mind trying a plain v4.12-rcX and report if
  you still need the quirk?

Cheers,
Benjamin

>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 6316498b7812..7b2df4042167 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -111,6 +111,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
> +	{ USB_VENDOR_ID_OCULUSVR, USB_DEVICE_ID_RIFT_CV1, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
> -- 
> 2.11.0
> 
