From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: factor out and export input_device_id matching code
Date: Mon,  9 Oct 2017 15:34:08 -0700
Message-ID: <20171009223410.17164-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Factor out and export input_match_device_id() so that modules may use it.
It will be needed by joydev to blacklist accelerometers in composite
devices.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 83 +++++++++++++++++++++++----------------------------
 include/linux/input.h |  3 ++
 2 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index f157ad5784a1..a8d4f1653588 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -938,58 +938,51 @@ int input_set_keycode(struct input_dev *dev,
 }
 EXPORT_SYMBOL(input_set_keycode);
 
+bool input_match_device_id(const struct input_dev *dev,
+			   const struct input_device_id *id)
+{
+	if (id->flags & INPUT_DEVICE_ID_MATCH_BUS)
+		if (id->bustype != dev->id.bustype)
+			return false;
+
+	if (id->flags & INPUT_DEVICE_ID_MATCH_VENDOR)
+		if (id->vendor != dev->id.vendor)
+			return false;
+
+	if (id->flags & INPUT_DEVICE_ID_MATCH_PRODUCT)
+		if (id->product != dev->id.product)
+			return false;
+
+	if (id->flags & INPUT_DEVICE_ID_MATCH_VERSION)
+		if (id->version != dev->id.version)
+			return false;
+
+	if (!bitmap_subset(id->evbit, dev->evbit, EV_MAX) ||
+	    !bitmap_subset(id->keybit, dev->keybit, KEY_MAX) ||
+	    !bitmap_subset(id->relbit, dev->relbit, REL_MAX) ||
+	    !bitmap_subset(id->absbit, dev->absbit, ABS_MAX) ||
+	    !bitmap_subset(id->mscbit, dev->mscbit, MSC_MAX) ||
+	    !bitmap_subset(id->ledbit, dev->ledbit, LED_MAX) ||
+	    !bitmap_subset(id->sndbit, dev->sndbit, SND_MAX) ||
+	    !bitmap_subset(id->ffbit, dev->ffbit, FF_MAX) ||
+	    !bitmap_subset(id->swbit, dev->swbit, SW_MAX)) {
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(input_match_device_id);
+
 static const struct input_device_id *input_match_device(struct input_handler *handler,
 							struct input_dev *dev)
 {
 	const struct input_device_id *id;
 
 	for (id = handler->id_table; id->flags || id->driver_info; id++) {
-
-		if (id->flags & INPUT_DEVICE_ID_MATCH_BUS)
-			if (id->bustype != dev->id.bustype)
-				continue;
-
-		if (id->flags & INPUT_DEVICE_ID_MATCH_VENDOR)
-			if (id->vendor != dev->id.vendor)
-				continue;
-
-		if (id->flags & INPUT_DEVICE_ID_MATCH_PRODUCT)
-			if (id->product != dev->id.product)
-				continue;
-
-		if (id->flags & INPUT_DEVICE_ID_MATCH_VERSION)
-			if (id->version != dev->id.version)
-				continue;
-
-		if (!bitmap_subset(id->evbit, dev->evbit, EV_MAX))
-			continue;
-
-		if (!bitmap_subset(id->keybit, dev->keybit, KEY_MAX))
-			continue;
-
-		if (!bitmap_subset(id->relbit, dev->relbit, REL_MAX))
-			continue;
-
-		if (!bitmap_subset(id->absbit, dev->absbit, ABS_MAX))
-			continue;
-
-		if (!bitmap_subset(id->mscbit, dev->mscbit, MSC_MAX))
-			continue;
-
-		if (!bitmap_subset(id->ledbit, dev->ledbit, LED_MAX))
-			continue;
-
-		if (!bitmap_subset(id->sndbit, dev->sndbit, SND_MAX))
-			continue;
-
-		if (!bitmap_subset(id->ffbit, dev->ffbit, FF_MAX))
-			continue;
-
-		if (!bitmap_subset(id->swbit, dev->swbit, SW_MAX))
-			continue;
-
-		if (!handler->match || handler->match(handler, dev))
+		if (input_match_device_id(dev, id) &&
+		    (!handler->match || handler->match(handler, dev))) {
 			return id;
+		}
 	}
 
 	return NULL;
diff --git a/include/linux/input.h b/include/linux/input.h
index 9b03f34807a7..066093fb8b3c 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -477,6 +477,9 @@ int input_get_keycode(struct input_dev *dev, struct input_keymap_entry *ke);
 int input_set_keycode(struct input_dev *dev,
 		      const struct input_keymap_entry *ke);
 
+bool input_match_device_id(const struct input_dev *dev,
+			   const struct input_device_id *id);
+
 void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
 
 extern struct class input_class;
-- 
2.14.2.920.gcf0c67979c-goog
