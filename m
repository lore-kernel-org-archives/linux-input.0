From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: Re: [PATCH] Check whether getkeycode and setkeycode are still
	valide
Date: Mon, 22 Mar 2010 10:48:11 +0800
Message-ID: <20100322024811.GA25096@ywang-moblin2.bj.intel.com>
References: <20100321025648.GA24497@ywang-moblin2.bj.intel.com> <20100321031149.GC29360@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61246 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716Ab0CVC5W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Mar 2010 22:57:22 -0400
Content-Disposition: inline
In-Reply-To: <20100321031149.GC29360@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, Mar 20, 2010 at 08:11:49PM -0700, Dmitry Torokhov wrote:
> On Sun, Mar 21, 2010 at 10:56:48AM +0800, Yong Wang wrote:
> > If sparse keymap is freed before unregistering the device, there is a
> > window where userspace can issue EVIOCGKEYCODE or EVIOCSKEYCODE. When
> > that happens, kernel will crash. Noticed by Dmitry Torokhov.
> > 
> 
> I'd rather require that getkeycode and setkeycode be mandatory. I will
> change sparse-kepmap module to stop setting these to NULL when freeing
> keymap.
> 

OK, I agree it would be better to require getkeycode and setkeycode be
mandatory. Then what about setting getkeycode and setkeycode to the
default handlers input_default_getkeycode and input_default_setkeycode
in sparse_keymap_free? This way it will not pass the check below in the
transient period time after calling sparse_keymap_free and before
unregistering input device since dev->keycodemax is set to 0 in
sparse_keymap_free.

	if (scancode >= dev->keycodemax)
		return -EINVAL;

Thanks
-Yong

---
diff --git a/drivers/input/input.c b/drivers/input/input.c
index e2aad0a..18c1d0b 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -581,7 +581,7 @@ static int input_fetch_keycode(struct input_dev *dev, int scancode)
 	}
 }
 
-static int input_default_getkeycode(struct input_dev *dev,
+int input_default_getkeycode(struct input_dev *dev,
 				    unsigned int scancode,
 				    unsigned int *keycode)
 {
@@ -595,8 +595,9 @@ static int input_default_getkeycode(struct input_dev *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL(input_default_getkeycode);
 
-static int input_default_setkeycode(struct input_dev *dev,
+int input_default_setkeycode(struct input_dev *dev,
 				    unsigned int scancode,
 				    unsigned int keycode)
 {
@@ -645,6 +646,7 @@ static int input_default_setkeycode(struct input_dev *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL(input_default_setkeycode);
 
 /**
  * input_get_keycode - retrieve keycode currently mapped to a given scancode
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index f64e004..2e30887 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -181,8 +181,8 @@ void sparse_keymap_free(struct input_dev *dev)
 	kfree(dev->keycode);
 	dev->keycode = NULL;
 	dev->keycodemax = 0;
-	dev->getkeycode = NULL;
-	dev->setkeycode = NULL;
+	dev->getkeycode = input_default_getkeycode;
+	dev->setkeycode = input_default_setkeycode;
 }
 EXPORT_SYMBOL(sparse_keymap_free);
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 7ed2251..873c250 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1417,6 +1417,13 @@ static inline void input_set_abs_params(struct input_dev *dev, int axis, int min
 	dev->absbit[BIT_WORD(axis)] |= BIT_MASK(axis);
 }
 
+int input_default_getkeycode(struct input_dev *dev,
+			     unsigned int scancode,
+			     unsigned int *keycode);
+int input_default_setkeycode(struct input_dev *dev,
+			     unsigned int scancode,
+			     unsigned int keycode);
+
 int input_get_keycode(struct input_dev *dev,
 		      unsigned int scancode, unsigned int *keycode);
 int input_set_keycode(struct input_dev *dev,
