Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E33A382A
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234501; cv=none; b=RC0MgxEQ8zm/58DfKfG+T9LffJ3DWNwRiy3Gy2wGJTbpnMEF+fxIygSCvEKX7Ag7rCcf20uSiEzxfVzAq0TD1+DtGZ4grZRoN/tJJQGHDKAzD2wnG/CWwbk8yTH0H3Kbj2efy/IbQdieQgra/rG0yZN7YFYS9JOT9L03AOjlFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234501; c=relaxed/simple;
	bh=3ApyXcATJZb78nPHHHdP725U2EJZWyGQUHqJdrNZckI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbrNUW/LrTsdox3pcLrkdMMxs0Q4RiGm8RYYBeIlZxECLMTX97o9lycFLx+T7RzUGAs3ECf2eM9zgNKliyQklVcs0Q/7ZikNMdnQo2aSOk7C+Ymu1e8JN9tnddv6LaJBGu6Uh7kI6R/pOmlsS+QIHPEs0UqrmbFLiSx3sBXpvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kvk+1dSG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kvk+1dSG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e97863425so46270811cf.0
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234498; x=1779839298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvT864S82Fo9HErNXXZXDbRGPrbybgU9p7aJmKXm2Tw=;
        b=kvk+1dSGwyy/ON8okWuQO1Hofpv1VQQU34aYrXWCl51cLHNMCbDv32/q7g/Shfhcy1
         xQC3pyQlbEFjseDCPfTIwOPloK4IipjbwZH++GUVE81+pcOepPe52mbsYz0/GXS9iBSm
         xK77r1SaoptzaK6a2rJxw0S5qaol9GfQKgo2LQRg35In3PJa1wT+eg8v3uyPW5TQEGKx
         xTxFzSQ82o1PxEeAa92cIlBc2KbjFbqxz7o/Hn5FhdDB5YG+YjExsXIynnYr8bdMnDDg
         KyZyW9VqXoUMCQE43zG4PJlgepKNzGXvfkCW1RKXTbRkj2HBu7i5HszsWWoGk0HpLTR7
         dKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234498; x=1779839298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vvT864S82Fo9HErNXXZXDbRGPrbybgU9p7aJmKXm2Tw=;
        b=Ie5OqMx5eZX68DpiskcgydfJuVxa8h3lCZNJ+IKwnPHdIKWkW+zkq8fuqClPDd1ctl
         HU+tI2SNtLe0A3uJsTYlUA/xBCp4Hv++7DiVPfmS3um8WWKkfNMsdJIoSHWhQRuVT17v
         5bz+vVRQ/ZFXuNnyMGNAIb5cQfDT6mp5hihJLxgmff5j8duVKbCx/Tr8RzHtuBdxafLa
         cCIilbzuO2rS6QFJvrrm3EKht5FBgGaHkhN7LUdVntlgLCX9qvBsa6z892xCwmGUD9BK
         98TPKKtmc/JVKSeJO82jKEtyboto1p3egZ5HpVlrgXGi6PwPy3ICQwzyBkg3BRdnCo2Z
         Oydg==
X-Forwarded-Encrypted: i=1; AFNElJ+IXQWTrBWOlsboIPDc6kkEIFrhqOZXiqAFiX9c+z4OoDOjgb7WTpOsMQFok2SFR/lwYtN0mle/t14bWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9EfpvLGRpjtQTk9ATIy/paI/48ezQ7mJ7/wJn0cF6Nb7R1U63
	/LlQ23HuKM5Y/wTIjXT1+iKGWQtT2ot2gfWWfY3DYmaSJRL7wyc8ifDMgZcI0XRYgXI=
X-Gm-Gg: Acq92OFj03fDKqY4heCSWsfOaPJ0g14f52TWpw+1XArKGW4S42gitifP8C+CY1mPHwF
	mSGGqA3TPlfO4MhWOhyyrC9Cvh/YEWkOmuekDs15iOmu6g6ztS/97tX+Fv/Xs8gKN8VT+vg8x6A
	lzwUSfyzn66KKkkumnRxWhqPhYMtJIxTUG02JBCo1M6QgluWJ7Si0/ndG4rZL05aZZWBALkd085
	Ibm9tSiiN5UrsQLeeKPOOV9JS+iz3nhP89nJ/2it+hTmCv0kxge2/xh4Y3dAzuaMh8Yh3Gn0mEQ
	QfgxKnNOLpPnOLUO4VZkeB3fyeHKUqVdwRQsWFn8YKXooWOH4XIPdGvVymjT7NrOWysbgCQqarf
	imrVUL7oJkWa3njpxNfakB8SFMrOKO3bF1ULzWgd1xVj9fqTFzkayY2/WgbnewXdufA77viZtuD
	hWcDI9CaaH2wV0WF0qjxe0fohwcEJh
X-Received: by 2002:a05:622a:8d1c:b0:516:a040:373b with SMTP id d75a77b69052e-516a04038b9mr100168621cf.58.1779234498001;
        Tue, 19 May 2026 16:48:18 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:17 -0700 (PDT)
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
Subject: [PATCH v4 2/6] iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:44 -0300
Message-ID: <20260519234752.23911-3-natalia.andre@ime.usp.br>
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

Replace the local gyro_3d_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability. Additionaly, clean up the channel initialization
loop by iterating directly over the channel scan indices.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c340cc899a7c..e48c25c87b6d 100644
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
@@ -248,19 +238,20 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct gyro_3d_state *st)
 {
 	int ret;
-	int i;
 
-	for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
+	for (unsigned int ch = CHANNEL_SCAN_INDEX_X; ch <= CHANNEL_SCAN_INDEX_Z; ch++) {
 		ret = sensor_hub_input_get_attribute_info(hsdev,
 				HID_INPUT_REPORT,
 				usage_id,
-				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + i,
-				&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
+				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + ch,
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

