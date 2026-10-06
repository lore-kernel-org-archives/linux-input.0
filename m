Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAA3C76A0;
	Tue,  6 Oct 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283170; cv=none; b=eBLitjgSL3vSvAaiYe39b63IQwSyh9lL1H4tEYzggx2xCwmdqydohGr9Gz93MG+fbtUBigO3s494SlI2/bQjeYzbre2KyjvWoDKGiTUeZD7nZRsKZ4B5RQCU/LQaZZOyAePB6keFrM1GJPUzM3XpH6jZugor6ltpYiH3Ui9IDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283170; c=relaxed/simple;
	bh=gkUr8JO4yHrJeLG/kDrSiVRI4PK52vCrh53FJ4ioEak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QD6JcJpRu52B0kWvGGMzDkIV6X48nzcPV3JRt0FbENuzKSQW2vUIA65kmC3QEfZAUMy1B6UkFrEDIznGvUnrfnL/A0EaEWE8UeI7I0vN9ahWIGQJ5QqsBJQGH3SW9qh2fFGH64m2YJ1WHJsPqXDQRh25Xq0pAsz/DwBtICU8eJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZPOcRAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZPOcRAT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 109B5C2BCF4;
	Tue,  6 Oct 2026 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791283170;
	bh=gkUr8JO4yHrJeLG/kDrSiVRI4PK52vCrh53FJ4ioEak=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kZPOcRATtm70gMk0+FhnoFysVgkQfnPPdZrWy0N3AqLc9s6Jwnv09iZzepT6yzuqU
	 cYqTochqzRI/H5uYBWTsULfLUxDBkqY6UJ8ci6U0tzWSujBIOnWwcgIyWNg/JCCv6s
	 Ary2D8oMzU1zrdKx9ZeAB9h4itYK6p/ZWTVDU8Y6xVvudoCfLipoxc9Z6CH++lOi+0
	 yfu10VxyXIuxcs2uUc1gWoBGztb544i5gt0zXhfhQkR3BIb/zsRjdI4xEtguAcOVlE
	 ax8fC3oFrf8ib/pZCVOr+Sr3hesvbZimU0gcTNu2pLyF1qB3zMjjStWKueO7haC5GN
	 3CxnooeyC08jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E1CA5FFC;
	Tue,  6 Oct 2026 10:39:29 +0000 (UTC)
From: Hans van Essen via B4 Relay <devnull+hans.kilurion.com@kernel.org>
Date: Tue, 06 Oct 2026 12:39:22 +0200
Subject: [PATCH] HID: asus: Resume the device before sending feature
 reports
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-hid-asus-autosuspend-v1-1-0c3df3121063@kilurion.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1gZqwSpzlcFFbaPGRZXGilC8u
 3Vm9fgW788gFJkEPlWGSCcLb6GgqStwiw0zIfti0EqbRimDC3u0kgRtOrayOwWPhrSZ2r7rO+u
 gXPdIE1+/7Hf4W9K4kjveFtz3A+Kq7Ol4AAAA
X-Change-ID: 20261006-hid-asus-autosuspend-6e26f58787ac
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans van Essen <hans@kilurion.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791283169; l=2846;
 i=hans@kilurion.com; s=20261006; h=from:subject:message-id;
 bh=9QfnflIXuuK4jOk4CkZW1MI0rh7BoL+EnE3PHnQPEZM=;
 b=AtXjKp1O0PfU//ZOMoRQLAoKgYF+1v+nFH4i6vT9zEu/0ReaRSS2l8K2cioWMYldKx2pdbT2d
 AZ3MqtBhpVuCYDdCtLWNKfKwzmGZGR9KGHF5K17Nteae9IbLd5CArc8
X-Developer-Key: i=hans@kilurion.com; a=ed25519;
 pk=1Qqd7FQOGBgV4kpJP4kZLbjH4wFg7+EdQaxwe+dr7Bs=
X-Endpoint-Received: by B4 Relay for hans@kilurion.com/20261006 with
 auth_id=1123
X-Original-From: Hans van Essen <hans@kilurion.com>
Reply-To: hans@kilurion.com

From: Hans van Essen <hans@kilurion.com>

asus_kbd_set_report() sends a SET_REPORT control request through
hid_hw_raw_request(). usbhid does not take a runtime PM reference for
raw requests, so the request fails while the keyboard is runtime
suspended. On a ROG Zephyrus G16 (GU605CW, N-KEY 0b05:19b6) with
power/control set to auto, every deferred backlight change from
asus_work() is lost:

  asus 0003:0B05:19B6.0002: Asus failed to set keyboard backlight: -108

Wrap the request in hid_hw_power(), as hidraw does, so the device is
resumed for the write and can autosuspend again afterwards.

Assisted-by: LLM
Signed-off-by: Hans van Essen <hans@kilurion.com>
---
Tested on an ASUS ROG Zephyrus G16 (GU605CW) with v7.3-rc5: with
power/control=auto and usbhid.ignoreled=1 the N-KEY keyboard
autosuspends. Backlight changes via asus::kbd_backlight now resume it,
apply, and the device suspends again after autosuspend_delay_ms. Before
this patch every change failed with -108.

Taking an autopm reference in usbhid's raw request path would fix this
for every driver, but hidraw, hiddev and several HID drivers
(hid-cp2112, hid-steelseries, hid-google-hammer, ...) already call
hid_hw_power() themselves, so this keeps the fix local to hid-asus.

No Fixes: tag: the write path never handled runtime suspend, it only
shows once autosuspend is enabled for the keyboard.

The fix was developed with an AI coding assistant (GitHub Copilot);
I reviewed the change and tested it on the hardware above.
---
 drivers/hid/hid-asus.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 7dc6417fe..bdb2c8b64 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -576,16 +576,24 @@ static int asus_raw_event(struct hid_device *hdev,
 
 static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
+	int ret;
 	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
 	if (!dmabuf)
 		return -ENOMEM;
 
+	/* The device may be runtime suspended, e.g. for a deferred backlight change */
+	ret = hid_hw_power(hdev, PM_HINT_FULLON);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * The report ID should be set from the incoming buffer due to LED and key
 	 * interfaces having different pages
 	 */
-	return hid_hw_raw_request(hdev, buf[0], dmabuf, buf_size, HID_FEATURE_REPORT,
-				  HID_REQ_SET_REPORT);
+	ret = hid_hw_raw_request(hdev, buf[0], dmabuf, buf_size, HID_FEATURE_REPORT,
+				 HID_REQ_SET_REPORT);
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+	return ret;
 }
 
 static int asus_kbd_init(struct hid_device *hdev, u8 report_id)

---
base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
change-id: 20261006-hid-asus-autosuspend-6e26f58787ac

Best regards,
--  
Hans van Essen <hans@kilurion.com>


