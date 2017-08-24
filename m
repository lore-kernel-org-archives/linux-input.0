From: Liang Yan <lyan@suse.com>
Subject: [PATCH v2] input/xen-kbdfront: Enable auto repeat for xen keyboard frontend driver
Date: Thu, 24 Aug 2017 09:54:14 -0400
Message-ID: <20170824135414.4870-1-lyan@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Long pressed key could not show right in XEN vncviewer after tigervnc
client changed the way how to send repeat keys, from "Down Up Down Up
..." to "Down Down ... Up". This will report autorepeat to input by
checking if same key being pressed, and let handler process it finally.

Signed-off-by: Liang Yan <lyan@suse.com>
---
v2:
- Sending autorepeat event rather than enable EV_REP bit 

drivers/input/misc/xen-kbdfront.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index fa130e7b734c..6bf56bb5f8d9 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -84,17 +84,20 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
 				    struct xenkbd_key *key)
 {
 	struct input_dev *dev;
+	int value = key->pressed;
 
 	if (test_bit(key->keycode, info->ptr->keybit)) {
 		dev = info->ptr;
 	} else if (test_bit(key->keycode, info->kbd->keybit)) {
 		dev = info->kbd;
+		if (key->pressed && test_bit(key->keycode, info->kbd->key))
+			value = 2; /* Mark as autorepeat */
 	} else {
 		pr_warn("unhandled keycode 0x%x\n", key->keycode);
 		return;
 	}
 
-	input_report_key(dev, key->keycode, key->pressed);
+	input_event(dev, EV_KEY, key->keycode, value);
 	input_sync(dev);
 }
 
-- 
2.14.1
