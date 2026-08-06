Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2653B71B5
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983310; cv=none; b=TsIZJgjK+dZ9or+oCqI5/f4GTuZ+a04C4BA5mbQi3C+INiHUMEQlQD2jjIkT6lYyb3DcCxpfRHZwC+uvtQfmqRWwZjBDnuxa7E8sg4/v10fA/1Q/MCgaYJ2+xweaycscqqyt/4Ds0vYuyYiIZPY1EuxKoeDqr64YkptH5uJIjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983310; c=relaxed/simple;
	bh=C35+bNPqhQFVsbUZX10MTLGRc4LG4pqboty1Xj1rkTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr/B+R4qsxFb4JDu8fUFCxZiiVY7u/VdOglElL2JVA1MTR2IqgfzWEX9VJ2KGRpZ+7+91DK4AhSNz1xdekI2auEM0JSOYY5KFfRtIaSD1BbJ2Hlp91myzjip/pDCsfvnlzOSGeWHkeqrIk1r5DzDGJfNiJNCtc+GWvcsiPIxQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=fZXep2oL; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="fZXep2oL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785983302; bh=C35+bNPqhQFVsbUZX10MTLGRc4LG4pqboty1Xj1rkTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZXep2oLdGBtWylUVx0ygcTYmmOSpS36u+HG2Rc1hanX/ePJfpHSXhY2N2MEnUqOW
	 Cww7A5WEd4Catde28Bez+PtZoBSVpESJX8N458kHJG3OmcHNflXnWWmHmqE4zNcJxo
	 dlVyYobqJfYLAweAHypfrMBhqt6JK3/b2H16JUjRkT9eFW5nPf9vEkEXyOO8ECoC3u
	 gxDPPE2TbJli8iLbIX+l2yUYPCck4+/wjt8EZ3MPDPA+RMK41dx9vS+Gs5102iD1rr
	 7TI//bN90zTOIeqhW5NXM4Adal98HEygIRiJ/GvxuTBiZpTPFwq9M0Od9K0XKoGDzX
	 QmOSQBruA5tkQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 6D4D2A278;
	Wed, 05 Aug 2026 19:28:22 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v2 6/6] HID: steam: Zero out inputs when disabling gamepad mode
Date: Wed,  5 Aug 2026 19:26:45 -0700
Message-ID: <20260806022653.93939-7-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806022653.93939-1-vi@endrift.com>
References: <20260806022653.93939-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 69 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 01801f2a5886..0c159ae7bf1a 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1498,11 +1498,76 @@ static void steam_mode_switch_cb(struct work_struct *work)
 
 	guard(mutex)(&steam->report_mutex);
 	hid_dbg(steam->hdev, "%s: switching gamepad mode to %i\n", __func__, steam->gamepad_mode);
-	if (gamepad_mode)
+	if (gamepad_mode) {
 		steam_set_lizard_mode(steam, false);
-	else {
+	} else {
+		struct input_dev *input;
+		struct input_dev *sensors;
+
 		if (!client_opened)
 			steam_set_lizard_mode(steam, lizard_mode);
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
+
+			input_report_abs(sensors, ABS_RX, 0);
+			input_report_abs(sensors, ABS_RY, 0);
+			input_report_abs(sensors, ABS_RZ, 0);
+
+			input_sync(sensors);
+		}
+		rcu_read_unlock();
 	}
 
 	steam_haptic_pulse(steam, STEAM_PAD_RIGHT, 0x190, 0, 1, 0);
-- 
2.54.0

