Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897A391822
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434864; cv=none; b=sV/3vdeYjkyOzEujNXI3GFzpwEfZbGn/yRYvyHP3HRqn+ftMKUL1PHUsrvQJ7HLXEj43yyBYEKQ/0VSYBDaC+qcJXwPVIepd9oZ4Qrd0wGI0eoL85lfSFIo6FgTNbxteulgjudav9S9qJIUMhlESGoSudMmfd1PrWsWsUVpW/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434864; c=relaxed/simple;
	bh=+tTBPf/ITWlpNCLZqiExxTpUAgaWoqxWpXFOOAp5x4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEwWEti1+SZNx7CWNk13kx68IBb90LzEyGBW3+oz5bq1hbs3rBrrxuJt3W1AHc2lwdrh2H9w383MriVp/KlzuUYvLXCJYhMPgss7scyNnctWtrLxH0/kbsCa/ynR1ap3Zahp9YZC89BhpPw+UK8ofZ4tnmrmVCAxBDznxiEKrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu5x/Oxa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu5x/Oxa"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1670dad7a8so388887266b.3
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434848; x=1788039648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=10Eq5R/N2bfHPdqI9SBKLnnx+VXtAYQbeV+dq9RoJTo=;
        b=hu5x/Oxa/d3y6zWFCg3G6PNcMQX82Q+drWOWuByIgA6VhI6ZegzD5MUAvNMyarunZf
         bKgIYjg7agqc87krmzC8O3kNHWpnB311UfyWnPZNvvNtzWyXNojfgq17hmPsjWocUinJ
         Dh2Abt3ZgWqZj8rbRQgM04Gu8L0VFlzDdfBo0rQBTJ+2BpM2zo/3EL1lDaKaWrcdPU7/
         gX7cRsLrSk0CoVSTepl7ZwwBr/LxxNCZFhGguErMZRgBYDSsMilwOnKk0fBuIs4W5Whq
         apmrT7q4J2N7Bwi22UqoFJc4Mv6FqjEB5dTVblDowuh/+df0CDv/AAB5ikAS+k5gwpR+
         ql1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434848; x=1788039648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=10Eq5R/N2bfHPdqI9SBKLnnx+VXtAYQbeV+dq9RoJTo=;
        b=SmxhtxQW+WXAD2rRCh9Sd4stm0wEn8VNJmqWoU2IXpdCKU55bX18kVecy9fZKvs0z1
         /R8sYmpnSyJ5YBaf4/K/QPmJu7ywDVH44ura5Y1rg/9x3o+UoVeGXHgf8cf4lMlm7Q6D
         L8E8X9jvIxxcs11U147wScaz7rgmOJ0saKhddDIrERmcLUydSY3ZmBMZqENLrB175vVU
         lM0J2rJbP53g4G5WYPwwoG8gjjimHLxJaE3+HtLYK5u8FK9pMuNhFBH8OSGvLPvFHUsf
         4vYscxZ4HtmL9wOv9nI7254wLc3HxTN59Eg5RZHPMk81eg9I/Xje6/y8qDo4lq83D4gK
         lzzg==
X-Forwarded-Encrypted: i=1; AHgh+RrZ32eotmDqVc7YePE61ekUJP1LUE7L7GTvCqoR7zXNckKJQHKi4rXQEhxdEyJY66w6ZJ0iWjgocNPfuw==@vger.kernel.org
X-Gm-Message-State: AFuF++kYqPnuB/TReLaL/SDMT1EZ2mvtznlp/18M2j1SVmmwJRIMY1Tr
	hyD313uTc1y2DnRUcBpHJDqavnPhWtChqxTWIRtRZf4iM+3A1iOLVHOX
X-Gm-Gg: AR+sD11Kya4e2ZncqhujNucqeqwd0e8Lu4a9lK5EAZTqQm37ykXX/BdB6UPHlvub0RR
	Rg10KmGJ7gAKkVACkbrV9jXQMBZv4dCOWB1o+qYwQznKNP4z4xL7QhHGvvomEaKtR7TmWB1JW5b
	cP0RxvcxXt1WMoPtqUgU3Mg53O0KStHQXVBmSoJkRoDhN37vNNUcUe/mK88FzrGuWVziAkMxeWF
	8D+pjMJGIqu+GSHoQA3vFDBwdnNlAcL4y0Tx6/HCBxCRhXVBsa6fPrxfRmkcp+XQ71EhQROZE74
	TgcJl17As1zbNjZ+dja8RzbB0zSXZnITqcEMgbV4zEZUHzc+fJ4d0lGzjcr/FJTQpA41EiVbOT+
	Oq9ibfC2vOc1/2aqgjHMXBZ93mTIQlKEmqsrc+FeYbNeyS+0gJp+EF6ZrFxwouWDnk6Hgad6nL0
	NFizvxotvfdVCsvJJVvitPatof7Lhkp/7EsOEjd90rO9KFCfWbOKZkAAjhYpSg
X-Received: by 2002:a05:6938:a086:20b0:c20:38c2:2b7f with SMTP id a640c23a62f3a-c246a684286mr1173749266b.12.1787434847817;
        Sat, 22 Aug 2026 14:40:47 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:47 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Chris Keeser <chriskeeser@meta.com>
Subject: [PATCH 11/13] HID: ft260: i2c: fix large write transaction failure
Date: Sun, 23 Aug 2026 00:39:39 +0300
Message-ID: <20260822213941.98882-12-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a regression from commit 5afac727defa ("HID: ft260: missed NACK
from busy device"), which waited for bus-idle after every HID write
report except when the report flag was exactly FT260_FLAG_START.

Multi-report I2C writes keep the bus busy between chunks for atomicity.
Treating those middle reports like a final STOP caused ft260_xfer_status()
to spin on -EAGAIN after the second HID report and fail large writes.
Write-then-read combined transfers still worked.

Pass the bus-busy check policy from the caller: ft260_i2c_write() and
ft260_smbus_write() wait for idle only when the report they send carries
STOP; intermediate chunks and the command phase of a combined transfer
do not.

The SMBus side matters for register reads. The command phase is written
with FT260_FLAG_START and no STOP, because a repeated START read follows
and the controller deliberately keeps the bus busy to keep the
transaction atomic. Checking the busy bit there makes
ft260_xfer_status() return -EAGAIN on every retry and the command write
fail with -EIO, which breaks probing of clients that read registers:

  ads1x19 6-0040: Failed to read config register: -5
  leds-pca963x: probe of 6-0008 failed with error -5

Fixes: 5afac727defa ("HID: ft260: missed NACK from busy device")
Reported-by: Chris Keeser <chriskeeser@meta.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/35
Tested-by: Chris Keeser <chriskeeser@meta.com>
Reported-by: Bruno Giacomazzi <brunoceg1@gmail.com>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/42
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index a2f4b6e5a16b..36687c086b40 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -566,9 +566,14 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	}
 
 	dev->clock = le16_to_cpu(report.clock);
-	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
-		  dev->clock);
+	ft260_dbg("bus_status %#02x, clock %u, bus_busy %#02x\n",
+		  report.bus_status, dev->clock, bus_busy);
 
+	/*
+	 * Do not check the busy bit for combined transactions
+	 * since the controller keeps the bus busy between writing
+	 * and reading IOs to ensure an atomic operation.
+	 */
 	if (report.bus_status & (FT260_I2C_STATUS_CTRL_BUSY | bus_busy))
 		return -EAGAIN;
 
@@ -602,13 +607,10 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 }
 
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
-						u8 *data, int len)
+						u8 *data, int len, u8 bus_busy)
 {
-	u8 bus_busy;
 	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
-	struct ft260_i2c_write_request_report *rep =
-		(struct ft260_i2c_write_request_report *)data;
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
@@ -625,16 +627,6 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		ft260_dbg("wait %d usec, len %d\n", usec, len);
 	}
 
-	/*
-	 * Do not check the busy bit for combined transactions
-	 * since the controller keeps the bus busy between writing
-	 * and reading IOs to ensure an atomic operation.
-	 */
-	if (rep->flag == FT260_FLAG_START)
-		bus_busy = 0;
-	else
-		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
-
 	do {
 		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret != -EAGAIN)
@@ -651,6 +643,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
+	u8 bus_busy = 0;
 	int ret, wr_len, idx = 0;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
@@ -663,8 +656,10 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 	do {
 		if (len <= FT260_WR_I2C_DATA_MAX) {
 			wr_len = len;
-			if (flag == FT260_FLAG_START_STOP)
+			if (flag == FT260_FLAG_START_STOP) {
 				rep->flag |= FT260_FLAG_STOP;
+				bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+			}
 		} else {
 			wr_len = FT260_WR_I2C_DATA_MAX;
 		}
@@ -680,7 +675,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			  rep->flag, data[0]);
 
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
-							   wr_len + 4);
+							   wr_len + 4, bus_busy);
 		if (ret < 0) {
 			ft260_dbg("%s: failed with %d\n", __func__, ret);
 			return ret;
@@ -721,7 +716,9 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 	ft260_dbg("rep %#02x addr %#02x cmd %#02x datlen %d replen %d\n",
 		  rep->report, addr, cmd, rep->length, len);
 
-	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
+	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len,
+						   (flag & FT260_FLAG_STOP) ?
+						   FT260_I2C_STATUS_BUS_BUSY : 0);
 	if (ret < 0)
 		ft260_dbg("%s: failed with %d\n", __func__, ret);
 
-- 
2.43.0

