From: akpm@linux-foundation.org
Subject: [patch 3/7] usbtouchscreen: find input endpoint automatically
Date: Tue, 02 Feb 2010 14:42:52 -0800
Message-ID: <201002022242.o12MgrgM019138@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49229 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756822Ab0BBWnV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2010 17:43:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, linux@rainbow-software.org, daniel.ritz@gmx.ch, ddstreet@ieee.org, dmitry.torokhov@gmail.com, floe@butterbrot.org, greg@kroah.com, jim-linux@nurd.se, oliver@neukum.org

From: Ondrej Zary <linux@rainbow-software.org>

Find input enpoint automatically instead of assuming that the first one is
OK.  This is needed for devices with multiple endpoints such as iNexio
where the first endpoint might be output.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jim Persson <jim-linux@nurd.se>
Cc: Florian Echtler <floe@butterbrot.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/touchscreen/usbtouchscreen.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff -puN drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-find-input-endpoint-automatically drivers/input/touchscreen/usbtouchscreen.c
--- a/drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-find-input-endpoint-automatically
+++ a/drivers/input/touchscreen/usbtouchscreen.c
@@ -1057,17 +1057,25 @@ static int usbtouch_probe(struct usb_int
 	struct usbtouch_usb *usbtouch;
 	struct input_dev *input_dev;
 	struct usb_host_interface *interface;
-	struct usb_endpoint_descriptor *endpoint;
+	struct usb_endpoint_descriptor *endpoint = NULL;
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usbtouch_device_info *type;
 	int err = -ENOMEM;
+	int i;
 
 	/* some devices are ignored */
 	if (id->driver_info == DEVTYPE_IGNORE)
 		return -ENODEV;
 
 	interface = intf->cur_altsetting;
-	endpoint = &interface->endpoint[0].desc;
+	/* find first input endpoint */
+	for (i = 0; i < interface->desc.bNumEndpoints; i++)
+		if (usb_endpoint_dir_in(&interface->endpoint[i].desc)) {
+			endpoint = &interface->endpoint[i].desc;
+			break;
+		}
+	if (!endpoint)
+		return -ENXIO;
 
 	usbtouch = kzalloc(sizeof(struct usbtouch_usb), GFP_KERNEL);
 	input_dev = input_allocate_device();
_
