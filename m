From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 06/20] Input: iforce - add bus type and parent arguments to iforce_init_device()
Date: Mon, 17 Sep 2018 17:47:18 -0700
Message-ID: <20180918004732.9875-6-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Note that the parent device for the USB-connected controllers is now
USB interface instead of USB device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c  | 19 ++++---------------
 drivers/input/joystick/iforce/iforce-serio.c |  2 +-
 drivers/input/joystick/iforce/iforce-usb.c   |  2 +-
 drivers/input/joystick/iforce/iforce.h       |  3 ++-
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 4401ca4a4c38..894769d03df3 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -221,7 +221,8 @@ static void iforce_close(struct input_dev *dev)
 	iforce->xport_ops->stop_io(iforce);
 }
 
-int iforce_init_device(struct iforce *iforce)
+int iforce_init_device(struct device *parent, u16 bustype,
+		       struct iforce *iforce)
 {
 	struct input_dev *input_dev;
 	struct ff_device *ff;
@@ -243,20 +244,8 @@ int iforce_init_device(struct iforce *iforce)
  * Input device fields.
  */
 
-	switch (iforce->bus) {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	case IFORCE_USB:
-		input_dev->id.bustype = BUS_USB;
-		input_dev->dev.parent = &iforce->usbdev->dev;
-		break;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	case IFORCE_232:
-		input_dev->id.bustype = BUS_RS232;
-		input_dev->dev.parent = &iforce->serio->dev;
-		break;
-#endif
-	}
+	input_dev->id.bustype = bustype;
+	input_dev->dev.parent = parent;
 
 	input_set_drvdata(input_dev, iforce);
 
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index afc7521b430d..b5dea273f98e 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -183,7 +183,7 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	if (err)
 		goto fail1;
 
-	err = iforce_init_device(iforce);
+	err = iforce_init_device(&serio->dev, BUS_RS232, iforce);
 	if (err)
 		goto fail2;
 
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 10b583b5fc82..824df4273774 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -229,7 +229,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	usb_fill_control_urb(iforce->ctrl, dev, usb_rcvctrlpipe(dev, 0),
 			(void*) &iforce->cr, iforce->edata, 16, iforce_usb_ctrl, iforce);
 
-	err = iforce_init_device(iforce);
+	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
 	if (err)
 		goto fail;
 
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index c020d61eccf2..3ee9245a415b 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -156,7 +156,8 @@ static inline int iforce_get_id_packet(struct iforce *iforce, u8* id)
 
 /* Public functions */
 /* iforce-main.c */
-int iforce_init_device(struct iforce *iforce);
+int iforce_init_device(struct device *parent, u16 bustype,
+		       struct iforce *iforce);
 
 /* iforce-packets.c */
 int iforce_control_playback(struct iforce*, u16 id, unsigned int);
-- 
2.19.0.397.gdd90340f6a-goog
