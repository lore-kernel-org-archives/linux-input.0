From: Richard Hughes <rhughes@redhat.com>
Subject: Remove HID ignore quirk for MGE UPS devices
Date: Fri, 15 Aug 2008 12:01:01 +0100
Message-ID: <1218798061.14646.13.camel@hughsie-work>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-frwWP/FJFdxJGvNI/gee"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944AbYHOMlx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2008 08:41:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Arnaud Quette <aquette.dev@gmail.com>, David Zeuthen <davidz@redhat.com>, "kay.sievers" <kay.sievers@vrfy.org>


--=-frwWP/FJFdxJGvNI/gee
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch reverts the change made four years ago here:
http://www.vg.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-hid-2.4.25-pre7.patch

UPS's made by MGE can be used with usbhid just fine, and by removing the
ignore quirk allows them to be used with HAL so they just work when plugged
in, without needing to be manually configured.

With the ignore quirk in place a user would have to configure NUT before the
UPS could be used, as NUT uses it's own internal USB matching framework
to match against the USB devices, do low level control messages on the
device and then parse the HID tables all in userspace.

This is not needed, as allowing the device to be claimed as a usbhid device
allows it to be used like any other USB UPS device. The devices correctly
advertise the power device page which can be queried for the device state.

I assume the quirk was changed so that people using < libusb 0.1.8 could
still use NUT's internal HID code to manage the UPS.
libusb 0.1.8 was released quite some time ago: 2004-02-11.

This patch does not break NUT as in drivers/libusb.c the device is force
unbound from the kernel driver using usb_detach_kernel_driver_np () where
it can be controlled like normal.

Signed-off-by: Richard Hughes <rhughes@redhat.com>

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 61e78a4..faf3f4e 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -568,8 +568,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETEST, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1024LS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1208LS, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_HIDDEV },
+	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_HIDDEV },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 20, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 30, HID_QUIRK_IGNORE },



--=-frwWP/FJFdxJGvNI/gee
Content-Disposition: attachment; filename=0001-remove-hid-ignore-quirk-for-mge-ups-devices.patch
Content-Type: text/x-patch; name=0001-remove-hid-ignore-quirk-for-mge-ups-devices.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

commit 0abf9c8395f83ba1396574ee4ca0efa3541b56b1
Author: Richard Hughes <richard@hughsie.com>
Date:   Wed Aug 13 09:43:02 2008 +0100

    remove hid ignore quirk for MGE UPS devices
    
    This patch reverts the change made four years ago here:
    http://www.vg.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-hid-2.4.25-pre7.patch
    
    UPS's made by MGE can be used with usbhid just fine, and by removing the
    ignore quirk allows them to be used with HAL so they just work when plugged
    in, without needing to be manually configured.
    
    With the ignore quirk in place a user would have to configure NUT before the
    UPS could be used, as NUT uses it's own internal USB matching framework
    to match against the USB devices, do low level control messages on the
    device and then parse the HID tables all in userspace.
    
    This is not needed, as allowing the device to be claimed as a usbhid device
    allows it to be used like any other USB UPS device. The devices correctly
    advertise the power device page which can be queried for the device state.
    
    I assume the quirk was changed so that people using < libusb 0.1.8 could
    still use NUT's internal HID code to manage the UPS.
    libusb 0.1.8 was released quite some time ago: 2004-02-11.
    
    This patch does not break NUT as in drivers/libusb.c the device is force
    unbound from the kernel driver using usb_detach_kernel_driver_np () where
    it can be controlled like normal.
    
    Signed-off-by: Richard Hughes <rhughes@redhat.com>

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 61e78a4..faf3f4e 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -568,8 +568,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETEST, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1024LS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1208LS, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_HIDDEV },
+	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_HIDDEV },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 20, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 30, HID_QUIRK_IGNORE },

--=-frwWP/FJFdxJGvNI/gee--

