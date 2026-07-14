Received: from mail.mcld.eu (mail.mcld.eu [84.242.69.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4B41A91B;
	Tue, 14 Jul 2026 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.242.69.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054565; cv=none; b=AvRK3G6msrO7+h/sMkADNRqZB0MDlsvpUtvxXrLxjSqW9Am4K1BM0yGwNOQciQ2bOub/3AyHKng+QK0fqxewSKRRRfQS4TuLFLEKtA/3UZjaKvQG6PbpoMgzTDibwsGemO0OFCFamLWnWxIfwVGw2l0nj4P61jrDN8M/Z6y4sLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054565; c=relaxed/simple;
	bh=BS+0VuagQgLQCmYYIxERCD3t6OSr5hWH6nYxg7O8J90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDSR23ufqfFL3P7b/wxyuNR4DEBme3DyOFSU0wOElvH0vK3uf30OW0vTBcd5M8VpNkhZGOnWmXIgBFSAlHaXjbs/9qi29Yq/lj/UB5fB1TN1zTYWXC+RNAhZ3GnEu9WeCVnYk6XJKfARBtkiXtybWYPjIc6Z91RkioKX3P9n3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu; spf=pass smtp.mailfrom=mcld.eu; dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=qMyIauA3; dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=BSnyV9hp; arc=none smtp.client-ip=84.242.69.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcld.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="qMyIauA3";
	dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="BSnyV9hp"
DKIM-Signature: v=1; a=ed25519-sha256; s=202501e; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1784054556; bh=tJTEtvcSkXmtP+QvUi1AyeR
	lDignp3OXCcxbvUq4h9I=; b=qMyIauA3YmDnTaNuuPViynNmxf6mM5smFSxZwh6ieAxgUTIiTf
	YMXD6V9MwVw8rTYbDKKDFqzhUogZRWIq+NCg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202501r; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1784054556; bh=tJTEtvcSkXmtP+QvUi1AyeR
	lDignp3OXCcxbvUq4h9I=; b=BSnyV9hpmE3cB7aPTCVrD6hIT2GO/ldiCDR+0NvtUILYdrmwA7
	a+y1oJq73gJISJ2IX06dDTJqO+JJyCNaJ9ZF2OmVjPGLcOcydrXJ9mw9SvLTdT3MSsLgsz0Aq7S
	GWXgX+tN1qh5vKgTXyg8d6g1DJ5qzlS41y/wEmEjBFOFRgUflUCULQdI6mmSS7LF4wtfj7/x6HY
	1tOhFYFzaRI4OQHOrF5g10kdpn9gFEwYObmLH7jg9OnTofx9lnDvjS2FlgMig9vjrWfKOLigWE4
	DM7094fVCrBxcX4BaWH5rlbnd2bO+UbefDgK4BGbtUHWA3sqUbJCxTvjzSFm9am30cQ==;
From: k8ie <k8ie@mcld.eu>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: =?UTF-8?q?Kate=C5=99ina=20Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: playstation: Support DualSense player LED brightness control
Date: Tue, 14 Jul 2026 20:42:20 +0200
Message-ID: <20260714184225.84646-1-k8ie@mcld.eu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714180424.70662-1-k8ie@mcld.eu>
References: <20260714180424.70662-1-k8ie@mcld.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kateřina Medvědová <k8ie@mcld.eu>

The DualSense's 5 player indicator LEDs are currently only exposed as
plain on/off LED classdevs (max_brightness = 1). The controller
firmware also supports a global brightness level (high/medium/low)
for whichever player LEDs are currently lit. The driver already
defines the brightness byte but never uses it
(dualsense_output_report_common::led_brightness).

This patch wires up the controls for the brightness byte, allowing
the player indicator brightness to be adjusted.

Increase max_brightness of each player's LED classdev from 1 to 3.

brightness = 0 still turns an LED off, writing brightness = 1..3
turns the LED on and applies the brightness to all lit player LEDs.
This is a hardware limitation and the driver reflects that by
keeping the sysfs brightness of player LEDs in sync. The last
brightness write wins.

The firmware encoding is inverted (lower is brighter), so map LED
core brightness values to the device-specific encoding before
sending reports.

Also set DS_OUTPUT_VALID_FLAG2_LED_BRIGHTNESS_CONTROL_ENABLE
whenever player LED state is updated so firmware applies the
brightness byte.

Existing userspace that writes brightness=1 as a simple "on" value
continues to work, but LEDs will now be lit at the lowest brightness
instead of the highest brightness.

Tested on a DualSense controller (product ID 0x0ce6) using Bluetooth
and USB.

Assisted-by: OpenCode:claude-sonnet-5
Signed-off-by: Kateřina Medvědová <k8ie@mcld.eu>
---
First-time contributing a patch.

v1 -> v2: Fixed a data race flagged by the list's automated review bot:
dualsense_player_led_get_brightness() read player_leds_state and
player_leds_brightness without holding ds->base.lock, while the setter
updates both fields together under that lock. Now takes the same lock
in the getter.

The bot also flagged a pre-existing missing cancel_work_sync() in the
dualsense_create()/dualshock4_create() error paths. That is unrelated
to this change (present before this patch) and is intentionally left
unfixed.
---
 drivers/hid/hid-playstation.c | 50 +++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f9dc9378cf77..58786117ec01 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -164,11 +164,20 @@ struct ps_led_info {
 #define DS_OUTPUT_VALID_FLAG1_AUDIO_CONTROL2_ENABLE		BIT(7)
 #define DS_OUTPUT_VALID_FLAG2_LIGHTBAR_SETUP_CONTROL_ENABLE	BIT(1)
 #define DS_OUTPUT_VALID_FLAG2_COMPATIBLE_VIBRATION2		BIT(2)
+#define DS_OUTPUT_VALID_FLAG2_LED_BRIGHTNESS_CONTROL_ENABLE	BIT(0)
 #define DS_OUTPUT_AUDIO_FLAGS_OUTPUT_PATH_SEL			GENMASK(5, 4)
 #define DS_OUTPUT_AUDIO_FLAGS2_SP_PREAMP_GAIN			GENMASK(2, 0)
 #define DS_OUTPUT_POWER_SAVE_CONTROL_MIC_MUTE			BIT(4)
 #define DS_OUTPUT_LIGHTBAR_SETUP_LIGHT_OUT			BIT(1)
 
+/*
+ * Player LED brightness levels. Lower values are brighter; this is inverted
+ * from the LED subsystem's convention where higher values mean brighter.
+ */
+#define DS_OUTPUT_PLAYER_LED_BRIGHTNESS_HIGH			0
+#define DS_OUTPUT_PLAYER_LED_BRIGHTNESS_MEDIUM			1
+#define DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW			2
+
 /* DualSense hardware limits */
 #define DS_ACC_RES_PER_G	8192
 #define DS_ACC_RANGE		(4 * DS_ACC_RES_PER_G)
@@ -225,6 +234,7 @@ struct dualsense {
 	/* Player leds */
 	bool update_player_leds;
 	u8 player_leds_state;
+	u8 player_leds_brightness;
 	struct led_classdev player_leds[5];
 
 	struct work_struct output_worker;
@@ -1219,12 +1229,24 @@ static int dualsense_lightbar_set_brightness(struct led_classdev *cdev,
 	return 0;
 }
 
+/*
+ * The DualSense's player LEDs only support a single, shared brightness level
+ * for all lit LEDs -- there is no per-LED brightness control. We still expose
+ * per-LED on/off state plus 3 brightness levels through each LED classdev's
+ * max_brightness of 3; the last value written by any player LED classdev sets
+ * the shared level for all of them.
+ */
 static enum led_brightness dualsense_player_led_get_brightness(struct led_classdev *led)
 {
 	struct hid_device *hdev = to_hid_device(led->dev->parent);
 	struct dualsense *ds = hid_get_drvdata(hdev);
 
-	return !!(ds->player_leds_state & BIT(led - ds->player_leds));
+	guard(spinlock_irqsave)(&ds->base.lock);
+
+	if (!(ds->player_leds_state & BIT(led - ds->player_leds)))
+		return LED_OFF;
+
+	return DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW + 1 - ds->player_leds_brightness;
 }
 
 static int dualsense_player_led_set_brightness(struct led_classdev *led, enum led_brightness value)
@@ -1235,10 +1257,18 @@ static int dualsense_player_led_set_brightness(struct led_classdev *led, enum le
 
 	scoped_guard(spinlock_irqsave, &ds->base.lock) {
 		led_index = led - ds->player_leds;
-		if (value == LED_OFF)
+		if (value == LED_OFF) {
 			ds->player_leds_state &= ~BIT(led_index);
-		else
+		} else {
 			ds->player_leds_state |= BIT(led_index);
+			/* Convert Linux brightness (1=dimmest) to firmware
+			 * scale (0=brightest), clamping to the valid range.
+			 */
+			value = clamp_t(enum led_brightness, value, 1,
+					 DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW + 1);
+			ds->player_leds_brightness =
+				DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW + 1 - value;
+		}
 
 		ds->update_player_leds = true;
 	}
@@ -1355,6 +1385,10 @@ static void dualsense_output_worker(struct work_struct *work)
 				DS_OUTPUT_VALID_FLAG1_PLAYER_INDICATOR_CONTROL_ENABLE;
 			common->player_leds = ds->player_leds_state;
 
+			common->valid_flag2 |=
+				DS_OUTPUT_VALID_FLAG2_LED_BRIGHTNESS_CONTROL_ENABLE;
+			common->led_brightness = ds->player_leds_brightness;
+
 			ds->update_player_leds = false;
 		}
 
@@ -1742,15 +1776,15 @@ static struct ps_device *dualsense_create(struct hid_device *hdev)
 	int i, ret;
 
 	static const struct ps_led_info player_leds_info[] = {
-		{ LED_FUNCTION_PLAYER1, "white", 1, dualsense_player_led_get_brightness,
+		{ LED_FUNCTION_PLAYER1, "white", 3, dualsense_player_led_get_brightness,
 				dualsense_player_led_set_brightness },
-		{ LED_FUNCTION_PLAYER2, "white", 1, dualsense_player_led_get_brightness,
+		{ LED_FUNCTION_PLAYER2, "white", 3, dualsense_player_led_get_brightness,
 				dualsense_player_led_set_brightness },
-		{ LED_FUNCTION_PLAYER3, "white", 1, dualsense_player_led_get_brightness,
+		{ LED_FUNCTION_PLAYER3, "white", 3, dualsense_player_led_get_brightness,
 				dualsense_player_led_set_brightness },
-		{ LED_FUNCTION_PLAYER4, "white", 1, dualsense_player_led_get_brightness,
+		{ LED_FUNCTION_PLAYER4, "white", 3, dualsense_player_led_get_brightness,
 				dualsense_player_led_set_brightness },
-		{ LED_FUNCTION_PLAYER5, "white", 1, dualsense_player_led_get_brightness,
+		{ LED_FUNCTION_PLAYER5, "white", 3, dualsense_player_led_get_brightness,
 				dualsense_player_led_set_brightness }
 	};
 
-- 
2.55.0

