Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DD72621
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549012; cv=none; b=cITEps9hwtrO3i/uXJ2YcZinqD8KEUm1s6Db+CZJL0T3wQ4lOxtJVXHK7Ts0vhwHqTcX6T8m7RcHEhMh60TYw0dMSFkfGCxb6wKhTISGIvFY4/qoxyVN2732x7mbx6iMu4Ig4G0GAPW9xR0XF8qAUD0YNcEKo7h6PVrs28JWC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549012; c=relaxed/simple;
	bh=UYtqvMi03L3/6VhP4OvuLyt+Rgxs7v8SXyN3T6pbuV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eH/h5UuO9HtopjKvMGaQZ6T4HBCnW5uFl8bi8iy5+zGSrJ1r78mXrAWnmQmTSBguA6x6hkM7rtV0XfiPpeXPykys+rKkCgjFntfLdfuZ8sukZgSU3c0E98S3QoOGaIPyRYfVScFvNmBaVEBsnWw+/e7nEcncAXKMHinZR/wSCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=l6F6t8/P; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="l6F6t8/P"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8627899eec.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549010; x=1779153810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B4D4HO8ajJ3scBsEP+vXkn2+3r1mujjZng1sfcyO2U=;
        b=l6F6t8/PIJ0jdV7UoEumyeLp4sJ+PeX4sNB/S5Dnq8vCULafU+cmrncn+KCsnc7RpL
         EjSce6WDYt9bTcuCYaIp9RsrzTjyr3dneAHxrUggQWdnkSnsMHrOAajPRfksns6lvMId
         9tWAWuRS6YmkVlje0swDRn2RaPzIdHz9wXXZW/vDxWd5w6yn8ZJGIWGlwp0ReAWNfuH1
         4y0VSWvQDU33ttpVKG/ArLgG2HhQGDeGsr8gr5pda71Qa5BrrwWtWrju+5aPaELq4eB1
         4xfTJPbjsswMy26yNr+FZ68oi84HUddUouNbnnEp2HvKcxaLWgWJVUbvviBvvBJG9j2b
         rNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549010; x=1779153810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8B4D4HO8ajJ3scBsEP+vXkn2+3r1mujjZng1sfcyO2U=;
        b=Om/QKeuJhC6x5bA8dTBFBfkI3NI2M1LPseTvbuf64Sjowr6vrwgaPUa5yvWhRC7SXb
         Zm6xg0628MpXBzeQ2Pa/4FqQPeee1xhB0qa4qRWh3Ey3HrCQuUMPjJ/+sULuR469yMwJ
         kyBwvEBpw9/pcYiRQxXqfTeyTUlx/Zw1Ip+m7UMjrEdCtc7oBDmT21Hi263K0uBpa9R1
         GNv1nRft+x9IELhCqngkdYSfY8SDwEqSnq5vKpIxIaXpJytTqd6phHAXwXuL/xnDkNnT
         fsOvZn5iypp7HXK+R9eWXK2ha2Bv0G0LcMugheo/yIWvL1zUTd90fmE+OT2kX86pdZLj
         Oafg==
X-Forwarded-Encrypted: i=1; AFNElJ9q0WS5Rjjzpq+fot95ojakYXyQyrww5XCDAGUYulpwqs6oReZdsiVzsTRT59a9/vHftIdZsGyXp1bkCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLPiv53Fcwzirx/4GEePzhb4+Rw85iGYg8/p0BvzhT5wHZeNp
	VEg/cmEyl1CKDdwoZl1gCHrPkFX9uKVQbaJk/h9bPvmAHcsiBb5prRUQj9TsJrdd6NU=
X-Gm-Gg: Acq92OHCilGTHOPj2hGkHlrbffJdH9b+wYuBhfx47yugIs25rFZqDPcL1kVovm+FmoP
	+2JDjrg8chbaT9mbn4ZkdMgsFSEZPtU598M83eJwfCB3g1zUl8/lceKl1SO7ng3UIHugjdLZ6IS
	h6/8lX+FakSjxi8AUTQ4dKgl2JCBwjhn+MsU2R1KSzCyywCnA99nBvkVHnjiQU2/82JO2GxC8mG
	LML/ujD0Q1xURtCJsqQvHkle1MKM+4J49KWvrRQVbLcdB7DZo5vswT1x7QmpjfV36kKgzTh3kTJ
	cVb7sPoCJrKVCrHttWPeScjhvlIhd/fv7jqnR/psaXhoyz0MZouduzR17LepU1Dms6LmNQVX5Om
	7/ZOBayDnsticVIs2tTYbvM5kaNReNQX1ouvLu2uLEO9xOJ0QJfBFWYoPk0fCZlw/X3s1eBoBB8
	O89St0vz8neB6OX36vcsVY0uNtu6GeKg==
X-Received: by 2002:a05:7300:dc14:b0:2da:2ec2:64fe with SMTP id 5a478bee46e88-2f55034e591mr11448933eec.24.1778549009845;
        Mon, 11 May 2026 18:23:29 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:29 -0700 (PDT)
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
Subject: [PATCH v3 2/6] iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:18 -0300
Message-ID: <20260512012302.20883-3-natalia.andre@ime.usp.br>
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

Replace the local gyro_3d_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..4cbe4d93a0a1 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -82,17 +83,6 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
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
 static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -251,16 +241,20 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 	int i;
 
 	for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
+		unsigned int ch = CHANNEL_SCAN_INDEX_X + i;
+
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 				HID_INPUT_REPORT,
 				usage_id,
 				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + i,
-				&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
+				&st->gyro[ch]);
 		if (ret < 0)
 			break;
-		gyro_3d_adjust_channel_bit_mask(channels,
-				CHANNEL_SCAN_INDEX_X + i,
-				st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
+		channels[ch].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->gyro[ch].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 	}
 	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
 			st->gyro[0].index,
-- 
2.51.0

