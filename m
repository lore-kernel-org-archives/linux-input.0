Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8353A453D
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810174; cv=none; b=Cm+VC5PrCAUio8nJx99ASa0BZutOepfMPmPzeDllxNH7pqdVMyo777EX1mqhBOH7y/PFoMjA+HhJTb7bi4qZAWxZ2iStMrSzu3HbUOKBB7Jepd/hSFKQP1tbJrq/6XOVTJ4RYD4CWViFOYQ9h4HiLTmG1n2qpvE4JsDu88sSiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810174; c=relaxed/simple;
	bh=pYVCusB/Yg6NECKuEuztptsmj+C8zqJUgjgzSK1ZYmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTjR0jdWy5gzlAboj9PqFQvtEIA33t69HAjMX9ow2KkW7KptIGUwYs4FynExcGRP0MbiQXca5EwdMAIT1lRFh4oHqAS4hwHz5xEzVVe38iu1uLS52+N6pteWYZ4qtVN3fu32AgVz61Ute1GQJ396LztCuf0tCd3LRZzlIwqEtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=w+p2Ki6E; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="w+p2Ki6E"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c6df0b9bbso2141644c88.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810170; x=1777414970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EQNgSiI0V8p/6r794MZ3/liLrTK/Jnr7QGMXeuwHUs=;
        b=w+p2Ki6E5drm3ln6xrT98zS9O+6sgZ2MAlsx+8x+147nEtykeWMQOu5TkPRg5WrIwc
         BUP3ER9mq1JMIppMhcdeIKI6ThdeoI2YBsFW0oCNr1fONGwshjrWHUEflfwgkPtgMQuQ
         qPj8A6sEgQcvOWdoM1XKF5Uj/kImeWO8VX7bIHtk+ktW2L3dfmZ5XIQ1XAFB5XqnSIv4
         3IBrkjxpVcT7+OdNdPIZ2h91wl9jWMFGBticWuEdHTIyAput2F+mMO3DhRT//7MhQ1oW
         zikZM8Pj4jQsEflHrMYlmoKBCNTR4XlZdcZOO6xXC+IKM/5lvo1vO41INCfZL++HLSrv
         p5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810170; x=1777414970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EQNgSiI0V8p/6r794MZ3/liLrTK/Jnr7QGMXeuwHUs=;
        b=hYXrzuLPGf3SylOvYd624A7z/l5YkNy31QZaPMMnYEeu1jPhUk/poou2sNMWnhXq1z
         yveLH9xY8VuX4dPWsX0ATnCPI8Woxc1U/6rt5BVb9lQFIBosR0AsVOu2gGMFKmLMFKCA
         GROaffndQFvkiqBoHuI9LRt0GBlGSWJtcNaYCTbMeY7jQaaD5fl+xI4Uf+0Tkhjsn4NI
         hf5m05yS1et3m2K85ehaH1UFZovp4Ax90p+GlpQEZEQadbcuBIfPWJB053Y7n6Zgy2H6
         oMBSYlHnKlRQPiVmnOAyhWGfYLY9P3vhoVUoQFmNZOALOzw7iOs6ibQ0P9i7Qw2lyMST
         SglQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+vvYyAEvmFqdNWgUJCjAtKC0zBuOtNkhzpGGLBp3S43i92MYqnuBud2XSTLvekom7DK4ag2jgU//9Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMjsNyICPqyPiDjyT3uAv7VtosjMojnX07T30F/Y7GGZDp4Bz
	02NZOxNXroIxeIweyuYh1D7+l/eUwDqGxVlzODapJyM9AvnEWv28P2vrZP05C3ZCFl4=
X-Gm-Gg: AeBDietsNofLw6ai4nxJ8IWNh9GfULo/KyB9SZtgPIH7O72i1VXJGCWTUUUrwUUg6tK
	OyNE1Nb9d2ycFg/REUEAAsx1PuHpGXSXzLvH6BZhq66/mfoEVVWTmtusBunc1DikKhM91QeoyC3
	FS+/vi9eLi7Jw12oLd8vcojiL725CQPtK+kRwmr1LCOvb4myq1EC8d3ReM8nqguIpcMS8NZAFEB
	IzfDZVUGl7MFWGC0LQVMK9XCA5VTsmXZG+B66UtfLEGsqcEqfxO3VaPORpJVHaBpdD/aO+JBBnH
	U+7W14CycuaJBuzSy72WUrdQZ1HSYxUQQ7jKfBs11pg3rYqUEZySiIz8L1qjU52EDWmpsl+kL5R
	IVJarFqe57ZolKhsuVmCNFZMlYG/U1Nv9Xzh9Y8GeTsMOSzZCb0lBEmf61Nu/vH56nCvCZCJxkE
	XlHaGnZvBJhQ5JiKFOhdLRfCMVRun/KzpfwNA6Qw==
X-Received: by 2002:a05:7022:ec07:b0:127:867f:2448 with SMTP id a92af1059eb24-12c73f9f309mr11039454c88.26.1776810170385;
        Tue, 21 Apr 2026 15:22:50 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:50 -0700 (PDT)
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
Subject: [PATCH v2 4/7] iio: light: HID: Replace method als_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:36 -0300
Message-ID: <20260421222210.16016-5-natalia.andre@ime.usp.br>
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

Replace method als_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-als.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..16ef9a37aeae 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -117,17 +117,6 @@ static const struct iio_chan_spec als_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void als_adjust_channel_bit_mask(struct iio_chan_spec *channels,
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
 static int als_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -335,7 +324,7 @@ static int als_parse_report(struct platform_device *pdev,
 
 		channels[index] = als_channels[i];
 		st->als_scan_mask[0] |= BIT(i);
-		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
+		hid_sensor_adjust_channel_bit_mask(channels, index, st->als[i].size);
 		++index;
 
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
-- 
2.51.0

