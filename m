Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848863A4F30
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810192; cv=none; b=ntK+wRZHlh+wvttlHiebGw2PUnnWJcXbjAr/hI3yYI2eLG73vMtNG9yU9ReGmTNVffHoy9slISEVxnY0UlVQ0CoWI4Zn6MIBGKiToijtL8nBtWghsySWKxozX91J1NiR9zezhbQ/j6ubPM1HRpOoc1wMNUIePShkQUZx9qDjJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810192; c=relaxed/simple;
	bh=/ce94Mc3GWWXNTYD7wFEvd4pPvHbahgXZy3vsWas94Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdTCyI/BXF8h+8NZTZPlyx5oci31rbskgdRfsHhWqq8kO++dN9sY0USMYM8nTpQ5JW3ejgmgPMm0A25ZxKJB8Wff0Hm11+DPY4ns/H0FbQWdBGqMc/QfQPJfbfA9C77BRU/CohMs6lXckHi7QsfOsIhxz0W0wL3xTJmqd0+wFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=KzlCfEy6; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="KzlCfEy6"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c637089ccso432265c88.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810189; x=1777414989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alV0/ZcmCtMRPsl8aXibbmAcoGCSPLj/Q0zsgAAjvt8=;
        b=KzlCfEy6F0yKE/3VBW7eQCO/ny1qWFnlxRfy8NaYM7Jk+ACe7RJJ8/s0NrDze07PoD
         Af3lULyNp8elCxkOX7C8hGAfqPXtFlHKLA1fw+5t9FIagzyzu549PhCFoli8+7BgVV26
         Q875w8S5umOLLI/xfnfxGEVxlvaOnp5DAuD0EASGW5iuKf/nfnp3RbTiI7oR97znuExD
         6xS38qsM5xJDICYeKJqKxeFj/+gfBtyuKYn9nWFISmSvhcLvgIhiMEgbCQDmCqscJgMo
         /6ASvmcFmsM3peZ3S8bG/DtH1KV0ePxnpbaZKIzVO+xHATihTVoQVZ+8297wrqO8/MfO
         kPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810189; x=1777414989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alV0/ZcmCtMRPsl8aXibbmAcoGCSPLj/Q0zsgAAjvt8=;
        b=W8cF/NZClQygDnIQ0APjzJZdHLmi84BnieIwn+DomslJqD4Zv9nXjB5BMTpLnBY81U
         4WzOTD4iN/4y6LqY3t+5SBt8zODzI0ppr3t3P7ajnPebAS8bfoZlg1o57tAK2O9tmjwN
         D5r4AKvceNp1khiy/vynbkwVOw+wclfJkBXzoFOeSq+CntBJbRkMtet7oU6DFu+E2RSB
         vxtaaIrlMkKMeK2u7VEDo3hZzek2tZUOOR3s0y63M4ccfH9C8HxpcOZWzfYl/83sltEn
         ovHkKw6G5kzeqRs/R6jxGiIpvLiNKpGx+pEmaeS4jyOm+yhI3gTI10FQSCGoRANAlpDe
         XESg==
X-Forwarded-Encrypted: i=1; AFNElJ/RblqLNPGJxSDUxluFI5zrDaVDkpq/g9wJ2mtA6NgO5RJUUBbKGSECzOSjLT2b8gnf0BtGMZlgdT7lag==@vger.kernel.org
X-Gm-Message-State: AOJu0YybcR9OLEaz6IYxeR5gOJhUMMtqnVL6LWb/9LfLpBLsR4WMtOiy
	c5CRQRkVxWDXHfPHute5EjmrY3A4Iq4BIDntkKekpWvASpX+J76TCrLb5yuGhBFrH3s=
X-Gm-Gg: AeBDievrEjxuvJvGYopTpSyNd6t4sFc8jwwrosEALif2b+QfSy/wAs9PKtFfAUHZM47
	mWARq4ddD43cKWkgWauOlHxDIREN3aOBI8YcrIH45NVIjjyfj7yzZFO9LqDLeQW+u/dwoE7TlVl
	Rglx+K4410nyST0+3J9EHmAagFdo9S1xM8TxcaW9lxEmsYsvkQsVfKWVaH34mX1D6kZtCFelFSn
	ukfGnUlIZtYYKb9GIhc/1ZosU9c7fnoVW1dA4nBewl/lrnEx1P/ubKr3OJRY6FWQwhwIiX3DpWp
	+eqzrD0O0pwxIjop03cy9uVbhla31rY3a73a/36g/veyDHdr+TW5RZHM5H4RP7b6xn/5UBqntfG
	8uZHIHM7AJdPtvYGTRRiAz2OfeJ5I2IgV18sQrLyRfW4YpgMOYOVirvsn6RBDRLLJR96QhjYN+a
	YnRUjZYQxcOPLV1AWE+ah/ZKPA+keVvyYhMPWo1ojb6no4gl5M
X-Received: by 2002:a05:7022:f016:b0:12c:44a5:fb54 with SMTP id a92af1059eb24-12c73f66c7fmr9811185c88.7.1776810188618;
        Tue, 21 Apr 2026 15:23:08 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:23:08 -0700 (PDT)
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
Subject: [PATCH v2 7/7] iio: pressure: HID: Replace method press_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:39 -0300
Message-ID: <20260421222210.16016-8-natalia.andre@ime.usp.br>
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

Replace method press_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/pressure/hid-sensor-press.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..fd9dafe4945a 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -53,17 +53,6 @@ static const struct iio_chan_spec press_channels[] = {
 
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
@@ -225,8 +214,8 @@ static int press_parse_report(struct platform_device *pdev,
 			&st->press_attr);
 	if (ret < 0)
 		return ret;
-	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
-					st->press_attr.size);
+	hid_sensor_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
+									   st->press_attr.size);
 
 	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
 			st->press_attr.report_id);
-- 
2.51.0

