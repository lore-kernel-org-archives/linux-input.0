From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [PATCH] input: Add support for eGalax TouchKit USB touchscreen used on HP tx1305us
Date: Tue, 1 Jul 2008 21:49:55 +0200
Message-ID: <200807012149.56351.daniel.ritz-ml@swissonline.ch>
References: <200806281719.16837.daniel.ritz-ml@swissonline.ch> <200806302218.37165.daniel.ritz-ml@swissonline.ch> <20080630162327.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep27-int.chello.at ([62.179.121.47]:58677 "EHLO
	viefep27-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbYGATpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 15:45:00 -0400
In-Reply-To: <20080630162327.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alastair Bridgewater <nyef_sbcl@lisphacker.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Monday 30 June 2008 22:24:09 Dmitry Torokhov wrote:
> On Mon, Jun 30, 2008 at 10:18:36PM +0200, Daniel Ritz wrote:
> > On Monday 30 June 2008 17:23:35 Dmitry Torokhov wrote:
> > > Hi Alastair,
> > > 
> > > On Sat, Jun 28, 2008 at 02:18:24PM -0400, Alastair Bridgewater wrote:
> > > >       bInterfaceClass         3 Human Interface Devices
> > > >       bInterfaceSubClass      1 Boot Interface Subclass
> > > >       bInterfaceProtocol      2 Mouse
> > > 
> > > I think we can try to make usbtouchscreen ignore eGalaxes with
> > > interface class set to HID?
> > > 
> > 
> > yeah, i was thinking of that too...something like the attached?
> > it's completely untested, so no signed-off-by yet...
> > 
> 
> Yeah, that looks nice. If both you guys could test it it'd be grand.
> 

ok, i got around testing the patch with my non-HID screen. it still works.
so from my side it's ok...attached the patch with the signed-off-by line
for your patch queue...

rgds
-daniel
----

[PATCH] usbtouchscreen: ignore newer eGalax screens with HID protocol

The newer versions of the eGalax/EETI screen implement the HID protocol.
The device IDs are still the same, but the USB interface descriptor shows
the device being of HID class. Change usbtouchscreen to ignore the HID
models as they are handled by usbhid.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 3a0a8ca..4736262 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -49,6 +49,7 @@
 #include <linux/init.h>
 #include <linux/usb.h>
 #include <linux/usb/input.h>
+#include <linux/hid.h>
 
 
 #define DRIVER_VERSION		"v0.6"
@@ -101,7 +102,7 @@ struct usbtouch_usb {
 
 /* device types */
 enum {
-	DEVTPYE_DUMMY = -1,
+	DEVTYPE_IGNORE = -1,
 	DEVTYPE_EGALAX,
 	DEVTYPE_PANJIT,
 	DEVTYPE_3M,
@@ -115,8 +116,21 @@ enum {
 	DEVTYPE_GOTOP,
 };
 
+#define USB_DEVICE_HID_CLASS(vend, prod) \
+	.match_flags = USB_DEVICE_ID_MATCH_INT_CLASS \
+		| USB_DEVICE_ID_MATCH_DEVICE, \
+	.idVendor = (vend), \
+	.idProduct = (prod), \
+	.bInterfaceClass = USB_INTERFACE_CLASS_HID, \
+	.bInterfaceProtocol = USB_INTERFACE_PROTOCOL_MOUSE
+
 static struct usb_device_id usbtouch_devices[] = {
 #ifdef CONFIG_TOUCHSCREEN_USB_EGALAX
+	/* ignore the HID capable devices, handled by usbhid */
+	{USB_DEVICE_HID_CLASS(0x0eef, 0x0001), .driver_info = DEVTYPE_IGNORE},
+	{USB_DEVICE_HID_CLASS(0x0eef, 0x0002), .driver_info = DEVTYPE_IGNORE},
+
+	/* normal device IDs */
 	{USB_DEVICE(0x3823, 0x0001), .driver_info = DEVTYPE_EGALAX},
 	{USB_DEVICE(0x3823, 0x0002), .driver_info = DEVTYPE_EGALAX},
 	{USB_DEVICE(0x0123, 0x0001), .driver_info = DEVTYPE_EGALAX},
@@ -857,6 +871,10 @@ static int usbtouch_probe(struct usb_interface *intf,
 	struct usbtouch_device_info *type;
 	int err = -ENOMEM;
 
+	/* some devices are ignored */
+	if (id->driver_info == DEVTYPE_IGNORE)
+		return -ENODEV;
+
 	interface = intf->cur_altsetting;
 	endpoint = &interface->endpoint[0].desc;
 



