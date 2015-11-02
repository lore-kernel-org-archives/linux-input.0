From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 1/2] HID: hid-logitech: Simplify wheel detection scheme
Date: Mon,  2 Nov 2015 07:56:51 -0700
Message-ID: <1446476212-2289-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Simplfy how hid-logitech driver detects the native mode of the wheel,
done by looking at the USB-ID revision and comparing bit mask.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg4ff.c | 70 ++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 02cec83..b363d88 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -114,16 +114,12 @@ struct lg4ff_compat_mode_switch {
 };
 
 struct lg4ff_wheel_ident_info {
+	const u32 modes;
 	const u16 mask;
 	const u16 result;
 	const u16 real_product_id;
 };
 
-struct lg4ff_wheel_ident_checklist {
-	const u32 count;
-	const struct lg4ff_wheel_ident_info *models[];
-};
-
 struct lg4ff_multimode_wheel {
 	const u16 product_id;
 	const u32 alternate_modes;
@@ -174,36 +170,39 @@ static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] = {
 
 /* Multimode wheel identificators */
 static const struct lg4ff_wheel_ident_info lg4ff_dfp_ident_info = {
+	LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
 	0xf000,
 	0x1000,
 	USB_DEVICE_ID_LOGITECH_DFP_WHEEL
 };
 
 static const struct lg4ff_wheel_ident_info lg4ff_g25_ident_info = {
+	LG4FF_MODE_G25 | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
 	0xff00,
 	0x1200,
 	USB_DEVICE_ID_LOGITECH_G25_WHEEL
 };
 
 static const struct lg4ff_wheel_ident_info lg4ff_g27_ident_info = {
+	LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
 	0xfff0,
 	0x1230,
 	USB_DEVICE_ID_LOGITECH_G27_WHEEL
 };
 
 static const struct lg4ff_wheel_ident_info lg4ff_dfgt_ident_info = {
+	LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
 	0xff00,
 	0x1300,
 	USB_DEVICE_ID_LOGITECH_DFGT_WHEEL
 };
 
 /* Multimode wheel identification checklists */
-static const struct lg4ff_wheel_ident_checklist lg4ff_main_checklist = {
-	4,
-	{&lg4ff_dfgt_ident_info,
-	 &lg4ff_g27_ident_info,
-	 &lg4ff_g25_ident_info,
-	 &lg4ff_dfp_ident_info}
+static const struct lg4ff_wheel_ident_info *lg4ff_main_checklist[] = {
+	&lg4ff_dfgt_ident_info,
+	&lg4ff_g27_ident_info,
+	&lg4ff_g25_ident_info,
+	&lg4ff_dfp_ident_info
 };
 
 /* Compatibility mode switching commands */
@@ -1037,41 +1036,28 @@ static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cde
 
 static u16 lg4ff_identify_multimode_wheel(struct hid_device *hid, const u16 reported_product_id, const u16 bcdDevice)
 {
-	const struct lg4ff_wheel_ident_checklist *checklist;
-	int i, from_idx, to_idx;
+	u32 current_mode;
+	int i;
 
-	switch (reported_product_id) {
-	case USB_DEVICE_ID_LOGITECH_WHEEL:
-	case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
-		checklist = &lg4ff_main_checklist;
-		from_idx = 0;
-		to_idx = checklist->count - 1;
-		break;
-	case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
-		checklist = &lg4ff_main_checklist;
-		from_idx = 0;
-		to_idx = checklist->count - 2; /* End identity check at G25 */
-		break;
-	case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
-		checklist = &lg4ff_main_checklist;
-		from_idx = 1; /* Start identity check at G27 */
-		to_idx = checklist->count - 3; /* End identity check at G27 */
-		break;
-	case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
-		checklist = &lg4ff_main_checklist;
-		from_idx = 0;
-		to_idx = checklist->count - 4; /* End identity check at DFGT */
-		break;
-	default:
-		return 0;
+	/* identify current mode from USB PID */
+	for (i = 1; i < ARRAY_SIZE(lg4ff_alternate_modes); i++) {
+		dbg_hid("Testing whether PID is %X\n", lg4ff_alternate_modes[i].product_id);
+		if (reported_product_id == lg4ff_alternate_modes[i].product_id)
+			break;
 	}
 
-	for (i = from_idx; i <= to_idx; i++) {
-		const u16 mask = checklist->models[i]->mask;
-		const u16 result = checklist->models[i]->result;
-		const u16 real_product_id = checklist->models[i]->real_product_id;
+	if (i == ARRAY_SIZE(lg4ff_alternate_modes))
+		return 0;
+
+	current_mode = BIT(i);
+
+	for (i = 0; i < ARRAY_SIZE(lg4ff_main_checklist); i++) {
+		const u16 mask = lg4ff_main_checklist[i]->mask;
+		const u16 result = lg4ff_main_checklist[i]->result;
+		const u16 real_product_id = lg4ff_main_checklist[i]->real_product_id;
 
-		if ((bcdDevice & mask) == result) {
+		if ((current_mode & lg4ff_main_checklist[i]->modes) && \
+				(bcdDevice & mask) == result) {
 			dbg_hid("Found wheel with real PID %X whose reported PID is %X\n", real_product_id, reported_product_id);
 			return real_product_id;
 		}
-- 
2.1.4
