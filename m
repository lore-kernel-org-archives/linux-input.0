Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2734CDD
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648929; cv=none; b=WvP4Ign2auXV2swr1EDcz1FuMoG/NBe+CB6i6tgXFfkTFoqD0cph7hCOIZdq9u9KXQtd/6UHY92IT25Y+sjgYsNasAptFvvhO/Wt77Q2GAF1jxpy6mFILLcqt4yXal0UpCP846oXN+iNg9cXsCTmkAtizpEgLX/lVvf9txcOrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648929; c=relaxed/simple;
	bh=h3pMn+uybXYURyKhzvmxckSK8Jp1GHfJItY16NxqiLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B54NrZeHcmxeTktE4988J7KhRulyjf3ffjv7HN59acKUQvI9ZxrG1X61P+P34wwD2Q5eRomcB3PPmY1Z/+qdDodwtI428lDC8WNT4hTFPfFa7N8rxhoa4ra2wtO9waK8nMKEIhpWXgU5TLILsqn2TvafQfJ09bfRMZ1MXfoxqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=1CEHmZ1C; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="1CEHmZ1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783648916; bh=h3pMn+uybXYURyKhzvmxckSK8Jp1GHfJItY16NxqiLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1CEHmZ1Cpb3g3NYu6rLJkrTIFrGi96ccG/2YyA3oVSxwwgBji7DbIhJaC5m9vVRki
	 R4vw6ZU9iPfTX9sakYBaN1C6hJKKfJH46A4pdys5TkgXoDup4H+hfUI/p7oKEj1Jfy
	 QG+y9uJT/1H76vu4uQF6LpO9nQFXj4afeFWS9sUOmnHcd/HcCNwah2hx5j5EKXM2y4
	 7Q/fsIE+fzNaHu4hhzGxiJuHGsfszPEykKwlZ9uraXHZBlbkBvsaGVF9a0zeEbpGFd
	 HuxK0g6WrOtlEZD4yIJBRwiXpadlVh5EZoV0YXdZTmVeXtpk029+KhoLQKihQEhsAj
	 iKD0DE/OP9XnA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 6FFA0A12E;
	Thu, 09 Jul 2026 19:01:56 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v3 02/10] HID: steam: Refactor and clean up report parsing
Date: Thu,  9 Jul 2026 19:00:37 -0700
Message-ID: <20260710020048.2337655-3-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710020048.2337655-1-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This switches from a parsing style where each button or axis is parsed
individually out of a report using !!(byte & BIT(x)) style. This commit
switches it to a mostly unified approach of defining a list of individual
mappings in an array and passing it to a function that handles all of the
extraction. Theoretically this is more lines, but in practice it results in
(subjectively) cleaner code. Some exceptions still need to be made for
things like handling the lizard mode toggle key, but in general there's a
lot less manual code.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 211 ++++++++++++++++++++++++----------------
 1 file changed, 128 insertions(+), 83 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index a854d6360a0e..1b0367c98eac 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -43,6 +43,7 @@
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
 #include <linux/power_supply.h>
+#include <linux/unaligned.h>
 #include "hid-ids.h"
 
 MODULE_DESCRIPTION("HID driver for Valve Steam Controller");
@@ -1355,13 +1356,45 @@ static void steam_do_connect_event(struct steam_device *steam, bool connected)
  * Clamp the values to 32767..-32767 so that the range is
  * symmetrical and can be negated safely.
  */
-static inline s16 steam_le16(u8 *data)
+static inline s16 steam_le16(const u8 *data)
 {
-	s16 x = (s16) le16_to_cpup((__le16 *)data);
+	s16 x = (s16) get_unaligned_le16((__le16 *)data);
 
 	return x == -32768 ? -32767 : x;
 }
 
+struct steam_button_mapping {
+	int code;
+	u8 byte;
+	u8 bit;
+};
+
+struct steam_axis_mapping {
+	int code;
+	s8 sign;
+	u8 byte;
+};
+
+static void steam_map_buttons(struct input_dev *input,
+		const struct steam_button_mapping *mappings, const u8 *data)
+{
+	const struct steam_button_mapping *mapping;
+
+	for (mapping = mappings; mapping->code; mapping++)
+		input_report_key(input, mapping->code,
+			data[mapping->byte] & BIT(mapping->bit));
+}
+
+static void steam_map_axes(struct input_dev *input,
+		const struct steam_axis_mapping *mappings, const u8 *data)
+{
+	const struct steam_axis_mapping *mapping;
+
+	for (mapping = mappings; mapping->sign; mapping++)
+		input_report_abs(input, mapping->code,
+			mapping->sign * steam_le16(&data[mapping->byte]));
+}
+
 /*
  * The size for this message payload is 60.
  * The known values are:
@@ -1428,18 +1461,42 @@ static inline s16 steam_le16(u8 *data)
  * 10.7  | --         | lpad_and_joy
  */
 
+static const struct steam_button_mapping steam_controller_button_mappings[] = {
+	{ BTN_TR2,		 8, 0 },
+	{ BTN_TL2,		 8, 1 },
+	{ BTN_TR,		 8, 2 },
+	{ BTN_TL,		 8, 3 },
+	{ BTN_Y,		 8, 4 },
+	{ BTN_B,		 8, 5 },
+	{ BTN_X,		 8, 6 },
+	{ BTN_A,		 8, 7 },
+	{ BTN_SELECT,		 9, 4 },
+	{ BTN_MODE,		 9, 5 },
+	{ BTN_START,		 9, 6 },
+	{ BTN_GRIPL,		 9, 7 },
+	{ BTN_GRIPR,		10, 0 },
+	{ BTN_THUMBR,		10, 2 },
+	{ BTN_THUMBL,		10, 6 },
+	{ BTN_THUMB2,		10, 4 },
+	{ BTN_DPAD_UP,		 9, 0 },
+	{ BTN_DPAD_RIGHT,	 9, 1 },
+	{ BTN_DPAD_LEFT,	 9, 2 },
+	{ BTN_DPAD_DOWN,	 9, 3 },
+	{ /* sentinel */ },
+};
+
+static const struct steam_axis_mapping steam_controller_axis_mappings[] = {
+	{ ABS_RX,  1, 20 },
+	{ ABS_RY, -1, 22 },
+	{ /* sentinel */ },
+};
+
 static void steam_do_input_event(struct steam_device *steam,
 		struct input_dev *input, u8 *data)
 {
-	/* 24 bits of buttons */
-	u8 b8, b9, b10;
 	s16 x, y;
 	bool lpad_touched, lpad_and_joy;
 
-	b8 = data[8];
-	b9 = data[9];
-	b10 = data[10];
-
 	input_report_abs(input, ABS_HAT2Y, data[11]);
 	input_report_abs(input, ABS_HAT2X, data[12]);
 
@@ -1451,8 +1508,8 @@ static void steam_do_input_event(struct steam_device *steam,
 	 * joystick values.
 	 * (lpad_touched || lpad_and_joy) tells if the lpad is really touched.
 	 */
-	lpad_touched = b10 & BIT(3);
-	lpad_and_joy = b10 & BIT(7);
+	lpad_touched = data[10] & BIT(3);
+	lpad_and_joy = data[10] & BIT(7);
 	x = steam_le16(data + 16);
 	y = -steam_le16(data + 18);
 
@@ -1468,31 +1525,10 @@ static void steam_do_input_event(struct steam_device *steam,
 		input_report_abs(input, ABS_HAT0X, 0);
 		input_report_abs(input, ABS_HAT0Y, 0);
 	}
+	input_report_key(input, BTN_THUMB, lpad_touched || lpad_and_joy);
 
-	input_report_abs(input, ABS_RX, steam_le16(data + 20));
-	input_report_abs(input, ABS_RY, -steam_le16(data + 22));
-
-	input_event(input, EV_KEY, BTN_TR2, !!(b8 & BIT(0)));
-	input_event(input, EV_KEY, BTN_TL2, !!(b8 & BIT(1)));
-	input_event(input, EV_KEY, BTN_TR, !!(b8 & BIT(2)));
-	input_event(input, EV_KEY, BTN_TL, !!(b8 & BIT(3)));
-	input_event(input, EV_KEY, BTN_Y, !!(b8 & BIT(4)));
-	input_event(input, EV_KEY, BTN_B, !!(b8 & BIT(5)));
-	input_event(input, EV_KEY, BTN_X, !!(b8 & BIT(6)));
-	input_event(input, EV_KEY, BTN_A, !!(b8 & BIT(7)));
-	input_event(input, EV_KEY, BTN_SELECT, !!(b9 & BIT(4)));
-	input_event(input, EV_KEY, BTN_MODE, !!(b9 & BIT(5)));
-	input_event(input, EV_KEY, BTN_START, !!(b9 & BIT(6)));
-	input_event(input, EV_KEY, BTN_GRIPL, !!(b9 & BIT(7)));
-	input_event(input, EV_KEY, BTN_GRIPR, !!(b10 & BIT(0)));
-	input_event(input, EV_KEY, BTN_THUMBR, !!(b10 & BIT(2)));
-	input_event(input, EV_KEY, BTN_THUMBL, !!(b10 & BIT(6)));
-	input_event(input, EV_KEY, BTN_THUMB, lpad_touched || lpad_and_joy);
-	input_event(input, EV_KEY, BTN_THUMB2, !!(b10 & BIT(4)));
-	input_event(input, EV_KEY, BTN_DPAD_UP, !!(b9 & BIT(0)));
-	input_event(input, EV_KEY, BTN_DPAD_RIGHT, !!(b9 & BIT(1)));
-	input_event(input, EV_KEY, BTN_DPAD_LEFT, !!(b9 & BIT(2)));
-	input_event(input, EV_KEY, BTN_DPAD_DOWN, !!(b9 & BIT(3)));
+	steam_map_buttons(input, steam_controller_button_mappings, data);
+	steam_map_axes(input, steam_controller_axis_mappings, data);
 
 	input_sync(input);
 }
@@ -1595,23 +1631,67 @@ static void steam_do_input_event(struct steam_device *steam,
  *  15.6 | --         | unknown
  *  15.7 | --         | unknown
  */
+
+static const struct steam_button_mapping steam_deck_button_mappings[] = {
+	{ BTN_TR2,		 8, 0 },
+	{ BTN_TL2,		 8, 1 },
+	{ BTN_TR,		 8, 2 },
+	{ BTN_TL,		 8, 3 },
+	{ BTN_Y,		 8, 4 },
+	{ BTN_B,		 8, 5 },
+	{ BTN_X,		 8, 6 },
+	{ BTN_A,		 8, 7 },
+	{ BTN_SELECT,		 9, 4 },
+	{ BTN_MODE,		 9, 5 },
+	{ BTN_START,		 9, 6 },
+	{ BTN_GRIPL2,		 9, 7 },
+	{ BTN_GRIPR2,		10, 0 },
+	{ BTN_THUMBL,		10, 6 },
+	{ BTN_THUMBR,		11, 2 },
+	{ BTN_DPAD_UP,		 9, 0 },
+	{ BTN_DPAD_RIGHT,	 9, 1 },
+	{ BTN_DPAD_LEFT,	 9, 2 },
+	{ BTN_DPAD_DOWN,	 9, 3 },
+	{ BTN_THUMB,		10, 1 },
+	{ BTN_THUMB2,		10, 2 },
+	{ BTN_GRIPL,		13, 1 },
+	{ BTN_GRIPR,		13, 2 },
+	{ BTN_BASE,		14, 2 },
+	{ /* sentinel */ },
+};
+
+static const struct steam_axis_mapping steam_deck_axis_mappings[] = {
+	{ ABS_X,	 1, 48 },
+	{ ABS_Y,	-1, 50 },
+	{ ABS_RX,	 1, 52 },
+	{ ABS_RY,	-1, 54 },
+	{ ABS_HAT2Y,	 1, 44 },
+	{ ABS_HAT2X,	 1, 46 },
+	{ /* sentinel */ },
+};
+
+static const struct steam_axis_mapping steam_deck_imu_mappings[] = {
+	{ ABS_X,   1, 24 },
+	{ ABS_Z,  -1, 26 },
+	{ ABS_Y,   1, 28 },
+	{ ABS_RX,  1, 30 },
+	{ ABS_RZ, -1, 32 },
+	{ ABS_RY,  1, 34 },
+	{ /* sentinel */ },
+};
+
 static void steam_do_deck_input_event(struct steam_device *steam,
 		struct input_dev *input, u8 *data)
 {
-	u8 b8, b9, b10, b11, b13, b14;
+	bool start_pressed;
 	bool lpad_touched, rpad_touched;
 
-	b8 = data[8];
-	b9 = data[9];
-	b10 = data[10];
-	b11 = data[11];
-	b13 = data[13];
-	b14 = data[14];
+	start_pressed = data[9] & BIT(6);
 
-	if (!(b9 & BIT(6)) && steam->did_mode_switch) {
+	if (!start_pressed && steam->did_mode_switch) {
 		steam->did_mode_switch = false;
 		cancel_delayed_work(&steam->mode_switch);
-	} else if (!steam->client_opened && (b9 & BIT(6)) && !steam->did_mode_switch) {
+	} else if (!steam->client_opened && start_pressed && !steam->did_mode_switch) {
 		steam->did_mode_switch = true;
 		schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
 	}
@@ -1619,8 +1699,8 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 	if (!steam->gamepad_mode && lizard_mode)
 		return;
 
-	lpad_touched = b10 & BIT(3);
-	rpad_touched = b10 & BIT(4);
+	lpad_touched = data[10] & BIT(3);
+	rpad_touched = data[10] & BIT(4);
 
 	if (lpad_touched) {
 		input_report_abs(input, ABS_HAT0X, steam_le16(data + 16));
@@ -1638,38 +1718,8 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 		input_report_abs(input, ABS_HAT1Y, 0);
 	}
 
-	input_report_abs(input, ABS_X, steam_le16(data + 48));
-	input_report_abs(input, ABS_Y, -steam_le16(data + 50));
-	input_report_abs(input, ABS_RX, steam_le16(data + 52));
-	input_report_abs(input, ABS_RY, -steam_le16(data + 54));
-
-	input_report_abs(input, ABS_HAT2Y, steam_le16(data + 44));
-	input_report_abs(input, ABS_HAT2X, steam_le16(data + 46));
-
-	input_event(input, EV_KEY, BTN_TR2, !!(b8 & BIT(0)));
-	input_event(input, EV_KEY, BTN_TL2, !!(b8 & BIT(1)));
-	input_event(input, EV_KEY, BTN_TR, !!(b8 & BIT(2)));
-	input_event(input, EV_KEY, BTN_TL, !!(b8 & BIT(3)));
-	input_event(input, EV_KEY, BTN_Y, !!(b8 & BIT(4)));
-	input_event(input, EV_KEY, BTN_B, !!(b8 & BIT(5)));
-	input_event(input, EV_KEY, BTN_X, !!(b8 & BIT(6)));
-	input_event(input, EV_KEY, BTN_A, !!(b8 & BIT(7)));
-	input_event(input, EV_KEY, BTN_SELECT, !!(b9 & BIT(4)));
-	input_event(input, EV_KEY, BTN_MODE, !!(b9 & BIT(5)));
-	input_event(input, EV_KEY, BTN_START, !!(b9 & BIT(6)));
-	input_event(input, EV_KEY, BTN_GRIPL2, !!(b9 & BIT(7)));
-	input_event(input, EV_KEY, BTN_GRIPR2, !!(b10 & BIT(0)));
-	input_event(input, EV_KEY, BTN_THUMBL, !!(b10 & BIT(6)));
-	input_event(input, EV_KEY, BTN_THUMBR, !!(b11 & BIT(2)));
-	input_event(input, EV_KEY, BTN_DPAD_UP, !!(b9 & BIT(0)));
-	input_event(input, EV_KEY, BTN_DPAD_RIGHT, !!(b9 & BIT(1)));
-	input_event(input, EV_KEY, BTN_DPAD_LEFT, !!(b9 & BIT(2)));
-	input_event(input, EV_KEY, BTN_DPAD_DOWN, !!(b9 & BIT(3)));
-	input_event(input, EV_KEY, BTN_THUMB, !!(b10 & BIT(1)));
-	input_event(input, EV_KEY, BTN_THUMB2, !!(b10 & BIT(2)));
-	input_event(input, EV_KEY, BTN_GRIPL, !!(b13 & BIT(1)));
-	input_event(input, EV_KEY, BTN_GRIPR, !!(b13 & BIT(2)));
-	input_event(input, EV_KEY, BTN_BASE, !!(b14 & BIT(2)));
+	steam_map_buttons(input, steam_deck_button_mappings, data);
+	steam_map_axes(input, steam_deck_axis_mappings, data);
 
 	input_sync(input);
 }
@@ -1690,12 +1740,7 @@ static void steam_do_deck_sensors_event(struct steam_device *steam,
 		return;
 
 	input_event(sensors, EV_MSC, MSC_TIMESTAMP, steam->sensor_timestamp_us);
-	input_report_abs(sensors, ABS_X, steam_le16(data + 24));
-	input_report_abs(sensors, ABS_Z, -steam_le16(data + 26));
-	input_report_abs(sensors, ABS_Y, steam_le16(data + 28));
-	input_report_abs(sensors, ABS_RX, steam_le16(data + 30));
-	input_report_abs(sensors, ABS_RZ, -steam_le16(data + 32));
-	input_report_abs(sensors, ABS_RY, steam_le16(data + 34));
+	steam_map_axes(sensors, steam_deck_imu_mappings, data);
 
 	input_sync(sensors);
 }
-- 
2.54.0

