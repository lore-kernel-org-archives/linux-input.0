From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] Input: Initialize device count variables by -1
Date: Thu,  4 Dec 2014 02:09:06 +0530
Message-ID: <1417639146-3494-1-git-send-email-aniroop.mathur@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51683 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaLCUjR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 15:39:17 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so1016269pdj.28
        for <linux-input@vger.kernel.org>; Wed, 03 Dec 2014 12:39:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aniroop.mathur@gmail.com, a.mathur@samsung.com

This patch initializes input device count variables by -1 in order
to avoid extra subtraction operation performed everytime for
allocation of an input device.

Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>
---
 drivers/input/gameport/gameport.c | 4 ++--
 drivers/input/joystick/xpad.c     | 4 ++--
 drivers/input/misc/ims-pcu.c      | 4 ++--
 drivers/input/serio/serio.c       | 4 ++--
 drivers/input/serio/serio_raw.c   | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 24c41ba..d8371e8 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -490,14 +490,14 @@ EXPORT_SYMBOL(gameport_set_phys);
  */
 static void gameport_init_port(struct gameport *gameport)
 {
-	static atomic_t gameport_no = ATOMIC_INIT(0);
+	static atomic_t gameport_no = ATOMIC_INIT(-1);
 
 	__module_get(THIS_MODULE);
 
 	mutex_init(&gameport->drv_mutex);
 	device_initialize(&gameport->dev);
 	dev_set_name(&gameport->dev, "gameport%lu",
-			(unsigned long)atomic_inc_return(&gameport_no) - 1);
+			(unsigned long)atomic_inc_return(&gameport_no));
 	gameport->dev.bus = &gameport_bus;
 	gameport->dev.release = gameport_release_port;
 	if (gameport->parent)
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 177602c..64dc7cb 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -850,7 +850,7 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
-	static atomic_t led_seq	= ATOMIC_INIT(0);
+	static atomic_t led_seq	= ATOMIC_INIT(-1);
 	long led_no;
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
@@ -863,7 +863,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	led_no = (long)atomic_inc_return(&led_seq) - 1;
+	led_no = (long)atomic_inc_return(&led_seq);
 
 	snprintf(led->name, sizeof(led->name), "xpad%ld", led_no);
 	led->xpad = xpad;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 719410f..69caee9 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1851,7 +1851,7 @@ static int ims_pcu_identify_type(struct ims_pcu *pcu, u8 *device_id)
 
 static int ims_pcu_init_application_mode(struct ims_pcu *pcu)
 {
-	static atomic_t device_no = ATOMIC_INIT(0);
+	static atomic_t device_no = ATOMIC_INIT(-1);
 
 	const struct ims_pcu_device_info *info;
 	int error;
@@ -1882,7 +1882,7 @@ static int ims_pcu_init_application_mode(struct ims_pcu *pcu)
 	}
 
 	/* Device appears to be operable, complete initialization */
-	pcu->device_no = atomic_inc_return(&device_no) - 1;
+	pcu->device_no = atomic_inc_return(&device_no);
 
 	/*
 	 * PCU-B devices, both GEN_1 and GEN_2 do not have OFN sensor
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index b29134d..21698cc 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -514,7 +514,7 @@ static void serio_release_port(struct device *dev)
  */
 static void serio_init_port(struct serio *serio)
 {
-	static atomic_t serio_no = ATOMIC_INIT(0);
+	static atomic_t serio_no = ATOMIC_INIT(-1);
 
 	__module_get(THIS_MODULE);
 
@@ -525,7 +525,7 @@ static void serio_init_port(struct serio *serio)
 	mutex_init(&serio->drv_mutex);
 	device_initialize(&serio->dev);
 	dev_set_name(&serio->dev, "serio%ld",
-			(long)atomic_inc_return(&serio_no) - 1);
+			(long)atomic_inc_return(&serio_no));
 	serio->dev.bus = &serio_bus;
 	serio->dev.release = serio_release_port;
 	serio->dev.groups = serio_device_attr_groups;
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index c9a02fe..71ef5d6 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -292,7 +292,7 @@ static irqreturn_t serio_raw_interrupt(struct serio *serio, unsigned char data,
 
 static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 {
-	static atomic_t serio_raw_no = ATOMIC_INIT(0);
+	static atomic_t serio_raw_no = ATOMIC_INIT(-1);
 	struct serio_raw *serio_raw;
 	int err;
 
@@ -303,7 +303,7 @@ static int serio_raw_connect(struct serio *serio, struct serio_driver *drv)
 	}
 
 	snprintf(serio_raw->name, sizeof(serio_raw->name),
-		 "serio_raw%ld", (long)atomic_inc_return(&serio_raw_no) - 1);
+		 "serio_raw%ld", (long)atomic_inc_return(&serio_raw_no));
 	kref_init(&serio_raw->kref);
 	INIT_LIST_HEAD(&serio_raw->client_list);
 	init_waitqueue_head(&serio_raw->wait);
-- 
1.9.1

