Received: from mail.mcld.eu (mail.mcld.eu [84.242.69.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA33C1087;
	Tue, 14 Jul 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.242.69.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052284; cv=none; b=J95lLfDTEyjER69xlrgU6NOKme6kR1rWS2Um4zQ24mvuMgh/qztJCyum88Mm2TWOk/exb8d+d5pJBt+LcH5BBdixeu541kA6a/uyHyxE8q/0bSmT+4xVGZ/LyQ90z6JHbdz/yBM+m3+oG+dE38TuKcmoF6n5FAFLqV1ePDyfoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052284; c=relaxed/simple;
	bh=JeB7hZ5wsNk4Pc1WDbNXKRPkUWweCWFHX7b+kUAM+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdUhKlrgnsQS5mxpr21fuAngDibNh4+ENMHC1smVg4QFrdJTIWGdWz2rmLOKHyy0dt055uHuNz/B8Ri8AWJYD6Uq+hODmdNYpbpeTRHKBZF1UyG0idgu4qzCfYgd/cS/DeL9L11pMChMc8F2e8VUoVvWNourQ4IV9wqt1dMfRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu; spf=pass smtp.mailfrom=mcld.eu; dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=Dz/Tcm/E; dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=U6kzD3AF; arc=none smtp.client-ip=84.242.69.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcld.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="Dz/Tcm/E";
	dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="U6kzD3AF"
DKIM-Signature: v=1; a=ed25519-sha256; s=202501e; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1784052270; bh=wbR9tzxT2unaUzA8ZIS03fH
	EwQ75mYxjEEbi+5Cqxzk=; b=Dz/Tcm/EnbKsMQdJCD/suL4UKGE3W1InNBbx0hPhX+DndLMDnb
	vhg6crQzzcra1qqNPj2VuJU6CDyXL3L9NqDA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202501r; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1784052270; bh=wbR9tzxT2unaUzA8ZIS03fH
	EwQ75mYxjEEbi+5Cqxzk=; b=U6kzD3AFO9l71EXqq10fGNIhRLWWzakv08HKlyfC0esUxaUGeE
	GuK5XQZ5jXdjh3ygodph1XfSyCoEnORvwQ6hj1uA5AwYD84eG/q3WHl6Exmc2sTjqu65sOiuVUG
	iLE4nTvKBxFyQi0mEo51LDzNXzGpE/FGSSdwPH2yntMraGB0aJs8GG6z/9iPIHOP4Wobl6DmDdO
	aspyilz3WCEnLeMON7IJc0UwhhkEDtn6oCpJv0L/QLy1AAwFgNCft0haNlLuPr0bqkWcDTal1W2
	mWi0gqekeWgcUB4fVNHFPnVNpj1kq+20maJWUq/2TGMmULWyc8BYUeibR/lhoUASTrw==;
From: =?UTF-8?q?Kate=C5=99ina=20Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: =?UTF-8?q?Kate=C5=99ina=20Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: playstation: Support DualSense player LED brightness control
Date: Tue, 14 Jul 2026 20:04:23 +0200
Message-ID: <20260714180424.70662-1-k8ie@mcld.eu>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/hid/hid-playstation.c | 48 +++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f9dc9378cf77..78e43a176248 100644
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
@@ -1219,12 +1229,22 @@ static int dualsense_lightbar_set_brightness(struct led_classdev *cdev,
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
+	if (!(ds->player_leds_state & BIT(led - ds->player_leds)))
+		return LED_OFF;
+
+	return DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW + 1 - ds->player_leds_brightness;
 }
 
 static int dualsense_player_led_set_brightness(struct led_classdev *led, enum led_brightness value)
@@ -1235,10 +1255,18 @@ static int dualsense_player_led_set_brightness(struct led_classdev *led, enum le
 
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
@@ -1355,6 +1383,10 @@ static void dualsense_output_worker(struct work_struct *work)
 				DS_OUTPUT_VALID_FLAG1_PLAYER_INDICATOR_CONTROL_ENABLE;
 			common->player_leds = ds->player_leds_state;
 
+			common->valid_flag2 |=
+				DS_OUTPUT_VALID_FLAG2_LED_BRIGHTNESS_CONTROL_ENABLE;
+			common->led_brightness = ds->player_leds_brightness;
+
 			ds->update_player_leds = false;
 		}
 
@@ -1742,15 +1774,15 @@ static struct ps_device *dualsense_create(struct hid_device *hdev)
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

