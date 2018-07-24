From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/5] Input: pxrc - move module device table closer to where it is used
Date: Tue, 24 Jul 2018 02:35:18 +0000
Message-ID: <20180724023520.2189-3-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: linux-input@vger.kernel.org

There is no need to have the device table first in the file.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 1560f0e39c34..327b5ef8515f 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -19,12 +19,6 @@
 #define PXRC_VENDOR_ID	(0x1781)
 #define PXRC_PRODUCT_ID	(0x0898)
 
-static const struct usb_device_id pxrc_table[] = {
-	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
-	{ }
-};
-MODULE_DEVICE_TABLE(usb, pxrc_table);
-
 struct pxrc {
 	struct input_dev	*input;
 	struct usb_interface	*intf;
@@ -277,6 +271,12 @@ static int pxrc_reset_resume(struct usb_interface *intf)
 	return pxrc_resume(intf);
 }
 
+static const struct usb_device_id pxrc_table[] = {
+	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, pxrc_table);
+
 static struct usb_driver pxrc_driver = {
 	.name =		"pxrc",
 	.probe =	pxrc_probe,
-- 
2.11.0
