From: "hartleys" <hartleys@visionengravers.com>
Subject: [PATCH 3/5] input: Update omap platforms to use MATRIX_KEY macro
Date: Fri, 30 Jan 2009 13:47:38 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A546C@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og106.obsmtp.com ([64.18.1.191]:37765 "HELO
	exprod6og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752906AbZA3SsW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 13:48:22 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Update omap1/2 platforms to use MATRIX_KEY macro.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-omap1/board-ams-delta.c
b/arch/arm/mach-omap1/board-ams-delta.c
index 2e61839..7f97298 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -33,84 +33,83 @@
 static u8 ams_delta_latch1_reg;
 static u16 ams_delta_latch2_reg;

-static int ams_delta_keymap[] = {
-	KEY(0, 0, KEY_F1),		/* Advert    */
-
-	KEY(3, 0, KEY_COFFEE),		/* Games     */
-	KEY(2, 0, KEY_QUESTION),	/* Directory */
-	KEY(3, 2, KEY_CONNECT),		/* Internet  */
-	KEY(2, 1, KEY_SHOP),		/* Services  */
-	KEY(1, 1, KEY_PHONE),		/* VoiceMail */
-
-	KEY(1, 0, KEY_DELETE),		/* Delete    */
-	KEY(2, 2, KEY_PLAY),		/* Play      */
-	KEY(0, 1, KEY_PAGEUP),		/* Up        */
-	KEY(3, 1, KEY_PAGEDOWN),	/* Down      */
-	KEY(0, 2, KEY_EMAIL),		/* ReadEmail */
-	KEY(1, 2, KEY_STOP),		/* Stop      */
+static const unsigned int ams_delta_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_F1),		/* Advert    */
+
+	MATRIX_KEY(3, 0, KEY_COFFEE),		/* Games     */
+	MATRIX_KEY(2, 0, KEY_QUESTION),		/* Directory */
+	MATRIX_KEY(3, 2, KEY_CONNECT),		/* Internet  */
+	MATRIX_KEY(2, 1, KEY_SHOP),		/* Services  */
+	MATRIX_KEY(1, 1, KEY_PHONE),		/* VoiceMail */
+
+	MATRIX_KEY(1, 0, KEY_DELETE),		/* Delete    */
+	MATRIX_KEY(2, 2, KEY_PLAY),		/* Play      */
+	MATRIX_KEY(0, 1, KEY_PAGEUP),		/* Up        */
+	MATRIX_KEY(3, 1, KEY_PAGEDOWN),		/* Down      */
+	MATRIX_KEY(0, 2, KEY_EMAIL),		/* ReadEmail */
+	MATRIX_KEY(1, 2, KEY_STOP),		/* Stop      */

 	/* Numeric keypad portion */
-	KEY(7, 0, KEY_KP1),
-	KEY(6, 0, KEY_KP2),
-	KEY(5, 0, KEY_KP3),
-	KEY(7, 1, KEY_KP4),
-	KEY(6, 1, KEY_KP5),
-	KEY(5, 1, KEY_KP6),
-	KEY(7, 2, KEY_KP7),
-	KEY(6, 2, KEY_KP8),
-	KEY(5, 2, KEY_KP9),
-	KEY(6, 3, KEY_KP0),
-	KEY(7, 3, KEY_KPASTERISK),
-	KEY(5, 3, KEY_KPDOT),		/* # key     */
-	KEY(2, 7, KEY_NUMLOCK),		/* Mute      */
-	KEY(1, 7, KEY_KPMINUS),		/* Recall    */
-	KEY(1, 6, KEY_KPPLUS),		/* Redial    */
-	KEY(6, 7, KEY_KPSLASH),		/* Handsfree */
-	KEY(0, 6, KEY_ENTER),		/* Video     */
-
-	KEY(4, 7, KEY_CAMERA),		/* Photo     */
-
-	KEY(4, 0, KEY_F2),		/* Home      */
-	KEY(4, 1, KEY_F3),		/* Office    */
-	KEY(4, 2, KEY_F4),		/* Mobile    */
-	KEY(7, 7, KEY_F5),		/* SMS       */
-	KEY(5, 7, KEY_F6),		/* Email     */
+	MATRIX_KEY(7, 0, KEY_KP1),
+	MATRIX_KEY(6, 0, KEY_KP2),
+	MATRIX_KEY(5, 0, KEY_KP3),
+	MATRIX_KEY(7, 1, KEY_KP4),
+	MATRIX_KEY(6, 1, KEY_KP5),
+	MATRIX_KEY(5, 1, KEY_KP6),
+	MATRIX_KEY(7, 2, KEY_KP7),
+	MATRIX_KEY(6, 2, KEY_KP8),
+	MATRIX_KEY(5, 2, KEY_KP9),
+	MATRIX_KEY(6, 3, KEY_KP0),
+	MATRIX_KEY(7, 3, KEY_KPASTERISK),
+	MATRIX_KEY(5, 3, KEY_KPDOT),		/* # key     */
+	MATRIX_KEY(2, 7, KEY_NUMLOCK),		/* Mute      */
+	MATRIX_KEY(1, 7, KEY_KPMINUS),		/* Recall    */
+	MATRIX_KEY(1, 6, KEY_KPPLUS),		/* Redial    */
+	MATRIX_KEY(6, 7, KEY_KPSLASH),		/* Handsfree */
+	MATRIX_KEY(0, 6, KEY_ENTER),		/* Video     */
+
+	MATRIX_KEY(4, 7, KEY_CAMERA),		/* Photo     */
+
+	MATRIX_KEY(4, 0, KEY_F2),		/* Home      */
+	MATRIX_KEY(4, 1, KEY_F3),		/* Office    */
+	MATRIX_KEY(4, 2, KEY_F4),		/* Mobile    */
+	MATRIX_KEY(7, 7, KEY_F5),		/* SMS       */
+	MATRIX_KEY(5, 7, KEY_F6),		/* Email     */

 	/* QWERTY portion of keypad */
-	KEY(4, 3, KEY_Q),
-	KEY(3, 3, KEY_W),
-	KEY(2, 3, KEY_E),
-	KEY(1, 3, KEY_R),
-	KEY(0, 3, KEY_T),
-	KEY(7, 4, KEY_Y),
-	KEY(6, 4, KEY_U),
-	KEY(5, 4, KEY_I),
-	KEY(4, 4, KEY_O),
-	KEY(3, 4, KEY_P),
-
-	KEY(2, 4, KEY_A),
-	KEY(1, 4, KEY_S),
-	KEY(0, 4, KEY_D),
-	KEY(7, 5, KEY_F),
-	KEY(6, 5, KEY_G),
-	KEY(5, 5, KEY_H),
-	KEY(4, 5, KEY_J),
-	KEY(3, 5, KEY_K),
-	KEY(2, 5, KEY_L),
-
-	KEY(1, 5, KEY_Z),
-	KEY(0, 5, KEY_X),
-	KEY(7, 6, KEY_C),
-	KEY(6, 6, KEY_V),
-	KEY(5, 6, KEY_B),
-	KEY(4, 6, KEY_N),
-	KEY(3, 6, KEY_M),
-	KEY(2, 6, KEY_SPACE),
-
-	KEY(0, 7, KEY_LEFTSHIFT),	/* Vol up    */
-	KEY(3, 7, KEY_LEFTCTRL),	/* Vol down  */
-
-	0
+	MATRIX_KEY(4, 3, KEY_Q),
+	MATRIX_KEY(3, 3, KEY_W),
+	MATRIX_KEY(2, 3, KEY_E),
+	MATRIX_KEY(1, 3, KEY_R),
+	MATRIX_KEY(0, 3, KEY_T),
+	MATRIX_KEY(7, 4, KEY_Y),
+	MATRIX_KEY(6, 4, KEY_U),
+	MATRIX_KEY(5, 4, KEY_I),
+	MATRIX_KEY(4, 4, KEY_O),
+	MATRIX_KEY(3, 4, KEY_P),
+
+	MATRIX_KEY(2, 4, KEY_A),
+	MATRIX_KEY(1, 4, KEY_S),
+	MATRIX_KEY(0, 4, KEY_D),
+	MATRIX_KEY(7, 5, KEY_F),
+	MATRIX_KEY(6, 5, KEY_G),
+	MATRIX_KEY(5, 5, KEY_H),
+	MATRIX_KEY(4, 5, KEY_J),
+	MATRIX_KEY(3, 5, KEY_K),
+	MATRIX_KEY(2, 5, KEY_L),
+
+	MATRIX_KEY(1, 5, KEY_Z),
+	MATRIX_KEY(0, 5, KEY_X),
+	MATRIX_KEY(7, 6, KEY_C),
+	MATRIX_KEY(6, 6, KEY_V),
+	MATRIX_KEY(5, 6, KEY_B),
+	MATRIX_KEY(4, 6, KEY_N),
+	MATRIX_KEY(3, 6, KEY_M),
+	MATRIX_KEY(2, 6, KEY_SPACE),
+
+	MATRIX_KEY(0, 7, KEY_LEFTSHIFT),	/* Vol up    */
+	MATRIX_KEY(3, 7, KEY_LEFTCTRL),		/* Vol down  */
 };

 void ams_delta_latch1_write(u8 mask, u8 value)
diff --git a/arch/arm/mach-omap1/board-fsample.c
b/arch/arm/mach-omap1/board-fsample.c
index 3030829..229c3e1 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -36,36 +36,36 @@
 #include <mach/board.h>
 #include <mach/board-fsample.h>

-static int fsample_keymap[] = {
-	KEY(0,0,KEY_UP),
-	KEY(0,1,KEY_RIGHT),
-	KEY(0,2,KEY_LEFT),
-	KEY(0,3,KEY_DOWN),
-	KEY(0,4,KEY_ENTER),
-	KEY(1,0,KEY_F10),
-	KEY(1,1,KEY_SEND),
-	KEY(1,2,KEY_END),
-	KEY(1,3,KEY_VOLUMEDOWN),
-	KEY(1,4,KEY_VOLUMEUP),
-	KEY(1,5,KEY_RECORD),
-	KEY(2,0,KEY_F9),
-	KEY(2,1,KEY_3),
-	KEY(2,2,KEY_6),
-	KEY(2,3,KEY_9),
-	KEY(2,4,KEY_KPDOT),
-	KEY(3,0,KEY_BACK),
-	KEY(3,1,KEY_2),
-	KEY(3,2,KEY_5),
-	KEY(3,3,KEY_8),
-	KEY(3,4,KEY_0),
-	KEY(3,5,KEY_KPSLASH),
-	KEY(4,0,KEY_HOME),
-	KEY(4,1,KEY_1),
-	KEY(4,2,KEY_4),
-	KEY(4,3,KEY_7),
-	KEY(4,4,KEY_KPASTERISK),
-	KEY(4,5,KEY_POWER),
-	0
+static const unsigned int fsample_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_UP),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_LEFT),
+	MATRIX_KEY(0, 3, KEY_DOWN),
+	MATRIX_KEY(0, 4, KEY_ENTER),
+	MATRIX_KEY(1, 0, KEY_F10),
+	MATRIX_KEY(1, 1, KEY_SEND),
+	MATRIX_KEY(1, 2, KEY_END),
+	MATRIX_KEY(1, 3, KEY_VOLUMEDOWN),
+	MATRIX_KEY(1, 4, KEY_VOLUMEUP),
+	MATRIX_KEY(1, 5, KEY_RECORD),
+	MATRIX_KEY(2, 0, KEY_F9),
+	MATRIX_KEY(2, 1, KEY_3),
+	MATRIX_KEY(2, 2, KEY_6),
+	MATRIX_KEY(2, 3, KEY_9),
+	MATRIX_KEY(2, 4, KEY_KPDOT),
+	MATRIX_KEY(3, 0, KEY_BACK),
+	MATRIX_KEY(3, 1, KEY_2),
+	MATRIX_KEY(3, 2, KEY_5),
+	MATRIX_KEY(3, 3, KEY_8),
+	MATRIX_KEY(3, 4, KEY_0),
+	MATRIX_KEY(3, 5, KEY_KPSLASH),
+	MATRIX_KEY(4, 0, KEY_HOME),
+	MATRIX_KEY(4, 1, KEY_1),
+	MATRIX_KEY(4, 2, KEY_4),
+	MATRIX_KEY(4, 3, KEY_7),
+	MATRIX_KEY(4, 4, KEY_KPASTERISK),
+	MATRIX_KEY(4, 5, KEY_POWER),
 };

 static struct resource smc91x_resources[] = {
diff --git a/arch/arm/mach-omap1/board-h2.c
b/arch/arm/mach-omap1/board-h2.c
index 0d784a7..c14551c 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -46,43 +46,43 @@
 #include <mach/keypad.h>
 #include <mach/common.h>

-static int h2_keymap[] = {
-	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_3),
-	KEY(0, 3, KEY_F10),
-	KEY(0, 4, KEY_F5),
-	KEY(0, 5, KEY_9),
-	KEY(1, 0, KEY_DOWN),
-	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_2),
-	KEY(1, 3, KEY_F9),
-	KEY(1, 4, KEY_F7),
-	KEY(1, 5, KEY_0),
-	KEY(2, 0, KEY_ENTER),
-	KEY(2, 1, KEY_6),
-	KEY(2, 2, KEY_1),
-	KEY(2, 3, KEY_F2),
-	KEY(2, 4, KEY_F6),
-	KEY(2, 5, KEY_HOME),
-	KEY(3, 0, KEY_8),
-	KEY(3, 1, KEY_5),
-	KEY(3, 2, KEY_F12),
-	KEY(3, 3, KEY_F3),
-	KEY(3, 4, KEY_F8),
-	KEY(3, 5, KEY_END),
-	KEY(4, 0, KEY_7),
-	KEY(4, 1, KEY_4),
-	KEY(4, 2, KEY_F11),
-	KEY(4, 3, KEY_F1),
-	KEY(4, 4, KEY_F4),
-	KEY(4, 5, KEY_ESC),
-	KEY(5, 0, KEY_F13),
-	KEY(5, 1, KEY_F14),
-	KEY(5, 2, KEY_F15),
-	KEY(5, 3, KEY_F16),
-	KEY(5, 4, KEY_SLEEP),
-	0
+static const unsigned int h2_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_LEFT),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_3),
+	MATRIX_KEY(0, 3, KEY_F10),
+	MATRIX_KEY(0, 4, KEY_F5),
+	MATRIX_KEY(0, 5, KEY_9),
+	MATRIX_KEY(1, 0, KEY_DOWN),
+	MATRIX_KEY(1, 1, KEY_UP),
+	MATRIX_KEY(1, 2, KEY_2),
+	MATRIX_KEY(1, 3, KEY_F9),
+	MATRIX_KEY(1, 4, KEY_F7),
+	MATRIX_KEY(1, 5, KEY_0),
+	MATRIX_KEY(2, 0, KEY_ENTER),
+	MATRIX_KEY(2, 1, KEY_6),
+	MATRIX_KEY(2, 2, KEY_1),
+	MATRIX_KEY(2, 3, KEY_F2),
+	MATRIX_KEY(2, 4, KEY_F6),
+	MATRIX_KEY(2, 5, KEY_HOME),
+	MATRIX_KEY(3, 0, KEY_8),
+	MATRIX_KEY(3, 1, KEY_5),
+	MATRIX_KEY(3, 2, KEY_F12),
+	MATRIX_KEY(3, 3, KEY_F3),
+	MATRIX_KEY(3, 4, KEY_F8),
+	MATRIX_KEY(3, 5, KEY_END),
+	MATRIX_KEY(4, 0, KEY_7),
+	MATRIX_KEY(4, 1, KEY_4),
+	MATRIX_KEY(4, 2, KEY_F11),
+	MATRIX_KEY(4, 3, KEY_F1),
+	MATRIX_KEY(4, 4, KEY_F4),
+	MATRIX_KEY(4, 5, KEY_ESC),
+	MATRIX_KEY(5, 0, KEY_F13),
+	MATRIX_KEY(5, 1, KEY_F14),
+	MATRIX_KEY(5, 2, KEY_F15),
+	MATRIX_KEY(5, 3, KEY_F16),
+	MATRIX_KEY(5, 4, KEY_SLEEP),
 };

 static struct mtd_partition h2_nor_partitions[] = {
diff --git a/arch/arm/mach-omap1/board-h3.c
b/arch/arm/mach-omap1/board-h3.c
index bf08b6a..f79edbd 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -52,43 +52,43 @@

 #define H3_TS_GPIO	48

-static int h3_keymap[] = {
-	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_3),
-	KEY(0, 3, KEY_F10),
-	KEY(0, 4, KEY_F5),
-	KEY(0, 5, KEY_9),
-	KEY(1, 0, KEY_DOWN),
-	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_2),
-	KEY(1, 3, KEY_F9),
-	KEY(1, 4, KEY_F7),
-	KEY(1, 5, KEY_0),
-	KEY(2, 0, KEY_ENTER),
-	KEY(2, 1, KEY_6),
-	KEY(2, 2, KEY_1),
-	KEY(2, 3, KEY_F2),
-	KEY(2, 4, KEY_F6),
-	KEY(2, 5, KEY_HOME),
-	KEY(3, 0, KEY_8),
-	KEY(3, 1, KEY_5),
-	KEY(3, 2, KEY_F12),
-	KEY(3, 3, KEY_F3),
-	KEY(3, 4, KEY_F8),
-	KEY(3, 5, KEY_END),
-	KEY(4, 0, KEY_7),
-	KEY(4, 1, KEY_4),
-	KEY(4, 2, KEY_F11),
-	KEY(4, 3, KEY_F1),
-	KEY(4, 4, KEY_F4),
-	KEY(4, 5, KEY_ESC),
-	KEY(5, 0, KEY_F13),
-	KEY(5, 1, KEY_F14),
-	KEY(5, 2, KEY_F15),
-	KEY(5, 3, KEY_F16),
-	KEY(5, 4, KEY_SLEEP),
-	0
+static const unsigned int h3_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_LEFT),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_3),
+	MATRIX_KEY(0, 3, KEY_F10),
+	MATRIX_KEY(0, 4, KEY_F5),
+	MATRIX_KEY(0, 5, KEY_9),
+	MATRIX_KEY(1, 0, KEY_DOWN),
+	MATRIX_KEY(1, 1, KEY_UP),
+	MATRIX_KEY(1, 2, KEY_2),
+	MATRIX_KEY(1, 3, KEY_F9),
+	MATRIX_KEY(1, 4, KEY_F7),
+	MATRIX_KEY(1, 5, KEY_0),
+	MATRIX_KEY(2, 0, KEY_ENTER),
+	MATRIX_KEY(2, 1, KEY_6),
+	MATRIX_KEY(2, 2, KEY_1),
+	MATRIX_KEY(2, 3, KEY_F2),
+	MATRIX_KEY(2, 4, KEY_F6),
+	MATRIX_KEY(2, 5, KEY_HOME),
+	MATRIX_KEY(3, 0, KEY_8),
+	MATRIX_KEY(3, 1, KEY_5),
+	MATRIX_KEY(3, 2, KEY_F12),
+	MATRIX_KEY(3, 3, KEY_F3),
+	MATRIX_KEY(3, 4, KEY_F8),
+	MATRIX_KEY(3, 5, KEY_END),
+	MATRIX_KEY(4, 0, KEY_7),
+	MATRIX_KEY(4, 1, KEY_4),
+	MATRIX_KEY(4, 2, KEY_F11),
+	MATRIX_KEY(4, 3, KEY_F1),
+	MATRIX_KEY(4, 4, KEY_F4),
+	MATRIX_KEY(4, 5, KEY_ESC),
+	MATRIX_KEY(5, 0, KEY_F13),
+	MATRIX_KEY(5, 1, KEY_F14),
+	MATRIX_KEY(5, 2, KEY_F15),
+	MATRIX_KEY(5, 3, KEY_F16),
+	MATRIX_KEY(5, 4, KEY_SLEEP),
 };


diff --git a/arch/arm/mach-omap1/board-innovator.c
b/arch/arm/mach-omap1/board-innovator.c
index 071cd02..3d57f4d 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -39,17 +39,17 @@
 #include <mach/common.h>
 #include <mach/mmc.h>

-static int innovator_keymap[] = {
-	KEY(0, 0, KEY_F1),
-	KEY(0, 3, KEY_DOWN),
-	KEY(1, 1, KEY_F2),
-	KEY(1, 2, KEY_RIGHT),
-	KEY(2, 0, KEY_F3),
-	KEY(2, 1, KEY_F4),
-	KEY(2, 2, KEY_UP),
-	KEY(3, 2, KEY_ENTER),
-	KEY(3, 3, KEY_LEFT),
-	0
+static const unsigned int innovator_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_F1),
+	MATRIX_KEY(0, 3, KEY_DOWN),
+	MATRIX_KEY(1, 1, KEY_F2),
+	MATRIX_KEY(1, 2, KEY_RIGHT),
+	MATRIX_KEY(2, 0, KEY_F3),
+	MATRIX_KEY(2, 1, KEY_F4),
+	MATRIX_KEY(2, 2, KEY_UP),
+	MATRIX_KEY(3, 2, KEY_ENTER),
+	MATRIX_KEY(3, 3, KEY_LEFT),
 };

 static struct mtd_partition innovator_partitions[] = {
diff --git a/arch/arm/mach-omap1/board-nokia770.c
b/arch/arm/mach-omap1/board-nokia770.c
index af51e0b..d511eee 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -53,19 +53,19 @@ static void __init omap_nokia770_init_irq(void)
 	omap_init_irq();
 }

-static int nokia770_keymap[] = {
-	KEY(0, 1, GROUP_0 | KEY_UP),
-	KEY(0, 2, GROUP_1 | KEY_F5),
-	KEY(1, 0, GROUP_0 | KEY_LEFT),
-	KEY(1, 1, GROUP_0 | KEY_ENTER),
-	KEY(1, 2, GROUP_0 | KEY_RIGHT),
-	KEY(2, 0, GROUP_1 | KEY_ESC),
-	KEY(2, 1, GROUP_0 | KEY_DOWN),
-	KEY(2, 2, GROUP_1 | KEY_F4),
-	KEY(3, 0, GROUP_2 | KEY_F7),
-	KEY(3, 1, GROUP_2 | KEY_F8),
-	KEY(3, 2, GROUP_2 | KEY_F6),
-	0
+static const unsigned int nokia770_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 1, GROUP_0 | KEY_UP),
+	MATRIX_KEY(0, 2, GROUP_1 | KEY_F5),
+	MATRIX_KEY(1, 0, GROUP_0 | KEY_LEFT),
+	MATRIX_KEY(1, 1, GROUP_0 | KEY_ENTER),
+	MATRIX_KEY(1, 2, GROUP_0 | KEY_RIGHT),
+	MATRIX_KEY(2, 0, GROUP_1 | KEY_ESC),
+	MATRIX_KEY(2, 1, GROUP_0 | KEY_DOWN),
+	MATRIX_KEY(2, 2, GROUP_1 | KEY_F4),
+	MATRIX_KEY(3, 0, GROUP_2 | KEY_F7),
+	MATRIX_KEY(3, 1, GROUP_2 | KEY_F8),
+	MATRIX_KEY(3, 2, GROUP_2 | KEY_F6),
 };

 static struct resource nokia770_kp_resources[] = {
diff --git a/arch/arm/mach-omap1/board-osk.c
b/arch/arm/mach-omap1/board-osk.c
index 1a16ecb..0db4656 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -322,24 +322,23 @@ static struct i2c_board_info __initdata
mistral_i2c_board_info[] = {
 	 */
 };

-static const int osk_keymap[] = {
-	/* KEY(col, row, code) */
-	KEY(0, 0, KEY_F1),		/* SW4 */
-	KEY(0, 3, KEY_UP),		/* (sw2/up) */
-	KEY(1, 1, KEY_LEFTCTRL),	/* SW5 */
-	KEY(1, 2, KEY_LEFT),		/* (sw2/left) */
-	KEY(2, 0, KEY_SPACE),		/* SW3 */
-	KEY(2, 1, KEY_ESC),		/* SW6 */
-	KEY(2, 2, KEY_DOWN),		/* (sw2/down) */
-	KEY(3, 2, KEY_ENTER),		/* (sw2/select) */
-	KEY(3, 3, KEY_RIGHT),		/* (sw2/right) */
-	0
+static const unsigned int osk_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_F1),		/* SW4 */
+	MATRIX_KEY(0, 3, KEY_UP),		/* (sw2/up) */
+	MATRIX_KEY(1, 1, KEY_LEFTCTRL),		/* SW5 */
+	MATRIX_KEY(1, 2, KEY_LEFT),		/* (sw2/left) */
+	MATRIX_KEY(2, 0, KEY_SPACE),		/* SW3 */
+	MATRIX_KEY(2, 1, KEY_ESC),		/* SW6 */
+	MATRIX_KEY(2, 2, KEY_DOWN),		/* (sw2/down) */
+	MATRIX_KEY(3, 2, KEY_ENTER),		/* (sw2/select) */
+	MATRIX_KEY(3, 3, KEY_RIGHT),		/* (sw2/right) */
 };

 static struct omap_kp_platform_data osk_kp_data = {
 	.rows		= 8,
 	.cols		= 8,
-	.keymap		= (int *) osk_keymap,
+	.keymap		= osk_keymap,
 	.keymapsize	= ARRAY_SIZE(osk_keymap),
 	.delay		= 9,
 };
diff --git a/arch/arm/mach-omap1/board-palmte.c
b/arch/arm/mach-omap1/board-palmte.c
index 99f2b43..473b1f4 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -50,26 +50,27 @@ static void __init omap_palmte_init_irq(void)
 	omap_gpio_init();
 }

-static const int palmte_keymap[] = {
-	KEY(0, 0, KEY_F1),		/* Calendar */
-	KEY(0, 1, KEY_F2),		/* Contacts */
-	KEY(0, 2, KEY_F3),		/* Tasks List */
-	KEY(0, 3, KEY_F4),		/* Note Pad */
-	KEY(0, 4, KEY_POWER),
-	KEY(1, 0, KEY_LEFT),
-	KEY(1, 1, KEY_DOWN),
-	KEY(1, 2, KEY_UP),
-	KEY(1, 3, KEY_RIGHT),
-	KEY(1, 4, KEY_ENTER),
-	0,
+static const unsigned int palmte_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_F1),		/* Calendar */
+	MATRIX_KEY(0, 1, KEY_F2),		/* Contacts */
+	MATRIX_KEY(0, 2, KEY_F3),		/* Tasks List */
+	MATRIX_KEY(0, 3, KEY_F4),		/* Note Pad */
+	MATRIX_KEY(0, 4, KEY_POWER),
+	MATRIX_KEY(1, 0, KEY_LEFT),
+	MATRIX_KEY(1, 1, KEY_DOWN),
+	MATRIX_KEY(1, 2, KEY_UP),
+	MATRIX_KEY(1, 3, KEY_RIGHT),
+	MATRIX_KEY(1, 4, KEY_ENTER),
 };

 static struct omap_kp_platform_data palmte_kp_data = {
-	.rows	= 8,
-	.cols	= 8,
-	.keymap = (int *) palmte_keymap,
-	.rep	= 1,
-	.delay	= 12,
+	.rows		= 8,
+	.cols		= 8,
+	.keymap		= palmte_keymap,
+	.keymapsize	= ARRAY_SIZE(palmte_keymap),
+	.rep		= 1,
+	.delay		= 12,
 };

 static struct resource palmte_kp_resources[] = {
diff --git a/arch/arm/mach-omap1/board-palmtt.c
b/arch/arm/mach-omap1/board-palmtt.c
index 1cbc127..dc53090 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -43,19 +43,19 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>

-static int palmtt_keymap[] = {
-	KEY(0, 0, KEY_ESC),
-	KEY(0, 1, KEY_SPACE),
-	KEY(0, 2, KEY_LEFTCTRL),
-	KEY(0, 3, KEY_TAB),
-	KEY(0, 4, KEY_ENTER),
-	KEY(1, 0, KEY_LEFT),
-	KEY(1, 1, KEY_DOWN),
-	KEY(1, 2, KEY_UP),
-	KEY(1, 3, KEY_RIGHT),
-	KEY(2, 0, KEY_SLEEP),
-	KEY(2, 4, KEY_Y),
-	0
+static const unsigned int palmtt_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_ESC),
+	MATRIX_KEY(0, 1, KEY_SPACE),
+	MATRIX_KEY(0, 2, KEY_LEFTCTRL),
+	MATRIX_KEY(0, 3, KEY_TAB),
+	MATRIX_KEY(0, 4, KEY_ENTER),
+	MATRIX_KEY(1, 0, KEY_LEFT),
+	MATRIX_KEY(1, 1, KEY_DOWN),
+	MATRIX_KEY(1, 2, KEY_UP),
+	MATRIX_KEY(1, 3, KEY_RIGHT),
+	MATRIX_KEY(2, 0, KEY_SLEEP),
+	MATRIX_KEY(2, 4, KEY_Y),
 };

 static struct mtd_partition palmtt_partitions[] = {
@@ -129,9 +129,10 @@ static struct resource palmtt_kp_resources[] = {
 };

 static struct omap_kp_platform_data palmtt_kp_data = {
-	.rows	= 6,
-	.cols	= 3,
-	.keymap = palmtt_keymap,
+	.rows		= 6,
+	.cols		= 3,
+	.keymap		= palmtt_keymap,
+	.keymapsize	= ARRAY_SIZE(palmtt_keymap),
 };

 static struct platform_device palmtt_kp_device = {
diff --git a/arch/arm/mach-omap1/board-palmz71.c
b/arch/arm/mach-omap1/board-palmz71.c
index baf5efb..1cabca9 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -54,27 +54,28 @@ omap_palmz71_init_irq(void)
 	omap_gpio_init();
 }

-static int palmz71_keymap[] = {
-	KEY(0, 0, KEY_F1),
-	KEY(0, 1, KEY_F2),
-	KEY(0, 2, KEY_F3),
-	KEY(0, 3, KEY_F4),
-	KEY(0, 4, KEY_POWER),
-	KEY(1, 0, KEY_LEFT),
-	KEY(1, 1, KEY_DOWN),
-	KEY(1, 2, KEY_UP),
-	KEY(1, 3, KEY_RIGHT),
-	KEY(1, 4, KEY_ENTER),
-	KEY(2, 0, KEY_CAMERA),
-	0,
+static const unsigned int palmz71_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_F1),
+	MATRIX_KEY(0, 1, KEY_F2),
+	MATRIX_KEY(0, 2, KEY_F3),
+	MATRIX_KEY(0, 3, KEY_F4),
+	MATRIX_KEY(0, 4, KEY_POWER),
+	MATRIX_KEY(1, 0, KEY_LEFT),
+	MATRIX_KEY(1, 1, KEY_DOWN),
+	MATRIX_KEY(1, 2, KEY_UP),
+	MATRIX_KEY(1, 3, KEY_RIGHT),
+	MATRIX_KEY(1, 4, KEY_ENTER),
+	MATRIX_KEY(2, 0, KEY_CAMERA),
 };

 static struct omap_kp_platform_data palmz71_kp_data = {
-	.rows	= 8,
-	.cols	= 8,
-	.keymap	= palmz71_keymap,
-	.rep	= 1,
-	.delay	= 80,
+	.rows		= 8,
+	.cols		= 8,
+	.keymap		= palmz71_keymap,
+	.keymapsize	= ARRAY_SIZE(palmz71_keymap),
+	.rep		= 1,
+	.delay		= 80,
 };

 static struct resource palmz71_kp_resources[] = {
diff --git a/arch/arm/mach-omap1/board-perseus2.c
b/arch/arm/mach-omap1/board-perseus2.c
index 3b9f907..39b4b86 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -35,36 +35,36 @@
 #include <mach/common.h>
 #include <mach/board.h>

-static int p2_keymap[] = {
-	KEY(0,0,KEY_UP),
-	KEY(0,1,KEY_RIGHT),
-	KEY(0,2,KEY_LEFT),
-	KEY(0,3,KEY_DOWN),
-	KEY(0,4,KEY_ENTER),
-	KEY(1,0,KEY_F10),
-	KEY(1,1,KEY_SEND),
-	KEY(1,2,KEY_END),
-	KEY(1,3,KEY_VOLUMEDOWN),
-	KEY(1,4,KEY_VOLUMEUP),
-	KEY(1,5,KEY_RECORD),
-	KEY(2,0,KEY_F9),
-	KEY(2,1,KEY_3),
-	KEY(2,2,KEY_6),
-	KEY(2,3,KEY_9),
-	KEY(2,4,KEY_KPDOT),
-	KEY(3,0,KEY_BACK),
-	KEY(3,1,KEY_2),
-	KEY(3,2,KEY_5),
-	KEY(3,3,KEY_8),
-	KEY(3,4,KEY_0),
-	KEY(3,5,KEY_KPSLASH),
-	KEY(4,0,KEY_HOME),
-	KEY(4,1,KEY_1),
-	KEY(4,2,KEY_4),
-	KEY(4,3,KEY_7),
-	KEY(4,4,KEY_KPASTERISK),
-	KEY(4,5,KEY_POWER),
-	0
+static const unsigned int p2_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_UP),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_LEFT),
+	MATRIX_KEY(0, 3, KEY_DOWN),
+	MATRIX_KEY(0, 4, KEY_ENTER),
+	MATRIX_KEY(1, 0, KEY_F10),
+	MATRIX_KEY(1, 1, KEY_SEND),
+	MATRIX_KEY(1, 2, KEY_END),
+	MATRIX_KEY(1, 3, KEY_VOLUMEDOWN),
+	MATRIX_KEY(1, 4, KEY_VOLUMEUP),
+	MATRIX_KEY(1, 5, KEY_RECORD),
+	MATRIX_KEY(2, 0, KEY_F9),
+	MATRIX_KEY(2, 1, KEY_3),
+	MATRIX_KEY(2, 2, KEY_6),
+	MATRIX_KEY(2, 3, KEY_9),
+	MATRIX_KEY(2, 4, KEY_KPDOT),
+	MATRIX_KEY(3, 0, KEY_BACK),
+	MATRIX_KEY(3, 1, KEY_2),
+	MATRIX_KEY(3, 2, KEY_5),
+	MATRIX_KEY(3, 3, KEY_8),
+	MATRIX_KEY(3, 4, KEY_0),
+	MATRIX_KEY(3, 5, KEY_KPSLASH),
+	MATRIX_KEY(4, 0, KEY_HOME),
+	MATRIX_KEY(4, 1, KEY_1),
+	MATRIX_KEY(4, 2, KEY_4),
+	MATRIX_KEY(4, 3, KEY_7),
+	MATRIX_KEY(4, 4, KEY_KPASTERISK),
+	MATRIX_KEY(4, 5, KEY_POWER),
 };

 static struct resource smc91x_resources[] = {
diff --git a/arch/arm/mach-omap1/board-sx1.c
b/arch/arm/mach-omap1/board-sx1.c
index 28c76a1..8061c42 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -162,36 +162,36 @@ EXPORT_SYMBOL(sx1_setusbpower);

 /*----------- Keypad -------------------------*/

-static int sx1_keymap[] = {
-	KEY(5, 3, GROUP_0 | 117), /* camera Qt::Key_F17 */
-	KEY(0, 4, GROUP_0 | 114), /* voice memo Qt::Key_F14 */
-	KEY(1, 4, GROUP_2 | 114), /* voice memo */
-	KEY(2, 4, GROUP_3 | 114), /* voice memo */
-	KEY(0, 0, GROUP_1 | KEY_F12),	/* red button Qt::Key_Hangup */
-	KEY(4, 3, GROUP_1 | KEY_LEFT),
-	KEY(2, 3, GROUP_1 | KEY_DOWN),
-	KEY(1, 3, GROUP_1 | KEY_RIGHT),
-	KEY(0, 3, GROUP_1 | KEY_UP),
-	KEY(3, 3, GROUP_1 | KEY_POWER), /* joystick press or
Qt::Key_Select */
-	KEY(5, 0, GROUP_1 | KEY_1),
-	KEY(4, 0, GROUP_1 | KEY_2),
-	KEY(3, 0, GROUP_1 | KEY_3),
-	KEY(3, 4, GROUP_1 | KEY_4),
-	KEY(4, 4, GROUP_1 | KEY_5),
-	KEY(5, 4, GROUP_1 | KEY_KPASTERISK),/* "*" */
-	KEY(4, 1, GROUP_1 | KEY_6),
-	KEY(5, 1, GROUP_1 | KEY_7),
-	KEY(3, 1, GROUP_1 | KEY_8),
-	KEY(3, 2, GROUP_1 | KEY_9),
-	KEY(5, 2, GROUP_1 | KEY_0),
-	KEY(4, 2, GROUP_1 | 113),	/* # F13 Toggle input method
Qt::Key_F13 */
-	KEY(0, 1, GROUP_1 | KEY_F11),	/* green button Qt::Key_Call */
-	KEY(1, 2, GROUP_1 | KEY_YEN),	/* left soft Qt::Key_Context1 */
-	KEY(2, 2, GROUP_1 | KEY_F8),	/* right soft Qt::Key_Back */
-	KEY(2, 1, GROUP_1 | KEY_LEFTSHIFT), /* shift */
-	KEY(1, 1, GROUP_1 | KEY_BACKSPACE), /* C (clear) */
-	KEY(0, 2, GROUP_1 | KEY_F7),	/* menu Qt::Key_Menu */
-	0
+static const unsigned int sx1_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(5, 3, GROUP_0 | 117), 	/* camera Qt::Key_F17 */
+	MATRIX_KEY(0, 4, GROUP_0 | 114), 	/* voice memo
Qt::Key_F14 */
+	MATRIX_KEY(1, 4, GROUP_2 | 114), 	/* voice memo */
+	MATRIX_KEY(2, 4, GROUP_3 | 114), 	/* voice memo */
+	MATRIX_KEY(0, 0, GROUP_1 | KEY_F12),	/* red button
Qt::Key_Hangup */
+	MATRIX_KEY(4, 3, GROUP_1 | KEY_LEFT),
+	MATRIX_KEY(2, 3, GROUP_1 | KEY_DOWN),
+	MATRIX_KEY(1, 3, GROUP_1 | KEY_RIGHT),
+	MATRIX_KEY(0, 3, GROUP_1 | KEY_UP),
+	MATRIX_KEY(3, 3, GROUP_1 | KEY_POWER), /* joystick press or
Qt::Key_Select */
+	MATRIX_KEY(5, 0, GROUP_1 | KEY_1),
+	MATRIX_KEY(4, 0, GROUP_1 | KEY_2),
+	MATRIX_KEY(3, 0, GROUP_1 | KEY_3),
+	MATRIX_KEY(3, 4, GROUP_1 | KEY_4),
+	MATRIX_KEY(4, 4, GROUP_1 | KEY_5),
+	MATRIX_KEY(5, 4, GROUP_1 | KEY_KPASTERISK), /* "*" */
+	MATRIX_KEY(4, 1, GROUP_1 | KEY_6),
+	MATRIX_KEY(5, 1, GROUP_1 | KEY_7),
+	MATRIX_KEY(3, 1, GROUP_1 | KEY_8),
+	MATRIX_KEY(3, 2, GROUP_1 | KEY_9),
+	MATRIX_KEY(5, 2, GROUP_1 | KEY_0),
+	MATRIX_KEY(4, 2, GROUP_1 | 113), /* # F13 Toggle input method
Qt::Key_F13 */
+	MATRIX_KEY(0, 1, GROUP_1 | KEY_F11),	/* green button
Qt::Key_Call */
+	MATRIX_KEY(1, 2, GROUP_1 | KEY_YEN),	/* left soft
Qt::Key_Context1 */
+	MATRIX_KEY(2, 2, GROUP_1 | KEY_F8),	/* right soft
Qt::Key_Back */
+	MATRIX_KEY(2, 1, GROUP_1 | KEY_LEFTSHIFT), /* shift */
+	MATRIX_KEY(1, 1, GROUP_1 | KEY_BACKSPACE), /* C (clear) */
+	MATRIX_KEY(0, 2, GROUP_1 | KEY_F7),	/* menu Qt::Key_Menu */
 };

 static struct resource sx1_kp_resources[] = {
@@ -205,9 +205,9 @@ static struct resource sx1_kp_resources[] = {
 static struct omap_kp_platform_data sx1_kp_data = {
 	.rows		= 6,
 	.cols		= 6,
-	.keymap	= sx1_keymap,
-	.keymapsize = ARRAY_SIZE(sx1_keymap),
-	.delay	= 80,
+	.keymap		= sx1_keymap,
+	.keymapsize	= ARRAY_SIZE(sx1_keymap),
+	.delay		= 80,
 };

 static struct platform_device sx1_kp_device = {
diff --git a/arch/arm/mach-omap2/board-h4.c
b/arch/arm/mach-omap2/board-h4.c
index 5e9b146..b32aed1 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -50,38 +50,38 @@
 static unsigned int row_gpios[6] = { 88, 89, 124, 11, 6, 96 };
 static unsigned int col_gpios[7] = { 90, 91, 100, 36, 12, 97, 98 };

-static int h4_keymap[] = {
-	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_A),
-	KEY(0, 3, KEY_B),
-	KEY(0, 4, KEY_C),
-	KEY(1, 0, KEY_DOWN),
-	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_E),
-	KEY(1, 3, KEY_F),
-	KEY(1, 4, KEY_G),
-	KEY(2, 0, KEY_ENTER),
-	KEY(2, 1, KEY_I),
-	KEY(2, 2, KEY_J),
-	KEY(2, 3, KEY_K),
-	KEY(2, 4, KEY_3),
-	KEY(3, 0, KEY_M),
-	KEY(3, 1, KEY_N),
-	KEY(3, 2, KEY_O),
-	KEY(3, 3, KEY_P),
-	KEY(3, 4, KEY_Q),
-	KEY(4, 0, KEY_R),
-	KEY(4, 1, KEY_4),
-	KEY(4, 2, KEY_T),
-	KEY(4, 3, KEY_U),
-	KEY(4, 4, KEY_ENTER),
-	KEY(5, 0, KEY_V),
-	KEY(5, 1, KEY_W),
-	KEY(5, 2, KEY_L),
-	KEY(5, 3, KEY_S),
-	KEY(5, 4, KEY_ENTER),
-	0
+static const unsigned int h4_keymap[] = {
+	/* MATRIX_KEY(col, row, code) */
+	MATRIX_KEY(0, 0, KEY_LEFT),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_A),
+	MATRIX_KEY(0, 3, KEY_B),
+	MATRIX_KEY(0, 4, KEY_C),
+	MATRIX_KEY(1, 0, KEY_DOWN),
+	MATRIX_KEY(1, 1, KEY_UP),
+	MATRIX_KEY(1, 2, KEY_E),
+	MATRIX_KEY(1, 3, KEY_F),
+	MATRIX_KEY(1, 4, KEY_G),
+	MATRIX_KEY(2, 0, KEY_ENTER),
+	MATRIX_KEY(2, 1, KEY_I),
+	MATRIX_KEY(2, 2, KEY_J),
+	MATRIX_KEY(2, 3, KEY_K),
+	MATRIX_KEY(2, 4, KEY_3),
+	MATRIX_KEY(3, 0, KEY_M),
+	MATRIX_KEY(3, 1, KEY_N),
+	MATRIX_KEY(3, 2, KEY_O),
+	MATRIX_KEY(3, 3, KEY_P),
+	MATRIX_KEY(3, 4, KEY_Q),
+	MATRIX_KEY(4, 0, KEY_R),
+	MATRIX_KEY(4, 1, KEY_4),
+	MATRIX_KEY(4, 2, KEY_T),
+	MATRIX_KEY(4, 3, KEY_U),
+	MATRIX_KEY(4, 4, KEY_ENTER),
+	MATRIX_KEY(5, 0, KEY_V),
+	MATRIX_KEY(5, 1, KEY_W),
+	MATRIX_KEY(5, 2, KEY_L),
+	MATRIX_KEY(5, 3, KEY_S),
+	MATRIX_KEY(5, 4, KEY_ENTER),
 };

 static struct mtd_partition h4_partitions[] = { 
