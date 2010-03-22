From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Check whether getkeycode and setkeycode are still valide
Date: Sun, 21 Mar 2010 21:22:34 -0700
Message-ID: <20100322042233.GA31621@core.coreip.homeip.net>
References: <20100321025648.GA24497@ywang-moblin2.bj.intel.com>
 <20100321031149.GC29360@core.coreip.homeip.net>
 <20100322024811.GA25096@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42058 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0CVEWj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 00:22:39 -0400
Received: by gyg8 with SMTP id 8so2516262gyg.19
        for <linux-input@vger.kernel.org>; Sun, 21 Mar 2010 21:22:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100322024811.GA25096@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Mon, Mar 22, 2010 at 10:48:11AM +0800, Yong Wang wrote:
> On Sat, Mar 20, 2010 at 08:11:49PM -0700, Dmitry Torokhov wrote:
> > On Sun, Mar 21, 2010 at 10:56:48AM +0800, Yong Wang wrote:
> > > If sparse keymap is freed before unregistering the device, there is a
> > > window where userspace can issue EVIOCGKEYCODE or EVIOCSKEYCODE. When
> > > that happens, kernel will crash. Noticed by Dmitry Torokhov.
> > > 
> > 
> > I'd rather require that getkeycode and setkeycode be mandatory. I will
> > change sparse-kepmap module to stop setting these to NULL when freeing
> > keymap.
> > 
> 
> OK, I agree it would be better to require getkeycode and setkeycode be
> mandatory. Then what about setting getkeycode and setkeycode to the
> default handlers input_default_getkeycode and input_default_setkeycode
> in sparse_keymap_free? This way it will not pass the check below in the
> transient period time after calling sparse_keymap_free and before
> unregistering input device since dev->keycodemax is set to 0 in
> sparse_keymap_free.
> 
> 	if (scancode >= dev->keycodemax)
> 		return -EINVAL;
> 

I'd rather not export the default handlers how about the patch below
instead?

-- 
Dmitry


Input: sparse-keymap - implement safer freeing of the keymap

Allow calling sparse_keymap_free() before unregistering input device
whithout risk of racing with EVIOCGETKEYCODE and EVIOCSETKEYCODE.
This makes life of drivers writers easier.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c         |    9 +++++++
 drivers/input/sparse-keymap.c |   50 ++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 19 deletions(-)


diff --git a/drivers/input/input.c b/drivers/input/input.c
index e2aad0a..be18fa9 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -659,7 +659,14 @@ static int input_default_setkeycode(struct input_dev *dev,
 int input_get_keycode(struct input_dev *dev,
 		      unsigned int scancode, unsigned int *keycode)
 {
-	return dev->getkeycode(dev, scancode, keycode);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	retval = dev->getkeycode(dev, scancode, keycode);
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	return retval;
 }
 EXPORT_SYMBOL(input_get_keycode);
 
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index f64e004..f896f24 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -67,12 +67,14 @@ static int sparse_keymap_getkeycode(struct input_dev *dev,
 				    unsigned int scancode,
 				    unsigned int *keycode)
 {
-	const struct key_entry *key =
-			sparse_keymap_entry_from_scancode(dev, scancode);
+	const struct key_entry *key;
 
-	if (key && key->type == KE_KEY) {
-		*keycode = key->keycode;
-		return 0;
+	if (dev->keycode) {
+		key = sparse_keymap_entry_from_scancode(dev, scancode);
+		if (key && key->type == KE_KEY) {
+			*keycode = key->keycode;
+			return 0;
+		}
 	}
 
 	return -EINVAL;
@@ -85,17 +87,16 @@ static int sparse_keymap_setkeycode(struct input_dev *dev,
 	struct key_entry *key;
 	int old_keycode;
 
-	if (keycode < 0 || keycode > KEY_MAX)
-		return -EINVAL;
-
-	key = sparse_keymap_entry_from_scancode(dev, scancode);
-	if (key && key->type == KE_KEY) {
-		old_keycode = key->keycode;
-		key->keycode = keycode;
-		set_bit(keycode, dev->keybit);
-		if (!sparse_keymap_entry_from_keycode(dev, old_keycode))
-			clear_bit(old_keycode, dev->keybit);
-		return 0;
+	if (dev->keymap) {
+		key = sparse_keymap_entry_from_scancode(dev, scancode);
+		if (key && key->type == KE_KEY) {
+			old_keycode = key->keycode;
+			key->keycode = keycode;
+			set_bit(keycode, dev->keybit);
+			if (!sparse_keymap_entry_from_keycode(dev, old_keycode))
+				clear_bit(old_keycode, dev->keybit);
+			return 0;
+		}
 	}
 
 	return -EINVAL;
@@ -175,14 +176,27 @@ EXPORT_SYMBOL(sparse_keymap_setup);
  *
  * This function is used to free memory allocated by sparse keymap
  * in an input device that was set up by sparse_keymap_setup().
+ * NOTE: It is safe to cal this function while input device is
+ * still registered (however the drivers should care not to try to
+ * use freed keymap and thus have to shut off interrups/polling
+ * before freeing the keymap).
  */
 void sparse_keymap_free(struct input_dev *dev)
 {
+	unsigned long flags;
+
+	/*
+	 * Take event lock to prevent racing with input_get_keycode()
+	 * and input_set_keycode() if we are called while input device
+	 * is still registered.
+	 */
+	spin_lock_irqsave(&dev->event_lock, flags);
+
 	kfree(dev->keycode);
 	dev->keycode = NULL;
 	dev->keycodemax = 0;
-	dev->getkeycode = NULL;
-	dev->setkeycode = NULL;
+
+	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
 EXPORT_SYMBOL(sparse_keymap_free);
 
