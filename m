Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02335203C
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234496; cv=none; b=jiFpJdakcBhPBAwPKWD6CWi0yDnY8XxilY35ck4QimtApgDUA/ahWEfzh8AneJ8ge6zBcwV4bnBjacAQio4Gp0rCvfLMuV2CfuJIWSva0NRGlTfgXgR19y7nluQhdcbFN2vfMHS6HuYPI6MX3Q9PwKY1/kFphv8rQD/y68YwBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234496; c=relaxed/simple;
	bh=VLq+OnlqkiTSPOlR+NkVS+pKlfsiY5f0O/xbmXPX4+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKFyMEJdzB84gnoXzL/aFIlmBSjiHspWasIJ0iE1sL8NAk2y8Wknzhlk4LQTM2mogiEPOF4gB67K4gSOndV4cQre/SizLE5xgSi1VAzghOfWrz50yIMcaKYWuWkvx78+7MxIFf6nT7XsRrQiRkxLfY8tP9W/0RxTe80b1ldJZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ZyUA6qyE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ZyUA6qyE"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so61863086d6.1
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234493; x=1779839293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhuMcTLWdNNuDcBNZFMFTCgFJ/UCWdePWMH+rdEL30s=;
        b=ZyUA6qyEHZqFadwVNIJEFRbDYP37gmFnNf9tcv/0bGjOIR8OFM2euWokMK5o+dcDjk
         xNQ/1BKdUd7fYkIJVVRTkgN0WMN4yRRWetujckycGj2/mvCXDARanx7b7GVWaGP8IPIf
         OCW/I109VsxcYB5yPiGwy3f//+8bI1sZMhCIUevTu0ILKSQnyrc+i4YIbQYr2VMFUVVX
         4xvDQG4djEeDYkBT5Z3ibjDULmcgC5rMsneY42NH2eqF+k/0fxnJ4KZxGTMDtwwJUEU6
         /6CGRi4wdsw8P8U6Zo2J5YcurHBV3V+1ArXjPMGdCRPheR9m9CjPwUoA/hQEiht0+/yW
         D4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234493; x=1779839293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RhuMcTLWdNNuDcBNZFMFTCgFJ/UCWdePWMH+rdEL30s=;
        b=a7nuTczQsp/vCluUYdGjFCorH1HGSGIL74bxkWbgb+F/s8rcbsh2AgRk6WfRllReAN
         TEgQ9sGrXE2ikLo3uRMgj0cXcwFus8tpHq+DXpVcJT09buKyNgB2yHl5DuiuHiDXufnO
         14dagZb3KxNgoIjJ4a4zn87+Qop0dauWOc96SAGKaxb4ySdJdtcfxGRfD25J9RsfkwYh
         jJmJ3KhPeiwA72G7m26oFUcEZtlM4gokj8MlDcJ2kpA2Pi1LNuENbZlHKuiTJRElx9j0
         38+d1NwSy9w/KTtNGQqdyfGxBgLkkP2G/YWerOLOjyR9lXKfV5ZMyAX/ThDfs6tJ9qTW
         H7Dg==
X-Forwarded-Encrypted: i=1; AFNElJ86oNcXvvOxpc/airOYXj7WVWNQW5jv2IJoo/5Uo4RDadlOQgVintlAUluKynMuR+ikhD/M/bF3xyqt4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfYX2fvrLVy+mGfGrrENPWOEdsdvWJW8SWXFSb/byN/eTvrlt
	/C1V8jQ89KsleyoJ5IrTeuWp9Uedq2Kt3ea18ptftKnuF4X8sDPXZ+P9wKV7/d06T1g=
X-Gm-Gg: Acq92OHuHk+trdgsmniJ1HNuJ+Nd+BPlSstUgO0TV10vpqV6I0VxOXIqNh7NRLB5xEZ
	quLunIHcSPkF8OQ274OhjuRyqpA/KKpdZgm65e9/IHA4zQPGLk2HUuW0qy1xJYpyrxW4YJLlRYd
	rk54dr2sBu3DF7LxqfVlzwx9A/uZvYRFViYT/VPN3aqJD7BflaGdtnuNO5GFf9RCPqLBma7j8DK
	NJEaHqlSM/yCfeEybmu2T82vep5mdIRVSkqGVHTEyPwkwt0hsxpaFEAPqR9rFZ7UiUDH0kWcMDb
	OvQkoiKtIMkbmlvWwKCsai1+Ef5/qK2K4wpDsf7Sn3ec8oyFirxW+9WMVMQpNR78wmc3glUS+Qa
	+z9dWKIOP+tvV4snwYPK4txp2QS7fsHX9BNXWsK06lmYWDrKqECpOcQt7AEs3JU+/WL/zqYVJ/8
	uzjDXhaL+jLVyupJ8Bb2yhFL2YWvmhNNerZFLEtxw=
X-Received: by 2002:a05:6214:54c7:b0:8ca:1753:90c0 with SMTP id 6a1803df08f44-8ca17539460mr338639726d6.29.1779234493271;
        Tue, 19 May 2026 16:48:13 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:13 -0700 (PDT)
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
Subject: [PATCH v4 1/6] iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:43 -0300
Message-ID: <20260519234752.23911-2-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
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
index 2ff591b3458f..2bf05ab5235e 100644
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
+				HID_USAGE_SENSOR_ACCEL_X_AXIS + ch,
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

