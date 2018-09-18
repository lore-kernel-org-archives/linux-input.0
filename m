From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 18/20] Input: iforce - drop bus type from iforce structure
Date: Mon, 17 Sep 2018 17:47:30 -0700
Message-ID: <20180918004732.9875-18-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It is not needed anymore as behavior is controlled by the transport
operations set up for given device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-serio.c | 1 -
 drivers/input/joystick/iforce/iforce-usb.c   | 1 -
 drivers/input/joystick/iforce/iforce.h       | 5 -----
 3 files changed, 7 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index c73d988cbc92..277522d0f324 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -214,7 +214,6 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	iforce = &iforce_serio->iforce;
 
 	iforce->xport_ops = &iforce_serio_xport_ops;
-	iforce->bus = IFORCE_232;
 
 	iforce_serio->serio = serio;
 	serio_set_drvdata(serio, iforce_serio);
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index d85258b50be2..ae2dd5b5a416 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -234,7 +234,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	iforce = &iforce_usb->iforce;
 
 	iforce->xport_ops = &iforce_usb_xport_ops;
-	iforce->bus = IFORCE_USB;
 
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 180de7a3f3a1..3e91cc381488 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -38,10 +38,6 @@
 
 #define IFORCE_MAX_LENGTH	16
 
-/* iforce::bus */
-#define IFORCE_232	1
-#define IFORCE_USB	2
-
 #define IFORCE_EFFECTS_MAX	32
 
 /* Each force feedback effect is made of one core effect, which can be
@@ -105,7 +101,6 @@ struct iforce {
 	struct input_dev *dev;		/* Input device interface */
 	struct iforce_device *type;
 	const struct iforce_xport_ops *xport_ops;
-	int bus;
 
 	spinlock_t xmit_lock;
 	/* Buffer used for asynchronous sending of bytes to the device */
-- 
2.19.0.397.gdd90340f6a-goog
