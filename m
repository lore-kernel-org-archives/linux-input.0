Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2735A933
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810161; cv=none; b=m0QuqKlB6WO+/l22/4ItKenpRy5+fHrxHSFCm482V3pU+g2vSCLRLKZ7fYAAsVRmAzutIQ2PwjKJ02VU4h4omWNcVAPtx9OuXIgg5A5mr/hNK+qp6gIfWlCNzooEyeAQnuCKNbvySw2pcRgFc0KNVb/LW6mSWEcPuPigSINajpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810161; c=relaxed/simple;
	bh=QZmdT8mQpsW48c+AhT01ZTMmhKAfG+ya7zAI8C3nqXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZnMkkAdJ3dFfQH3788XuLI31FcybEIuNHdlxz609gVoZqJMtDx23g82zKAkUmluSS3GUIls8ALOyjcfPPqCF2SxB9DgZybDCi1jPFNGwRQssNqRKyrMTgLJnDar7tmoZtmVyo3ymHYcgwAvNy6inkijlj8+gzMQK+EzImmMx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=zMw3SDZ7; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="zMw3SDZ7"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c6df0b9bbso2141167c88.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810159; x=1777414959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q3QuGRdKHHhCPwwItXJr3sR9N+64pPFE1filzk7mOo=;
        b=zMw3SDZ7gh2mFVa5bvorgH2Td+OxbGfdBSCxAnO/dn9J/J2sE9dtkoThz+KiM1Gv29
         98UELv0DL24lO5tDiSEo/0NPBCf+TKX8O4doEl0xauR1shu1w5Kg33btA4GAfbd5/jEg
         muaHJeF528V0YigvojscAKWjsfUdz/aEGNZuxFYJekP79JAEgezrMLsrXHq130cGSsd5
         Bk9awGQNDbDo88E5mqhsZwILiZEzNhAKq1ZJceGxXnps2T4Yte2JRQaaIRfeoC3pKFN9
         V0Lz8k4ZK7IL/WSMFg3u4beZxsyh6FzElvCfcMDtRW5e3eVyxaIQJODy9E5pPggUqqw3
         cKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810159; x=1777414959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Q3QuGRdKHHhCPwwItXJr3sR9N+64pPFE1filzk7mOo=;
        b=sQT32ZQ8j2/VZ1zy7pMatPMxVxaqK+54W/Qa7gUd1N1P0uzoEXLQl2BG+iGrJAwEDF
         DMqeZBoYwVJD06doi87DSL+/EyU/DkJO+gsjlBeAc4CVGEemoKvdtohwQZdempnT1aP9
         9hCnVJ36h02gjSa/7aQKOELqmKiDZdocBmOFAUzJX+sRv8iU9bXeQumMLLV20oqLZPvC
         zN6zVdlWOAZSIcmT0wFO7OWZoVBMIVvuGuEOpce0YcmLo8qwr6EUsDyDStshCy4azNAT
         XaIKNXnKxtYCbaEEFQ7kspttcIghh6wuy2JrvUbQrAZvz1U2ZQjGAjBO3J/8fD/Vuvaf
         r2lg==
X-Forwarded-Encrypted: i=1; AFNElJ+B/Vguqeqcz/kzjRhkxqs+NYW76IdFATjXv5vp+oYXfIhuN02k2/OgHHOS/0mQi2sy/88DtcVhzAN75w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnXRiqZZSVGODdQGHfc1wKXKfH1aeQ1FREvDgS8UUNJC3jrXkR
	zc0On7nWDchluW3MsTksQNgh7hE/jzBOpwkB9byqXEYgvuCF4wDM6i4tzFg+fc7HcQ4=
X-Gm-Gg: AeBDietGUoPGUm3/sHOvOAGBDEaXRRM+TgMtxyRylGglWl/WN95IhROSGnRNpw6CltR
	WluyslWzmXHfQXgY6JrY6h8rTjKs1ikIbMfwLb3TpLq+I/gXrH1EEkDDhV508iRymm9HrVPWXY8
	X5PiP58WfYD4sYgB4tiWmxqjEno8j1HMtLvoNNFQrmWIgbp/y4mHuwENJw8JFAL8O3c8G9rSX6h
	x7nUvUqG/T28NMaDv4oJdV2N0xChBIgm5LlGH6Qpz9Qko4ezv7NC7uM4KaXiw9qeRG2+Gm5u6Q4
	vtnUC05CoI2R1sHfqzxTQbIT2hsv051/hvDS2FdGtO58HQk0w4uRovOd70ABEYtA+ynIeRa/Auv
	grsuVtocZhb1mU3xW6kzneLp4n/U5c3whiS0K6mGbuvcCEEIzTK/9SsObgbT27IUq2gXPCGwQXj
	YBoV4JJEzre3hh6FAcc9siWGHhPNfPlX9VKsYydw==
X-Received: by 2002:a05:7022:6289:b0:11b:b179:6e17 with SMTP id a92af1059eb24-12c73fb26famr11626547c88.34.1776810158871;
        Tue, 21 Apr 2026 15:22:38 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:38 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 2/7] iio: accel: HID: Replace method accel_3d_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:34 -0300
Message-ID: <20260421222210.16016-3-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method accel_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..ac4ab69f80b9 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -119,17 +119,6 @@ static const struct iio_chan_spec gravity_channels[] = {
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
@@ -307,9 +296,9 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 				&st->accel[CHANNEL_SCAN_INDEX_X + i]);
 		if (ret < 0)
 			break;
-		accel_3d_adjust_channel_bit_mask(channels,
-				CHANNEL_SCAN_INDEX_X + i,
-				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
+		hid_sensor_adjust_channel_bit_mask(channels,
+			CHANNEL_SCAN_INDEX_X + i,
+			st->accel[CHANNEL_SCAN_INDEX_X + i].size);
 	}
 	dev_dbg(&pdev->dev, "accel_3d %x:%x, %x:%x, %x:%x\n",
 			st->accel[0].index,
-- 
2.51.0

