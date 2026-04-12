Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4613D8B1;
	Sun, 12 Apr 2026 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956119; cv=none; b=S11GD4rrPIFoAvf3QNh5jcL4qzkBACpFNyWpV+weG4Z0wp8oCQUtUA0hIhZWyi7ywLDKM3MZq8MEPrHGpZ8DDR7pOVqhr1R3DS9D8chzpcJ2pT81F+IVF028ORsjx0Kmb0aIY3Zp40nW22u6XjVcAI6jkqYHu4C0cZ7Y0FlctPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956119; c=relaxed/simple;
	bh=irYzm9zg/r1VtwkaWnFgScITlJEAbv7tO4oJGy47aSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLcDsmCdvGWxBNenimHE4QzTPtqGYBYSKKAyezhcKEn/2wqj3dyWuvcQnpIJcerDeteMCsJEwR2BsViTafMGNiiTHCcGE8gtcUvmzvvYyPDqSIfHbBGTA+2XZL921HVlDkZgH/HPMRCKBQxg0aTwkhhIM4JZ1YuGCAjb/Gq+37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DClkDs6S; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=blDQ6A7Y; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DClkDs6S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="blDQ6A7Y"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ftXV45Z7mz9tB8;
	Sun, 12 Apr 2026 03:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775956108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x/RGDKBWf0NclOC6XzYkf1cYXDq5sy1C+yoIf4Qx9/k=;
	b=DClkDs6SHUQw3w4WYEIYjLcot/ZQt+3VbMCC1+tyInI4MSleyEAP4q9nqWGlj5ahFc1Wui
	HLir/rJE7VxDRD2B96ermHVG0T2Lwrp/6APxGHsnrjPFnLSXEE9Y/zqCovzKwfbK1cFWTw
	Q8Qd/3TR7aL1o/vUcobKTyHQPyeTyWwIW1McD3MnsvCxhM7mjgzoNyFqr6SYv0z8jTOCnD
	qdcDvsUI76NdKt8TEtuS3y6mqjqxTJdZKIABUuLWl2TXrOWuZcsC4Ce2T/dN2yjo0yvHCy
	cGREJ+lT6uNZL2a/xKFc2Ha4BQ6/sDF/57GEbHqamtGOyVj0JwIdSgqv61CVtg==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775956107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x/RGDKBWf0NclOC6XzYkf1cYXDq5sy1C+yoIf4Qx9/k=;
	b=blDQ6A7YaYdU441nJShavfphKtf2a2Ngty2/5c8Osde7XDucq/z2BEh8rYu6ovpXhB5+Tn
	d26YXIkXERd8ulht8h/t3BR4viUXBcqg8+ajKX/UWDt5WkOevX0lFpvHY9Lsd2y+2IJCOW
	FeCSkbg9ebUN3l9WTkpre2aXPR7xW1N0ZKHSb93/Y7aMCoJVLMaVer0xYz7KssMz8+E4q1
	G9t4r1J3x88BGmc8YXIcaW8VRxp8H9AcwK89DJvysCJwk+Ho0TcMPlxdgqo8oDuXAZSEI7
	Y27dRbjstla/dbOIiw63FjxsMM2zWPQ/yzH5f7vXIwCm+QuaVa7TzYe3uxNE3A==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: add missing size validation for SMK-Link remotes
Date: Sun, 12 Apr 2026 03:08:06 +0200
Message-ID: <20260412010806.7997-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 470ae6ac2bb18dde24f
X-MBO-RS-META: 4i1oupe8ns55jhnke3jnueyxzoqbk7ns

This commit adds the missing size validation for SMK-Link remotes in
sony_raw_event(), this prevents a malicious device from allowing
hid-sony to read out of bounds of the provided buffer.

I do not own these devices so the size check only forces that the buffer
is large enough for nsg_mrxu_parse_report().

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ad394ac57fa5..2260d55a17b0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1169,10 +1169,9 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		sixaxis_parse_report(sc, rd, size);
 	} else if ((sc->quirks & MOTION_CONTROLLER_BT) && rd[0] == 0x01 && size == 49) {
 		sixaxis_parse_report(sc, rd, size);
-	} else if ((sc->quirks & NAVIGATION_CONTROLLER) && rd[0] == 0x01 &&
-			size == 49) {
+	} else if ((sc->quirks & NAVIGATION_CONTROLLER) && rd[0] == 0x01 && size == 49) {
 		sixaxis_parse_report(sc, rd, size);
-	} else if ((sc->quirks & NSG_MRXU_REMOTE) && rd[0] == 0x02) {
+	} else if ((sc->quirks & NSG_MRXU_REMOTE) && rd[0] == 0x02 && size >= 12) {
 		nsg_mrxu_parse_report(sc, rd, size);
 		return 1;
 	} else if ((sc->quirks & RB4_GUITAR_PS4_USB) && rd[0] == 0x01 && size == 64) {
-- 
2.53.0

