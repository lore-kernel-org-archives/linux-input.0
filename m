Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AA40DFD8;
	Sat, 11 Apr 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775921600; cv=none; b=obCcWymyVHCKoKxGeNFIguu8ZnpgQ9YdwRq+uJYgEioVPuNkKUC9E2RbqtQnBUogmLwJkF81Ycfug4bKJkXnomRdsAWa35lbacAP5uqgNNZUji9LfbET9CjmyRG8ORLEh/PAlJe8vuGenyx2/pKoae/L59MBvGzN4X6yk6IPDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775921600; c=relaxed/simple;
	bh=hKnG7YEz8twLoKoiqnsDDsFZ99hiroqZVQhCgMTVr/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eErLajbOSjfo9DJqqo8eRAOzAST/FvaAI3accVpmIuBmcfZaYQW2+wPOz7xrAxq53Hx3BkXo+/m7iAgx1hXmcbiXDwavvKzIr644Lwkmwk8ZAaFk3TXLkLLd98lCDCk3E0kmwncedLnbn9FEE5hMrSsIjAEySrgmBiNtkwf2MLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZKtzR/cf; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=H57m62A2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZKtzR/cf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H57m62A2"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ftHkF5JWLz9tyB;
	Sat, 11 Apr 2026 17:33:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775921589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wp7ov9E0eXvoHvzGnuCMsReljQX483lKQhsUd3UUZm8=;
	b=ZKtzR/cfYzEyxycxCSL6lwqXDw6tVf6qM5dBWEBafwYPOPutFcl09SGRWj84VNTidCC289
	98Pf5lCvfxBdLWnGAM7ZX3MkbUsNKxWq+DIpSRZhJ8SxF0lv6d03bz57w3lHsPBLO+TAIt
	CK3OejZDJ4IYswuT3WjY+Mkn6EuYb+1s8kxRj6GqKV2C5KSP8pn3mOSkZ0cDXTni9Pl/aF
	yHsFw6reD87yxyQlyFzWzDQyO+G49AVD5ihTuCW3wRIKdJzGiDL2x2tqMXTU8yNB99QZNE
	MWhW/zsVdoiAUwWRKGEN6KX7w43/E/d7L9VFG/BJk7bP9GW5WjPo9+/sLNqnjA==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775921588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wp7ov9E0eXvoHvzGnuCMsReljQX483lKQhsUd3UUZm8=;
	b=H57m62A2MfrZ8lkNMO1vR+Rp6YPRAeIASfuRQSjTxTWkwEiAFOcp8bBzjWuPM5yyOqrKxO
	vEx1PYGFIy7jDreZy5PCCDl08QrH5oG3x3VFS7RHrasQ7N43DOmw7UyhGErog4Gz4NPeom
	CpujPh5Ewwd63/qBpw9695lO/015xjjLyqX174WQhDtMF8D5ObMM/Hxe94+6s36s1RjrdL
	7O5Y8WdnQlu9J2YDoEtKKpK/Zs+9wbu7JegXsHlLZMqdfQf65Ym1a8wzB0yl3+/vIhkE2U
	XJEpPvu2C8RlvRQQwdH2xKR32dtcprxUGJ6HQyTpo2NHVWRXTgcV2LQ5gS1kYQ==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: remove unneeded WARN_ON() in sony_leds_init()
Date: Sat, 11 Apr 2026 17:32:48 +0200
Message-ID: <20260411153247.5920-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7bsg7yfihxeat1gmoi3nh734zchdtekb
X-MBO-RS-ID: 3ae6172e0352108c08c

This commit removes the unneeded WARN_ON() macro usage in
sony_leds_init(), this is unneeded because the sony_leds_init() function
call is already gated behind a SONY_LED_SUPPORT check in
sony_input_configured()

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 23db406092ef..6a860b9ef677 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1640,9 +1640,6 @@ static int sony_leds_init(struct sony_sc *sc)
 	u8 max_brightness[MAX_LEDS] = { [0 ... (MAX_LEDS - 1)] = 1 };
 	u8 use_hw_blink[MAX_LEDS] = { 0 };
 
-	if (WARN_ON(!(sc->quirks & SONY_LED_SUPPORT)))
-		return -EINVAL;
-
 	if (sc->quirks & BUZZ_CONTROLLER) {
 		sc->led_count = 4;
 		use_color_names = 0;
-- 
2.53.0

