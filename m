From: Dennis O'Brien <dennis.obrien@eqware.net>
Subject: [PATCH 1/1] usb: Remove Vernier devices from lsusb and hid_ignore_list
Date: Sun, 31 May 2015 09:19:59 -0700
Message-ID: <556B34AF.7050000@eqware.net>
References: <555DEEFB.50604@eqware.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:59557 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756366AbbEaQUH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2015 12:20:07 -0400
In-Reply-To: <555DEEFB.50604@eqware.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: gregkh@linuxfoundation.org, jminor@vernier.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, dennis.obrien@eqware.net

From: Dennis O'Brien <dennis.obrien@eqware.net>

Removes Vernier Software & Technology devices from the ldusb
driver and the hid_ignore_list table of the usbhid driver in the
Linux tree.  These devices will now be supported via the hidraw
driver.

A user space driver for these devices will be found in the
Go! Software Development Kit from Vernier at
http://www.vernier.com/downloads/software-development-kits/go-sdk/.
These devices are also be supported by the LabQuest2 standalone
interface shown at http://www.vernier.com/products/interfaces/labq2/
and the LoggerPro for Linux software shown at
http://www.vernier.com/downloads/logger-pro-linux/.

Signed-off-by: Dennis O'Brien <dennis.obrien@eqware.net>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
  drivers/hid/hid-core.c   |    5 -----
  drivers/hid/hid-ids.h    |    7 -------
  drivers/usb/misc/ldusb.c |   10 ----------
  3 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 722a925..3a9abfe 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2399,11 +2399,6 @@ static const struct hid_device_id hid_ignore_list[] = {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_WTP) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
  #endif
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LABPRO) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_GOTEMP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_CYCLOPS) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LCSPEC) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_4_PHIDGETSERVO_20) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41f167e..9036beb 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -957,13 +957,6 @@
  #define USB_DEVICE_ID_VELLEMAN_K8061_FIRST	0x8061
  #define USB_DEVICE_ID_VELLEMAN_K8061_LAST	0x8068
  
-#define USB_VENDOR_ID_VERNIER		0x08f7
-#define USB_DEVICE_ID_VERNIER_LABPRO	0x0001
-#define USB_DEVICE_ID_VERNIER_GOTEMP	0x0002
-#define USB_DEVICE_ID_VERNIER_SKIP	0x0003
-#define USB_DEVICE_ID_VERNIER_CYCLOPS	0x0004
-#define USB_DEVICE_ID_VERNIER_LCSPEC	0x0006
-
  #define USB_VENDOR_ID_VTL		0x0306
  #define USB_DEVICE_ID_VTL_MULTITOUCH_FF3F	0xff3f
  
diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 82503a7..cce22ff 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -69,12 +69,6 @@
  #define USB_DEVICE_ID_LD_HYBRID		0x2090	/* USB Product ID of Automotive Hybrid */
  #define USB_DEVICE_ID_LD_HEATCONTROL	0x20A0	/* USB Product ID of Heat control */
  
-#define USB_VENDOR_ID_VERNIER		0x08f7
-#define USB_DEVICE_ID_VERNIER_GOTEMP	0x0002
-#define USB_DEVICE_ID_VERNIER_SKIP	0x0003
-#define USB_DEVICE_ID_VERNIER_CYCLOPS	0x0004
-#define USB_DEVICE_ID_VERNIER_LCSPEC	0x0006
-
  #ifdef CONFIG_USB_DYNAMIC_MINORS
  #define USB_LD_MINOR_BASE	0
  #else
@@ -115,10 +109,6 @@ static const struct usb_device_id ld_usb_table[] = {
  	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MCT) },
  	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_HYBRID) },
  	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_HEATCONTROL) },
-	{ USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_GOTEMP) },
-	{ USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP) },
-	{ USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_CYCLOPS) },
-	{ USB_DEVICE(USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LCSPEC) },
  	{ }					/* Terminating entry */
  };
  MODULE_DEVICE_TABLE(usb, ld_usb_table);
-- 
1.7.0.4

