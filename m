Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA223C51D
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467138; cv=none; b=YVf76phycvc0ry4aZ8XJo0DP4fu1l8XAPD0tNYRrdBvQ6JRKHk3Yi7XdmC02kbkqnXIM4RCjBy4Qyhxbf26S0XtPl87/jiwxCWLiTpWOcKCrae66361J5Rq00w3VQ8G+LwLrxVrPXSKvET2qTAXHv24CAAbki7jffdOxwyjYIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467138; c=relaxed/simple;
	bh=pYVCusB/Yg6NECKuEuztptsmj+C8zqJUgjgzSK1ZYmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwROtjT+YFEbRSU81Q+4nBfMC9oeR5+AqNLHlUoYwxEMMlggC24Po9m8NRAvCTrdsNBKM906sOMS5/5bBWH+1I0o9RFmGxoCI98AvvB+eSR92J8oNu3fr+EJomOqDf47CXypLebIlYM0MXVtn62LQ+6tZx19a6by9KrohPw+a8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=mIXtuveH; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="mIXtuveH"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1577411eec.0
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467136; x=1777071936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EQNgSiI0V8p/6r794MZ3/liLrTK/Jnr7QGMXeuwHUs=;
        b=mIXtuveHLLFeX5LdSGfXBvE6XBWY4J0JmiwJ5/ZjiS0HKcxnyJz/J0Bg/AhwsLXJmP
         TmTL2jabTLtzIW4cPrX94qUo5P0a0JbVN7l1s940q9e9xYavac4cnFIfKNJLw8YT80YK
         PmS0XSfqt7UTGqp9OhHoXtfFxZCcLl5kd5sB0ZReQDrmCGL31ayvGtbS7rH9DkkfROsV
         0qdgAD2HbKbnmCITXjGF5pqKKv1ERC5bL4oyem30vmSjIS0huYHNsyzyrjoDWUpZIOfy
         hMnE3eZ0bUPRU+rz3feE3Oo23yEesx5DSt6ZL7wXW+AyVAI3Tjy63iaqt4bzMpYx6Ryb
         BPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467136; x=1777071936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EQNgSiI0V8p/6r794MZ3/liLrTK/Jnr7QGMXeuwHUs=;
        b=HJWEJmoliWDpnd1LtxhbWlhh4yiSAaQJlM+YdUhrnOvvfqyyry3uqWCnsPJwAP5GPG
         f+IIxKxWY5Zy8dorkFler/8vQc6gHsnDCj20D379grrV94nh+0tZdzuJWSAPQKqe4aSw
         itJnmTRGYkFkP+wPbRGdNYXznnaHAF3BEpTrT81Zt3SarHQLMUFp01cISV3zSHeXRi+e
         3QaeUSpHsVNq8jp0Djdt7QILea1KxuLgkHMKZafbMRCQNLEzqWj4RZDX5nKRONUeBsWz
         /q0dJKDs3UCuplWvFX0XmAAIvHYX/PX9d9m2lAaLdITeeXK50xXVhmaBm8WPeX5Snq3b
         +PGA==
X-Forwarded-Encrypted: i=1; AFNElJ8VcBBPoy1dEqOcLpRVxkidoJF0/kWzQNH93gzp59nx9RelGQtUPwI3bW0ZWYZToSIyZ450jImrHsG9ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4udVAejq355QcXYBy7zVAD91UKFV4xR+/6s4zO/0JBQiu3Z/I
	6tlqFzuXpEsHru4PnT9ZZxhavCtl/dKIOAlA13fgeWFdhv4N2u3FWPgmCbAY01TGrOI=
X-Gm-Gg: AeBDiet5arPsey17j0kGRotaQQI2Y5eSeoriPhqh6cqrBIGDo1psaMBff5PZTHM5qRu
	SANFhvFhALL3HgtnQ7kbIepSsXyb9YpZZstH22HN+GGOvgl7rifsOyCa2e9FJrSUfv0Itx0QjDe
	iwky1h815Gl9VP6+0nxJtVi4AmzjC/c1qhvFIM1IH8xhoIwQEKHq0x4lZYxKZoKjJWyB6k9VwiI
	WgCM/acLeym9y2oAP6JGcNjcGIhfO+pjJIfzdJh/UZg0nTYEoETKzc9PsRE+j6l+KHFhftfBMI/
	muqDvdVucd3tGMGhVhM5UCvSznehOZImpd427Cp/dJpIoCYEOGSkjvjJb43GcrdXqiTmsIzIbrS
	8A74vfaA4xL/4P9DC6/cyl0ZFuxVqkXLLLbZSl3PqiGNyQfVOib90BA1SVmHR4bt3/QhG98hQqb
	IIQShUXbaEr92pSCJVyYECVL4ZQuaNdr3fKrRXkg==
X-Received: by 2002:a05:7300:fd18:b0:2ba:a2fb:403f with SMTP id 5a478bee46e88-2e478c2023amr2295687eec.21.1776467136079;
        Fri, 17 Apr 2026 16:05:36 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:35 -0700 (PDT)
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
Subject: [PATCH 4/7] iio: light: HID: Replace method als_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:47 -0300
Message-ID: <20260417225959.16688-5-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417225959.16688-1-natalia.andre@ime.usp.br>
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
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

