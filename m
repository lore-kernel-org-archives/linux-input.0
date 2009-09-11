From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: ATKBD: adding force-release quirks
Date: Thu, 10 Sep 2009 22:12:45 -0700
Message-ID: <20090911051245.GB23210@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:52351 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZIKFMq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:12:46 -0400
Received: by pxi27 with SMTP id 27so602658pxi.15
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:12:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: hal@lists.freedesktop.org

Hi,

It appears that more and more laptops do not send release events for
their multimedia keys requiring adding their DMI info to the atkbd
driver. I don't think we can continue this practice any longer and I
would like to punt this responsibility to HAL/DevKit/whatever. In 2.6.32
there will be a new sysfs attribute, force_release, attached to the
serio port that is bound to atkbd driver. Writing to that attribute will
allow setting a new bitmap for the keys that require forced release,
reading will produce current bitmap. The format as follows:

echo 133-139,143,147 > /sys/devices/platform/i8042/serio0/force_release

-- 
Dmitry


Input: atkbd - allow setting force-release bitmap via sysfs

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

There are more and more laptop requiring use of force_release quirk
for their multimedia and other specialized keys. Adding their DMI data
to the kernel is not sustainable; instead we will rely on help from
userspace (HAL) to do that for us.

This patch creates a new 'force_release' sysfs attribute (that belongs
to serio device to which keyboard is attached) which can be used to set
up force_release keymap. For example, Dell laptop owners might do:

echo 133-139,143,147 > /sys/devices/platform/i8042/serio0/force_release

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/atkbd.c |   43 ++++++++++++++++++++++++++++++++++------
 1 files changed, 37 insertions(+), 6 deletions(-)


diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 6c6a09b..c9523e4 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -68,7 +68,9 @@ MODULE_PARM_DESC(extra, "Enable extra LEDs and keys on IBM RapidAcces, EzKey and
  * are loadable via a userland utility.
  */
 
-static const unsigned short atkbd_set2_keycode[512] = {
+#define ATKBD_KEYMAP_SIZE	512
+
+static const unsigned short atkbd_set2_keycode[ATKBD_KEYMAP_SIZE] = {
 
 #ifdef CONFIG_KEYBOARD_ATKBD_HP_KEYCODES
 
@@ -99,7 +101,7 @@ static const unsigned short atkbd_set2_keycode[512] = {
 #endif
 };
 
-static const unsigned short atkbd_set3_keycode[512] = {
+static const unsigned short atkbd_set3_keycode[ATKBD_KEYMAP_SIZE] = {
 
 	  0,  0,  0,  0,  0,  0,  0, 59,  1,138,128,129,130, 15, 41, 60,
 	131, 29, 42, 86, 58, 16,  2, 61,133, 56, 44, 31, 30, 17,  3, 62,
@@ -200,8 +202,8 @@ struct atkbd {
 	char phys[32];
 
 	unsigned short id;
-	unsigned short keycode[512];
-	DECLARE_BITMAP(force_release_mask, 512);
+	unsigned short keycode[ATKBD_KEYMAP_SIZE];
+	DECLARE_BITMAP(force_release_mask, ATKBD_KEYMAP_SIZE);
 	unsigned char set;
 	unsigned char translated;
 	unsigned char extra;
@@ -253,6 +255,7 @@ static struct device_attribute atkbd_attr_##_name =				\
 	__ATTR(_name, S_IWUSR | S_IRUGO, atkbd_do_show_##_name, atkbd_do_set_##_name);
 
 ATKBD_DEFINE_ATTR(extra);
+ATKBD_DEFINE_ATTR(force_release);
 ATKBD_DEFINE_ATTR(scroll);
 ATKBD_DEFINE_ATTR(set);
 ATKBD_DEFINE_ATTR(softrepeat);
@@ -272,6 +275,7 @@ ATKBD_DEFINE_RO_ATTR(err_count);
 
 static struct attribute *atkbd_attributes[] = {
 	&atkbd_attr_extra.attr,
+	&atkbd_attr_force_release.attr,
 	&atkbd_attr_scroll.attr,
 	&atkbd_attr_set.attr,
 	&atkbd_attr_softrepeat.attr,
@@ -934,7 +938,7 @@ static void atkbd_set_keycode_table(struct atkbd *atkbd)
 	int i, j;
 
 	memset(atkbd->keycode, 0, sizeof(atkbd->keycode));
-	bitmap_zero(atkbd->force_release_mask, 512);
+	bitmap_zero(atkbd->force_release_mask, ATKBD_KEYMAP_SIZE);
 
 	if (atkbd->translated) {
 		for (i = 0; i < 128; i++) {
@@ -1041,7 +1045,7 @@ static void atkbd_set_device_attrs(struct atkbd *atkbd)
 	input_dev->keycodesize = sizeof(unsigned short);
 	input_dev->keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
 
-	for (i = 0; i < 512; i++)
+	for (i = 0; i < ATKBD_KEYMAP_SIZE; i++)
 		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
 			__set_bit(atkbd->keycode[i], input_dev->keybit);
 }
@@ -1309,6 +1313,33 @@ static ssize_t atkbd_set_extra(struct atkbd *atkbd, const char *buf, size_t coun
 	return count;
 }
 
+static ssize_t atkbd_show_force_release(struct atkbd *atkbd, char *buf)
+{
+	size_t len = bitmap_scnlistprintf(buf, PAGE_SIZE - 2,
+			atkbd->force_release_mask, ATKBD_KEYMAP_SIZE);
+
+	buf[len++] = '\n';
+	buf[len] = '\0';
+
+	return len;
+}
+
+static ssize_t atkbd_set_force_release(struct atkbd *atkbd,
+					const char *buf, size_t count)
+{
+	/* 64 bytes on stack should be acceptable */
+	DECLARE_BITMAP(new_mask, ATKBD_KEYMAP_SIZE);
+	int err;
+
+	err = bitmap_parselist(buf, new_mask, ATKBD_KEYMAP_SIZE);
+	if (err)
+		return err;
+
+	memcpy(atkbd->force_release_mask, new_mask, sizeof(atkbd->force_release_mask));
+	return count;
+}
+
+
 static ssize_t atkbd_show_scroll(struct atkbd *atkbd, char *buf)
 {
 	return sprintf(buf, "%d\n", atkbd->scroll ? 1 : 0);
