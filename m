Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7F369990
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497343; cv=none; b=FjIk/K2hs19tH1cQ2MYuMI8XiHcE6z7hFzckmpVduwgHwVw9c3rtmh1d7FbnHu4u9o92QQgL8kJqAdvo4SZrf7jVpiBq2Ev8qPwQfeO3JbjESRi/lcRMZ/ek7S6CHExrdGqHrVgb5s8NYVv5P1eLOWQo4rg9Tg9Gjakuw/68lzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497343; c=relaxed/simple;
	bh=Vj6X975IgaSjDwkr2598zWC9d57Mp0X49Av8oQVyhbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwE04NWtBjJley9dzfRKPhb9Yp7acer+brqEm+CHfmttCxSvWJ04HC0l4KFlAjyyWuAUUVSgXzCOMK4lL70zmdyKotozyeLTwYaLMmWtk9QJ27aZl0sqSPbw1u7+Rje+oOjn8UHoPDoicKEJbabYG3s9SsRO2LAmIwUHEldkivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=MEa9mGud; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="MEa9mGud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786497334; bh=Vj6X975IgaSjDwkr2598zWC9d57Mp0X49Av8oQVyhbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEa9mGud8+DKT5VGq/INEkoN5FUplYQrNmLGFk+b93UjzKM4gPnPqFiCLPvDUPMjj
	 b7876PSM26weR7X6pS4ieX5ic4bAPCYJ2p2/i1FSJCQm5t55AKv2XqkOgIQ4TMNlyT
	 OtgYC+DNkGq0mR/fFnpka+RA54ClXavCPIJeDeK4lzo/sL2tFVagtvGd8o6c0ra6eq
	 NZixO7Dd6cTelBaz6R7Vv9Nczk7LcARNKndfsJ6XZd+8WiZfOMZ+9isikab33dQ1Y+
	 EEsoJv6F8C/nnIO3s5viqy61+TDVYQ7GAoUnrzJSOa6++x6IBfne0MAyOpj4d+JGXk
	 BtoAKd8DSIdNA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 81723A0AD;
	Tue, 11 Aug 2026 18:15:34 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 6/6] HID: steam: Zero out inputs when disabling gamepad mode
Date: Tue, 11 Aug 2026 18:13:57 -0700
Message-ID: <20260812011401.3250968-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812011401.3250968-1-vi@endrift.com>
References: <20260812011401.3250968-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When gamepad mode is disabled the gamepad input devices will stop receiving
updates. However, in the case where there are buttons still pressed this
will appear as an indefinitely-held button. Instead we should zero out the
inputs to make it look like things are all released. We do the same thing
for gyroscope inputs to make sure it doesn't look like it's endlessly
rotating, but we freeze the accelerometer input since zero isn't a neutral
input on the surface of the Earth.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 78 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 7bb892972447..ac08cb2d0368 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1501,13 +1501,83 @@ static void steam_mode_switch_cb(struct work_struct *work)
 	client_opened = steam->client_opened;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
-	guard(mutex)(&steam->report_mutex);
 	hid_dbg(steam->hdev, "%s: switching gamepad mode to %i\n", __func__, gamepad_mode);
-	if (gamepad_mode)
+	if (gamepad_mode) {
+		guard(mutex)(&steam->report_mutex);
 		steam_set_lizard_mode(steam, false);
-	else if (!client_opened)
-		steam_set_lizard_mode(steam, lizard_mode);
+	} else {
+		struct input_dev *input;
+		struct input_dev *sensors;
+
+		if (!client_opened) {
+			guard(mutex)(&steam->report_mutex);
+			steam_set_lizard_mode(steam, lizard_mode);
+		}
+
+		/*
+		 * Zero out inputs so it doesn't look like we're holding
+		 * anything indefinitely.
+		 */
+		guard(spinlock_irqsave)(&steam->lock);
+		rcu_read_lock();
+		input = rcu_dereference(steam->input);
+		if (likely(input)) {
+			input_report_key(input, BTN_TR2, 0);
+			input_report_key(input, BTN_TL2, 0);
+			input_report_key(input, BTN_TR, 0);
+			input_report_key(input, BTN_TL, 0);
+			input_report_key(input, BTN_Y, 0);
+			input_report_key(input, BTN_B, 0);
+			input_report_key(input, BTN_X, 0);
+			input_report_key(input, BTN_A, 0);
+			input_report_key(input, BTN_DPAD_UP, 0);
+			input_report_key(input, BTN_DPAD_RIGHT, 0);
+			input_report_key(input, BTN_DPAD_LEFT, 0);
+			input_report_key(input, BTN_DPAD_DOWN, 0);
+			input_report_key(input, BTN_SELECT, 0);
+			input_report_key(input, BTN_MODE, 0);
+			input_report_key(input, BTN_START, 0);
+			input_report_key(input, BTN_THUMBR, 0);
+			input_report_key(input, BTN_THUMBL, 0);
+			input_report_key(input, BTN_THUMB, 0);
+			input_report_key(input, BTN_THUMB2, 0);
+			input_report_key(input, BTN_GRIPL, 0);
+			input_report_key(input, BTN_GRIPR, 0);
+
+			input_report_abs(input, ABS_X, 0);
+			input_report_abs(input, ABS_Y, 0);
+			input_report_abs(input, ABS_RX, 0);
+			input_report_abs(input, ABS_RY, 0);
+			input_report_abs(input, ABS_HAT0X, 0);
+			input_report_abs(input, ABS_HAT0Y, 0);
+			input_report_abs(input, ABS_HAT2Y, 0);
+			input_report_abs(input, ABS_HAT2X, 0);
+
+			if (steam->quirks & (STEAM_QUIRK_DECK | STEAM_QUIRK_IBEX)) {
+				input_report_key(input, BTN_BASE, 0);
+				input_report_key(input, BTN_GRIPL2, 0);
+				input_report_key(input, BTN_GRIPR2, 0);
+
+				input_report_abs(input, ABS_HAT1X, 0);
+				input_report_abs(input, ABS_HAT1Y, 0);
+			}
+
+			input_sync(input);
+		}
+		sensors = rcu_dereference(steam->sensors);
+		if (likely(sensors)) {
+			/* Skip accelerometers since 0 isn't a neutral input */
 
+			input_report_abs(sensors, ABS_RX, 0);
+			input_report_abs(sensors, ABS_RY, 0);
+			input_report_abs(sensors, ABS_RZ, 0);
+
+			input_sync(sensors);
+		}
+		rcu_read_unlock();
+	}
+
+	guard(mutex)(&steam->report_mutex);
 	steam_haptic_pulse(steam, STEAM_PAD_RIGHT, 0x190, 0, 1, 0);
 	if (gamepad_mode) {
 		steam_haptic_pulse(steam, STEAM_PAD_LEFT, 0x14D, 0x14D, 0x2D, 0);
-- 
2.54.0

