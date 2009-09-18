From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: make the CtrlR and CtrlL modifier output different keys
Date: Fri, 18 Sep 2009 13:13:17 +0800
Message-ID: <4AB316ED.80005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040508050000060103070403"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:54772 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZIRFNY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 01:13:24 -0400
Received: by ywh5 with SMTP id 5so906017ywh.4
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2009 22:13:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------040508050000060103070403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi.

I want make the CtrlR and CtrlL output different keys.
like:

CtrlR + U = 7
CtrlR + U = Control + U.

so I　modify the keyboard.c code. attach is the code.

give me some feedback about this patch.
thanks.


-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com

--------------040508050000060103070403
Content-Type: text/x-patch;
 name="510-Fn-modifier-keys-work.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="510-Fn-modifier-keys-work.patch"

diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 5859589..ddd7d3f 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -242,11 +242,11 @@ static struct platform_device jz_nand_device = {
  * don't define this. the keyboard and keyboard both work
  */
 
-#define KEY_QI_QI		KEY_F13
-#define KEY_QI_UPRED	KEY_RIGHTCTRL
+#define KEY_QI_QI	KEY_RIGHTCTRL
+#define KEY_QI_UPRED	KEY_RIGHTSHIFT
 #define KEY_QI_VOLUP	KEY_F15
 #define KEY_QI_VOLDOWN	KEY_F16
-#define KEY_QI_FN	KEY_F17
+#define KEY_QI_FN	KEY_RIGHTCTRL
 
 static const uint32_t qi_lb60_keymap[] = {
 	KEY(0, 0, KEY_F1),	/* S2 */
diff --git a/drivers/char/defkeymap.map b/drivers/char/defkeymap.map
index 25d05b4..497cfc2 100644
--- a/drivers/char/defkeymap.map
+++ b/drivers/char/defkeymap.map
@@ -113,9 +113,9 @@ keycode  43 = backslash        bar
 	control keycode  43 = Control_backslash
 	alt     keycode  43 = Meta_backslash  
 keycode  44 = z               
-	altgr   keycode  43 = nine
+	altgr   keycode  44 = nine
 keycode  45 = x               
-	altgr   keycode  43 = zero
+	altgr   keycode  45 = zero
 keycode  46 = c
 	altgr   keycode  46 = Hex_C   
 keycode  47 = v               
@@ -133,7 +133,7 @@ keycode  52 = period           greater
 keycode  53 = slash            question        
 	control keycode  53 = Delete          
 	alt     keycode  53 = Meta_slash      
-keycode  54 = Shift           
+keycode  54 = AltGr
 keycode  55 = KP_Multiply     
 keycode  56 = Alt             
 keycode  57 = space            space           
@@ -240,7 +240,7 @@ keycode  93 =
 keycode  94 =
 keycode  95 =
 keycode  96 = KP_Enter        
-keycode  97 = AltGr
+keycode  97 = Control
 keycode  98 = KP_Divide       
 keycode  99 = Control_backslash
 	control keycode  99 = Control_backslash
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 737be95..4cdd9ac 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -121,6 +121,8 @@ struct vt_spawn_console vt_spawn_con = {
 	.sig  = 0,
 };
 
+static int ctrlr = 0;
+
 /*
  * Variables exported for vt.c
  */
@@ -1133,6 +1135,60 @@ static int emulate_raw(struct vc_data *vc, unsigned int keycode, unsigned char u
 }
 #endif
 
+static int qi_keymap(int keysym, int keycode, int up_flag)
+{
+	int ret;
+	ret = keysym;
+
+	if (up_flag && keycode == KEY_RIGHTCTRL) {
+		ctrlr = 0;
+		return ret;
+	}
+
+	if (ctrlr) {
+		switch (keycode) {
+		case KEY_SLASH:	/* 0 */
+			ret = 61488;
+			break;
+		case KEY_N:	/* 1 */
+			ret = 61489;
+			break;
+		case KEY_M:	/* 2 */
+			ret = 61490;
+			break;
+		case KEY_B:	/* 3 */
+			ret = 61491;
+			break;
+		case KEY_J:	/* 4 */
+			ret = 61492;
+			break;
+		case KEY_K:	/* 5 */
+			ret = 61493;
+			break;
+		case KEY_L:	/* 6 */
+			ret = 61494;
+			break;
+		case KEY_U:	/* 7 */
+			ret = 61495;
+			break;
+		case KEY_I:	/* 8 */
+			ret = 61496;
+			break;
+		case KEY_O:	/* 9 */
+			ret = 61497;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (keycode == KEY_RIGHTCTRL) {
+		ctrlr = 1;
+	}
+
+	return ret;
+}
+
 static void kbd_rawcode(unsigned char data)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
@@ -1284,6 +1340,8 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 	if (raw_mode && type != KT_SPEC && type != KT_SHIFT)
 		return;
 
+	keysym = qi_keymap(keysym, keycode, !down);
+
 	(*k_handler[type])(vc, keysym & 0xff, !down);
 
 	param.ledstate = kbd->ledflagstate;

--------------040508050000060103070403--
