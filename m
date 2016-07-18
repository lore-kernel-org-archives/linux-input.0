From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/4] input: tablet: pegasus_notetaker: Track usb control msg errors
Date: Mon, 18 Jul 2016 16:29:06 +0200
Message-ID: <1468852149-2614-2-git-send-email-martink@posteo.de>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468852149-2614-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/tablet/pegasus_notetaker.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 83aa583..27cb352 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -79,7 +79,7 @@ struct pegasus {
 	struct work_struct init;
 };
 
-static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
+static int pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
 {
 	const int sizeof_buf = len + 2;
 	int result;
@@ -87,7 +87,7 @@ static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
 
 	cmd_buf = kmalloc(sizeof_buf, GFP_KERNEL);
 	if (!cmd_buf)
-		return;
+		return -ENOMEM;
 
 	cmd_buf[0] = NOTETAKER_REPORT_ID;
 	cmd_buf[1] = len;
@@ -100,17 +100,23 @@ static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
 				 0, 0, cmd_buf, sizeof_buf,
 				 USB_CTRL_SET_TIMEOUT);
 
-	if (result != sizeof_buf)
-		dev_err(&pegasus->usbdev->dev, "control msg error\n");
+	if (result != sizeof_buf) {
+		if (result >= 0)
+			result = -EIO;
+		dev_err(&pegasus->usbdev->dev, "control msg error: %d\n",
+			result);
+	}
 
 	kfree(cmd_buf);
+
+	return result;
 }
 
-static void pegasus_set_mode(struct pegasus *pegasus, u8 mode, u8 led)
+static int pegasus_set_mode(struct pegasus *pegasus, u8 mode, u8 led)
 {
 	u8 cmd[] = {NOTETAKER_SET_CMD, NOTETAKER_SET_MODE, led, mode};
 
-	pegasus_control_msg(pegasus, cmd, sizeof(cmd));
+	return pegasus_control_msg(pegasus, cmd, sizeof(cmd));
 }
 
 static void pegasus_parse_packet(struct pegasus *pegasus)
@@ -184,8 +190,12 @@ static void pegasus_irq(struct urb *urb)
 static void pegasus_init(struct work_struct *work)
 {
 	struct pegasus *pegasus = container_of(work, struct pegasus, init);
+	int retval;
 
-	pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
+	retval = pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
+	if (retval < 0)
+		dev_err(&pegasus->usbdev->dev, "pegasus_set_mode error: %d\n",
+			retval);
 }
 
 static int pegasus_open(struct input_dev *dev)
@@ -201,7 +211,7 @@ static int pegasus_open(struct input_dev *dev)
 	if (usb_submit_urb(pegasus->irq, GFP_KERNEL))
 		retval = -EIO;
 
-	pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
+	retval = pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
 
 	usb_autopm_put_interface(pegasus->intf);
 
-- 
2.1.4
