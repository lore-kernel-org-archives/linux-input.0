Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B70318EE6
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467157; cv=none; b=MQEkoEW9bNIVCdfpKXJSwy3okjlBpFKZCe6OBw59C1dd1NmqK7uQHxs1lc5DSpXnTcxajzv0WF4wuC5FvdXxnAqrCSM0OoMTsN5jE2dwTe36jic8qTUx/yK+13kw/uArSAVAmMnMEPCV9OsXje/6+ZIqQDI/ecD04+OdQOPTlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467157; c=relaxed/simple;
	bh=bnmHaJe8QWE1jsWEm1hh6uAMBtdwAAo32rr18B2LXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2NbPuyCSUQhHvfBDx3SdQlqVMAWLlRlhi0U6ik7MUjM/+ylOr54hVSCwPSaU/znUcWirdR8T0IaiuH5jg5EWjviaHJXQsvjEzD2ACU76KHTtXnznWG/O2Hh2+0Nw94eyXPnByK3OlYKh9cavKciLwu1B0RoRPvRRXgq71E9slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=lo1hHcoC; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="lo1hHcoC"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d868d014a5so1307931eec.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467156; x=1777071956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIT22lpBhdrkSsKE5y6HFSbXhz+lUiuwd0sLknwDGlc=;
        b=lo1hHcoC6l1+rLw3HS9fVLIhF9ut9fK1oUmiBnTxtV5cV6chgk5ykYi8+iuJgPe878
         BZoguEp7zQLlNMOFMpw/kkbvztE0aD148p0+D0Q0dE+0PXCbke/HMcFvgPUAi1rBlx7p
         k/ixQPTrAJCQi2NdOVinyyVxTgG7avX/PWmYTy3jLvik5CT4tlPu0XsJUWxRHV00gXs3
         Iplxeo8sTB+1Kz1w/+Q1Gej5SxQAsmnZihC4NFOL64a8cCbEskGOFzvSTDKaSxun3PAl
         7aCbW3PtuJF9OaMxWj9KIhcM565pdAsb25tRiExIixN6XlDv3BKSypfBlutwBm1Vm1EN
         bDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467156; x=1777071956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIT22lpBhdrkSsKE5y6HFSbXhz+lUiuwd0sLknwDGlc=;
        b=BV+CaK1px1jnnx1OpscTMAHY6r5Xxm0IBT/zOF0hCte98OdEXHgyrqUfRKVtRycIMQ
         b1DedXz++GO241JLVqmTEwU7Fjdqwxkrufh+moojAO9L+LPWU86bdK8X8rWROy8hV6gd
         qbF0ZMU30eah3RSHyYJHn6YFvh3BO19flHHCbKBX1w/8vL2l3XXzlJxnv0UsMupMx4hp
         Nqzw9NcrhgPhlXSnSxu9MFUme4Yl0o4aTxNJWzVJzh07hKGJWu9K/bGBK8JV17JLncnB
         yYBcagYDCZFCZkeiswz/AoFynRW6ZbAv4qeBM7EbH9et4J/5JwEQc9EseXOFuam680ps
         b9AA==
X-Forwarded-Encrypted: i=1; AFNElJ9kXrkqUZlaqZxqUW8qE3uN3sImtpS8//5whAivarBLsfnU8kHluN9FSfuG4sm2joGfiJ0TuSzq1qYJ0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkx7AKScgFtZbufZUK5N+hzIl7Y6ogSysQf6XuoCe0pF14k10
	5acBNXQ9Q6nAjOpvPYBs4XpcgHfVSaOcvcfA4n3B7lTvYrlpmo1FRAN9Xkh4TcBrdPQ=
X-Gm-Gg: AeBDiev5bhhtiNCkB9ykGMpXl88CPHLz4XciSpz47/g8XjlwsMZARakY7+1NaKPoiJV
	V5M9qBJB+gDTXpEjTZW/nvDYmu8qWH5U+jEcHmQV7hzgQyX9zyUJhnxLpcd+Y20roBW2mF0NNvF
	r7lAu9NDQFS28H8/2B2Ktdusfm0t2fUSGE/1I+v6IpdBpYNl4DBkEJ9s6yZ76yv5AwasFysYi6r
	ZEZBX8YLd90+lzyNQQVumbV2jkZUEwpSsE4gvh3b3qCLHDn0zuph25UmC3VmIwtNdfo7N8usOgi
	E8OdBLQn3ECRw7Hqqgq8TRfpbLn1pPIG4FRea0CKPKT0Dvb04g9f2oHE3DLcS397ESycqQO1Cv3
	56JXvVlWIr9dMXFtk9JPGgVNTYRygw2LOu6CA3oaMxSJXQwXx6A5tAdMGXeR7zQNro2HVwR1P/C
	KQb3flUG269F1sDET6Z38IDl6QAEmEzR6bAhL3/Q==
X-Received: by 2002:a05:7301:4593:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2e464dafabemr2362824eec.4.1776467155749;
        Fri, 17 Apr 2026 16:05:55 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:55 -0700 (PDT)
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
Subject: [PATCH 7/7] iio: pressure: HID: Replace method press_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:50 -0300
Message-ID: <20260417225959.16688-8-natalia.andre@ime.usp.br>
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

Replace method press_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/pressure/hid-sensor-press.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..3d609436a85a 100644
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
@@ -225,7 +214,7 @@ static int press_parse_report(struct platform_device *pdev,
 			&st->press_attr);
 	if (ret < 0)
 		return ret;
-	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
+	hid_sensor_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
 					st->press_attr.size);
 
 	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
-- 
2.51.0

