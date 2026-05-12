Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C822D4C3
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549009; cv=none; b=lyWh1T6Pmlb3LIn1zTy5V042Xv3Td86jqj/07cwy7HsNZ4llCIjGj+L0sbJDklv71uOonNDN7R0vqxMPa2O9NDy7hymGlQYV4qgos3LyHc2D+D5+iRzJEuppq/eot/KaX5D8nUG/jZJH0pqB5IyXCM0yjYf4gVa+O4aK4sFi4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549009; c=relaxed/simple;
	bh=bGF3SOQGWINSFtgAIzXnB14gPqPP8mmWpdvWHwpXStc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0ZuhkuFmstVzyqMnbMj/RachXl3luPfUz3jiaIHs7cKORIZ5EeKXAWeavmbFoB3/u4G0FwNUmmlhWs4WjV26k+uGHkdekT5xzzEEAw5T3w8+nmwjMVrmlvMBMILOTnHjLwV/8ArNzDTnFSIWaaFHSPyYdEp85KJpdqLJCrca1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=RFLxmv+V; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="RFLxmv+V"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f3c623322bso8329213eec.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 18:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549006; x=1779153806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGAP2uNSb2ABD3/WN+PryrBLAUiNs2d2P0FijTLRFBw=;
        b=RFLxmv+Vla5cRgPtXEFHZjpLPxkjczIuTWVZtVbjURYeM9OgjbFGkkcMHzjisS7MgA
         l54tLPS+/a0Yaf6Am4ILYYTp4LrYrEvEvePLCoxe4Fr6OuBJTZ+4fbOTPUJcwZfWpOeG
         7D9hE2TgNWXf5lhkimrx2bUYpUIHDvkq/GHLur8J6hVyLB+2s4zLzzrjAIxL+pLEGi1J
         zptYlp/6TP+WZQzk5etRp7wWkIPR3GT/oCjImtUfGOegyOkYp9+r2Dk0FQLgG4cP5/ti
         9GZHUR7tDXzhGaJVLJnljdZQzf4cTZoWGjwP8jkRSx0fietqlfeAcS9WFKcOTln6axeN
         IYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549006; x=1779153806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGAP2uNSb2ABD3/WN+PryrBLAUiNs2d2P0FijTLRFBw=;
        b=cg1HxoZU7Kt3ylXvHI/qiIQbbgy4/DlAtzlILNP/dEUxEOCFomy6AUw/2HTtoRRAgU
         Pddx+7DPeB9T2YSeYh1kLawgVs78fsss4iN6j0s7zwp5GtnF+kTICfTSRPhgWpGMa6NQ
         zdIPE4fdINxggXB40FxrFvx2YUh7kA7i1mqZDV8wa+AxNIHQx/vwz/5NCOpldnDsz1yI
         lYPRmJYQqohaLFSdQPKr7yMqfNES3XYLFG8AeBjcJ4MDN0afSR2WEDvHUr7JWOnT1Ro2
         yd9U8vwbb6ije/gpSbN8IlS4m/C+GlDsIVr0j/oPBUdyix3pLhmnjF/a+xO8jOP7lX6t
         +xBg==
X-Forwarded-Encrypted: i=1; AFNElJ8WGG71k4uQaTaR2t2WUhHHVJNlPfCtBPs9ebbCykH773Z3xEvDAOQ7UzQ9Lsj7tDksH0lnGCES4/74UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfCJCAJiOj6gg4niJ/1eNwbYf90BZ+l/axOEiPsrMGHhDIdWX
	v6BwEthJRohWMaB/Hgucck5vNZKp/+3XzQ4QyO9TCSRsCa9l497YbH4yhnWn4RdOCbE=
X-Gm-Gg: Acq92OEHx/cS5Me/APZ5ELhBI7Y6J47vKxA1TtJmGdhCYM/xMaObDGNtc1XZsh9f0nZ
	kzNS7Jgh5cqIUtmc9HKHu3ZqXyhreFuF9RjeTndJ1aHorZ4pQgsHnkAMoAqSnHOQy7JFOwvp2O8
	mHedaqgLvnB7WAR0V9eHKw6mN/KW6kFsz3/t9B7PfeGPOL/sj/CUZwmKDZVF1NMOUGxpR6Rruut
	9zMV+OlKVvJXyggMPunFKnTNBuKzUwVsmoIuxPyM6u0aYlm6Q2MSPrVQoUHX5PvxJXu09JNp8Jt
	b9IAH9AuZPDYQQwCcHvqgA5VEyEIvzFNpnA3f4IVd7mr888X75t0t2d06yfNsQ81oho6qBdOqfX
	k+f/uAqj/vV3Rm10aydtaBqHv11CLZz2Oq/9pZARjgh5x6QQuaaQzGQPivaZUEXN3bK23mvB8V2
	hUV0lkadfBDW3FFVRJ7Y2qY/YQvE0s+O30UPHZF+yD
X-Received: by 2002:a05:7301:3f16:b0:2c8:6361:ab2e with SMTP id 5a478bee46e88-2f54b35faf5mr12485989eec.8.1778549006517;
        Mon, 11 May 2026 18:23:26 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:26 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 1/6] iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:17 -0300
Message-ID: <20260512012302.20883-2-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512012302.20883-1-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clean up the channel initialization loop and replace the local
accel_3d_adjust_channel_bit_mask() function with a compound literal
to improve code readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 27 +++++++++----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..99ca67732bbe 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -119,17 +120,6 @@ static const struct iio_chan_spec gravity_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP),
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void accel_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int accel_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -297,19 +287,20 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 				struct accel_3d_state *st)
 {
 	int ret;
-	int i;
 
-	for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
+	for (unsigned int ch = CHANNEL_SCAN_INDEX_X; ch <= CHANNEL_SCAN_INDEX_Z; ch++) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 				HID_INPUT_REPORT,
 				usage_id,
-				HID_USAGE_SENSOR_ACCEL_X_AXIS + i,
-				&st->accel[CHANNEL_SCAN_INDEX_X + i]);
+				ch,
+				&st->accel[ch]);
 		if (ret < 0)
 			break;
-		accel_3d_adjust_channel_bit_mask(channels,
-				CHANNEL_SCAN_INDEX_X + i,
-				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
+		channels[ch].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->accel[ch].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 	}
 	dev_dbg(&pdev->dev, "accel_3d %x:%x, %x:%x, %x:%x\n",
 			st->accel[0].index,
-- 
2.51.0

