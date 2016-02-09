From: Antonio Ospite <ao2@ao2.it>
Subject: [RESEND PATCH 4/6] HID: sony: fix errors from scripts/checkpatch.pl
Date: Tue,  9 Feb 2016 13:55:06 +0100
Message-ID: <1455022508-20041-5-git-send-email-ao2@ao2.it>
References: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:3836 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbcBIMzd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 07:55:33 -0500
In-Reply-To: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Antonio Ospite <ao2@ao2.it>

  ./scripts/checkpatch.pl \
    --types "SPACING,TRAILING_WHITESPACE,POINTER_LOCATION,CODE_INDENT" \
    -f drivers/hid/hid-sony.c

  ERROR: trailing whitespace
  #933: FILE: drivers/hid/hid-sony.c:933:
  +^I * $

  ERROR: space prohibited after that open square bracket '['
  #947: FILE: drivers/hid/hid-sony.c:947:
  +	[ 1] = BTN_TRIGGER_HAPPY1,

  ERROR: space prohibited after that open square bracket '['
  #948: FILE: drivers/hid/hid-sony.c:948:
  +	[ 2] = BTN_TRIGGER_HAPPY2,

  ERROR: space prohibited after that open square bracket '['
  #949: FILE: drivers/hid/hid-sony.c:949:
  +	[ 3] = BTN_TRIGGER_HAPPY3,

  ERROR: space prohibited after that open square bracket '['
  #950: FILE: drivers/hid/hid-sony.c:950:
  +	[ 4] = BTN_TRIGGER_HAPPY4,

  ERROR: space prohibited after that open square bracket '['
  #951: FILE: drivers/hid/hid-sony.c:951:
  +	[ 5] = BTN_TRIGGER_HAPPY5,

  ERROR: space prohibited after that open square bracket '['
  #952: FILE: drivers/hid/hid-sony.c:952:
  +	[ 6] = BTN_TRIGGER_HAPPY6,

  ERROR: space prohibited after that open square bracket '['
  #953: FILE: drivers/hid/hid-sony.c:953:
  +	[ 7] = BTN_TRIGGER_HAPPY7,

  ERROR: space prohibited after that open square bracket '['
  #954: FILE: drivers/hid/hid-sony.c:954:
  +	[ 8] = BTN_TRIGGER_HAPPY8,

  ERROR: space prohibited after that open square bracket '['
  #955: FILE: drivers/hid/hid-sony.c:955:
  +	[ 9] = BTN_TRIGGER_HAPPY9,

  ERROR: "(foo*)" should be "(foo *)"
  #1032: FILE: drivers/hid/hid-sony.c:1032:
  +	void(*send_output_report)(struct sony_sc*);

  WARNING: missing space after return type
  #1032: FILE: drivers/hid/hid-sony.c:1032:
  +	void(*send_output_report)(struct sony_sc*);

  ERROR: "(foo*)" should be "(foo *)"
  #2261: FILE: drivers/hid/hid-sony.c:2261:
  +				void(*send_output_report)(struct sony_sc*))

  WARNING: missing space after return type
  #2261: FILE: drivers/hid/hid-sony.c:2261:
  +				void(*send_output_report)(struct sony_sc*))

  ERROR: code indent should use tabs where possible
  #2449: FILE: drivers/hid/hid-sony.c:2449:
  +         */$

  total: 13 errors, 2 warnings, 2570 lines checked

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Acked-by: Frank Praznik <frank.praznik@gmail.com>
---
 drivers/hid/hid-sony.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 3877101..ce516f3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -930,7 +930,7 @@ static const unsigned int buzz_keymap[] = {
 	/*
 	 * The controller has 4 remote buzzers, each with one LED and 5
 	 * buttons.
-	 * 
+	 *
 	 * We use the mapping chosen by the controller, which is:
 	 *
 	 * Key          Offset
@@ -944,15 +944,15 @@ static const unsigned int buzz_keymap[] = {
 	 * So, for example, the orange button on the third buzzer is mapped to
 	 * BTN_TRIGGER_HAPPY14
 	 */
-	[ 1] = BTN_TRIGGER_HAPPY1,
-	[ 2] = BTN_TRIGGER_HAPPY2,
-	[ 3] = BTN_TRIGGER_HAPPY3,
-	[ 4] = BTN_TRIGGER_HAPPY4,
-	[ 5] = BTN_TRIGGER_HAPPY5,
-	[ 6] = BTN_TRIGGER_HAPPY6,
-	[ 7] = BTN_TRIGGER_HAPPY7,
-	[ 8] = BTN_TRIGGER_HAPPY8,
-	[ 9] = BTN_TRIGGER_HAPPY9,
+	 [1] = BTN_TRIGGER_HAPPY1,
+	 [2] = BTN_TRIGGER_HAPPY2,
+	 [3] = BTN_TRIGGER_HAPPY3,
+	 [4] = BTN_TRIGGER_HAPPY4,
+	 [5] = BTN_TRIGGER_HAPPY5,
+	 [6] = BTN_TRIGGER_HAPPY6,
+	 [7] = BTN_TRIGGER_HAPPY7,
+	 [8] = BTN_TRIGGER_HAPPY8,
+	 [9] = BTN_TRIGGER_HAPPY9,
 	[10] = BTN_TRIGGER_HAPPY10,
 	[11] = BTN_TRIGGER_HAPPY11,
 	[12] = BTN_TRIGGER_HAPPY12,
@@ -1029,7 +1029,7 @@ struct sony_sc {
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
 	struct work_struct state_worker;
-	void(*send_output_report)(struct sony_sc*);
+	void (*send_output_report)(struct sony_sc *);
 	struct power_supply *battery;
 	struct power_supply_desc battery_desc;
 	int device_id;
@@ -2259,7 +2259,7 @@ static void sony_release_device_id(struct sony_sc *sc)
 }
 
 static inline void sony_init_output_report(struct sony_sc *sc,
-				void(*send_output_report)(struct sony_sc*))
+				void (*send_output_report)(struct sony_sc *))
 {
 	sc->send_output_report = send_output_report;
 
@@ -2447,7 +2447,7 @@ static int sony_suspend(struct hid_device *hdev, pm_message_t message)
 	/*
 	 * On suspend save the current LED state,
 	 * stop running force-feedback and blank the LEDS.
-         */
+	 */
 	if (SONY_LED_SUPPORT || SONY_FF_SUPPORT) {
 		struct sony_sc *sc = hid_get_drvdata(hdev);
 
-- 
2.7.0

