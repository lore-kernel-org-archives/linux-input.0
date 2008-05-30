From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - Move KEY_{EURO, DOLLAR} to lower keycodes
Date: Fri, 30 May 2008 16:28:57 -0400
Message-ID: <20080530202856.GA20935@anvil.corenet.prv>
References: <200711161341.58696.carlos@strangeworlds.co.uk> <200711161349.02657.carlos@strangeworlds.co.uk> <200712111928.44935.carlos@strangeworlds.co.uk> <200805302039.03881.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.243]:48384 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbYE3U3C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 May 2008 16:29:02 -0400
Received: by hs-out-0708.google.com with SMTP id 4so101205hsl.5
        for <linux-input@vger.kernel.org>; Fri, 30 May 2008 13:29:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200805302039.03881.carlos@strangeworlds.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-input@vger.kernel.org

On Fri, May 30, 2008 at 08:39:03PM +0100, Carlos Corbacho wrote:
> On Tuesday 11 December 2007 19:28:44 Carlos Corbacho wrote:
> > On Friday 16 November 2007 13:49:02 Carlos Corbacho wrote:
> > > On Friday 16 November 2007 13:47:23 Dmitry Torokhov wrote:
> > > > They should stay where they were. We need to change atkbd to use
> > > > ushorts in keymaps. I have a patch for it, I'll forward it to you
> > > > today or tomorrow.
> > >
> > > Even better - cheers :)
> >
> > Any news on this yet?
> 
> Dmitry,
> 
> Any progress on this front, or are there other problems with this change that 
> need to be fixed first?
> 

Argh, forgot all about it, terribly sorry. How about the patch below?

-- 
Dmitry

Input: atkbd - use ushort instead of uchar keymap

Since some of the keycodes defined in input.h have values greater
than 255 we should use unsigned shorts in keymaps.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/atkbd.c |   20 ++++++++++----------
 include/linux/input.h          |    2 ++
 2 files changed, 12 insertions(+), 10 deletions(-)

Index: work/drivers/input/keyboard/atkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/atkbd.c
+++ work/drivers/input/keyboard/atkbd.c
@@ -68,7 +68,7 @@ MODULE_PARM_DESC(extra, "Enable extra LE
  * are loadable via an userland utility.
  */
 
-static unsigned char atkbd_set2_keycode[512] = {
+static const unsigned short atkbd_set2_keycode[512] = {
 
 #ifdef CONFIG_KEYBOARD_ATKBD_HP_KEYCODES
 
@@ -99,7 +99,7 @@ static unsigned char atkbd_set2_keycode[
 #endif
 };
 
-static unsigned char atkbd_set3_keycode[512] = {
+static const unsigned short atkbd_set3_keycode[512] = {
 
 	  0,  0,  0,  0,  0,  0,  0, 59,  1,138,128,129,130, 15, 41, 60,
 	131, 29, 42, 86, 58, 16,  2, 61,133, 56, 44, 31, 30, 17,  3, 62,
@@ -115,7 +115,7 @@ static unsigned char atkbd_set3_keycode[
 	148,149,147,140
 };
 
-static unsigned char atkbd_unxlate_table[128] = {
+static const unsigned short atkbd_unxlate_table[128] = {
           0,118, 22, 30, 38, 37, 46, 54, 61, 62, 70, 69, 78, 85,102, 13,
          21, 29, 36, 45, 44, 53, 60, 67, 68, 77, 84, 91, 90, 20, 28, 27,
          35, 43, 52, 51, 59, 66, 75, 76, 82, 14, 18, 93, 26, 34, 33, 42,
@@ -161,7 +161,7 @@ static unsigned char atkbd_unxlate_table
 #define ATKBD_SCR_LEFT		249
 #define ATKBD_SCR_RIGHT		248
 
-#define ATKBD_SPECIAL		248
+#define ATKBD_SPECIAL		ATKBD_SCR_RIGHT
 
 #define ATKBD_LED_EVENT_BIT	0
 #define ATKBD_REP_EVENT_BIT	1
@@ -173,7 +173,7 @@ static unsigned char atkbd_unxlate_table
 #define ATKBD_XL_HANGEUL	0x10
 #define ATKBD_XL_HANJA		0x20
 
-static struct {
+static const struct {
 	unsigned char keycode;
 	unsigned char set2;
 } atkbd_scroll_keys[] = {
@@ -200,7 +200,7 @@ struct atkbd {
 	char phys[32];
 
 	unsigned short id;
-	unsigned char keycode[512];
+	unsigned short keycode[512];
 	DECLARE_BITMAP(force_release_mask, 512);
 	unsigned char set;
 	unsigned char translated;
@@ -357,7 +357,7 @@ static irqreturn_t atkbd_interrupt(struc
 	unsigned int code = data;
 	int scroll = 0, hscroll = 0, click = -1;
 	int value;
-	unsigned char keycode;
+	unsigned short keycode;
 
 #ifdef ATKBD_DEBUG
 	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
@@ -961,16 +961,16 @@ static void atkbd_set_device_attrs(struc
 		input_dev->evbit[0] |= BIT_MASK(EV_REL);
 		input_dev->relbit[0] = BIT_MASK(REL_WHEEL) |
 			BIT_MASK(REL_HWHEEL);
-		set_bit(BTN_MIDDLE, input_dev->keybit);
+		__set_bit(BTN_MIDDLE, input_dev->keybit);
 	}
 
 	input_dev->keycode = atkbd->keycode;
-	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodesize = sizeof(unsigned short);
 	input_dev->keycodemax = ARRAY_SIZE(atkbd_set2_keycode);
 
 	for (i = 0; i < 512; i++)
 		if (atkbd->keycode[i] && atkbd->keycode[i] < ATKBD_SPECIAL)
-			set_bit(atkbd->keycode[i], input_dev->keybit);
+			__set_bit(atkbd->keycode[i], input_dev->keybit);
 }
 
 /*
Index: work/include/linux/input.h
===================================================================
--- work.orig/include/linux/input.h
+++ work/include/linux/input.h
@@ -373,6 +373,8 @@ struct input_absinfo {
 
 #define KEY_WIMAX		246
 
+/* Range 248 - 255 is reserved for special needs of AT keyboard driver */
+
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101
