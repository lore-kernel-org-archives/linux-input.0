From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 12/19] HID: wacom: generic: Support tool ID and additional tool types
Date: Thu,  6 Oct 2016 14:22:24 -0700
Message-ID: <20161006212231.31440-13-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33395 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935088AbcJFVW7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id m5so836307qtb.0
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:59 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

Devices following the new Custom HID mode specification (as well as even
some recent component sensors which use the same standard HID usage)
are capable of reporting tool ID information that we need to relay to
userspace. This patch adds support for reading and relaying the tool
type information, which is (unfortunately) split across two usages.
We also advertise the existence of tool types beyond BTN_TOOL_PEN
that might be available.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/hid/wacom_wac.h |  4 ++-
 2 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 60f065b..f2aadc4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1450,6 +1450,8 @@ static int wacom_equivalent_usage(int usage)
 		if (subpage == WACOM_HID_SP_DIGITIZER ||
 		    subpage == WACOM_HID_SP_DIGITIZERINFO ||
 		    usage == WACOM_HID_WD_SENSE ||
+		    usage == WACOM_HID_WD_SERIALHI ||
+		    usage == WACOM_HID_WD_TOOLTYPE ||
 		    usage == WACOM_HID_WD_DISTANCE) {
 			return usage;
 		}
@@ -1551,6 +1553,17 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		features->quirks |= WACOM_QUIRK_SENSE;
 		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
 		break;
+	case WACOM_HID_WD_SERIALHI:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_MISC, 0);
+		set_bit(EV_KEY, input->evbit);
+		input_set_capability(input, EV_KEY, BTN_TOOL_PEN);
+		input_set_capability(input, EV_KEY, BTN_TOOL_RUBBER);
+		input_set_capability(input, EV_KEY, BTN_TOOL_BRUSH);
+		input_set_capability(input, EV_KEY, BTN_TOOL_PENCIL);
+		input_set_capability(input, EV_KEY, BTN_TOOL_AIRBRUSH);
+		input_set_capability(input, EV_KEY, BTN_TOOL_MOUSE);
+		input_set_capability(input, EV_KEY, BTN_TOOL_LENS);
+		break;
 	case WACOM_HID_WD_FINGERWHEEL:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
 		break;
@@ -1587,9 +1600,35 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 	case HID_DG_TIPSWITCH:
 		wacom_wac->hid_data.tipswitch |= value;
 		return 0;
+	case HID_DG_TOOLSERIALNUMBER:
+		wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFF);
+		wacom_wac->serial[0] |= value;
+		return 0;
 	case WACOM_HID_WD_SENSE:
 		wacom_wac->hid_data.sense_state = value;
 		return 0;
+	case WACOM_HID_WD_SERIALHI:
+		wacom_wac->serial[0] = (wacom_wac->serial[0] & 0xFFFFFFFF);
+		wacom_wac->serial[0] |= ((__u64)value) << 32;
+		/*
+		 * Non-USI EMR devices may contain additional tool type
+		 * information here. See WACOM_HID_WD_TOOLTYPE case for
+		 * more details.
+		 */
+		if (value >> 20 == 1) {
+			wacom_wac->id[0] |= value & 0xFFFFF;
+		}
+		return 0;
+	case WACOM_HID_WD_TOOLTYPE:
+		/*
+		 * Some devices (MobileStudio Pro, and possibly later
+		 * devices as well) do not return the complete tool
+		 * type in their WACOM_HID_WD_TOOLTYPE usage. Use a
+		 * bitwise OR so the complete value can be built
+		 * up over time :(
+		 */
+		wacom_wac->id[0] |= value;
+		return 0;
 	}
 
 	/* send pen events only when touch is up or forced out
@@ -1622,26 +1661,51 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 	bool prox = wacom_wac->hid_data.inrange_state;
 	bool range = wacom_wac->hid_data.sense_state;
 
-	if (!wacom_wac->tool[0] && prox) /* first in prox */
+	if (!wacom_wac->tool[0] && prox) { /* first in prox */
 		/* Going into proximity select tool */
-		wacom_wac->tool[0] = wacom_wac->hid_data.invert_state ?
-						BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+		if (wacom_wac->hid_data.invert_state)
+			wacom_wac->tool[0] = BTN_TOOL_RUBBER;
+		else if (wacom_wac->id[0])
+			wacom_wac->tool[0] = wacom_intuos_get_tool_type(wacom_wac->id[0]);
+		else
+			wacom_wac->tool[0] = BTN_TOOL_PEN;
+	}
 
 	/* keep pen state for touch events */
 	wacom_wac->shared->stylus_in_proximity = range;
 
 	if (!delay_pen_events(wacom_wac) && wacom_wac->tool[0]) {
+		int id = wacom_wac->id[0];
+
+		/*
+		 * Non-USI EMR tools should have their IDs mangled to
+		 * match the legacy behavior of wacom_intuos_general
+		 */
+		if (wacom_wac->serial[0] >> 52 == 1)
+			id = wacom_intuos_id_mangle(id);
+
+		/*
+		 * To ensure compatibility with xf86-input-wacom, we should
+		 * report the BTN_TOOL_* event prior to the ABS_MISC or
+		 * MSC_SERIAL events.
+		 */
 		input_report_key(input, BTN_TOUCH,
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], prox);
+		if (wacom_wac->serial[0]) {
+			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
+			input_report_abs(input, ABS_MISC, id);
+		}
 
 		wacom_wac->hid_data.tipswitch = false;
 
 		input_sync(input);
 	}
 
-	if (!prox)
+	if (!prox) {
 		wacom_wac->tool[0] = 0;
+		wacom_wac->id[0] = 0;
+	}
 }
 
 static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index e8779c7..3926ff4 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -90,6 +90,8 @@
 #define WACOM_HID_SP_DIGITIZERINFO      0x00100000
 #define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
 #define WACOM_HID_WD_SENSE              (WACOM_HID_UP_WACOMDIGITIZER | 0x36)
+#define WACOM_HID_WD_SERIALHI           (WACOM_HID_UP_WACOMDIGITIZER | 0x5c)
+#define WACOM_HID_WD_TOOLTYPE           (WACOM_HID_UP_WACOMDIGITIZER | 0x77)
 #define WACOM_HID_WD_DISTANCE           (WACOM_HID_UP_WACOMDIGITIZER | 0x0132)
 #define WACOM_HID_WD_FINGERWHEEL        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d03)
 #define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
@@ -247,7 +249,7 @@ struct wacom_wac {
 	unsigned char data[WACOM_PKGLEN_MAX];
 	int tool[2];
 	int id[2];
-	__u32 serial[2];
+	__u64 serial[2];
 	bool reporting_data;
 	struct wacom_features features;
 	struct wacom_shared *shared;
-- 
2.10.0

