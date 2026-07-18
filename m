Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7C34889F
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387573; cv=none; b=uF4ks3zJgCtZftjXDwGvjsJwZ3yXfolm9obWKGi12xmWA/44nJ5ubyNv1u5X2jJcGvIHbd6NnBxgArQRDbYviWMnELZyDKKcpRgkUk/tl3UJ0dVKeyHLHBrhcus17mxFYRpbQtPeHkZz2odlrnU5dIoQzLfY/6vmUJ0AdqIi+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387573; c=relaxed/simple;
	bh=koFL55gn6B93OOiTluw00ero3cvpXqFbFJkOcyhlQYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ik6MqUt5KBKA5MfjTrwUQcMexTgQbthUHIGsZT/JAYdkB/nxyze7z8naSX+vS9L0/2WwVLrmK3dpniPbqtVPqxeP1ZRRzFQrGalFtuMs1xObZsFoJoctXpC0/qtxbG4Oz8p6eKEO3ZayNtWTWpAy8WTxoBfuEXMTfbesx/QQCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=Pv55K5wU; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="Pv55K5wU"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: a0f2919e-9359-416f-9d6c-92581e26999d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1784387570;
	bh=koFL55gn6B93OOiTluw00ero3cvpXqFbFJkOcyhlQYA=;
	h=From:To:Cc:Subject:Date:From;
	b=Pv55K5wU27K+Equ8TgCjZL88duulymLdREPrnDfsCWpBB1vXfAkbrZOntyFP57EP4
	 6CuUYkt98TOfjQL+ixrCEdaQvLggeb2ZXpS5Oqp3MeO/Z5OmRoraoWSDjQWIFzZk0E
	 wjVMdn8L37dLhNgvdGB/kwAOCVZglqU7ae5jAed8Ntu+pecNhOm2qq9CYZBqCnOVsX
	 h73jRIfBBhjNErnXQiUjvTLQjp+osVCqBkA9b91mRQJRfWHtlv6NAO6BF05EuOzdXP
	 EWyru6UNt20G8TaM1UfW+K+8jBUIWp6JdKGg8trI/bZhX16RIZDrozmQmBUlVX2SoY
	 M8pysPuqHfzdw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Paul Pawlowski <paul@mrarm.io>,
	Aun-Ali Zaidi <admin@kodeit.net>,
	Aditya Garg <gargaditya08@live.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH] HID: apple: fix endianness of keyboard backlight reports
Date: Sat, 18 Jul 2026 17:12:41 +0200
Message-ID: <20260718151241.7496-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw reports used by the T2 butterfly keyboard backlight contain
little-endian 16-bit fields. They are currently read and written as native
u16 values, leaving the wire format dependent on host endianness.

We should describe these fields as __le16 and convert them explicitly when
reading the backlight limits and writing the brightness and transition
rate.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260718123641.DA2FF1F000E9@smtp.kernel.org
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/hid/hid-apple.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index bf7dd0fbf249..473b6722938e 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -94,14 +94,16 @@ struct apple_sc_backlight {
 struct apple_backlight_config_report {
 	u8 report_id;
 	u8 version;
-	u16 backlight_off, backlight_on_min, backlight_on_max;
+	__le16 backlight_off;
+	__le16 backlight_on_min;
+	__le16 backlight_on_max;
 };
 
 struct apple_backlight_set_report {
 	u8 report_id;
 	u8 version;
-	u16 backlight;
-	u16 rate;
+	__le16 backlight;
+	__le16 rate;
 };
 
 struct apple_magic_backlight {
@@ -803,8 +805,8 @@ static int apple_backlight_set(struct hid_device *hdev, u16 value, u16 rate)
 
 	rep->report_id = 0xB0;
 	rep->version = 1;
-	rep->backlight = value;
-	rep->rate = rate;
+	rep->backlight = cpu_to_le16(value);
+	rep->rate = cpu_to_le16(rate);
 
 	ret = hid_hw_raw_request(hdev, 0xB0u, (u8 *) rep, sizeof(*rep),
 				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
@@ -848,7 +850,9 @@ static int apple_backlight_init(struct hid_device *hdev)
 	}
 
 	hid_dbg(hdev, "backlight config: off=%u, on_min=%u, on_max=%u\n",
-		rep->backlight_off, rep->backlight_on_min, rep->backlight_on_max);
+		le16_to_cpu(rep->backlight_off),
+		le16_to_cpu(rep->backlight_on_min),
+		le16_to_cpu(rep->backlight_on_max));
 
 	asc->backlight = devm_kzalloc(&hdev->dev, sizeof(*asc->backlight), GFP_KERNEL);
 	if (!asc->backlight) {
@@ -858,7 +862,7 @@ static int apple_backlight_init(struct hid_device *hdev)
 
 	asc->backlight->hdev = hdev;
 	asc->backlight->cdev.name = "apple::kbd_backlight";
-	asc->backlight->cdev.max_brightness = rep->backlight_on_max;
+	asc->backlight->cdev.max_brightness = le16_to_cpu(rep->backlight_on_max);
 	asc->backlight->cdev.brightness_set_blocking = apple_backlight_led_set;
 	asc->backlight->cdev.flags = LED_CORE_SUSPENDRESUME;
 
-- 
2.55.0

