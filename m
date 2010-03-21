From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: [PATCH] Check whether getkeycode and setkeycode are still valide
Date: Sun, 21 Mar 2010 10:56:48 +0800
Message-ID: <20100321025648.GA24497@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:20939 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752998Ab0CUDFs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 23:05:48 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

If sparse keymap is freed before unregistering the device, there is a
window where userspace can issue EVIOCGKEYCODE or EVIOCSKEYCODE. When
that happens, kernel will crash. Noticed by Dmitry Torokhov.

Signed-off-by: Yong Wang <yong.y.wang@intel.com>
---
 drivers/input/input.c         |    6 ++++++
 drivers/input/sparse-keymap.c |    6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index e2aad0a..bfe4bdc 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -659,6 +659,9 @@ static int input_default_setkeycode(struct input_dev *dev,
 int input_get_keycode(struct input_dev *dev,
 		      unsigned int scancode, unsigned int *keycode)
 {
+	if (!dev->getkeycode)
+		return -ENODEV;
+
 	return dev->getkeycode(dev, scancode, keycode);
 }
 EXPORT_SYMBOL(input_get_keycode);
@@ -682,6 +685,9 @@ int input_set_keycode(struct input_dev *dev,
 	if (keycode > KEY_MAX)
 		return -EINVAL;
 
+	if (!dev->getkeycode || !dev->setkeycode)
+		return -ENODEV;
+
 	spin_lock_irqsave(&dev->event_lock, flags);
 
 	retval = dev->getkeycode(dev, scancode, &old_keycode);
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index f64e004..25b8d7d 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -34,6 +34,9 @@ struct key_entry *sparse_keymap_entry_from_scancode(struct input_dev *dev,
 {
 	struct key_entry *key;
 
+	if (!dev->keycode)
+		return NULL;
+
 	for (key = dev->keycode; key->type != KE_END; key++)
 		if (code == key->code)
 			return key;
@@ -55,6 +58,9 @@ struct key_entry *sparse_keymap_entry_from_keycode(struct input_dev *dev,
 {
 	struct key_entry *key;
 
+	if (!dev->keycode)
+		return NULL;
+
 	for (key = dev->keycode; key->type != KE_END; key++)
 		if (key->type == KE_KEY && keycode == key->keycode)
 			return key;
