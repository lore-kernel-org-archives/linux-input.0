From: "hartleys" <hartleys@visionengravers.com>
Subject: [PATCH 2/5] input: Update omap_keypad to use MATRIX_KEY macro
Date: Fri, 30 Jan 2009 13:46:47 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A5469@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:54223 "HELO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751411AbZA3SrQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 13:47:16 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Update the omap_keypad driver to use common MATRIX_KEY macro.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/plat-omap/include/mach/keypad.h
b/arch/arm/plat-omap/include/mach/keypad.h
index 232923a..c8269c3 100644
--- a/arch/arm/plat-omap/include/mach/keypad.h
+++ b/arch/arm/plat-omap/include/mach/keypad.h
@@ -13,7 +13,7 @@
 struct omap_kp_platform_data {
 	int rows;
 	int cols;
-	int *keymap;
+	unsigned int *keymap;
 	unsigned int keymapsize;
 	unsigned int rep:1;
 	unsigned long delay;
@@ -33,7 +33,5 @@ struct omap_kp_platform_data {
 #define GROUP_3		(3 << 16)
 #define GROUP_MASK	GROUP_3

-#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
-
 #endif

diff --git a/drivers/input/keyboard/omap-keypad.c
b/drivers/input/keyboard/omap-keypad.c
index 3f3d119..d5e9f24 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -64,7 +64,7 @@ struct omap_kp {

 static DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);

-static int *keymap;
+static unsigned int *keymap;
 static unsigned int *row_gpios;
 static unsigned int *col_gpios;

@@ -151,9 +151,10 @@ static void omap_kp_scan_keypad(struct omap_kp
*omap_kp, unsigned char *state)

 static inline int omap_kp_find_key(int col, int row)
 {
-	int i, key;
+	unsigned int key;
+	int i;

-	key = KEY(col, row, 0);
+	key = MATRIX_KEY(col, row, 0);
 	for (i = 0; keymap[i] != 0; i++)
 		if ((keymap[i] & 0xff000000) == key)
 			return keymap[i] & 0x00ffffff; 
