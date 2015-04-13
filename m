From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 2/2] Input: Allow devices to state that they aren't joysticks
Date: Sun, 12 Apr 2015 23:07:51 -0700
Message-ID: <1428905271-3416-3-git-send-email-thellstrom@vmware.com>
References: <1428905271-3416-1-git-send-email-thellstrom@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:45242 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751418AbbDMGIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2015 02:08:12 -0400
In-Reply-To: <1428905271-3416-1-git-send-email-thellstrom@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com, dmitry.torokhov@gmail.com, Thomas Hellstrom <thellstrom@vmware.com>

Sometimes the device driver knows that a device isn't a joystick.
In those cases, allow the driver to ovveride joydev's guess.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/input/joydev.c        | 4 ++++
 drivers/input/mouse/vmmouse.c | 1 +
 include/linux/input.h         | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index f362883..6add101 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -750,6 +750,10 @@ static void joydev_cleanup(struct joydev *joydev)
 
 static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
 {
+	/* Avoid devices that explicitly don't want to be joysticks */
+	if (dev->flags & INPUT_FLAG_NO_JOYSTICK)
+		return false;
+
 	/* Avoid touchpads and touchscreens */
 	if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_TOUCH, dev->keybit))
 		return false;
diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index b3a6170..0fabe3d 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -468,6 +468,7 @@ int vmmouse_init(struct psmouse *psmouse)
 	abs_dev->id.product = PSMOUSE_VMMOUSE;
 	abs_dev->id.version = psmouse->model;
 	abs_dev->dev.parent = &psmouse->ps2dev.serio->dev;
+	abs_dev->flags |= INPUT_FLAG_NO_JOYSTICK;
 
 	if (input_register_device(priv->abs_dev))
 		goto init_fail;
diff --git a/include/linux/input.h b/include/linux/input.h
index 82ce323..516387e 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -117,6 +117,7 @@ struct input_value {
  * @vals: array of values queued in the current frame
  * @devres_managed: indicates that devices is managed with devres framework
  *	and needs not be explicitly unregistered or freed.
+ * @flags: Device flags.
  */
 struct input_dev {
 	const char *name;
@@ -187,9 +188,13 @@ struct input_dev {
 	struct input_value *vals;
 
 	bool devres_managed;
+
+	u32 flags;
 };
 #define to_input_dev(d) container_of(d, struct input_dev, dev)
 
+#define INPUT_FLAG_NO_JOYSTICK      (1 << 0)
+
 /*
  * Verify that we are in sync with input_device_id mod_devicetable.h #defines
  */
-- 
2.1.0

