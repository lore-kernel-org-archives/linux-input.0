Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD033291F
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772396748; cv=none; b=h04dxU3aDWDUNeWHqH1gxmqQCCzRSxBx+W5cjrv4UOajvdeLdkthEGq4bDqYYZK0625C9e0ReTlhhuUDCD1Uew+V//kib5LThXzKBWcMGoWH6fV4lYkORSpQ4JHZoMbk+pKp3qn1lA+Pxgln+WnvnrJL1wP9PuEGDdYhZBBJzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772396748; c=relaxed/simple;
	bh=ps7ZUToN5AgC3idSqYVCwGGorlD/RoDfLukDDAMO5jY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0p1Zq6m5WEMzHQruFF+e/wKVMr0bHvR7AvUvGWNTZG1qhePN/4SSsoWrecJQrHdUbmhrAESvsYpJBH2PH60aSMDwAw9GqIjuRny8dX1/WY0BNVvGcs2Gd3Sf2UTUeasBSM5O7vT8dMqtTVfhvC/x/kOYx1s7uPBFhpbq1PYSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AHcPZkHw; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AHcPZkHw"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4ba9abbecso4826736a34.1
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 12:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772396736; x=1773001536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZodpChBQz3zA6o/aOiIaqgV1izpjgwL4nvy2nT3q2A=;
        b=AHcPZkHw+WhdQKjW2p817SsQLROvE08xKc4xEye1YmJNaFBoZWVvPg7WBP1QL+nzpX
         j1ABYA6xZ3IPzgnR3TGlwPWDqyvQwyGVVG9qOCiDUUAGdKuLm0UBlm2zMrI0t673pBcq
         X6C5glM076e1YeHXRVLgQY1+xMnuxE2tsJKB/KfQRw8XSUf63UuytsU6HmPE18MVsv3j
         voYMt/8Fo8i3X7Tdufc9AIoHZZ2Zdgzl/vBq5nV98nKNLY43BwuqxQkjhl153wW9N2g6
         gcsQO09AsK5k/RMmHZeTvZYBfZz5/5VBGUb4dJuJwZr4bhsYK+D4t6fTFRAvfwbw/7fy
         FTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772396736; x=1773001536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eZodpChBQz3zA6o/aOiIaqgV1izpjgwL4nvy2nT3q2A=;
        b=pwUeTLbDwcFJcDqlcgZcvtTNcEAQWTlCAbXh28Kw9uC8zInAmYzKdlSOB1kgXHj/TS
         stIdZg7fJpOHmOkoRFb0Ylqs4SXO6R8ZG1Rf2teMTMi9GGXLXbEB1+piVnNsznRTzlHL
         6/BNunlgh7ylxC5EJ4fr2UubU/fIxdXHPnz+eALsXABNDrBC4/+60/5kuSNuWP2kYtNr
         GJ2lHw9E+SX/DE6YV7dHfryCQOPCHbJXFfia/BFqdxwZrPobcElHw9XIv027ycIeU7a0
         4FmPoGc19qFNDBQqfqOY9romAkI/Kk8CUGgQWcxo/VlL3cbrCteTunWWa7fzgOmrmlJI
         Lg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgnnjVmb6damVsAAseKukxbPzbSf/Sx/AGCgJ2fEEaLC8pK6qOaATQdOfals+K2ZViX2Ng1IADMXac9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbtiJfqIyERPW77PVbhYFm9m5geayDld/4zj7Fvr09CtxOEwG
	6qNkMrbnZXgZZjybDfpHv3Qxj2RbicTg/Wd+Jd53lWU5dLk2BBYB34e45vIcJD9zxq4=
X-Gm-Gg: ATEYQzxvrlIU9nW58IKV0eXqA1vUJm6twPcbIlg/GwkyIh0GTm6Btvv4KyJscsnJVjd
	PnkXzfQrGyqt8DIj0QUHzbiX7glPsadDwM3dq8kCQlgVSFRbJGbfxSgD5uNrwD5EtVSQnp8ziAq
	lA/y6eDDeyzpIDMCyyyKi/Eageu7CxkXfN/1RJa/tKSHyZ4cya7oEcnBdnbRBhBQahMKywp6aZN
	EG06wilfLNZUkBunf+NJHw4wpCkbKyeYllCgMwSwcvRtBc//aUxS6v6Z0cAOf/SHGvrxaEXpM5h
	vZjr4r94N2WujtudKGfFlY6oUPT8xJ6VQn9UdqyW/lvjN39SM0iWX22MJOJoebusnkEzYzcGR/I
	ZoRWCH1chmCI+sHUL13E8hxVFj1mySWTdQzgPnenPeFgZdmDWpblHU5Id5NrAK4a02bASrxOdUD
	lVsIVnhE+Odg8HGEeN1pjAQ/EO3xeG
X-Received: by 2002:a05:6870:b2f2:b0:3e7:fa5f:7250 with SMTP id 586e51a60fabf-41626fb0924mr6857750fac.33.1772396735728;
        Sun, 01 Mar 2026 12:25:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d277316sm10063025fac.17.2026.03.01.12.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:25:34 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 01 Mar 2026 14:24:53 -0600
Subject: [PATCH 4/4] iio: buffer: fix timestamp alignment when quaternion
 in scan
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ps7ZUToN5AgC3idSqYVCwGGorlD/RoDfLukDDAMO5jY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBppKCwYE1zFgBlGDGu3K1oCQ/jPEYUUNKtvI1Ot
 1PILepELrGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaSgsAAKCRDCzCAB/wGP
 wPs9CACHinHJ1VZdedi8872GMRPuqVtNXcLmjGgG84f0Hvo47puFDicij2+7ttc5/hNCkuucf0Q
 VxweBrvdIVjIgo+whzd5dGCz3jnBWwNbsiT9t8EuvxNQ37DQLwbvoeiA50ilhWodXv9zNqdwsda
 6PcwvSMcYfoz7Gc0PtmmRphBtQErYG9exjFfCu3jkkc0g9VBx1lvJRGiX7XrezZB404lj5J9BeY
 POWRk0fM95AZ/+qFSv7Hjv1kBr8LrMzm8ptlHzYXku+Pk6kQvdISAXU4Q9TEOy9V0N2aQXb8GUK
 xDkChsUIJQ5XV3pqfKcHZRupjpZ8aijk967gxZjVAOOqiGk4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix timestamp alignment when a scan buffer contains an element larger
than sizeof(int64_t). Currently s32 quaternions are the only such
element, and the one driver that has this (hid-sensor-rotation) has a
workaround in place already so this change does not affect it.

Previously, we assumed that the timestamp would always be 8-byte aligned
relative to the end of the scan buffer, but in the case of a scan buffer
a 16-byte quaternion vector, scan_bytes == 32, but the timestamp needs
to be placed at offset 16, not 24.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

To test this, I used hid-sensor-rotation minus the first patch in the
series so that we can see that the timestamp actually moved to the
correct location.

Before this patch, the timestamp (8 bytes ending with "98 18") is in the
wrong location.

00000000  6a 18 00 00 ac f3 ff ff  83 2d 00 00 02 d3 ff ff  |j........-......|
00000010  00 00 00 00 00 00 00 00  5a 17 a0 2a 73 cb 98 18  |........Z..*s...|

00000020  ad 17 00 00 6a f4 ff ff  35 2b 00 00 ca d0 ff ff  |....j...5+......|
00000030  00 00 00 00 00 00 00 00  2a a6 bb 30 73 cb 98 18  |........*..0s...|

00000040  92 1e 00 00 50 ec ff ff  ea c1 ff ff 78 f0 ff ff  |....P.......x...|
00000050  00 00 00 00 00 00 00 00  8f 3b a7 39 77 cb 98 18  |.........;.9w...|

After this patch, timestamp is now in the correct location.

00000000  55 0f 00 00 dd 1f 00 00  af 0b 00 00 ec 3e 00 00  |U............>..|
00000010  c7 17 68 42 6d d0 98 18  00 00 00 00 00 00 00 00  |..hBm...........|

00000020  57 0e 00 00 c8 1f 00 00  d1 0e 00 00 42 3e 00 00  |W...........B>..|
00000030  56 a2 87 48 6d d0 98 18  00 00 00 00 00 00 00 00  |V..Hm...........|

00000040  a3 e2 ff ff d3 1b 00 00  0b c9 ff ff cc 20 00 00  |............. ..|
00000050  27 59 4d b3 72 d0 98 18  00 00 00 00 00 00 00 00  |'YM.r...........|

I also tested this with a different driver not affected by this bug to
make sure that the timestamp is still in the correct location for all
other drivers.
---
 include/linux/iio/buffer.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index d37f82678f71..ac19b39bdbe4 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -34,8 +34,16 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	void *data, int64_t timestamp)
 {
 	if (ACCESS_PRIVATE(indio_dev, scan_timestamp)) {
-		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
-		((int64_t *)data)[ts_offset] = timestamp;
+		size_t ts_offset = indio_dev->scan_bytes -
+			ACCESS_PRIVATE(indio_dev, largest_scan_element_size);
+
+		/*
+		 * The size of indio_dev->scan_bytes is always aligned to
+		 * largest_scan_element_size (see iio_compute_scan_bytes()).
+		 * And this size is always going to be >= sizeof(timestamp).
+		 * So to correctly place the timestamp, it goes at this offset.
+		 */
+		*(int64_t *)(data + ts_offset) = timestamp;
 	}
 
 	return iio_push_to_buffers(indio_dev, data);

-- 
2.43.0

