From: "hartleys" <hartleys@visionengravers.com>
Subject: [PATCH 5/5] input: Update pxa platforms to use MATRIX_KEY macro
Date: Fri, 30 Jan 2009 13:49:41 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A5471@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og108.obsmtp.com ([64.18.1.21]:53914 "HELO
	exprod6og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752906AbZA3Sub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 13:50:31 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Update pxa platforms to use MATRIX_KEY macro.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index f5ed803..8913cb5 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -481,10 +481,17 @@ static inline void em_x270_init_ac97(void) {}
 #endif

 #if defined(CONFIG_KEYBOARD_PXA27x) ||
defined(CONFIG_KEYBOARD_PXA27x_MODULE)
-static unsigned int em_x270_matrix_keys[] = {
-	KEY(0, 0, KEY_A), KEY(1, 0, KEY_UP), KEY(2, 1, KEY_B),
-	KEY(0, 2, KEY_LEFT), KEY(1, 1, KEY_ENTER), KEY(2, 0, KEY_RIGHT),
-	KEY(0, 1, KEY_C), KEY(1, 2, KEY_DOWN), KEY(2, 2, KEY_D),
+static const unsigned int em_x270_matrix_keys[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_A),
+	MATRIX_KEY(1, 0, KEY_UP),
+	MATRIX_KEY(2, 1, KEY_B),
+	MATRIX_KEY(0, 2, KEY_LEFT),
+	MATRIX_KEY(1, 1, KEY_ENTER),
+	MATRIX_KEY(2, 0, KEY_RIGHT),
+	MATRIX_KEY(0, 1, KEY_C),
+	MATRIX_KEY(1, 2, KEY_DOWN),
+	MATRIX_KEY(2, 2, KEY_D),
 };

 struct pxa27x_keypad_platform_data em_x270_keypad_info = {
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index df5f822..7fa16b7 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -377,76 +377,78 @@ static unsigned long e6_pin_config[] __initdata =
{

 /* KEYPAD */
 #ifdef CONFIG_MACH_EZX_A780
-static unsigned int a780_key_map[] = {
-	KEY(0, 0, KEY_SEND),
-	KEY(0, 1, KEY_BACK),
-	KEY(0, 2, KEY_END),
-	KEY(0, 3, KEY_PAGEUP),
-	KEY(0, 4, KEY_UP),
-
-	KEY(1, 0, KEY_NUMERIC_1),
-	KEY(1, 1, KEY_NUMERIC_2),
-	KEY(1, 2, KEY_NUMERIC_3),
-	KEY(1, 3, KEY_SELECT),
-	KEY(1, 4, KEY_KPENTER),
-
-	KEY(2, 0, KEY_NUMERIC_4),
-	KEY(2, 1, KEY_NUMERIC_5),
-	KEY(2, 2, KEY_NUMERIC_6),
-	KEY(2, 3, KEY_RECORD),
-	KEY(2, 4, KEY_LEFT),
-
-	KEY(3, 0, KEY_NUMERIC_7),
-	KEY(3, 1, KEY_NUMERIC_8),
-	KEY(3, 2, KEY_NUMERIC_9),
-	KEY(3, 3, KEY_HOME),
-	KEY(3, 4, KEY_RIGHT),
-
-	KEY(4, 0, KEY_NUMERIC_STAR),
-	KEY(4, 1, KEY_NUMERIC_0),
-	KEY(4, 2, KEY_NUMERIC_POUND),
-	KEY(4, 3, KEY_PAGEDOWN),
-	KEY(4, 4, KEY_DOWN),
+static const unsigned int a780_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_SEND),
+	MATRIX_KEY(0, 1, KEY_BACK),
+	MATRIX_KEY(0, 2, KEY_END),
+	MATRIX_KEY(0, 3, KEY_PAGEUP),
+	MATRIX_KEY(0, 4, KEY_UP),
+
+	MATRIX_KEY(1, 0, KEY_NUMERIC_1),
+	MATRIX_KEY(1, 1, KEY_NUMERIC_2),
+	MATRIX_KEY(1, 2, KEY_NUMERIC_3),
+	MATRIX_KEY(1, 3, KEY_SELECT),
+	MATRIX_KEY(1, 4, KEY_KPENTER),
+
+	MATRIX_KEY(2, 0, KEY_NUMERIC_4),
+	MATRIX_KEY(2, 1, KEY_NUMERIC_5),
+	MATRIX_KEY(2, 2, KEY_NUMERIC_6),
+	MATRIX_KEY(2, 3, KEY_RECORD),
+	MATRIX_KEY(2, 4, KEY_LEFT),
+
+	MATRIX_KEY(3, 0, KEY_NUMERIC_7),
+	MATRIX_KEY(3, 1, KEY_NUMERIC_8),
+	MATRIX_KEY(3, 2, KEY_NUMERIC_9),
+	MATRIX_KEY(3, 3, KEY_HOME),
+	MATRIX_KEY(3, 4, KEY_RIGHT),
+
+	MATRIX_KEY(4, 0, KEY_NUMERIC_STAR),
+	MATRIX_KEY(4, 1, KEY_NUMERIC_0),
+	MATRIX_KEY(4, 2, KEY_NUMERIC_POUND),
+	MATRIX_KEY(4, 3, KEY_PAGEDOWN),
+	MATRIX_KEY(4, 4, KEY_DOWN),
 };

 static struct pxa27x_keypad_platform_data a780_keypad_platform_data = {
-	.matrix_key_rows = 5,
-	.matrix_key_cols = 5,
-	.matrix_key_map = a780_key_map,
-	.matrix_key_map_size = ARRAY_SIZE(a780_key_map),
+	.matrix_key_rows	= 5,
+	.matrix_key_cols	= 5,
+	.matrix_key_map		= a780_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(a780_key_map),

-	.direct_key_map = { KEY_CAMERA },
-	.direct_key_num = 1,
+	.direct_key_map		= { KEY_CAMERA },
+	.direct_key_num		= 1,

-	.debounce_interval = 30,
+	.debounce_interval	= 30,
 };
 #endif /* CONFIG_MACH_EZX_A780 */

 #ifdef CONFIG_MACH_EZX_E680
-static unsigned int e680_key_map[] = {
-	KEY(0, 0, KEY_UP),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_RESERVED),
-	KEY(0, 3, KEY_SEND),
+static const unsigned int e680_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_UP),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_RESERVED),
+	MATRIX_KEY(0, 3, KEY_SEND),

-	KEY(1, 0, KEY_DOWN),
-	KEY(1, 1, KEY_LEFT),
-	KEY(1, 2, KEY_PAGEUP),
-	KEY(1, 3, KEY_PAGEDOWN),
+	MATRIX_KEY(1, 0, KEY_DOWN),
+	MATRIX_KEY(1, 1, KEY_LEFT),
+	MATRIX_KEY(1, 2, KEY_PAGEUP),
+	MATRIX_KEY(1, 3, KEY_PAGEDOWN),

-	KEY(2, 0, KEY_RESERVED),
-	KEY(2, 1, KEY_RESERVED),
-	KEY(2, 2, KEY_RESERVED),
-	KEY(2, 3, KEY_KPENTER),
+	MATRIX_KEY(2, 0, KEY_RESERVED),
+	MATRIX_KEY(2, 1, KEY_RESERVED),
+	MATRIX_KEY(2, 2, KEY_RESERVED),
+	MATRIX_KEY(2, 3, KEY_KPENTER),
 };

 static struct pxa27x_keypad_platform_data e680_keypad_platform_data = {
-	.matrix_key_rows = 3,
-	.matrix_key_cols = 4,
-	.matrix_key_map = e680_key_map,
-	.matrix_key_map_size = ARRAY_SIZE(e680_key_map),
+	.matrix_key_rows	= 3,
+	.matrix_key_cols	= 4,
+	.matrix_key_map		= e680_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(e680_key_map),

-	.direct_key_map = {
+	.direct_key_map		= {
 		KEY_CAMERA,
 		KEY_RESERVED,
 		KEY_RESERVED,
@@ -454,201 +456,205 @@ static struct pxa27x_keypad_platform_data
e680_keypad_platform_data = {
 		KEY_CANCEL,
 		KEY_F2,
 	},
-	.direct_key_num = 6,
+	.direct_key_num		= 6,

-	.debounce_interval = 30,
+	.debounce_interval	= 30,
 };
 #endif /* CONFIG_MACH_EZX_E680 */

 #ifdef CONFIG_MACH_EZX_A1200
-static unsigned int a1200_key_map[] = {
-	KEY(0, 0, KEY_RESERVED),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_PAGEDOWN),
-	KEY(0, 3, KEY_RESERVED),
-	KEY(0, 4, KEY_RESERVED),
-	KEY(0, 5, KEY_RESERVED),
-
-	KEY(1, 0, KEY_RESERVED),
-	KEY(1, 1, KEY_DOWN),
-	KEY(1, 2, KEY_CAMERA),
-	KEY(1, 3, KEY_RESERVED),
-	KEY(1, 4, KEY_RESERVED),
-	KEY(1, 5, KEY_RESERVED),
-
-	KEY(2, 0, KEY_RESERVED),
-	KEY(2, 1, KEY_KPENTER),
-	KEY(2, 2, KEY_RECORD),
-	KEY(2, 3, KEY_RESERVED),
-	KEY(2, 4, KEY_RESERVED),
-	KEY(2, 5, KEY_SELECT),
-
-	KEY(3, 0, KEY_RESERVED),
-	KEY(3, 1, KEY_UP),
-	KEY(3, 2, KEY_SEND),
-	KEY(3, 3, KEY_RESERVED),
-	KEY(3, 4, KEY_RESERVED),
-	KEY(3, 5, KEY_RESERVED),
-
-	KEY(4, 0, KEY_RESERVED),
-	KEY(4, 1, KEY_LEFT),
-	KEY(4, 2, KEY_PAGEUP),
-	KEY(4, 3, KEY_RESERVED),
-	KEY(4, 4, KEY_RESERVED),
-	KEY(4, 5, KEY_RESERVED),
+static const unsigned int a1200_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_RESERVED),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_PAGEDOWN),
+	MATRIX_KEY(0, 3, KEY_RESERVED),
+	MATRIX_KEY(0, 4, KEY_RESERVED),
+	MATRIX_KEY(0, 5, KEY_RESERVED),
+
+	MATRIX_KEY(1, 0, KEY_RESERVED),
+	MATRIX_KEY(1, 1, KEY_DOWN),
+	MATRIX_KEY(1, 2, KEY_CAMERA),
+	MATRIX_KEY(1, 3, KEY_RESERVED),
+	MATRIX_KEY(1, 4, KEY_RESERVED),
+	MATRIX_KEY(1, 5, KEY_RESERVED),
+
+	MATRIX_KEY(2, 0, KEY_RESERVED),
+	MATRIX_KEY(2, 1, KEY_KPENTER),
+	MATRIX_KEY(2, 2, KEY_RECORD),
+	MATRIX_KEY(2, 3, KEY_RESERVED),
+	MATRIX_KEY(2, 4, KEY_RESERVED),
+	MATRIX_KEY(2, 5, KEY_SELECT),
+
+	MATRIX_KEY(3, 0, KEY_RESERVED),
+	MATRIX_KEY(3, 1, KEY_UP),
+	MATRIX_KEY(3, 2, KEY_SEND),
+	MATRIX_KEY(3, 3, KEY_RESERVED),
+	MATRIX_KEY(3, 4, KEY_RESERVED),
+	MATRIX_KEY(3, 5, KEY_RESERVED),
+
+	MATRIX_KEY(4, 0, KEY_RESERVED),
+	MATRIX_KEY(4, 1, KEY_LEFT),
+	MATRIX_KEY(4, 2, KEY_PAGEUP),
+	MATRIX_KEY(4, 3, KEY_RESERVED),
+	MATRIX_KEY(4, 4, KEY_RESERVED),
+	MATRIX_KEY(4, 5, KEY_RESERVED),
 };

 static struct pxa27x_keypad_platform_data a1200_keypad_platform_data =
{
-	.matrix_key_rows = 5,
-	.matrix_key_cols = 6,
-	.matrix_key_map = a1200_key_map,
-	.matrix_key_map_size = ARRAY_SIZE(a1200_key_map),
+	.matrix_key_rows	= 5,
+	.matrix_key_cols	= 6,
+	.matrix_key_map		= a1200_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(a1200_key_map),

-	.debounce_interval = 30,
+	.debounce_interval	= 30,
 };
 #endif /* CONFIG_MACH_EZX_A1200 */

 #ifdef CONFIG_MACH_EZX_E6
-static unsigned int e6_key_map[] = {
-	KEY(0, 0, KEY_RESERVED),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_PAGEDOWN),
-	KEY(0, 3, KEY_RESERVED),
-	KEY(0, 4, KEY_RESERVED),
-	KEY(0, 5, KEY_NEXTSONG),
-
-	KEY(1, 0, KEY_RESERVED),
-	KEY(1, 1, KEY_DOWN),
-	KEY(1, 2, KEY_PROG1),
-	KEY(1, 3, KEY_RESERVED),
-	KEY(1, 4, KEY_RESERVED),
-	KEY(1, 5, KEY_RESERVED),
-
-	KEY(2, 0, KEY_RESERVED),
-	KEY(2, 1, KEY_ENTER),
-	KEY(2, 2, KEY_CAMERA),
-	KEY(2, 3, KEY_RESERVED),
-	KEY(2, 4, KEY_RESERVED),
-	KEY(2, 5, KEY_WWW),
-
-	KEY(3, 0, KEY_RESERVED),
-	KEY(3, 1, KEY_UP),
-	KEY(3, 2, KEY_SEND),
-	KEY(3, 3, KEY_RESERVED),
-	KEY(3, 4, KEY_RESERVED),
-	KEY(3, 5, KEY_PLAYPAUSE),
-
-	KEY(4, 0, KEY_RESERVED),
-	KEY(4, 1, KEY_LEFT),
-	KEY(4, 2, KEY_PAGEUP),
-	KEY(4, 3, KEY_RESERVED),
-	KEY(4, 4, KEY_RESERVED),
-	KEY(4, 5, KEY_PREVIOUSSONG),
+static const unsigned int e6_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_RESERVED),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_PAGEDOWN),
+	MATRIX_KEY(0, 3, KEY_RESERVED),
+	MATRIX_KEY(0, 4, KEY_RESERVED),
+	MATRIX_KEY(0, 5, KEY_NEXTSONG),
+
+	MATRIX_KEY(1, 0, KEY_RESERVED),
+	MATRIX_KEY(1, 1, KEY_DOWN),
+	MATRIX_KEY(1, 2, KEY_PROG1),
+	MATRIX_KEY(1, 3, KEY_RESERVED),
+	MATRIX_KEY(1, 4, KEY_RESERVED),
+	MATRIX_KEY(1, 5, KEY_RESERVED),
+
+	MATRIX_KEY(2, 0, KEY_RESERVED),
+	MATRIX_KEY(2, 1, KEY_ENTER),
+	MATRIX_KEY(2, 2, KEY_CAMERA),
+	MATRIX_KEY(2, 3, KEY_RESERVED),
+	MATRIX_KEY(2, 4, KEY_RESERVED),
+	MATRIX_KEY(2, 5, KEY_WWW),
+
+	MATRIX_KEY(3, 0, KEY_RESERVED),
+	MATRIX_KEY(3, 1, KEY_UP),
+	MATRIX_KEY(3, 2, KEY_SEND),
+	MATRIX_KEY(3, 3, KEY_RESERVED),
+	MATRIX_KEY(3, 4, KEY_RESERVED),
+	MATRIX_KEY(3, 5, KEY_PLAYPAUSE),
+
+	MATRIX_KEY(4, 0, KEY_RESERVED),
+	MATRIX_KEY(4, 1, KEY_LEFT),
+	MATRIX_KEY(4, 2, KEY_PAGEUP),
+	MATRIX_KEY(4, 3, KEY_RESERVED),
+	MATRIX_KEY(4, 4, KEY_RESERVED),
+	MATRIX_KEY(4, 5, KEY_PREVIOUSSONG),
 };

 static struct pxa27x_keypad_platform_data e6_keypad_platform_data = {
-	.matrix_key_rows = 5,
-	.matrix_key_cols = 6,
-	.matrix_key_map = e6_key_map,
-	.matrix_key_map_size = ARRAY_SIZE(e6_key_map),
+	.matrix_key_rows	= 5,
+	.matrix_key_cols	= 6,
+	.matrix_key_map		= e6_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(e6_key_map),

-	.debounce_interval = 30,
+	.debounce_interval	= 30,
 };
 #endif /* CONFIG_MACH_EZX_E6 */

 #ifdef CONFIG_MACH_EZX_A910
-static unsigned int a910_key_map[] = {
-	KEY(0, 0, KEY_NUMERIC_6),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_PAGEDOWN),
-	KEY(0, 3, KEY_KPENTER),
-	KEY(0, 4, KEY_NUMERIC_5),
-	KEY(0, 5, KEY_CAMERA),
-
-	KEY(1, 0, KEY_NUMERIC_8),
-	KEY(1, 1, KEY_DOWN),
-	KEY(1, 2, KEY_RESERVED),
-	KEY(1, 3, KEY_F1), /* Left SoftKey */
-	KEY(1, 4, KEY_NUMERIC_STAR),
-	KEY(1, 5, KEY_RESERVED),
-
-	KEY(2, 0, KEY_NUMERIC_7),
-	KEY(2, 1, KEY_NUMERIC_9),
-	KEY(2, 2, KEY_RECORD),
-	KEY(2, 3, KEY_F2), /* Right SoftKey */
-	KEY(2, 4, KEY_BACK),
-	KEY(2, 5, KEY_SELECT),
-
-	KEY(3, 0, KEY_NUMERIC_2),
-	KEY(3, 1, KEY_UP),
-	KEY(3, 2, KEY_SEND),
-	KEY(3, 3, KEY_NUMERIC_0),
-	KEY(3, 4, KEY_NUMERIC_1),
-	KEY(3, 5, KEY_RECORD),
-
-	KEY(4, 0, KEY_NUMERIC_4),
-	KEY(4, 1, KEY_LEFT),
-	KEY(4, 2, KEY_PAGEUP),
-	KEY(4, 3, KEY_NUMERIC_POUND),
-	KEY(4, 4, KEY_NUMERIC_3),
-	KEY(4, 5, KEY_RESERVED),
+static const unsigned int a910_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_NUMERIC_6),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_PAGEDOWN),
+	MATRIX_KEY(0, 3, KEY_KPENTER),
+	MATRIX_KEY(0, 4, KEY_NUMERIC_5),
+	MATRIX_KEY(0, 5, KEY_CAMERA),
+
+	MATRIX_KEY(1, 0, KEY_NUMERIC_8),
+	MATRIX_KEY(1, 1, KEY_DOWN),
+	MATRIX_KEY(1, 2, KEY_RESERVED),
+	MATRIX_KEY(1, 3, KEY_F1), /* Left SoftKey */
+	MATRIX_KEY(1, 4, KEY_NUMERIC_STAR),
+	MATRIX_KEY(1, 5, KEY_RESERVED),
+
+	MATRIX_KEY(2, 0, KEY_NUMERIC_7),
+	MATRIX_KEY(2, 1, KEY_NUMERIC_9),
+	MATRIX_KEY(2, 2, KEY_RECORD),
+	MATRIX_KEY(2, 3, KEY_F2), /* Right SoftKey */
+	MATRIX_KEY(2, 4, KEY_BACK),
+	MATRIX_KEY(2, 5, KEY_SELECT),
+
+	MATRIX_KEY(3, 0, KEY_NUMERIC_2),
+	MATRIX_KEY(3, 1, KEY_UP),
+	MATRIX_KEY(3, 2, KEY_SEND),
+	MATRIX_KEY(3, 3, KEY_NUMERIC_0),
+	MATRIX_KEY(3, 4, KEY_NUMERIC_1),
+	MATRIX_KEY(3, 5, KEY_RECORD),
+
+	MATRIX_KEY(4, 0, KEY_NUMERIC_4),
+	MATRIX_KEY(4, 1, KEY_LEFT),
+	MATRIX_KEY(4, 2, KEY_PAGEUP),
+	MATRIX_KEY(4, 3, KEY_NUMERIC_POUND),
+	MATRIX_KEY(4, 4, KEY_NUMERIC_3),
+	MATRIX_KEY(4, 5, KEY_RESERVED),
 };

 static struct pxa27x_keypad_platform_data a910_keypad_platform_data = {
-	.matrix_key_rows = 5,
-	.matrix_key_cols = 6,
-	.matrix_key_map = a910_key_map,
-	.matrix_key_map_size = ARRAY_SIZE(a910_key_map),
+	.matrix_key_rows	= 5,
+	.matrix_key_cols	= 6,
+	.matrix_key_map		= a910_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(a910_key_map),

-	.debounce_interval = 30,
+	.debounce_interval	= 30,
 };
 #endif /* CONFIG_MACH_EZX_A910 */

 #ifdef CONFIG_MACH_EZX_E2
-static unsigned int e2_key_map[] = {
-	KEY(0, 0, KEY_NUMERIC_6),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_NUMERIC_9),
-	KEY(0, 3, KEY_NEXTSONG),
-	KEY(0, 4, KEY_NUMERIC_5),
-	KEY(0, 5, KEY_F1), /* Left SoftKey */
-
-	KEY(1, 0, KEY_NUMERIC_8),
-	KEY(1, 1, KEY_DOWN),
-	KEY(1, 2, KEY_RESERVED),
-	KEY(1, 3, KEY_PAGEUP),
-	KEY(1, 4, KEY_NUMERIC_STAR),
-	KEY(1, 5, KEY_F2), /* Right SoftKey */
-
-	KEY(2, 0, KEY_NUMERIC_7),
-	KEY(2, 1, KEY_KPENTER),
-	KEY(2, 2, KEY_RECORD),
-	KEY(2, 3, KEY_PAGEDOWN),
-	KEY(2, 4, KEY_BACK),
-	KEY(2, 5, KEY_NUMERIC_0),
-
-	KEY(3, 0, KEY_NUMERIC_2),
-	KEY(3, 1, KEY_UP),
-	KEY(3, 2, KEY_SEND),
-	KEY(3, 3, KEY_PLAYPAUSE),
-	KEY(3, 4, KEY_NUMERIC_1),
-	KEY(3, 5, KEY_SOUND), /* Music SoftKey */
-
-	KEY(4, 0, KEY_NUMERIC_4),
-	KEY(4, 1, KEY_LEFT),
-	KEY(4, 2, KEY_NUMERIC_POUND),
-	KEY(4, 3, KEY_PREVIOUSSONG),
-	KEY(4, 4, KEY_NUMERIC_3),
-	KEY(4, 5, KEY_RESERVED),
+static const unsigned int e2_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_NUMERIC_6),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_NUMERIC_9),
+	MATRIX_KEY(0, 3, KEY_NEXTSONG),
+	MATRIX_KEY(0, 4, KEY_NUMERIC_5),
+	MATRIX_KEY(0, 5, KEY_F1),		/* Left SoftKey */
+
+	MATRIX_KEY(1, 0, KEY_NUMERIC_8),
+	MATRIX_KEY(1, 1, KEY_DOWN),
+	MATRIX_KEY(1, 2, KEY_RESERVED),
+	MATRIX_KEY(1, 3, KEY_PAGEUP),
+	MATRIX_KEY(1, 4, KEY_NUMERIC_STAR),
+	MATRIX_KEY(1, 5, KEY_F2),		/* Right SoftKey */
+
+	MATRIX_KEY(2, 0, KEY_NUMERIC_7),
+	MATRIX_KEY(2, 1, KEY_KPENTER),
+	MATRIX_KEY(2, 2, KEY_RECORD),
+	MATRIX_KEY(2, 3, KEY_PAGEDOWN),
+	MATRIX_KEY(2, 4, KEY_BACK),
+	MATRIX_KEY(2, 5, KEY_NUMERIC_0),
+
+	MATRIX_KEY(3, 0, KEY_NUMERIC_2),
+	MATRIX_KEY(3, 1, KEY_UP),
+	MATRIX_KEY(3, 2, KEY_SEND),
+	MATRIX_KEY(3, 3, KEY_PLAYPAUSE),
+	MATRIX_KEY(3, 4, KEY_NUMERIC_1),
+	MATRIX_KEY(3, 5, KEY_SOUND),		/* Music SoftKey */
+
+	MATRIX_KEY(4, 0, KEY_NUMERIC_4),
+	MATRIX_KEY(4, 1, KEY_LEFT),
+	MATRIX_KEY(4, 2, KEY_NUMERIC_POUND),
+	MATRIX_KEY(4, 3, KEY_PREVIOUSSONG),
+	MATRIX_KEY(4, 4, KEY_NUMERIC_3),
+	MATRIX_KEY(4, 5, KEY_RESERVED),
 };

 static struct pxa27x_keypad_platform_data e2_keypad_platform_data = {
-	.matrix_key_rows = 5,
-	.matrix_key_cols = 6,
-	.matrix_key_map = e2_key_map,
-	.matrix_key_map_size = ARRAY_SIZE(e2_key_map),
+	.matrix_key_rows	= 5,
+	.matrix_key_cols	= 6,
+	.matrix_key_map		= e2_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(e2_key_map),

-	.debounce_interval = 30,
+	.debounce_interval	= 30,
 };
 #endif /* CONFIG_MACH_EZX_E2 */
diff --git a/arch/arm/mach-pxa/littleton.c
b/arch/arm/mach-pxa/littleton.c
index 31da7f3..b5cbddc 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -221,31 +221,38 @@ static inline void littleton_init_spi(void) {}
 #endif

 #if defined(CONFIG_KEYBOARD_PXA27x) ||
defined(CONFIG_KEYBOARD_PXA27x_MODULE)
-static unsigned int littleton_matrix_key_map[] = {
-	/* KEY(row, col, key_code) */
-	KEY(1, 3, KEY_0), KEY(0, 0, KEY_1), KEY(1, 0, KEY_2), KEY(2, 0,
KEY_3),
-	KEY(0, 1, KEY_4), KEY(1, 1, KEY_5), KEY(2, 1, KEY_6), KEY(0, 2,
KEY_7),
-	KEY(1, 2, KEY_8), KEY(2, 2, KEY_9),
-
-	KEY(0, 3, KEY_KPASTERISK), 	/* * */
-	KEY(2, 3, KEY_KPDOT), 		/* # */
-
-	KEY(5, 4, KEY_ENTER),
-
-	KEY(5, 0, KEY_UP),
-	KEY(5, 1, KEY_DOWN),
-	KEY(5, 2, KEY_LEFT),
-	KEY(5, 3, KEY_RIGHT),
-	KEY(3, 2, KEY_HOME),
-	KEY(4, 1, KEY_END),
-	KEY(3, 3, KEY_BACK),
-
-	KEY(4, 0, KEY_SEND),
-	KEY(4, 2, KEY_VOLUMEUP),
-	KEY(4, 3, KEY_VOLUMEDOWN),
-
-	KEY(3, 0, KEY_F22),	/* soft1 */
-	KEY(3, 1, KEY_F23),	/* soft2 */
+static const unsigned int littleton_matrix_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(1, 3, KEY_0),
+	MATRIX_KEY(0, 0, KEY_1),
+	MATRIX_KEY(1, 0, KEY_2),
+	MATRIX_KEY(2, 0, KEY_3),
+	MATRIX_KEY(0, 1, KEY_4),
+	MATRIX_KEY(1, 1, KEY_5),
+	MATRIX_KEY(2, 1, KEY_6),
+	MATRIX_KEY(0, 2, KEY_7),
+	MATRIX_KEY(1, 2, KEY_8),
+	MATRIX_KEY(2, 2, KEY_9),
+
+	MATRIX_KEY(0, 3, KEY_KPASTERISK), 	/* * */
+	MATRIX_KEY(2, 3, KEY_KPDOT), 		/* # */
+
+	MATRIX_KEY(5, 4, KEY_ENTER),
+
+	MATRIX_KEY(5, 0, KEY_UP),
+	MATRIX_KEY(5, 1, KEY_DOWN),
+	MATRIX_KEY(5, 2, KEY_LEFT),
+	MATRIX_KEY(5, 3, KEY_RIGHT),
+	MATRIX_KEY(3, 2, KEY_HOME),
+	MATRIX_KEY(4, 1, KEY_END),
+	MATRIX_KEY(3, 3, KEY_BACK),
+
+	MATRIX_KEY(4, 0, KEY_SEND),
+	MATRIX_KEY(4, 2, KEY_VOLUMEUP),
+	MATRIX_KEY(4, 3, KEY_VOLUMEDOWN),
+
+	MATRIX_KEY(3, 0, KEY_F22),		/* soft1 */
+	MATRIX_KEY(3, 1, KEY_F23),		/* soft2 */
 };

 static struct pxa27x_keypad_platform_data littleton_keypad_info = {
diff --git a/arch/arm/mach-pxa/mainstone.c
b/arch/arm/mach-pxa/mainstone.c
index 5f22496..5591904 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -517,33 +517,51 @@ static struct pxaohci_platform_data
mainstone_ohci_platform_data = {
 };

 #if defined(CONFIG_KEYBOARD_PXA27x) ||
defined(CONFIG_KEYBOARD_PXA27x_MODULE)
-static unsigned int mainstone_matrix_keys[] = {
-	KEY(0, 0, KEY_A), KEY(1, 0, KEY_B), KEY(2, 0, KEY_C),
-	KEY(3, 0, KEY_D), KEY(4, 0, KEY_E), KEY(5, 0, KEY_F),
-	KEY(0, 1, KEY_G), KEY(1, 1, KEY_H), KEY(2, 1, KEY_I),
-	KEY(3, 1, KEY_J), KEY(4, 1, KEY_K), KEY(5, 1, KEY_L),
-	KEY(0, 2, KEY_M), KEY(1, 2, KEY_N), KEY(2, 2, KEY_O),
-	KEY(3, 2, KEY_P), KEY(4, 2, KEY_Q), KEY(5, 2, KEY_R),
-	KEY(0, 3, KEY_S), KEY(1, 3, KEY_T), KEY(2, 3, KEY_U),
-	KEY(3, 3, KEY_V), KEY(4, 3, KEY_W), KEY(5, 3, KEY_X),
-	KEY(2, 4, KEY_Y), KEY(3, 4, KEY_Z),
-
-	KEY(0, 4, KEY_DOT),	/* . */
-	KEY(1, 4, KEY_CLOSE),	/* @ */
-	KEY(4, 4, KEY_SLASH),
-	KEY(5, 4, KEY_BACKSLASH),
-	KEY(0, 5, KEY_HOME),
-	KEY(1, 5, KEY_LEFTSHIFT),
-	KEY(2, 5, KEY_SPACE),
-	KEY(3, 5, KEY_SPACE),
-	KEY(4, 5, KEY_ENTER),
-	KEY(5, 5, KEY_BACKSPACE),
-
-	KEY(0, 6, KEY_UP),
-	KEY(1, 6, KEY_DOWN),
-	KEY(2, 6, KEY_LEFT),
-	KEY(3, 6, KEY_RIGHT),
-	KEY(4, 6, KEY_SELECT),
+static const unsigned int mainstone_matrix_keys[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_A),
+	MATRIX_KEY(1, 0, KEY_B),
+	MATRIX_KEY(2, 0, KEY_C),
+	MATRIX_KEY(3, 0, KEY_D),
+	MATRIX_KEY(4, 0, KEY_E),
+	MATRIX_KEY(5, 0, KEY_F),
+	MATRIX_KEY(0, 1, KEY_G),
+	MATRIX_KEY(1, 1, KEY_H),
+	MATRIX_KEY(2, 1, KEY_I),
+	MATRIX_KEY(3, 1, KEY_J),
+	MATRIX_KEY(4, 1, KEY_K),
+	MATRIX_KEY(5, 1, KEY_L),
+	MATRIX_KEY(0, 2, KEY_M),
+	MATRIX_KEY(1, 2, KEY_N),
+	MATRIX_KEY(2, 2, KEY_O),
+	MATRIX_KEY(3, 2, KEY_P),
+	MATRIX_KEY(4, 2, KEY_Q),
+	MATRIX_KEY(5, 2, KEY_R),
+	MATRIX_KEY(0, 3, KEY_S),
+	MATRIX_KEY(1, 3, KEY_T),
+	MATRIX_KEY(2, 3, KEY_U),
+	MATRIX_KEY(3, 3, KEY_V),
+	MATRIX_KEY(4, 3, KEY_W),
+	MATRIX_KEY(5, 3, KEY_X),
+	MATRIX_KEY(2, 4, KEY_Y),
+	MATRIX_KEY(3, 4, KEY_Z),
+
+	MATRIX_KEY(0, 4, KEY_DOT),		/* . */
+	MATRIX_KEY(1, 4, KEY_CLOSE),		/* @ */
+	MATRIX_KEY(4, 4, KEY_SLASH),
+	MATRIX_KEY(5, 4, KEY_BACKSLASH),
+	MATRIX_KEY(0, 5, KEY_HOME),
+	MATRIX_KEY(1, 5, KEY_LEFTSHIFT),
+	MATRIX_KEY(2, 5, KEY_SPACE),
+	MATRIX_KEY(3, 5, KEY_SPACE),
+	MATRIX_KEY(4, 5, KEY_ENTER),
+	MATRIX_KEY(5, 5, KEY_BACKSPACE),
+
+	MATRIX_KEY(0, 6, KEY_UP),
+	MATRIX_KEY(1, 6, KEY_DOWN),
+	MATRIX_KEY(2, 6, KEY_LEFT),
+	MATRIX_KEY(3, 6, KEY_RIGHT),
+	MATRIX_KEY(4, 6, KEY_SELECT),
 };

 struct pxa27x_keypad_platform_data mainstone_keypad_info = {
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 2b427e0..9ca7285 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -273,22 +273,24 @@ static struct pxafb_mach_info mioa701_pxafb_info =
{
 /*
  * Keyboard configuration
  */
-static unsigned int mioa701_matrix_keys[] = {
-	KEY(0, 0, KEY_UP),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_MEDIA),
-	KEY(1, 0, KEY_DOWN),
-	KEY(1, 1, KEY_ENTER),
-	KEY(1, 2, KEY_CONNECT),	/* GPS key */
-	KEY(2, 0, KEY_LEFT),
-	KEY(2, 1, KEY_PHONE),	/* Phone Green key */
-	KEY(2, 2, KEY_CAMERA)	/* Camera key */
+static const unsigned int mioa701_matrix_keys[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_UP),
+	MATRIX_KEY(0, 1, KEY_RIGHT),
+	MATRIX_KEY(0, 2, KEY_MEDIA),
+	MATRIX_KEY(1, 0, KEY_DOWN),
+	MATRIX_KEY(1, 1, KEY_ENTER),
+	MATRIX_KEY(1, 2, KEY_CONNECT),		/* GPS key */
+	MATRIX_KEY(2, 0, KEY_LEFT),
+	MATRIX_KEY(2, 1, KEY_PHONE),		/* Phone Green key */
+	MATRIX_KEY(2, 2, KEY_CAMERA),		/* Camera key */
 };
+
 static struct pxa27x_keypad_platform_data mioa701_keypad_info = {
-	.matrix_key_rows = 3,
-	.matrix_key_cols = 3,
-	.matrix_key_map = mioa701_matrix_keys,
-	.matrix_key_map_size = ARRAY_SIZE(mioa701_matrix_keys),
+	.matrix_key_rows	= 3,
+	.matrix_key_cols	= 3,
+	.matrix_key_map		= mioa701_matrix_keys,
+	.matrix_key_map_size	= ARRAY_SIZE(mioa701_matrix_keys),
 };

 /*
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index a9d94f5..e8fc53c 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -215,20 +215,21 @@ static struct pxamci_platform_data
palmtx_mci_platform_data = {
 
/***********************************************************************
*******
  * GPIO keyboard
 
************************************************************************
******/
-static unsigned int palmtx_matrix_keys[] = {
-	KEY(0, 0, KEY_POWER),
-	KEY(0, 1, KEY_F1),
-	KEY(0, 2, KEY_ENTER),
+static const unsigned int palmtx_matrix_keys[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_POWER),
+	MATRIX_KEY(0, 1, KEY_F1),
+	MATRIX_KEY(0, 2, KEY_ENTER),

-	KEY(1, 0, KEY_F2),
-	KEY(1, 1, KEY_F3),
-	KEY(1, 2, KEY_F4),
+	MATRIX_KEY(1, 0, KEY_F2),
+	MATRIX_KEY(1, 1, KEY_F3),
+	MATRIX_KEY(1, 2, KEY_F4),

-	KEY(2, 0, KEY_UP),
-	KEY(2, 2, KEY_DOWN),
+	MATRIX_KEY(2, 0, KEY_UP),
+	MATRIX_KEY(2, 2, KEY_DOWN),

-	KEY(3, 0, KEY_RIGHT),
-	KEY(3, 2, KEY_LEFT),
+	MATRIX_KEY(3, 0, KEY_RIGHT),
+	MATRIX_KEY(3, 2, KEY_LEFT),
 };

 static struct pxa27x_keypad_platform_data palmtx_keypad_platform_data =
{
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 2f730da..8fb0ed3 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -213,20 +213,21 @@ static struct pxamci_platform_data
palmz72_mci_platform_data = {
 
/***********************************************************************
*******
  * GPIO keyboard
 
************************************************************************
******/
-static unsigned int palmz72_matrix_keys[] = {
-	KEY(0, 0, KEY_POWER),
-	KEY(0, 1, KEY_F1),
-	KEY(0, 2, KEY_ENTER),
+static const unsigned int palmz72_matrix_keys[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_POWER),
+	MATRIX_KEY(0, 1, KEY_F1),
+	MATRIX_KEY(0, 2, KEY_ENTER),

-	KEY(1, 0, KEY_F2),
-	KEY(1, 1, KEY_F3),
-	KEY(1, 2, KEY_F4),
+	MATRIX_KEY(1, 0, KEY_F2),
+	MATRIX_KEY(1, 1, KEY_F3),
+	MATRIX_KEY(1, 2, KEY_F4),

-	KEY(2, 0, KEY_UP),
-	KEY(2, 2, KEY_DOWN),
+	MATRIX_KEY(2, 0, KEY_UP),
+	MATRIX_KEY(2, 2, KEY_DOWN),

-	KEY(3, 0, KEY_RIGHT),
-	KEY(3, 2, KEY_LEFT),
+	MATRIX_KEY(3, 0, KEY_RIGHT),
+	MATRIX_KEY(3, 2, KEY_LEFT),
 };

 static struct pxa27x_keypad_platform_data palmz72_keypad_platform_data
= {
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 58ef08a..f31f936 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -107,45 +107,64 @@ static struct platform_device smc91x_device = {
 };

 #if defined(CONFIG_KEYBOARD_PXA27x) ||
defined(CONFIG_KEYBOARD_PXA27x_MODULE)
-static unsigned int tavorevb_matrix_key_map[] = {
-	/* KEY(row, col, key_code) */
-	KEY(0, 4, KEY_A), KEY(0, 5, KEY_B), KEY(0, 6, KEY_C),
-	KEY(1, 4, KEY_E), KEY(1, 5, KEY_F), KEY(1, 6, KEY_G),
-	KEY(2, 4, KEY_I), KEY(2, 5, KEY_J), KEY(2, 6, KEY_K),
-	KEY(3, 4, KEY_M), KEY(3, 5, KEY_N), KEY(3, 6, KEY_O),
-	KEY(4, 5, KEY_R), KEY(4, 6, KEY_S),
-	KEY(5, 4, KEY_U), KEY(5, 4, KEY_V), KEY(5, 6, KEY_W),
-
-	KEY(6, 4, KEY_Y), KEY(6, 5, KEY_Z),
-
-	KEY(0, 3, KEY_0), KEY(2, 0, KEY_1), KEY(2, 1, KEY_2), KEY(2, 2,
KEY_3),
-	KEY(2, 3, KEY_4), KEY(1, 0, KEY_5), KEY(1, 1, KEY_6), KEY(1, 2,
KEY_7),
-	KEY(1, 3, KEY_8), KEY(0, 2, KEY_9),
-
-	KEY(6, 6, KEY_SPACE),
-	KEY(0, 0, KEY_KPASTERISK), 	/* * */
-	KEY(0, 1, KEY_KPDOT), 		/* # */
-
-	KEY(4, 1, KEY_UP),
-	KEY(4, 3, KEY_DOWN),
-	KEY(4, 0, KEY_LEFT),
-	KEY(4, 2, KEY_RIGHT),
-	KEY(6, 0, KEY_HOME),
-	KEY(3, 2, KEY_END),
-	KEY(6, 1, KEY_DELETE),
-	KEY(5, 2, KEY_BACK),
-	KEY(6, 3, KEY_CAPSLOCK),	/* KEY_LEFTSHIFT), */
-
-	KEY(4, 4, KEY_ENTER),		/* scroll push */
-	KEY(6, 2, KEY_ENTER),		/* keypad action */
-
-	KEY(3, 1, KEY_SEND),
-	KEY(5, 3, KEY_RECORD),
-	KEY(5, 0, KEY_VOLUMEUP),
-	KEY(5, 1, KEY_VOLUMEDOWN),
-
-	KEY(3, 0, KEY_F22),	/* soft1 */
-	KEY(3, 3, KEY_F23),	/* soft2 */
+static const unsigned int tavorevb_matrix_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 4, KEY_A),
+	MATRIX_KEY(0, 5, KEY_B),
+	MATRIX_KEY(0, 6, KEY_C),
+	MATRIX_KEY(1, 4, KEY_E),
+	MATRIX_KEY(1, 5, KEY_F),
+	MATRIX_KEY(1, 6, KEY_G),
+	MATRIX_KEY(2, 4, KEY_I),
+	MATRIX_KEY(2, 5, KEY_J),
+	MATRIX_KEY(2, 6, KEY_K),
+	MATRIX_KEY(3, 4, KEY_M),
+	MATRIX_KEY(3, 5, KEY_N),
+	MATRIX_KEY(3, 6, KEY_O),
+	MATRIX_KEY(4, 5, KEY_R),
+	MATRIX_KEY(4, 6, KEY_S),
+	MATRIX_KEY(5, 4, KEY_U),
+	MATRIX_KEY(5, 4, KEY_V),
+	MATRIX_KEY(5, 6, KEY_W),
+
+	MATRIX_KEY(6, 4, KEY_Y),
+	MATRIX_KEY(6, 5, KEY_Z),
+
+	MATRIX_KEY(0, 3, KEY_0),
+	MATRIX_KEY(2, 0, KEY_1),
+	MATRIX_KEY(2, 1, KEY_2),
+	MATRIX_KEY(2, 2, KEY_3),
+	MATRIX_KEY(2, 3, KEY_4),
+	MATRIX_KEY(1, 0, KEY_5),
+	MATRIX_KEY(1, 1, KEY_6),
+	MATRIX_KEY(1, 2, KEY_7),
+	MATRIX_KEY(1, 3, KEY_8),
+	MATRIX_KEY(0, 2, KEY_9),
+
+	MATRIX_KEY(6, 6, KEY_SPACE),
+	MATRIX_KEY(0, 0, KEY_KPASTERISK), 	/* * */
+	MATRIX_KEY(0, 1, KEY_KPDOT), 		/* # */
+
+	MATRIX_KEY(4, 1, KEY_UP),
+	MATRIX_KEY(4, 3, KEY_DOWN),
+	MATRIX_KEY(4, 0, KEY_LEFT),
+	MATRIX_KEY(4, 2, KEY_RIGHT),
+	MATRIX_KEY(6, 0, KEY_HOME),
+	MATRIX_KEY(3, 2, KEY_END),
+	MATRIX_KEY(6, 1, KEY_DELETE),
+	MATRIX_KEY(5, 2, KEY_BACK),
+	MATRIX_KEY(6, 3, KEY_CAPSLOCK),		/* KEY_LEFTSHIFT), */
+
+	MATRIX_KEY(4, 4, KEY_ENTER),		/* scroll push */
+	MATRIX_KEY(6, 2, KEY_ENTER),		/* keypad action */
+
+	MATRIX_KEY(3, 1, KEY_SEND),
+	MATRIX_KEY(5, 3, KEY_RECORD),
+	MATRIX_KEY(5, 0, KEY_VOLUMEUP),
+	MATRIX_KEY(5, 1, KEY_VOLUMEDOWN),
+
+	MATRIX_KEY(3, 0, KEY_F22),		/* soft1 */
+	MATRIX_KEY(3, 3, KEY_F23),		/* soft2 */
 };

 static struct pxa27x_keypad_platform_data tavorevb_keypad_info = {
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 218d200..5866928 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -309,47 +309,73 @@ static inline void zylonite_init_mmc(void) {}
 #endif

 #if defined(CONFIG_KEYBOARD_PXA27x) ||
defined(CONFIG_KEYBOARD_PXA27x_MODULE)
-static unsigned int zylonite_matrix_key_map[] = {
-	/* KEY(row, col, key_code) */
-	KEY(0, 0, KEY_A), KEY(0, 1, KEY_B), KEY(0, 2, KEY_C), KEY(0, 5,
KEY_D),
-	KEY(1, 0, KEY_E), KEY(1, 1, KEY_F), KEY(1, 2, KEY_G), KEY(1, 5,
KEY_H),
-	KEY(2, 0, KEY_I), KEY(2, 1, KEY_J), KEY(2, 2, KEY_K), KEY(2, 5,
KEY_L),
-	KEY(3, 0, KEY_M), KEY(3, 1, KEY_N), KEY(3, 2, KEY_O), KEY(3, 5,
KEY_P),
-	KEY(5, 0, KEY_Q), KEY(5, 1, KEY_R), KEY(5, 2, KEY_S), KEY(5, 5,
KEY_T),
-	KEY(6, 0, KEY_U), KEY(6, 1, KEY_V), KEY(6, 2, KEY_W), KEY(6, 5,
KEY_X),
-	KEY(7, 1, KEY_Y), KEY(7, 2, KEY_Z),
-
-	KEY(4, 4, KEY_0), KEY(1, 3, KEY_1), KEY(4, 1, KEY_2), KEY(1, 4,
KEY_3),
-	KEY(2, 3, KEY_4), KEY(4, 2, KEY_5), KEY(2, 4, KEY_6), KEY(3, 3,
KEY_7),
-	KEY(4, 3, KEY_8), KEY(3, 4, KEY_9),
-
-	KEY(4, 5, KEY_SPACE),
-	KEY(5, 3, KEY_KPASTERISK), 	/* * */
-	KEY(5, 4, KEY_KPDOT), 		/* #" */
-
-	KEY(0, 7, KEY_UP),
-	KEY(1, 7, KEY_DOWN),
-	KEY(2, 7, KEY_LEFT),
-	KEY(3, 7, KEY_RIGHT),
-	KEY(2, 6, KEY_HOME),
-	KEY(3, 6, KEY_END),
-	KEY(6, 4, KEY_DELETE),
-	KEY(6, 6, KEY_BACK),
-	KEY(6, 3, KEY_CAPSLOCK),	/* KEY_LEFTSHIFT), */
-
-	KEY(4, 6, KEY_ENTER),		/* scroll push */
-	KEY(5, 7, KEY_ENTER),		/* keypad action */
-
-	KEY(0, 4, KEY_EMAIL),
-	KEY(5, 6, KEY_SEND),
-	KEY(4, 0, KEY_CALENDAR),
-	KEY(7, 6, KEY_RECORD),
-	KEY(6, 7, KEY_VOLUMEUP),
-	KEY(7, 7, KEY_VOLUMEDOWN),
-
-	KEY(0, 6, KEY_F22),	/* soft1 */
-	KEY(1, 6, KEY_F23),	/* soft2 */
-	KEY(0, 3, KEY_AUX),	/* contact */
+static const unsigned int zylonite_matrix_key_map[] = {
+	/* MATRIX_KEY(row, col, code) */
+	MATRIX_KEY(0, 0, KEY_A),
+	MATRIX_KEY(0, 1, KEY_B),
+	MATRIX_KEY(0, 2, KEY_C),
+	MATRIX_KEY(0, 5, KEY_D),
+	MATRIX_KEY(1, 0, KEY_E),
+	MATRIX_KEY(1, 1, KEY_F),
+	MATRIX_KEY(1, 2, KEY_G),
+	MATRIX_KEY(1, 5, KEY_H),
+	MATRIX_KEY(2, 0, KEY_I),
+	MATRIX_KEY(2, 1, KEY_J),
+	MATRIX_KEY(2, 2, KEY_K),
+	MATRIX_KEY(2, 5, KEY_L),
+	MATRIX_KEY(3, 0, KEY_M),
+	MATRIX_KEY(3, 1, KEY_N),
+	MATRIX_KEY(3, 2, KEY_O),
+	MATRIX_KEY(3, 5, KEY_P),
+	MATRIX_KEY(5, 0, KEY_Q),
+	MATRIX_KEY(5, 1, KEY_R),
+	MATRIX_KEY(5, 2, KEY_S),
+	MATRIX_KEY(5, 5, KEY_T),
+	MATRIX_KEY(6, 0, KEY_U),
+	MATRIX_KEY(6, 1, KEY_V),
+	MATRIX_KEY(6, 2, KEY_W),
+	MATRIX_KEY(6, 5, KEY_X),
+	MATRIX_KEY(7, 1, KEY_Y),
+	MATRIX_KEY(7, 2, KEY_Z),
+
+	MATRIX_KEY(4, 4, KEY_0),
+	MATRIX_KEY(1, 3, KEY_1),
+	MATRIX_KEY(4, 1, KEY_2),
+	MATRIX_KEY(1, 4, KEY_3),
+	MATRIX_KEY(2, 3, KEY_4),
+	MATRIX_KEY(4, 2, KEY_5),
+	MATRIX_KEY(2, 4, KEY_6),
+	MATRIX_KEY(3, 3, KEY_7),
+	MATRIX_KEY(4, 3, KEY_8),
+	MATRIX_KEY(3, 4, KEY_9),
+
+	MATRIX_KEY(4, 5, KEY_SPACE),
+	MATRIX_KEY(5, 3, KEY_KPASTERISK), 	/* * */
+	MATRIX_KEY(5, 4, KEY_KPDOT), 		/* #" */
+
+	MATRIX_KEY(0, 7, KEY_UP),
+	MATRIX_KEY(1, 7, KEY_DOWN),
+	MATRIX_KEY(2, 7, KEY_LEFT),
+	MATRIX_KEY(3, 7, KEY_RIGHT),
+	MATRIX_KEY(2, 6, KEY_HOME),
+	MATRIX_KEY(3, 6, KEY_END),
+	MATRIX_KEY(6, 4, KEY_DELETE),
+	MATRIX_KEY(6, 6, KEY_BACK),
+	MATRIX_KEY(6, 3, KEY_CAPSLOCK),		/* KEY_LEFTSHIFT), */
+
+	MATRIX_KEY(4, 6, KEY_ENTER),		/* scroll push */
+	MATRIX_KEY(5, 7, KEY_ENTER),		/* keypad action */
+
+	MATRIX_KEY(0, 4, KEY_EMAIL),
+	MATRIX_KEY(5, 6, KEY_SEND),
+	MATRIX_KEY(4, 0, KEY_CALENDAR),
+	MATRIX_KEY(7, 6, KEY_RECORD),
+	MATRIX_KEY(6, 7, KEY_VOLUMEUP),
+	MATRIX_KEY(7, 7, KEY_VOLUMEDOWN),
+
+	MATRIX_KEY(0, 6, KEY_F22),		/* soft1 */
+	MATRIX_KEY(1, 6, KEY_F23),		/* soft2 */
+	MATRIX_KEY(0, 3, KEY_AUX),		/* contact */
 };

 static struct pxa27x_keypad_platform_data zylonite_keypad_info = {
 
