Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945825782D;
	Sun, 12 Apr 2026 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956338; cv=none; b=NbMu9jM9qmJDDPsF8jmQGAzNq4S2hX0BMViZZ/hLeepnEQ7/+RALXl9p5HuE6a764FuvFS8PvvXRP1kNlWteQ6k1FgQAw0m5DOICdm9OKhINfcaEj+ow1uR0ZH+IUhDaDGaKf+FY2eWsQJBrVODRcPNkAi+Gr/Q4d7n3FlxOen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956338; c=relaxed/simple;
	bh=Uoz9pIQf+C+y7d5Pxx8P1fMdWPvQ4rYe7XWTR1G5uio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aws1VMYDwaJfrPHK5RUl43bMu9xbGNcOT97Cw4sQdlrX++/9XQXmD8/L7LBG6csjAx/9VXDt7YqWNfDuLREsP4T2vlVO1A14UpTSKGX8MN5UEIC9xpuW8LS1stDwKJvfzx83BrG7JoxnZla6nleHO0XqHD3jv2cLgYn/zLFqYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XDAdNKHj; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PYcdWfmZ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XDAdNKHj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PYcdWfmZ"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ftXZR1GyVz9vGN;
	Sun, 12 Apr 2026 03:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775956335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=arFcDsdNir76EYWDBL5/u724SrpapY2XhrYEStdWqM4=;
	b=XDAdNKHj5+U0LiafmJUcJWye6hE3bsNLI4hut30TEaNXnQr8RBjYDCMoo7mDPnh34l+hRB
	ZhpLlWtl9FAq9gfwRGLELbR55kfPRWQFVzTKfBV4s2smzm2XtFWQYeMvNXsZFgt4UcjnIp
	WNKUytmaGWbpQPtWSqFHYEwr5/QriJQrTHn35HNIvbFlU+7dfcSxIVt10bWWc460FWBn2O
	09z0id9ssvwMr4bo02Fb9bXCGyym/wfjtzDKNwTUFjdbqzdIZRZOB375oK9aBLMFRIkQhg
	QJ2wUX2UZ/hYhvqfZy9g917itXgCsa8m6yOQ1MMi1TCVmGqyPu6S9JdlbD/sXw==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775956333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=arFcDsdNir76EYWDBL5/u724SrpapY2XhrYEStdWqM4=;
	b=PYcdWfmZLhEN9Bx1N0BRsSzZprilZXrZdSX+CqgUlYofdHIzjAwMFpBtJiyFE0RV8ogIhS
	Hmeqir7FiHDSueJLMqpV+7uJ5RqOKxpQPkMSV6D11QqGHa/XuKlh+u9gKjZm8dtsNMEfcy
	mUDlDoEDUATEAXfOL8Co6MMAnJUmcId/zhBMjC4IoY8Wk3LBbkmkQEfrAepuokSx2zum7x
	lWNjXnAZxU2HpLYRu/OSECbxyhQ+d0ZU3ssEWXAtbzjTXMxbn84pdvjppDZa6ysPBSoDjJ
	AuU2jKo6CZ/4jCm4q7o2BDlSm8hlb4aBAm8MbvN6wTR163GObM0J5kTOBFuNEw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: add missing size validation for Rock Band 3 Pro instruments
Date: Sun, 12 Apr 2026 03:12:03 +0200
Message-ID: <20260412011203.8921-1-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iukfckmadq6sne9xq3dbb3sjrniuteq6
X-MBO-RS-ID: d28d9c8182036dc860e

This commit adds the missing size validation for Rock Band 3 PS3 Pro
instruments in sony_raw_event(), this prevents a malicious device from
allowing hid-sony to read out of bounds of the provided buffer.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2260d55a17b0..e75246d29e16 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1188,7 +1188,7 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 	/* Rock Band 3 PS3 Pro instruments set rd[24] to 0xE0 when they're
 	 * sending full reports, and 0x02 when only sending navigation.
 	 */
-	if ((sc->quirks & RB3_PRO_INSTRUMENT) && rd[24] == 0x02) {
+	if ((sc->quirks & RB3_PRO_INSTRUMENT) && size >= 25 && rd[24] == 0x02) {
 		/* Only attempt to enable full report every 8 seconds */
 		if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
 			sc->rb3_pro_poke_jiffies = jiffies + secs_to_jiffies(8);
-- 
2.53.0

