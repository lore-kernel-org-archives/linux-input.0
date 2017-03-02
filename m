From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH v2] Input: sparse-keymap - use a managed allocation for keymap copy
Date: Thu,  2 Mar 2017 13:02:42 +0100
Message-ID: <20170302120242.6342-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35536 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdCBMjl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Mar 2017 07:39:41 -0500
Received: by mail-lf0-f65.google.com with SMTP id z127so5628811lfa.2
        for <linux-input@vger.kernel.org>; Thu, 02 Mar 2017 04:38:12 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Some platform drivers use devm_input_allocate_device() together with
sparse_keymap_setup() in their .probe callbacks.  While using the former
simplifies error handling, using the latter necessitates calling
sparse_keymap_free() in the error path and upon module unloading to
avoid leaking the copy of the keymap allocated by sparse_keymap_setup().

To help prevent such leaks and enable simpler error handling, make
sparse_keymap_setup() use devm_kcalloc() to allocate memory for the
keymap copy so that it gets automatically freed.

This works for both managed and non-managed input devices, although both
are handled a bit differently.  Specifically, the managed keymap copy is
attached to a different struct device:

  - for managed input devices, as all other managed resources are
    attached to the device owning the input device, we do the same to
    ensure freeing the keymap copy is properly slotted in the devres
    stack,

  - for non-managed input devices, the managed keymap copy is attached
    to the struct device embedded inside the input device itself, so
    that the keymap is freed after the last reference to the input
    device is dropped, i.e. after input_unregister_device() is called.

Note that actions previously taken by sparse_keymap_free(), i.e. taking
the input device's mutex and zeroing its keycode and keycodemax fields,
are now redundant because the managed keymap will always be freed after
the input device is unregistered.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
Changes from v1:

  - Do not add a new function.  Instead, make sparse_keymap_setup()
    always use a managed allocation, which allows making
    sparse_keymap_free() a noop and simplifies error handling.

  - Update subject, commit message and comments accordingly.

 drivers/input/sparse-keymap.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index e7409c45bdd0..fd391c339b4e 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -160,12 +160,12 @@ static int sparse_keymap_setkeycode(struct input_dev *dev,
  * @keymap: Keymap in form of array of &key_entry structures ending
  *	with %KE_END type entry
  * @setup: Function that can be used to adjust keymap entries
- *	depending on device's deeds, may be %NULL
+ *	depending on device's needs, may be %NULL
  *
  * The function calculates size and allocates copy of the original
  * keymap after which sets up input device event bits appropriately.
- * Before destroying input device allocated keymap should be freed
- * with a call to sparse_keymap_free().
+ * The allocated copy of the keymap is automatically freed when it
+ * is no longer needed.
  */
 int sparse_keymap_setup(struct input_dev *dev,
 			const struct key_entry *keymap,
@@ -180,7 +180,8 @@ int sparse_keymap_setup(struct input_dev *dev,
 	for (e = keymap; e->type != KE_END; e++)
 		map_size++;
 
-	map = kcalloc(map_size, sizeof(struct key_entry), GFP_KERNEL);
+	map = devm_kcalloc(dev->devres_managed ? dev->dev.parent : &dev->dev,
+			   map_size, sizeof(struct key_entry), GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
 
@@ -192,7 +193,7 @@ int sparse_keymap_setup(struct input_dev *dev,
 		if (setup) {
 			error = setup(dev, entry);
 			if (error)
-				goto err_out;
+				return error;
 		}
 
 		switch (entry->type) {
@@ -221,10 +222,6 @@ int sparse_keymap_setup(struct input_dev *dev,
 	dev->setkeycode = sparse_keymap_setkeycode;
 
 	return 0;
-
- err_out:
-	kfree(map);
-	return error;
 }
 EXPORT_SYMBOL(sparse_keymap_setup);
 
@@ -232,29 +229,13 @@ EXPORT_SYMBOL(sparse_keymap_setup);
  * sparse_keymap_free - free memory allocated for sparse keymap
  * @dev: Input device using sparse keymap
  *
- * This function is used to free memory allocated by sparse keymap
+ * This function used to free memory allocated by sparse keymap
  * in an input device that was set up by sparse_keymap_setup().
- * NOTE: It is safe to cal this function while input device is
- * still registered (however the drivers should care not to try to
- * use freed keymap and thus have to shut off interrupts/polling
- * before freeing the keymap).
+ * Since sparse_keymap_setup() now uses a managed allocation for the
+ * keymap copy, use of this function is deprecated.
  */
 void sparse_keymap_free(struct input_dev *dev)
 {
-	unsigned long flags;
-
-	/*
-	 * Take event lock to prevent racing with input_get_keycode()
-	 * and input_set_keycode() if we are called while input device
-	 * is still registered.
-	 */
-	spin_lock_irqsave(&dev->event_lock, flags);
-
-	kfree(dev->keycode);
-	dev->keycode = NULL;
-	dev->keycodemax = 0;
-
-	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
 EXPORT_SYMBOL(sparse_keymap_free);
 
-- 
2.12.0

