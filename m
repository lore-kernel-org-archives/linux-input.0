Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA83A254D
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894792; cv=none; b=pjkM6T3LymP4DPyluDILiO0nOEj/4VDJb0XXFXHDHyL0Hc18F7pRNg5oN/AAbxizgOBMxgxM1CvPrzFTUkL5HElB5JBiC+jFRsbXiW9CtRPFKjQaaoktpQJIDyKze30ltSbPMiVcg+0RAG8G23hpzFS7PDgKZvf18+QqaA/VJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894792; c=relaxed/simple;
	bh=CTo0pA1655RH47i5iy0FDOaLQn7iTjjTf2ACl7U6Lxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbfLimMFr2bpesBowAMipw0TOu8Yq3h2mUUwWJWWiRjV8suqxL6LSstBhxslJBfBZGXadlsJNbcd0YIGRStuo+e7UqyzxmC07SjxdV8aETQ/H9g9MTgTQ/5mgR9H6V1vm3GV5fg0Trp+xGOpN15zJw6lrIGCHZUdNqnfmkXre5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=02ys4eDt; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="02ys4eDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785894770; bh=CTo0pA1655RH47i5iy0FDOaLQn7iTjjTf2ACl7U6Lxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=02ys4eDtVfG2ACFPmdjyvvTci62ogA4VBC3l+EDVBCLw8xM4xckJjtdN4zPknJmK0
	 06DI6NVFe54rPs/w0lavrqgBQZ4Ar5+azW1fqtnvnnfwT7u/uCCT0GrW0l/7yYmwg6
	 caaMFwWf2GEsXt2Xma3/ZXtxK84MF1voaaXH18lUGI2cOb6WG/0gfQuJTAoOFVT+nZ
	 AMJkz5ZrW+JGpOraTEV4zG+ybGIaAOZaQdnr9bCl1vco9tXa9hKqAZ667jwM9vhPKH
	 2FBcErnL1GxJC53nJtFb95l4ivsdFd1wCAFEqUyIqrHqFQk5jQ+pbKgY3zzhBS9Dx1
	 AaOLCO9YqcN+g==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 1ECCCA278;
	Tue, 04 Aug 2026 18:52:50 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 5/5] HID: steam: Zero out inputs when disabling gamepad mode
Date: Tue,  4 Aug 2026 18:51:06 -0700
Message-ID: <20260805015116.3884465-6-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805015116.3884465-1-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
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
index 87af4bee9f5f..93a6f4e17fb7 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1490,11 +1490,76 @@ static void steam_mode_switch_cb(struct work_struct *work)
 
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

