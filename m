Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB5346E66
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236251; cv=none; b=JpAip1JuVBa/dB+Yef9EkVxXG/QcnTJoeqZN0r1B5eKO7t29I4m/JJq8a+QQo2N4Tb+zt/5GX7w4Ufch7t5brLcNSYiwDcdVBmDS+s5ioAYFEZvdTzJgo7rERuw/faY68dcbQjaIScP7xXvJPFSVoJPinEetgTcqYt1ee2TdNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236251; c=relaxed/simple;
	bh=NbbI/3xTJIVp9rP8bTvgfcJaLoAVOjM37WP3ObO/V4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvYz5z1nJW4kQLn1P2osaBWGqgbAhVUMlCZzORyk7Lzqj9i1DAcfJVFeHfrzbASxrvJCYZ8tYnyLY9q58v9hcdg71MYkeTe6Pq5qK2/gOTt7oiwJdj6YlZHQEgflWNyIiHjJhWD2AeRkHoLk45LdgVgf8KP9fdGIuEK0eWXo6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrGXq32E; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrGXq32E"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899c97c5afeso18220626d6.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236248; x=1772841048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl9i/tPAcm9jn+eDgOCz9wrF4aIKmWaaUz0y8PMJrEc=;
        b=GrGXq32ENdoNBNOnoZ/dEbPGrfYSMvktXHCJsdVYeDG1pTf4GtglIiwVfoCc69Nr50
         RU+4odVWSh3W4r8ATwdA6nBGRvpZNQIZQY457jcyfCH0MR3Azq0booCgWEjRpoF0Y9QM
         ZBl7+r+qcmxVj1leyz3nDayOMKB3IDaLSpvAf0qq/Zy/wRG+D2AMD4d/hdd6Z1LQaOCw
         BLtpWdX1+wLJIaU6xL3IZVfnw1KGAsf6+Q8jXxAES0IO9icOVKqKieV+HHjd/YxzGWUm
         VXK5YsNNng34gBCBwXnY3XLBD0mCPtMx3VchEvs9nf1YCz/DCtG/g8sTI9JfEnQrV8vb
         JASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236248; x=1772841048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bl9i/tPAcm9jn+eDgOCz9wrF4aIKmWaaUz0y8PMJrEc=;
        b=bUS6iueYKnJWi8Vk2MQWuSP2w+UdVWvHl8QF0eBMTiIlwDJhhA8N65RCFiE6ZGpmQy
         ymWyYl89WMwWNvrx+j3AvyHAZtfodtkx3TMVXS8XKnk7HcQopfMfE/ykwkNGrbnTX/B+
         gwenYDZUjRxut+cGMW/uFSue/l8YKqCWpguaXeSeioKsq8cwSOW59OH3EKAiqZi6/GDn
         zvbQqXnv2aZK0qnj9vYpzj3kIpxjCnto2fCr5iIAlm8CUvQUGYifXe8S6LZq1DC3dRlq
         yjHMICyfLnybPyKyR/n/LdHjIiDTgpT9lsoTWBirvfCYvmWwomqhj5IP9Zoj9xK19gHs
         as4g==
X-Gm-Message-State: AOJu0YyvvZiH/0bMzvwl9S5O0dDzJhKyW0/NaljM4f3AQ3Yu+rmOs3vy
	SDuJpKoiO7ZEIcO1eWjGy5pzckMfYGUOgax/nztC5Rt8rDS8VOVh11PY
X-Gm-Gg: ATEYQzwrDfpJYRg7EqHEJIm337bzyyV+wHFiKTz7rcTedLRfAZ266TN5pY+pQAFbbrH
	Tj+7ipTbqOr6D+FbCC4ca8KzKm0EfI4aX/1NDJOu0UQZAXfHOtWScvd7kCpwasfxBbYoyw+/JWo
	oiSqA3C8FgDqndM6ydo54rVptEmtsUPrAbjfbmJrqK0CIyF0f05fJRL6NiNumdSg/oWWGKRtX32
	Js987MUan/bLnG5ZxL92udB8os+9emkLGp3PE0MeJ7/5Yz4hg1zl8UTa+lSYPmmXDk9kxO4AdZW
	C9BYSJgzUlqMl5xLQWUrjuAfx4yWf+HagLCWtL0vBGwjNemmji/PYktXi1s8lsX3Sjjls5nWQAR
	PWqzU0tnPuQZiFo6Ker3u/qUMelnhxUkzTjR3q5WVHCAAOozEZE1LQw2e8rhMY1hY9zs+mkSPQv
	4NlqxIWSM4MLttmiaF9gPtY4PwLb1JhtnmYhgfYTHAK1ruQAi72g==
X-Received: by 2002:a05:6214:410c:b0:896:f6d5:c73c with SMTP id 6a1803df08f44-899d1e3433bmr73135466d6.41.1772236248367;
        Fri, 27 Feb 2026 15:50:48 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:47 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 03/18] HID: quirks: Add additional Arctis headset device IDs
Date: Fri, 27 Feb 2026 18:50:27 -0500
Message-ID: <20260227235042.410062-4-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for additional SteelSeries Arctis headset models to the HID
quirks table. This enables proper device recognition and handling for:
- Arctis 7 series (7, 7P, 7X, 7 Gen2)
- Arctis 7 Plus series (7 Plus, 7 Plus P, 7 Plus X, 7 Plus Destiny)
- Arctis Pro
- Arctis Nova 3 series (3, 3P, 3X)
- Arctis Nova 5 series (5, 5X)
- Arctis Nova 7 series (7, 7X, 7P, 7X Rev2, 7 Diablo, 7 WoW, 7 Gen2, 7X
  Gen2)
- Arctis Nova Pro series (Pro, Pro X)

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-quirks.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 17349eac5c3e..65a6f6ab30b9 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -714,7 +714,33 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_P) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_GEN2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_P) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_7_PLUS_DESTINY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_P) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_3_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_PRO_X) },
 #endif
 #if IS_ENABLED(CONFIG_HID_SUNPLUS)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
-- 
2.53.0

