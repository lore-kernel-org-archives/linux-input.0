From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 2/4] input: mt: Collect slots initialization code
Date: Mon, 29 Nov 2010 08:13:20 +0100
Message-ID: <1291014802-17061-3-git-send-email-rydberg@euromail.se>
References: <1291014802-17061-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291014802-17061-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

The MT slots devices all follow the same initialization pattern
of creating slots and hinting about buffer size. Let drivers call
an initialization function instead, and make sure it can be called
repeatedly without side effects.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-3m-pct.c                |    5 +----
 drivers/input/input-mt.c                |   19 +++++++++++++------
 drivers/input/misc/uinput.c             |    3 +--
 drivers/input/tablet/wacom_wac.c        |    2 +-
 drivers/input/touchscreen/wacom_w8001.c |    2 +-
 include/linux/input-mt.h                |    2 +-
 6 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-3m-pct.c b/drivers/hid/hid-3m-pct.c
index cb507f4..e3711c5 100644
--- a/drivers/hid/hid-3m-pct.c
+++ b/drivers/hid/hid-3m-pct.c
@@ -29,7 +29,6 @@ MODULE_LICENSE("GPL");
 
 #define MAX_SLOTS		60
 #define MAX_TRKID		USHRT_MAX
-#define MAX_EVENTS		360
 
 /* estimated signal-to-noise ratios */
 #define SN_MOVE			2048
@@ -123,9 +122,7 @@ static int mmm_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 					EV_ABS, ABS_MT_TRACKING_ID);
 			input_set_abs_params(hi->input, ABS_MT_TRACKING_ID,
 					     0, MAX_TRKID, 0, 0);
-			if (!hi->input->mt)
-				input_mt_create_slots(hi->input, MAX_SLOTS);
-			input_set_events_per_packet(hi->input, MAX_EVENTS);
+			input_mt_init_slots(hi->input, MAX_SLOTS);
 			return 1;
 		}
 		/* let hid-input decide for the others */
diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index ee24d28..c4a9784 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -12,20 +12,25 @@
 #include <linux/slab.h>
 
 /**
- * input_mt_create_slots() - create MT input slots
+ * input_mt_init_slots() - initialize MT input slots
  * @dev: input device supporting MT events and finger tracking
  * @num_slots: number of slots used by the device
  *
- * This function allocates all necessary memory for MT slot handling in the
- * input device, and adds ABS_MT_SLOT to the device capabilities. All slots
- * are initially marked as unused by setting ABS_MT_TRACKING_ID to -1.
+ * This function allocates all necessary memory for MT slot handling
+ * in the input device, adds ABS_MT_SLOT to the device capabilities
+ * and sets up appropriate event buffers. All slots are initially
+ * marked as unused by setting ABS_MT_TRACKING_ID to -1. May be called
+ * repeatedly. Returns -EINVAL if attempting to reinitialize with a
+ * different number of slots.
  */
-int input_mt_create_slots(struct input_dev *dev, unsigned int num_slots)
+int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots)
 {
 	int i;
 
 	if (!num_slots)
 		return 0;
+	if (dev->mt)
+		return dev->mtsize != num_slots ? -EINVAL : 0;
 
 	dev->mt = kcalloc(num_slots, sizeof(struct input_mt_slot), GFP_KERNEL);
 	if (!dev->mt)
@@ -33,6 +38,7 @@ int input_mt_create_slots(struct input_dev *dev, unsigned int num_slots)
 
 	dev->mtsize = num_slots;
 	input_set_abs_params(dev, ABS_MT_SLOT, 0, num_slots - 1, 0, 0);
+	input_set_events_per_packet(dev, 6 * num_slots);
 
 	/* Mark slots as 'unused' */
 	for (i = 0; i < num_slots; i++)
@@ -40,7 +46,7 @@ int input_mt_create_slots(struct input_dev *dev, unsigned int num_slots)
 
 	return 0;
 }
-EXPORT_SYMBOL(input_mt_create_slots);
+EXPORT_SYMBOL(input_mt_init_slots);
 
 /**
  * input_mt_destroy_slots() - frees the MT slots of the input device
@@ -54,5 +60,6 @@ void input_mt_destroy_slots(struct input_dev *dev)
 	kfree(dev->mt);
 	dev->mt = NULL;
 	dev->mtsize = 0;
+	dev->slot = 0;
 }
 EXPORT_SYMBOL(input_mt_destroy_slots);
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index e8962b1..67aa7ba 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -407,8 +407,7 @@ static int uinput_setup_device(struct uinput_device *udev, const char __user *bu
 			goto exit;
 		if (test_bit(ABS_MT_SLOT, dev->absbit)) {
 			int nslot = input_abs_get_max(dev, ABS_MT_SLOT) + 1;
-			input_mt_create_slots(dev, nslot);
-			input_set_events_per_packet(dev, 6 * nslot);
+			input_mt_init_slots(dev, nslot);
 		} else if (test_bit(ABS_MT_POSITION_X, dev->absbit)) {
 			input_set_events_per_packet(dev, 60);
 		}
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 107ee3a..3f9e280 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1273,7 +1273,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
 
-			input_mt_create_slots(input_dev, 2);
+			input_mt_init_slots(input_dev, 2);
 			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 					     0, features->x_max,
 					     features->x_fuzz, 0);
diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 1fb0cbc..b706cd5 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -318,7 +318,7 @@ static int w8001_setup(struct w8001 *w8001)
 		case 5:
 			w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
 
-			input_mt_create_slots(dev, 2);
+			input_mt_init_slots(dev, 2);
 			input_set_abs_params(dev, ABS_MT_TRACKING_ID,
 						0, MAX_TRACKING_ID, 0, 0);
 			input_set_abs_params(dev, ABS_MT_POSITION_X,
diff --git a/include/linux/input-mt.h b/include/linux/input-mt.h
index 4f5e9d0..d7f6518 100644
--- a/include/linux/input-mt.h
+++ b/include/linux/input-mt.h
@@ -33,7 +33,7 @@ static inline int input_mt_get_value(const struct input_mt_slot *slot,
 	return slot->abs[code - ABS_MT_FIRST];
 }
 
-int input_mt_create_slots(struct input_dev *dev, unsigned int num_slots);
+int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots);
 void input_mt_destroy_slots(struct input_dev *dev);
 
 static inline void input_mt_slot(struct input_dev *dev, int slot)
-- 
1.7.1
