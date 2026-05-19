Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBF35203C
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234518; cv=none; b=XW8QyMdmRK+rabkscUo8g2ZaKKUnfHeI11p/kZXVnJLCrYqjpbscEi+9JHUVQkpc5SzWVqav69d3KovV7qotbK4j3WYh/jLEYwDlmSM0hqkddKhHr1IQCXPHrAqMNNW0aVfoGcudJxW7pPCYKl+XAxbWp1Bk5iwY/IL6B7YdXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234518; c=relaxed/simple;
	bh=QSiv7WSpFd2YKxc//BeochhaYMtiyPIjzqQwxwybp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGFz4Dgf6hSARpZYNRaqX0pRAB3Rz61BWaDfGUPUFzDzsDA/UZ6AoOopZb5lYFwXxbeIWyVmarI+ibMk49m1hQI2nnJGZXjifZk8tZcgMdf7RX9hU4R3OY8emahP1+yztozEYXfVtnGUIBDH/UvD+RSnpPzXNwBmXJ7HGThlijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kseqh+rt; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kseqh+rt"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90caad2e944so451254185a.2
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234516; x=1779839316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=kseqh+rtwnL9RZ0cG478Hyut6+BRTclDmn7wdOa8Jw/1umJ73pUssr1TKlPUwAwuFG
         +0souUazjfr5mOvFiRX2t8IA1Qh7TQxmb6fqNtDXfh3OfXwdNzYigEPUqETxpUTr3Tly
         EA2WQI1TLMpw9TsDXxmvMMwVI81hGzXmoQ1u1ROEeaKi8QXsBiu+rK1mADiUU8q/PvUZ
         Tv8uj52z1jKF4qTfgRoodhEjVDzaFMFeCtMY2RHbS8h8iMpjg/BFuBj80OsdzkRTolsV
         0qFALr64I3i1IqcecOej8Gy9y1q2CpEPT5YUM6QkesId2Rlbqtf+B+ek48+L3j11U6UX
         GwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234516; x=1779839316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=euYdGsl0vKWK8DCuHhkPUoHC+p12O7DckwA8ddytJxFe6MTcNPxFVS8xAqYeufKh7a
         xZKOUE6vLLRjTfmj0FI8sxQClPLajgbPwTShNUX1thYnJO6XuZCunfHm2vtmudjWUjSo
         aioD07pzjnIlCSMkpYMZefdgcGtofn1zJ0uXm4qi8U72rdfhPPZq5a5AhCWjnVboqRgV
         Z2UVn6iqVrrewrTXTwuSslcCAT5OG3k6SvV/CeRuRMBC96u8YyTJQfBBID3m1rh/rxKN
         HnaPOVNrN1+JuzcO8WLrz8y7MROZ0LJ4f5Ciebjb+BVC0DmTLTP9+10akyVA3Vs+ziMP
         Y0vw==
X-Forwarded-Encrypted: i=1; AFNElJ/vVvqSTNVmGJaigtO8Z3RJ6CbOJdKeqSLDUeOf+t3DhLCXARRbx9d02mysCVIZN0hfGqPT1sU8pobb8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ZU+cHRu/Xtiqw4vdiortp0mKkaZon+k7ExzCzF7MQT4Ttl09
	KkA6ePSZCcwoS1H7c+5difalnUF70XOemGRcgFVXKMUP0W69stKkHcWcYqPss7OoJ3k=
X-Gm-Gg: Acq92OFpHXrLGWL8JheoUe2j5pHIt3XCuKx2HbAhXoOiiCCsV3Hi6e2j2UMS0jvLmxe
	60r+1iE5H3TMuNOL5UzDDtPm2Mh7HD3FNPrS8NYr5i9jsp3mlIZ813cn26AF16Wjj8aBDx02V4q
	gg+NSGo8NrZx1WIsfT5m2BaZ6ruYpX/izmSsVYlcEZWn6dCeDiL4p6QVHm6qBlKgb08nnToQPEe
	HWnpUCpI+UZ29cDCn3a7Pn4YbY8gHvKk8W0K22Ltwr8UfFQRaktnQrM6Rqz60EOWqreJ3pv1PVh
	LQEPm1+se8BSXRGZEheOtB9jps/DMQSRrxl6C3UDlbVFr/ijW5RvGvvF+yr/fwIXhLWLcAJWLvu
	DnEJMIQZZtpd7y97Qz7qlpj/Q1IvRcMJ1MFBOZNil4+4akTw+CrTh+f+bzvN0SR9X9G4/ezsi4C
	wBMTz5F/vj9sty0LUO+3+p71QQ7kx4
X-Received: by 2002:a05:620a:4148:b0:8cb:5176:ef8 with SMTP id af79cd13be357-911ccd8bd6amr3179246485a.8.1779234516135;
        Tue, 19 May 2026 16:48:36 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:35 -0700 (PDT)
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
Subject: [PATCH v4 6/6] iio: pressure: HID: hid-sensor-press: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:48 -0300
Message-ID: <20260519234752.23911-7-natalia.andre@ime.usp.br>
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

Replace the local press_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/pressure/hid-sensor-press.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..a039b99d9851 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2014, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -53,17 +54,6 @@ static const struct iio_chan_spec press_channels[] = {
 
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void press_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int press_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -225,8 +215,11 @@ static int press_parse_report(struct platform_device *pdev,
 			&st->press_attr);
 	if (ret < 0)
 		return ret;
-	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
-					st->press_attr.size);
+	channels[CHANNEL_SCAN_INDEX_PRESSURE].scan_type = (struct iio_scan_type) {
+		.format = 's',
+		.realbits = BYTES_TO_BITS(st->press_attr.size),
+		.storagebits = BITS_PER_TYPE(u32),
+	};
 
 	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
 			st->press_attr.report_id);
-- 
2.51.0

