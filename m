Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733F230264
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549025; cv=none; b=mQiU67002jFkFWtG7yJOu3G4yylzLCt9oSy6IQcdeKv03Wu1ARBVO1fg7crKA84qxl+RVX4ccTScUUVMdT3TRYmPnoDq6psuGiosMzIAJlIZhTBf2Ob6K/NODQ1RS0hCTFmgKKdIpFi652rZUW/rE+Ob50ScX5hlg2KQ/NFGc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549025; c=relaxed/simple;
	bh=QSiv7WSpFd2YKxc//BeochhaYMtiyPIjzqQwxwybp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uycjBpJ9g9WYzRhR3jcGxGH9q511xByjgMD8yOaSEY7nukk/Mmrx0/3tdufbnMHwjXrS3mMStJNFO/NU9j2V3F57d8WFkZd8kszE62Z/CqnYuu9+W/+M/svfQ8bhxnPB7alJd2tZDj6dZjhZTtLYY3EaKYrTZW6EWdVyu5yDaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=TbjS6kCZ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="TbjS6kCZ"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8628196eec.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549023; x=1779153823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=TbjS6kCZlhbqbBY/uwLRDr9lAqMPw6hvIb2J6nX2A14lnk/vtlAtXYB60I+f/jhP12
         Q4ur45Zq/P4Ack7Jk/yPcgu+YM1Mn/ju4bLr2jq+VAI/Wd6naHHGByiuplN0UVNtVIGs
         2QyxdZrEGh7QHkuG612na59MIlXp0ZphqV7ES4gZGEwhjR+H0ctsg84hCZeSt0ixzc7b
         rXo3VqMsxYpCTbrS2k1gmsM2d/hzMXU/lHGoPPaAr0VdBcRp8suaTlxCPzNhKLxxKHfb
         biPHfYFI/iMIcl1l24Ml4HvfFzlrMqA4+fj+SsHmsg8eph0tugBPRIw1l5QVJeysay/6
         DBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549023; x=1779153823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=gedWUiMfbTBRXRpgLdhIeE7vElqxK/4o6kg05TcB4rA6vD51x8F19Gm6ci/g1mWR43
         Ct6UWCEz8TwJvVWVdMSxC120USZ9GnelOSTicfvgPjDStfjEAMS6cXOS3qhNWVD7eIWe
         4M4JSObtQJNXdqTo+bq+uKmJFI7Vdfvsg9rNLx+7YqJ5SlgklYo8k9amNRPy9vCEiXZH
         N67DVxfB81pcC02M1KHQxyEKvXvavcQHw4FJ/BfmrsJUGtd86oAG9B316lduQcZfxliL
         uiBfHJMbBkZGWanLSoaBagELdtUdPDRSeikIuPMoNG68MpYyWOzadfnZYID/TgzRGXur
         d64g==
X-Forwarded-Encrypted: i=1; AFNElJ/VT02rKwuOX/76sJNlP5fgue9ZjfHVGq4R4U9xISHa1CUIhvJynDk3JP9nmQjqLP6QOdZDYLglwmnuOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFncLLAZxSNnbSEFF8C48xaF19MpqKGTgvzVplfkidNmYskdl
	t6DLNQT9GLslT5AMoZreoUukP90Q78gdzZrxqZZq3+vQ0VC7k6FelJtYongDRiC1TTs=
X-Gm-Gg: Acq92OGvH3M2jb7Ph39zg96htA6DNptsd5/BPeTxNK1R1iaeCPK2C9En5Pc0D12vw17
	9y01y258A8zmpq/JyynF3E8v37UVVmAQxy/Qge+Dwilfeoo55uKTXagnFZpudH4DStIyfOZqrLr
	p2eCeQBdRov5yeeWlVK3EPqM5GD04NmMyoKc3hcN8+tyl+IbkzGq4jyGs4tVsAzpua/6Bm6CZKG
	wTpH+h1vaKC7jjPRFIpwmUymtVZcOl8KJdVjPBRR4/M3WocIgLpHGVdA+4qNkoqc83eVyXMX4Vx
	ncL66YV5BRqVkTTbmRIblIv38ucLlG0MivHwGjbB30ywGh/voCnwt1abKmjfWH1CHzwpvNZPNMq
	JaJDSWbBPXASVTCOmZW29LURyVxP1+szlzAyaEz5p6DKJ2LfbOYptovdT5tAm/BZhtXcnP2pA+e
	Xwf9rpNPca1bZF+sxpXRw66fg4we5Jaw==
X-Received: by 2002:a05:7300:f191:b0:2c4:61be:1d33 with SMTP id 5a478bee46e88-2f54d69b008mr12339249eec.6.1778549023476;
        Mon, 11 May 2026 18:23:43 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:43 -0700 (PDT)
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
Subject: [PATCH v3 6/6] iio: pressure: HID: hid-sensor-press: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:22 -0300
Message-ID: <20260512012302.20883-7-natalia.andre@ime.usp.br>
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

