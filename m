From: nolsen@jabra.com
Subject: [PATCH] HID: Support telephony devices
Date: Wed,  3 Aug 2016 12:42:26 +0200
Message-ID: <1470220946-32431-1-git-send-email-nolsen@jabra.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prime.nsonet.eu ([178.63.75.197]:35532 "EHLO prime.nsonet.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757802AbcHCKmj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Aug 2016 06:42:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Niels Skou Olsen <nolsen@jabra.com>

From: Niels Skou Olsen <nolsen@jabra.com>

Add support for telephony device buttons and LEDs as described in the USB
HID Usage Tables specification.

This allows user mode applications convenient access to telephony devices
such as headsets, speaker phones and desk phones.

Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
---
 drivers/hid/hid-debug.c                | 39 ++++++++++++++++++++-
 drivers/hid/hid-input.c                | 63 +++++++++++++++++++++++++++++++---
 drivers/input/input-leds.c             |  5 +++
 include/linux/hid.h                    |  8 ++++-
 include/linux/mod_devicetable.h        |  2 +-
 include/uapi/linux/input-event-codes.h | 18 +++++++++-
 6 files changed, 126 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index acfb522..9f109c3 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -129,9 +129,42 @@ static const struct hid_usage_entry hid_usage_table[] = {
       {0, 0x03, "ScrollLock"},
       {0, 0x04, "Compose"},
       {0, 0x05, "Kana"},
+	{0, 0x09, "Mute"},
+	{0, 0x17, "OffHook"},
+	{0, 0x18, "Ring"},
+	{0, 0x19, "MessageWaiting"},
+	{0, 0x20, "Hold"},
+	{0, 0x21, "Microphone"},
+	{0, 0x27, "Standby"},
+	{0, 0x2a, "Online"},
+	{0, 0x4c, "SystemSuspend"},
+	{0, 0x4d, "ExtPowerConnected"},
       {0, 0x4b, "GenericIndicator"},
   {  9, 0, "Button" },
   { 10, 0, "Ordinal" },
+	{ 11, 0, "Telephony" },
+	{0, 0x20, "KeyHookSwitch"},
+	{0, 0x21, "KeyFlash"},
+	{0, 0x23, "KeyHold"},
+	{0, 0x24, "KeyRedial"},
+	{0, 0x2f, "KeyMicMute"},
+	{0, 0x9e, "LedRinger"},
+	{0, 0xb0, "KeyNumeric0"},
+	{0, 0xb1, "KeyNumeric1"},
+	{0, 0xb2, "KeyNumeric2"},
+	{0, 0xb3, "KeyNumeric3"},
+	{0, 0xb4, "KeyNumeric4"},
+	{0, 0xb5, "KeyNumeric5"},
+	{0, 0xb6, "KeyNumeric6"},
+	{0, 0xb7, "KeyNumeric7"},
+	{0, 0xb8, "KeyNumeric8"},
+	{0, 0xb9, "KeyNumeric9"},
+	{0, 0xba, "KeyNumericStar"},
+	{0, 0xbb, "KeyNumericPound"},
+	{0, 0xbc, "KeyNumericA"},
+	{0, 0xbd, "KeyNumericB"},
+	{0, 0xbe, "KeyNumericC"},
+	{0, 0xbf, "KeyNumericD"},
   { 12, 0, "Consumer" },
       {0, 0x238, "HorizontalWheel"},
   { 13, 0, "Digitizers" },
@@ -998,7 +1031,11 @@ static const char *leds[LED_MAX + 1] = {
 	[LED_SCROLLL] = "ScrollLock",	[LED_COMPOSE] = "Compose",
 	[LED_KANA] = "Kana",		[LED_SLEEP] = "Sleep",
 	[LED_SUSPEND] = "Suspend",	[LED_MUTE] = "Mute",
-	[LED_MISC] = "Misc",
+	[LED_MISC] = "Misc",		[LED_MAIL] = "Mail",
+	[LED_CHARGING] = "Charging",	[LED_OFF_HOOK] = "Off-hook",
+	[LED_RING] = "Ring",		[LED_RINGER] = "Ringer",
+	[LED_HOLD] = "Hold",		[LED_MICROPHONE] = "Microphone",
+	[LED_ONLINE] = "Online"
 };
 
 static const char *repeats[REP_MAX + 1] = {
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bcfaf32..b2a4136 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -509,9 +509,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 	if (field->report_count < 1)
 		goto ignore;
 
-	/* only LED usages are supported in output fields */
+	/* only LED and TELEPHONY usages are supported in output fields */
 	if (field->report_type == HID_OUTPUT_REPORT &&
-			(usage->hid & HID_USAGE_PAGE) != HID_UP_LED) {
+			(usage->hid & HID_USAGE_PAGE) != HID_UP_LED &&
+			(usage->hid & HID_USAGE_PAGE) != HID_UP_TELEPHONY) {
+
 		goto ignore;
 	}
 
@@ -658,11 +660,32 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x03:  map_led (LED_SCROLLL);  break;    /*   "Scroll Lock"              */
 		case 0x04:  map_led (LED_COMPOSE);  break;    /*   "Compose"                  */
 		case 0x05:  map_led (LED_KANA);     break;    /*   "Kana"                     */
-		case 0x27:  map_led (LED_SLEEP);    break;    /*   "Stand-By"                 */
-		case 0x4c:  map_led (LED_SUSPEND);  break;    /*   "System Suspend"           */
 		case 0x09:  map_led (LED_MUTE);     break;    /*   "Mute"                     */
-		case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
+		case 0x17: /* "Off hook" */
+			map_led(LED_OFF_HOOK);
+			break;
+		case 0x18: /* "Ring" */
+			map_led(LED_RING);
+			break;
 		case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
+		case 0x20: /* "Hold" */
+			map_led(LED_HOLD);
+			break;
+		case 0x21: /* "Microphone" */
+			map_led(LED_MICROPHONE);
+			break;
+		case 0x27: /* "Stand-By" */
+			map_led(LED_SLEEP);
+			break;
+		case 0x2a: /* "Online" */
+			map_led(LED_ONLINE);
+			break;
+		case 0x4b: /* "Generic Indicator" */
+			map_led(LED_MISC);
+			break;
+		case 0x4c: /* "System Suspend" */
+			map_led(LED_SUSPEND);
+			break;
 		case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
 
 		default: goto ignore;
@@ -732,7 +755,37 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 	case HID_UP_TELEPHONY:
 		switch (usage->hid & HID_USAGE) {
+		case 0x07:
+			map_key_clear(KEY_PROGRAMMABLE);
+			break;
+		case 0x1e:
+			map_led(LED_SPEAKER);
+			break;
+		case 0x20:
+			map_key_clear(KEY_HOOK_SWITCH);
+			break;
+		case 0x21:
+			map_key_clear(KEY_FLASH);
+			break;
+		case 0x23:
+			map_key_clear(KEY_HOLD);
+			break;
+		case 0x24:
+			map_key_clear(KEY_REDIAL);
+			break;
+		case 0x2a:
+			map_key_clear(KEY_LINE);
+			break;
+		case 0x2b:
+			map_key_clear(KEY_SPEAKER_PHONE);
+			break;
 		case 0x2f: map_key_clear(KEY_MICMUTE);		break;
+		case 0x50:
+			map_key_clear(KEY_SPEED_DIAL);
+			break;
+		case 0x9e:
+			map_led(LED_RINGER);
+			break;
 		case 0xb0: map_key_clear(KEY_NUMERIC_0);	break;
 		case 0xb1: map_key_clear(KEY_NUMERIC_1);	break;
 		case 0xb2: map_key_clear(KEY_NUMERIC_2);	break;
diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 766bf26..cf692df 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -36,6 +36,11 @@ static const struct {
 	[LED_MISC]	= { "misc" },
 	[LED_MAIL]	= { "mail" },
 	[LED_CHARGING]	= { "charging" },
+	[LED_OFF_HOOK]	= { "off-hook" },
+	[LED_RING]	= { "ring" },
+	[LED_HOLD]	= { "hold" },
+	[LED_MICROPHONE] = { "microphone" },
+	[LED_ONLINE]	= { "online" },
 };
 
 struct input_led {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75b66ec..0c91c89 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -764,7 +764,13 @@ struct hid_ll_driver {
 
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
 /* We ignore a few input applications that are not widely used */
-#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
+#define IS_INPUT_APPLICATION(a) (				\
+		((a >= 0x00010000) && (a <= 0x00010008)) ||	\
+		(a == 0x00010080) ||				\
+		(a == 0x000b0005) ||				\
+		(a == 0x000c0001) ||				\
+		((a >= 0x000d0002) && (a <= 0x000d0006)))
+
 
 /* HID core API */
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ed84c07..e342d3f 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -288,7 +288,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_REL_MAX		0x0f
 #define INPUT_DEVICE_ID_ABS_MAX		0x3f
 #define INPUT_DEVICE_ID_MSC_MAX		0x07
-#define INPUT_DEVICE_ID_LED_MAX		0x0f
+#define INPUT_DEVICE_ID_LED_MAX		0x11
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
 #define INPUT_DEVICE_ID_SW_MAX		0x0f
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index d6d071f..eaa368b 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -593,6 +593,15 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 
+#define KEY_HOOK_SWITCH	0x231
+#define KEY_FLASH		0x232
+#define KEY_HOLD		0x233
+#define KEY_REDIAL		0x234
+#define KEY_PROGRAMMABLE	0x235
+#define KEY_LINE		0x236
+#define KEY_SPEAKER_PHONE	0x237
+#define KEY_SPEED_DIAL		0x238
+
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
 #define KEY_JOURNAL		0x242	/* AL Log/Journal/Timecard */
@@ -812,7 +821,14 @@
 #define LED_MISC		0x08
 #define LED_MAIL		0x09
 #define LED_CHARGING		0x0a
-#define LED_MAX			0x0f
+#define LED_OFF_HOOK		0x0b
+#define LED_RING		0x0c
+#define LED_RINGER		0x0d
+#define LED_HOLD		0x0e
+#define LED_MICROPHONE		0x0f
+#define LED_SPEAKER		0x10
+#define LED_ONLINE		0x11
+#define LED_MAX		0x11
 #define LED_CNT			(LED_MAX+1)
 
 /*
-- 
2.7.4

