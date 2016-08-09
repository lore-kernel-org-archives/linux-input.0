From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom - add touch_arbitration parameter to wacom module
Date: Mon,  8 Aug 2016 21:46:24 -0700
Message-ID: <1470717984-5655-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34047 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbcHIEqj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Aug 2016 00:46:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id g202so172746pfb.1
        for <linux-input@vger.kernel.org>; Mon, 08 Aug 2016 21:46:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org
Cc: peter.hutterer@who-t.net, benjamin.tissoires@redhat.com, Ping Cheng <pingc@wacom.com>

Touch arbitration is always on in wacom.ko. However, there are
touch enabled applications use both pen and touch simultaneously.
We should provide an option for userland to decide if they want
arbitration on or off.

This patch sets default touch_arbitration to on since most userland
apps are not ready to process pen and touch events simultaneously.
In the future, when userland is ready to accept pen and touch events
together, we will switch default touch_arbitration to off.

Tested-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 65 +++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 0914667..3d55182 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -34,6 +34,10 @@
  */
 #define WACOM_CONTACT_AREA_SCALE 2607
 
+static bool touch_arbitration = 1;
+module_param(touch_arbitration, bool, 0644);
+MODULE_PARM_DESC(touch_arbitration, " on (Y) off (N)");
+
 static void wacom_report_numbered_buttons(struct input_dev *input_dev,
 				int button_count, int mask);
 
@@ -882,6 +886,16 @@ static void wacom_remote_status_irq(struct wacom_wac *wacom_wac, size_t len)
 	wacom_schedule_work(wacom_wac, WACOM_WORKER_REMOTE);
 }
 
+static inline bool touch_state(bool in_proximity)
+{
+	return (touch_arbitration ? !in_proximity : 1);
+}
+
+static inline bool delay_pen_events(bool touch_down)
+{
+	return (touch_down && touch_arbitration);
+}
+
 static int wacom_intuos_general(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -895,7 +909,7 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 		data[0] != WACOM_REPORT_INTUOS_PEN)
 		return 0;
 
-	if (wacom->shared->touch_down)
+	if (delay_pen_events(wacom->shared->touch_down))
 		return 1;
 
 	/* don't report events if we don't know the tool ID */
@@ -1155,7 +1169,7 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 
 	if (touch_max == 1)
 		return test_bit(BTN_TOUCH, input->key) &&
-		       !wacom->shared->stylus_in_proximity;
+		       touch_state(wacom->shared->stylus_in_proximity);
 
 	for (i = 0; i < input->mt->num_slots; i++) {
 		struct input_mt_slot *ps = &input->mt->slots[i];
@@ -1196,7 +1210,8 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 
 	for (i = 0; i < contacts_to_send; i++) {
 		int offset = (byte_per_packet * i) + 1;
-		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
+		bool touch = (data[offset] & 0x1) &&
+			    touch_state(wacom->shared->stylus_in_proximity);
 		int slot = input_mt_get_slot_by_key(input, data[offset + 1]);
 
 		if (slot < 0)
@@ -1260,7 +1275,8 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 
 	for (i = 0; i < contacts_to_send; i++) {
 		int offset = (WACOM_BYTES_PER_MT_PACKET + x_offset) * i + 3;
-		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
+		bool touch = (data[offset] & 0x1) &&
+			    touch_state(wacom->shared->stylus_in_proximity);
 		int id = get_unaligned_le16(&data[offset + 1]);
 		int slot = input_mt_get_slot_by_key(input, id);
 
@@ -1294,7 +1310,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 
 	for (i = 0; i < 2; i++) {
 		int p = data[1] & (1 << i);
-		bool touch = p && !wacom->shared->stylus_in_proximity;
+		bool touch = p && touch_state(wacom->shared->stylus_in_proximity);
 
 		input_mt_slot(input, i);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
@@ -1318,7 +1334,7 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t len)
 {
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->touch_input;
-	bool prox = !wacom->shared->stylus_in_proximity;
+	bool prox = touch_state(wacom->shared->stylus_in_proximity);
 	int x = 0, y = 0;
 
 	if (wacom->features.touch_max > 1 || len > WACOM_PKGLEN_TPC2FG)
@@ -1363,8 +1379,10 @@ static int wacom_tpc_pen(struct wacom_wac *wacom)
 	/* keep pen state for touch events */
 	wacom->shared->stylus_in_proximity = prox;
 
-	/* send pen events only when touch is up or forced out */
-	if (!wacom->shared->touch_down) {
+	/* send pen events only when touch is up or forced out
+	 * or touch arbitration is off
+	 */
+	if (!delay_pen_events(wacom->shared->touch_down)) {
 		input_report_key(input, BTN_STYLUS, data[1] & 0x02);
 		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
 		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
@@ -1506,8 +1524,11 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		return 0;
 	}
 
-	/* send pen events only when touch is up or forced out */
-	if (!usage->type || wacom_wac->shared->touch_down)
+	/* send pen events only when touch is up or forced out
+	 * or touch arbitration is off
+	 */
+	if (!usage->type ||
+	    delay_pen_events(wacom_wac->shared->touch_down))
 		return 0;
 
 	input_event(input, usage->type, usage->code, value);
@@ -1537,8 +1558,7 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 	/* keep pen state for touch events */
 	wacom_wac->shared->stylus_in_proximity = prox;
 
-	/* send pen events only when touch is up or forced out */
-	if (!wacom_wac->shared->touch_down) {
+	if (!delay_pen_events(wacom_wac->shared->touch_down)) {
 		input_report_key(input, BTN_TOUCH,
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], prox);
@@ -1609,7 +1629,7 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 	struct hid_data *hid_data = &wacom_wac->hid_data;
 	bool mt = wacom_wac->features.touch_max > 1;
 	bool prox = hid_data->tipswitch &&
-		    !wacom_wac->shared->stylus_in_proximity;
+		    touch_state(wacom_wac->shared->stylus_in_proximity);
 
 	wacom_wac->hid_data.num_received++;
 	if (wacom_wac->hid_data.num_received > wacom_wac->hid_data.num_expected)
@@ -1835,15 +1855,8 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 
 	for (i = 0; i < 2; i++) {
 		int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
-		bool touch = data[offset + 3] & 0x80;
-
-		/*
-		 * Touch events need to be disabled while stylus is
-		 * in proximity because user's hand is resting on touchpad
-		 * and sending unwanted events.  User expects tablet buttons
-		 * to continue working though.
-		 */
-		touch = touch && !wacom->shared->stylus_in_proximity;
+		bool touch = touch_state(wacom->shared->stylus_in_proximity)
+			   && (data[offset + 3] & 0x80);
 
 		input_mt_slot(input, i);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
@@ -1880,7 +1893,7 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 	if (slot < 0)
 		return;
 
-	touch = touch && !wacom->shared->stylus_in_proximity;
+	touch = touch && touch_state(wacom->shared->stylus_in_proximity);
 
 	input_mt_slot(input, slot);
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
@@ -1993,7 +2006,7 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	}
 
 	wacom->shared->stylus_in_proximity = prox;
-	if (wacom->shared->touch_down)
+	if (delay_pen_events(wacom->shared->touch_down))
 		return 0;
 
 	if (prox) {
@@ -2087,7 +2100,7 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 
 	for (id = 0; id < wacom->features.touch_max; id++) {
 		valid = !!(prefix & BIT(id)) &&
-			!wacom->shared->stylus_in_proximity;
+			touch_state(wacom->shared->stylus_in_proximity);
 
 		input_mt_slot(input, id);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, valid);
@@ -2110,7 +2123,7 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 
 	/* keep touch state for pen event */
 	wacom->shared->touch_down = !!prefix &&
-				    !wacom->shared->stylus_in_proximity;
+				    touch_state(wacom->shared->stylus_in_proximity);
 
 	return 1;
 }
-- 
1.9.1

