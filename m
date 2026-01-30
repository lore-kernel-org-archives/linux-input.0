Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C9271457;
	Fri, 30 Jan 2026 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769756299; cv=none; b=rIqdHS7cfiW/UryaPPPPPxpOH76g5Y827cS8S3zuGlXuEc0GacVYVOm64CgGNelhpOANmzdIssf2DPl4tePWcFvEJZOjqZ7N9J7DTEXA5Ax704YzqQrf/q9s94feP9dVzxuJ64MMEyC7rAnddqCeAXG1TXG9XpUrp67YNjwTjNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769756299; c=relaxed/simple;
	bh=4dddITnr96NS+nvVq1s7oTZRt0zem8kHZjPbaKMGMCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAMSJ9j/rXrnIPAKoeI1pk5dDQjPPpedAjB6atCbYFn5QrBX+DSNW+/HV9ZtFlSvv6KnTW6XSmqYPwXxTjsEApysnl14dzVIwDMshqps2wuRnB+UvwU2VfvzcoMXmBscGs/QMbR11uLDXKCA2r88E4PY3sIzLiDCxAyL40p8orI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uv7u1P/7; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=khON/y0O; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uv7u1P/7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="khON/y0O"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f2Rfm6mH5z9vHj;
	Fri, 30 Jan 2026 07:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769756289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sipQll1Er6of8V6+b+RZfr1pPybbc0+P8ZGuDAK3UI=;
	b=uv7u1P/7xLkPjDqK18PIBEKlja+YK91j4+xODuP8zikmgst2SnY7K4CyBhw0fmJzPVbphi
	0lT/fLTNsSEHGhDNTl6uJWucxnvxnhU7UUzA0+ixEST8M+swEojQNQHgjxw7RYG0nnzRDU
	OtG7Z361e7cbUKVr6yCMvTx52JeMNXZZg0T5WlEkXPVDYOdg+SYrOGmvgtYaNwEDfvacd0
	z//ZK+UulvsG50c/AEJj5z6zlPt3ltIGjVajE2GuXCo2XmwEta2TFgV7sOmB7eCRTztlCR
	oYzMs+07X+LDQusaB6duSOZN4rfyjQ6Gr5mG3BBj3snqtldMK1+PJ7BdASd8mQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="khON/y0O";
	spf=pass (outgoing_mbo_mout: domain of rosalie@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=rosalie@mailbox.org
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769756287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sipQll1Er6of8V6+b+RZfr1pPybbc0+P8ZGuDAK3UI=;
	b=khON/y0Oij+a3kM8mAlL5Jq6kUyoxbSL2sn8LtbPzlV5EfRxZiapqwVOlLE1ozDiw4W1QJ
	20WxrvfX/CnERwEhwou8TFf8q1Kl4okM99L+/LtVZiquRdOO36mVpgk8vzYaTuwkIxdF/M
	2DLePl64xHfMlwFz2AMXYTgJ24K1fw3uc9NmOTjyZ+gFiwuUhfzO5FS+oHCwH7mIngKCRM
	L2MLzvNTROL5OL67imsIW27I6vUN+orCKHZiOMQDMVmC4lPxosVt2Iqyp6gy+0FFWdr6Qu
	CSXQrBC81d/su4gHaljMi/zTwKa+SsxTBOQcBfdswd/7QBiW7531ELETkZgagQ==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: sony: add dongle device IDs for CRKD Gibson SG
Date: Fri, 30 Jan 2026 07:57:51 +0100
Message-ID: <20260130065751.7173-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1c002fb240d4baa8528
X-MBO-RS-META: i14qast4bmugrrhfg6onyspygmw95ogi
X-Rspamd-Queue-Id: 4f2Rfm6mH5z9vHj

This patch adds the dongle device IDs for the CRKD Gibson SG

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-ids.h  | 4 +++-
 drivers/hid/hid-sony.c | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 43f86061cab2..91253b57c499 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -365,7 +365,9 @@
 
 #define USB_VENDOR_ID_CRKD	0x3651
 #define USB_DEVICE_ID_CRKD_PS4_GIBSON_SG	0x1500
-#define USB_DEVICE_ID_CRKD_PS5_GIBSON_SG	0x1600
+#define USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_DONGLE 0x5500
+#define USB_DEVICE_ID_CRKD_PS5_GIBSON_SG        0x1600
+#define USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_DONGLE	0x5600
 
 #define USB_VENDOR_ID_CVTOUCH		0x1ff7
 #define USB_DEVICE_ID_CVTOUCH_SCREEN	0x0013
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d0270ffec4f4..836ce74764a8 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2383,6 +2383,8 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = RB4_GUITAR_PS4_USB },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG),
 		.driver_data = RB4_GUITAR_PS4_USB },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS4_GIBSON_SG_DONGLE),
+		.driver_data = RB4_GUITAR_PS4_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_JAGUAR),
 		.driver_data = RB4_GUITAR_PS4_BT },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_PS4_STRATOCASTER),
@@ -2392,6 +2394,8 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = RB4_GUITAR_PS5 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG),
 		.driver_data = RB4_GUITAR_PS5 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CRKD, USB_DEVICE_ID_CRKD_PS5_GIBSON_SG_DONGLE),
+		.driver_data = RB4_GUITAR_PS5 },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
-- 
2.52.0

