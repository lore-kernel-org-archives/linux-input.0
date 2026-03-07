Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072121339A4;
	Sat,  7 Mar 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772876962; cv=none; b=cOGwh7MuK0RVWv2FIgQqfAwgAP/252YSJ5/1kgeAohooYTtwCwYfE+0QTNghm2oQQ54Na8Y9j+6Gry85w/FmPRsHJ2teuCqQrfT3gtzygKgS8Z8ioCsc2gHi1Z8Ph9CX1Y65qPdJ58vunJChslxOO5b0vqwn9RJvDlTHzxqx9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772876962; c=relaxed/simple;
	bh=F6LNkG2WzFE8KDittlLMCztH5YU7mSDfMqhoHeXv26g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyjyCTgGi1ISOsdeywSxcA0jHqAcA+lHcyWtlKIJy4QFJAqVE0oLCkWkaZYUiyLdvuoWsC2hr4SCP6iVUjuPvG5lFeHzIjbZ/0e6BeuRxC6bjA+ljN7HVSlpbKhclz+wVVy2OHRwV2mF+QHbb92zNIQ7sf0wulN6bJIU6WQ21ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gAoWdi6y; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JaHBRFYy; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gAoWdi6y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JaHBRFYy"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fSdlX4sX2z9tV5;
	Sat,  7 Mar 2026 10:49:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772876952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bQMGkRDJORFqsKsOiRZcrSgkKCwsKoPA1jJjVXTH5Gw=;
	b=gAoWdi6yJ/pSFiu/JiT79lt+D5IpXjcHxWTeb++EklCgKa1T7o0acJ3Y2QmZFC4uRALCsJ
	zrZ9HbMXGOUbAtr+v4vqk5WnFsZkByZaxowYDUkmmKPngF72A93rcPFPak1/Go/Pd0WZjh
	jBA40T417meGHhF4gLMZtX3W7KfT/H2eVzwDYy/uWUosMBHffi5ym+J01bpzFKPVqa2kCE
	QqhatNAXJwpnvMOoPBpbVpeXvlJml24hJaOUQx3bhTEVCwXo7LXT2uBFE6OoHqTr7kt2dw
	36a9Qs57HvE7U7aLzhqdPRzT+NMJIEswKWU9o9S4O3wugUJxgFpsNxI61yQkKg==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772876951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bQMGkRDJORFqsKsOiRZcrSgkKCwsKoPA1jJjVXTH5Gw=;
	b=JaHBRFYyv1YwZgVmIdYfOTszoQZYWtKf4cyAJDCZkHev22s3svznLocoXQudV2rMdPd+IF
	9NxpbFlW7rF9MAy2jt98vmnE6vqZ3G/RprtoDZDFy6bRnKq9XAbSQlTCRC5RgzORF9YYMn
	GcYSer8GOtxriZDXbhoqlXqrVBiaXRiHFbpQjJ9Yh3HJDSv2IM0a6sOqLaKSQyq50MAAWj
	KoCe5HAGZfX8vFFHyudx0fQb3oc1z+0SqEIhbxWTJ1/LEHIhN3vjXnZM8r6FIQB6h1K4ep
	NgoURnWltPg9/QqayKCDbmIsw/k1JSlC9hsc/ZLbdcqFEgLrQ5PMZubW9qPiWw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: sony: add battery status support for Rock Band 4 PS5 guitars
Date: Sat,  7 Mar 2026 10:48:25 +0100
Message-ID: <20260307094824.50332-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0ddf88c5082abfcf458
X-MBO-RS-META: dho3kierfhtb3rrw41jmx4fr3u4zsqmw

This commit adds battery status support for Rock Band 4 PS5 guitars.

The data is reported in the same way as the dualsense in hid-playstation
except it's located at byte 30.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a89af14e4acc..5a1d41cb3a72 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -72,7 +72,8 @@
 				NAVIGATION_CONTROLLER_BT)
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
 				MOTION_CONTROLLER | NAVIGATION_CONTROLLER)
-#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER)
+#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER |\
+				RB4_GUITAR_PS5)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | MOTION_CONTROLLER)
 #define SONY_BT_DEVICE (SIXAXIS_CONTROLLER_BT | MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER_BT)
 #define NSG_MRXU_REMOTE (NSG_MR5U_REMOTE_BT | NSG_MR7U_REMOTE_BT)
@@ -991,6 +992,12 @@ static void rb4_ps4_guitar_parse_report(struct sony_sc *sc, u8 *rd, int size)
 
 static void rb4_ps5_guitar_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
+	u8 charging_status;
+	u8 battery_data;
+	u8 battery_capacity;
+	u8 battery_status;
+	unsigned long flags;
+
 	/*
 	 * Rock Band 4 PS5 guitars have whammy and
 	 * tilt functionality, they're located at
@@ -1003,6 +1010,37 @@ static void rb4_ps5_guitar_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	input_report_abs(sc->input_dev, ABS_Z, rd[41]);
 	input_report_abs(sc->input_dev, ABS_RZ, rd[42]);
 
+	/*
+	 * Rock Band 4 PS5 guitars also report the
+	 * battery status and level at byte 30.
+	 */
+	charging_status = (rd[30] >> 4) & 0x0F;
+	battery_data = rd[30] & 0x0F;
+
+	switch (charging_status) {
+	case 0x0:
+		battery_capacity = min(battery_data * 10 + 5, 100);
+		battery_status = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case 0x1:
+		battery_capacity = min(battery_data * 10 + 5, 100);
+		battery_status = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case 0x2:
+		battery_capacity = 100;
+		battery_status = POWER_SUPPLY_STATUS_FULL;
+		break;
+	default:
+		battery_capacity = 0;
+		battery_status = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	}
+
+	spin_lock_irqsave(&sc->lock, flags);
+	sc->battery_capacity = battery_capacity;
+	sc->battery_status = battery_status;
+	spin_unlock_irqrestore(&sc->lock, flags);
+
 	input_sync(sc->input_dev);
 }
 
-- 
2.53.0

