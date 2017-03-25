From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: synaptics - use BIT() and GENMASK() macros
Date: Fri, 24 Mar 2017 23:04:07 -0700
Message-ID: <20170325060409.40558-2-dmitry.torokhov@gmail.com>
References: <20170325060409.40558-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36407 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967140AbdCYGER (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 02:04:17 -0400
In-Reply-To: <20170325060409.40558-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

Use standard infrastructure, such as BIT and GENMASK, instead of rolling
bitmasks by hand.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c |  6 +--
 drivers/input/mouse/synaptics.h | 90 ++++++++++++++++++++---------------------
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7e35da8abcde..be2265bc386c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -907,9 +907,9 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 	if (!SYN_CAP_EXT_BUTTONS_STICK(priv->info.ext_cap_10)) {
 		for (i = 0; i < ext_bits; i++) {
 			input_report_key(dev, BTN_0 + 2 * i,
-				hw->ext_buttons & (1 << i));
+				hw->ext_buttons & BIT(i));
 			input_report_key(dev, BTN_1 + 2 * i,
-				hw->ext_buttons & (1 << (i + ext_bits)));
+				hw->ext_buttons & BIT(i + ext_bits));
 		}
 		return;
 	}
@@ -1534,7 +1534,7 @@ static int synaptics_init_ps2(struct psmouse *psmouse,
 					SYN_NEWABS : SYN_OLDABS;
 
 	psmouse_info(psmouse,
-		     "Touchpad model: %u, fw: %u.%u, id: %#x, caps: %#x/%#x/%#x/%#x, board id: %u, fw id: %u\n",
+		     "Touchpad model: %lu, fw: %lu.%lu, id: %#x, caps: %#x/%#x/%#x/%#x, board id: %u, fw id: %u\n",
 		     SYN_ID_MODEL(info->identity),
 		     SYN_ID_MAJOR(info->identity), SYN_ID_MINOR(info->identity),
 		     info->model_id,
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 87fbe5b53803..7a998fbfa6b0 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -25,37 +25,37 @@
 #define SYN_QUE_MEXT_CAPAB_10		0x10
 
 /* synatics modes */
-#define SYN_BIT_ABSOLUTE_MODE		(1 << 7)
-#define SYN_BIT_HIGH_RATE		(1 << 6)
-#define SYN_BIT_SLEEP_MODE		(1 << 3)
-#define SYN_BIT_DISABLE_GESTURE		(1 << 2)
-#define SYN_BIT_FOUR_BYTE_CLIENT	(1 << 1)
-#define SYN_BIT_W_MODE			(1 << 0)
+#define SYN_BIT_ABSOLUTE_MODE		BIT(7)
+#define SYN_BIT_HIGH_RATE		BIT(6)
+#define SYN_BIT_SLEEP_MODE		BIT(3)
+#define SYN_BIT_DISABLE_GESTURE		BIT(2)
+#define SYN_BIT_FOUR_BYTE_CLIENT	BIT(1)
+#define SYN_BIT_W_MODE			BIT(0)
 
 /* synaptics model ID bits */
-#define SYN_MODEL_ROT180(m)		((m) & (1 << 23))
-#define SYN_MODEL_PORTRAIT(m)		((m) & (1 << 22))
-#define SYN_MODEL_SENSOR(m)		(((m) >> 16) & 0x3f)
-#define SYN_MODEL_HARDWARE(m)		(((m) >> 9) & 0x7f)
-#define SYN_MODEL_NEWABS(m)		((m) & (1 << 7))
-#define SYN_MODEL_PEN(m)		((m) & (1 << 6))
-#define SYN_MODEL_SIMPLIC(m)		((m) & (1 << 5))
-#define SYN_MODEL_GEOMETRY(m)		((m) & 0x0f)
+#define SYN_MODEL_ROT180(m)		((m) & BIT(23))
+#define SYN_MODEL_PORTRAIT(m)		((m) & BIT(22))
+#define SYN_MODEL_SENSOR(m)		(((m) & GENMASK(21, 16)) >> 16)
+#define SYN_MODEL_HARDWARE(m)		(((m) & GENMASK(15, 9)) >> 9)
+#define SYN_MODEL_NEWABS(m)		((m) & BIT(7))
+#define SYN_MODEL_PEN(m)		((m) & BIT(6))
+#define SYN_MODEL_SIMPLIC(m)		((m) & BIT(5))
+#define SYN_MODEL_GEOMETRY(m)		((m) & GENMASK(3, 0))
 
 /* synaptics capability bits */
-#define SYN_CAP_EXTENDED(c)		((c) & (1 << 23))
-#define SYN_CAP_MIDDLE_BUTTON(c)	((c) & (1 << 18))
-#define SYN_CAP_PASS_THROUGH(c)		((c) & (1 << 7))
-#define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
-#define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
-#define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
-#define SYN_CAP_PALMDETECT(c)		((c) & (1 << 0))
-#define SYN_CAP_SUBMODEL_ID(c)		(((c) & 0x00ff00) >> 8)
-#define SYN_EXT_CAP_REQUESTS(c)		(((c) & 0x700000) >> 20)
+#define SYN_CAP_EXTENDED(c)		((c) & BIT(23))
+#define SYN_CAP_MIDDLE_BUTTON(c)	((c) & BIT(18))
+#define SYN_CAP_PASS_THROUGH(c)		((c) & BIT(7))
+#define SYN_CAP_SLEEP(c)		((c) & BIT(4))
+#define SYN_CAP_FOUR_BUTTON(c)		((c) & BIT(3))
+#define SYN_CAP_MULTIFINGER(c)		((c) & BIT(1))
+#define SYN_CAP_PALMDETECT(c)		((c) & BIT(0))
+#define SYN_CAP_SUBMODEL_ID(c)		(((c) & GENMASK(15, 8)) >> 8)
+#define SYN_EXT_CAP_REQUESTS(c)		(((c) & GENMASK(22, 20)) >> 20)
 #define SYN_CAP_MB_MASK			GENMASK(15, 12)
 #define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & SYN_CAP_MB_MASK) >> 12)
-#define SYN_CAP_PRODUCT_ID(ec)		(((ec) & 0xff0000) >> 16)
-#define SYN_MEXT_CAP_BIT(m)		((m) & (1 << 1))
+#define SYN_CAP_PRODUCT_ID(ec)		(((ec) & GENMASK(23, 16)) >> 16)
+#define SYN_MEXT_CAP_BIT(m)		((m) & BIT(1))
 
 /*
  * The following describes response for the 0x0c query.
@@ -84,14 +84,14 @@
  *					hinged at the top.
  * 2	0x20	report min		query 0x0f gives min coord reported
  */
-#define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button ClickPad */
-#define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & 0x000100) /* 2-button ClickPad */
-#define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x020000)
-#define SYN_CAP_MIN_DIMENSIONS(ex0c)	((ex0c) & 0x002000)
-#define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
-#define SYN_CAP_REDUCED_FILTERING(ex0c)	((ex0c) & 0x000400)
-#define SYN_CAP_IMAGE_SENSOR(ex0c)	((ex0c) & 0x000800)
-#define SYN_CAP_INTERTOUCH(ex0c)	((ex0c) & 0x004000)
+#define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & BIT(20)) /* 1-button ClickPad */
+#define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) & BIT(8))  /* 2-button ClickPad */
+#define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & BIT(17))
+#define SYN_CAP_MIN_DIMENSIONS(ex0c)	((ex0c) & BIT(13))
+#define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & BIT(19))
+#define SYN_CAP_REDUCED_FILTERING(ex0c)	((ex0c) & BIT(10))
+#define SYN_CAP_IMAGE_SENSOR(ex0c)	((ex0c) & BIT(11))
+#define SYN_CAP_INTERTOUCH(ex0c)	((ex0c) & BIT(14))
 
 /*
  * The following descibes response for the 0x10 query.
@@ -110,27 +110,27 @@
  * 3	0xff	SecurePad height	the height of the SecurePad fingerprint
  *					reader.
  */
-#define SYN_CAP_EXT_BUTTONS_STICK(ex10)	((ex10) & 0x010000)
-#define SYN_CAP_SECUREPAD(ex10)		((ex10) & 0x020000)
+#define SYN_CAP_EXT_BUTTONS_STICK(ex10)	((ex10) & BIT(16))
+#define SYN_CAP_SECUREPAD(ex10)		((ex10) & BIT(17))
 
 #define SYN_EXT_BUTTON_STICK_L(eb)	(((eb) & BIT(0)) >> 0)
 #define SYN_EXT_BUTTON_STICK_M(eb)	(((eb) & BIT(1)) >> 1)
 #define SYN_EXT_BUTTON_STICK_R(eb)	(((eb) & BIT(2)) >> 2)
 
 /* synaptics modes query bits */
-#define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
-#define SYN_MODE_RATE(m)		((m) & (1 << 6))
-#define SYN_MODE_BAUD_SLEEP(m)		((m) & (1 << 3))
-#define SYN_MODE_DISABLE_GESTURE(m)	((m) & (1 << 2))
-#define SYN_MODE_PACKSIZE(m)		((m) & (1 << 1))
-#define SYN_MODE_WMODE(m)		((m) & (1 << 0))
+#define SYN_MODE_ABSOLUTE(m)		((m) & BIT(7))
+#define SYN_MODE_RATE(m)		((m) & BIT(6))
+#define SYN_MODE_BAUD_SLEEP(m)		((m) & BIT(3))
+#define SYN_MODE_DISABLE_GESTURE(m)	((m) & BIT(2))
+#define SYN_MODE_PACKSIZE(m)		((m) & BIT(1))
+#define SYN_MODE_WMODE(m)		((m) & BIT(0))
 
 /* synaptics identify query bits */
-#define SYN_ID_MODEL(i)			(((i) >> 4) & 0x0f)
-#define SYN_ID_MAJOR(i)			((i) & 0x0f)
-#define SYN_ID_MINOR(i)			(((i) >> 16) & 0xff)
+#define SYN_ID_MODEL(i)			(((i) & GENMASK(7, 4)) >> 4)
+#define SYN_ID_MAJOR(i)			(((i) & GENMASK(3, 0)) >> 0)
+#define SYN_ID_MINOR(i)			(((i) & GENMASK(23, 16)) >> 16)
 #define SYN_ID_FULL(i)			((SYN_ID_MAJOR(i) << 8) | SYN_ID_MINOR(i))
-#define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)
+#define SYN_ID_IS_SYNAPTICS(i)		(((i) & GENMASK(15, 8)) == 0x004700U)
 #define SYN_ID_DISGEST_SUPPORTED(i)	(SYN_ID_MAJOR(i) >= 4)
 
 /* synaptics special commands */
-- 
2.12.1.578.ge9c3154ca4-goog

