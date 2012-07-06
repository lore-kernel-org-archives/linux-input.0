From: Bob Ross <pigiron@gmx.com>
Subject: [PATCH] synaptics_usb: Remove TrackPoint name trailing whitespace
Date: Fri, 6 Jul 2012 12:28:17 -0500
Message-ID: <20120706122817.4ff2cdbf@atom.pigiron.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-us.gmx.com ([74.208.5.67]:59751 "HELO
	mailout-us.mail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753986Ab2GFR2d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jul 2012 13:28:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jan Steinhoff <mail@jan-steinhoff.de>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


The USB TrackPoint name string contains a space at the trailing end that
can cause confusion/difficulty when creating udev rules. Example:

 "Synaptics Inc. Composite TouchPad / TrackPoint (Stick) "

This patch removes the trailing space.

Signed-off-by: Bob Ross <pigiron@gmx.com>
---
This patch was based from the "torvalds" git tree.

 drivers/input/mouse/synaptics_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 3c5eaaa..64cf34e 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -364,7 +364,7 @@ static int synusb_probe(struct usb_interface *intf,
 			 le16_to_cpu(udev->descriptor.idProduct));
 
 	if (synusb->flags & SYNUSB_STICK)
-		strlcat(synusb->name, " (Stick) ", sizeof(synusb->name));
+		strlcat(synusb->name, " (Stick)", sizeof(synusb->name));
 
 	usb_make_path(udev, synusb->phys, sizeof(synusb->phys));
 	strlcat(synusb->phys, "/input0", sizeof(synusb->phys));
-- 
1.7.11

