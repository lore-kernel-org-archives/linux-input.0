From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH resend] Input: usbtouchscreen - initialize eGalax devices
Date: Fri, 31 Aug 2012 20:37:26 -0400
Message-ID: <20120901003726.GG24820@alittletooquiet.net>
References: <20120831232338.GF24820@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:57690 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab2IAAi2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Aug 2012 20:38:28 -0400
Content-Disposition: inline
In-Reply-To: <20120831232338.GF24820@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

From: Forest Bond <forest.bond@rapidrollout.com>

Certain eGalax devices expose an interface with class HID and protocol
None.  Some work with usbhid and some work with usbtouchscreen, but
there is no easy way to differentiate.  Sending an eGalax diagnostic
packet seems to kick them all into using the right protocol for
usbtouchscreen, so we can continue to bind them all there (as opposed to
handing some off to usbhid).

This fixes a regression for devices that were claimed by (and worked
with) usbhid prior to commit 139ebe8dc80dd74cb2ac9f5603d18fbf5cff049f
("Input: usbtouchscreen - fix eGalax HID ignoring"), which made
usbtouchscreen claim them instead.  With this patch they will still be
claimed by usbtouchscreen, but they will actually report events
usbtouchscreen can understand.  Note that these devices will be limited
to the usbtouchscreen feature set so e.g. dual touch features are not
supported.

I have the distinct pleasure of needing to support devices of both types
and have tested accordingly.

Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
---
 drivers/input/touchscreen/usbtouchscreen.c |   36 ++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index e32709e..64b4b17 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -304,6 +304,41 @@ static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 #define EGALAX_PKT_TYPE_REPT		0x80
 #define EGALAX_PKT_TYPE_DIAG		0x0A
 
+static int egalax_init(struct usbtouch_usb *usbtouch)
+{
+	int ret, i;
+	unsigned char *buf;
+	struct usb_device *udev = interface_to_usbdev(usbtouch->interface);
+
+	/* An eGalax diagnostic packet kicks the device into using the right
+	 * protocol.  We send a "check active" packet.  The response will be
+	 * read later and ignored.
+	 */
+
+	buf = kmalloc(3, GFP_KERNEL);
+	buf[0] = EGALAX_PKT_TYPE_DIAG;
+	buf[1] = 1;	/* length */
+	buf[2] = 'A';	/* command - check active */
+
+	for (i = 0; i < 3; i++) {
+		ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				      0,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				      0, 0, buf, 3,
+				      USB_CTRL_SET_TIMEOUT);
+		if (ret >= 0) {
+			ret = 0;
+			break;
+		}
+		if (ret != -EPIPE)
+			break;
+	}
+
+	kfree(buf);
+
+	return ret;
+}
+
 static int egalax_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
 {
 	if ((pkt[0] & EGALAX_PKT_TYPE_MASK) != EGALAX_PKT_TYPE_REPT)
@@ -1056,6 +1091,7 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
 		.process_pkt	= usbtouch_process_multi,
 		.get_pkt_len	= egalax_get_pkt_len,
 		.read_data	= egalax_read_data,
+		.init		= egalax_init,
 	},
 #endif
 
-- 
1.7.0.4
