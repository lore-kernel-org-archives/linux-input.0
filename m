Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF83A4F30
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810184; cv=none; b=DGgPyvWYYXYMKjrJ8aJBS1Cdfgsm0K98Rcv+RbJP0MaQXeC5+MvSuT7l/Ui9Mkgkl7tAi/ezuauKO/Q3CcuDM1BW3YOcSaVfoGXaQ/k7hkRta0ezo2niYNUQFQYmlsUOuJPLzSHjQCUUAEVoV97cGxWUT3iQ7YFhNu89cjUfSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810184; c=relaxed/simple;
	bh=JBGxskPAlxesezIsmdBy4JBF6ffl9IJu9YrIIh4DFo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLoobXWUU9Z9jy5IDF2doRUVZZvwBZzX9s4KNctgEuoVQZh3fxqIGmKUNbViUr57ws0DwiMlX7M5zNeXdRLkqKM88cGOLVd3QQaVNCuXnHDr09OjealvrNbccohNvZfvaHgE7Zz8tOZUXN+qHXLs1f/OF2k4VjEWN/fQ5W/tI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=h2l60K/G; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="h2l60K/G"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12db2e415a7so839993c88.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810182; x=1777414982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMgcC6xmHzm251G4tD4kusrT9SwebP5b/OJN5LCz8G8=;
        b=h2l60K/GbUaXeNw/45Vh04iBV8WL5o/JF6gAsoT6dgFvkgp83Xu4u/r/ns9uzTr3In
         jB7LGj63phD1ztbl1U0Jjs7bO9a3qNnO+pkxYvi51HHoEJhpLj2BIVmh76J/w9vhewl5
         bwGQssCt34aiS2K+XvHKNqgV/Zlk8XRjaHSdXj0oWlh0g4NJlchDuosTjzuD058VtKsu
         IjwjWy2GqOLHItnBTWaQYgJ4rACJidUeVyKdMe1TvOgTDjPTGCtz122dtiYPTUg0qEJ0
         8NRQ3L2OHvdaLGPEggRv9VxQiUhiTNGIJLLG15nRIFY+4K+e71mgBzo7RCx0CMOJqwxd
         SbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810182; x=1777414982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMgcC6xmHzm251G4tD4kusrT9SwebP5b/OJN5LCz8G8=;
        b=f+V21e6/lziqzS0aVkEQy7ZWnOINlbQteMR+Ys3l9PxVT9KG1xaFnR4chh7yERolSi
         n3oBgLSxQFJshshVfILLp7r9L0R5ZKzl8CHgo1jtQ/7p5QhTmgMmSq1JGhBe0IcTZLd7
         MIEmK8sCcF71w7yeC5ZWFVhRyBdzsAPThorywgccBM/UBwqlzTPE6mMSijUUdcjBS1tH
         MRwrkODS8fQHIvJV5l9IpFT39aZ7o/kAW44fZ+puOcAEHJyjh1DU6/2HXrTE6321zeqo
         1zQmt5d7vIPShYobGmUTI7FFdJi9dosbAKDm1dq8jJN6X9+LFD/pYLkZf2Tr7LCPvNIJ
         A4sA==
X-Forwarded-Encrypted: i=1; AFNElJ/lggTfRxzl3BpWwu1YrTQQsPd2dCAVSnSQordOq5BloK+4tGvWw4Re6wOYYLzw7sD7RPZia2my7wBtUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQDsVmXvF9fU3lLwZEYqNLvs4I+D7OX7W+jHb8tAr6LkXVa1Q6
	fGixET2rRtysqr6tNmItkFJZaG3PW2XVdtLzBIlLUzgYgppbcZ7L7KunFSHOxe6MibU=
X-Gm-Gg: AeBDiesuBA84J7EWcgeQWcBT1UCb7slJN6vwYwd1te/Vwi3rwbSJXqPcJUKfmFl0wej
	/F3ylkl9o7I3wWLJbC6cwo49JaYjGmYiYy9c+Px2tecIZg2e1SS+Gyqc1MDAm0nFeHpCJi6km1Y
	jrQoBjzFfoaQn/I0ZuDQMF8gX7HUa6m65iRKIqPZfInHcBYPSqJIbcTGBSLe/TlROM1yctNKQxN
	tRgVv/REEzPy4mIwp+6e903yrWWlHsldkmY3De5muS+ZOFUQNoA0OhHJGRKQJ/0S4pHYmwzW5Id
	in/PYzswhhaksRueRm/FfgzMePOEWDfse3+QyEP7rSCG4f9O1PbmJBfdw9XReSlKILo2w/5eTT4
	z1GRf4ev6U0sW84sYZu83wDCyTVZFYBGDrFkud8G1c68IT/Xb/hKhMs3jsNw+4MqrflQDVlyyme
	ErpC98MAnOFfebU+Y33X7Nx9zxTJcPLGddB6yKDaDqXpq1PvXG
X-Received: by 2002:a05:7022:1282:b0:122:33e:6d41 with SMTP id a92af1059eb24-12c73f975e0mr8682377c88.23.1776810182431;
        Tue, 21 Apr 2026 15:23:02 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:23:02 -0700 (PDT)
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
Subject: [PATCH v2 6/7] iio: magnetometer: HID: Replace method magn_3d_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:38 -0300
Message-ID: <20260421222210.16016-7-natalia.andre@ime.usp.br>
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

Replace method magn_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e47..f1939da22e0d 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -132,17 +132,6 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
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
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -418,9 +407,9 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
 				/* Set magn_val_addr to iio value address */
 				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
-				magn_3d_adjust_channel_bit_mask(_channels,
-								*chan_count,
-								st->magn[i].size);
+				hid_sensor_adjust_channel_bit_mask(_channels,
+					*chan_count,
+					st->magn[i].size);
 			}
 			(*chan_count)++;
 		}
-- 
2.51.0

