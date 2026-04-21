Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBB39A80E
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810155; cv=none; b=hxxf6ADki+cjc5+GjuBPp4qipkV6sHyNb/LVNEtK/g0czNsUSnazeRfu4S6whaTWoyrTi5qaTnkwFQ8eEtOyMil++gh99G172lpvdTW/WkY9c4zpF189VYFtGFDY0L/43fHzcx7G6qDCIDaf9p5Z6wg9YGDsSyFq7yDX6MTZ4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810155; c=relaxed/simple;
	bh=spg5rQKXsqW1a1lIS9VujueN2QCUDqNUSHNDWHg6oCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsFYM7JEtFBYiliQsp8B0EdG/1yLACq0CwBP3vl6EgqncmAcOj8WB1h9zM0sqhCAw+fAQ8B71GSVYsjEBS8DO1gk7oYOn54Uel9SAQ3QWcPvo7/NnKG/dI7JZneiozf7U2u2Bhkrag12VJ9sv6JPB4rfaJsHNIw9tLET9Umge8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=bw2pqXAb; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="bw2pqXAb"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c726ef332so6501608c88.1
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810153; x=1777414953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFReESBgBDz5s2/o3KOByBeZqhXkDZ85laE9wQTf5Jg=;
        b=bw2pqXAbaLpm9CpffwkHgDSGDIud+97eB/Vp49SerP4+5gNjvftAV35jljtnOVEiFw
         JMRYAuqCR4AsQ7IYWDu/PzMma1vuU84ButgIMTWSRb/gFRFn6YRIG1MtED/MkpouBv9+
         rm7kxuZWXzU80RrN/dYdHsLrENwhLZNHBeEbk0qgNkDUCE1CqsoYwD1forvk+68sGbh6
         GaKcE6apHzd996XXbfIXx/BtXzlgJvmibA3WC/jdsdknbQlNJTDpKvgor+9OgrmEfjgb
         VwkXWEYGq5woYQJTEO65py0mBZ5drp3Gkxr30cQNYQMCLG37h7zHYPqdeCim05hIKv8C
         8LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810153; x=1777414953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFReESBgBDz5s2/o3KOByBeZqhXkDZ85laE9wQTf5Jg=;
        b=U4qbZtlAiEgJe4FMPqcmWScmdJOlZcI28rJt4HhJPm8hVpJwBA9Wflf9CcbqcRCXbF
         ARsrHwbQedXLRxBFBk8fkY9qKUj1tQm/g+gqznPVwXTFBXuHuYDmjMwdpfOpG/GBz+T2
         rKKJiy/yAjDLDWQX5hLdwLxx99J2Obpf1iY7DfZhUr280PezH0Y05pkMe9ciHxdn92EI
         mNgHNRpaSeTo6J7C7Q+8gOw2SYOGg6oBTihRbuesFy5c+bMaFMI3WyrrZ/kuUqu4gdf6
         jIogz4v2L6/zNm9C/N9QXXU/uAE0RJ+VqioUjS/PUr+Vhn/8DV2IK/CBLG77GIhzRlMx
         iMfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zTbKLWLOumCxwwLyYxl9GmW6EAcIONChQw6wHuedboFHEhiJH7hp610H1nXPkhGPcZ/mzLDvnsj+a9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHV5/867QQcmghGCVNb/2OqqSNQfmiOXCsRq0tgvN8prJ5aKut
	JTrBLxASO9nP7AKamxs0SR76GEbGjWcwOEXKSngv4vuSrAY0iRBkizA2tjcW30N+1Hw=
X-Gm-Gg: AeBDieuQtlgV4XKLO3GFXBJ4HXnkjQD539yI2mZ8RsYVA9F2+3UNAy9dqnizbyqU/BZ
	bZXGbw/uh/a8KmxFhDCkR0vARP2jffcD+80ssl8G4fk+gbHcTAjvbCJgkX0AOkNgz9ttwzMnwyM
	ODBdqO5EXtoR/a4Xqy1XX+V2G5fh49eJasOTMcn3TMpDl6s7RJS4fBCGMxvQE6IRAE5tZV7F58p
	nPf0PiiM1+1Hj53zsZmUHTJr2LqaBUdMHjq1agx9qP1l0e/OkMH3CBrGd1i4eAfG9xafZ0Nxg1e
	1GWi0Ka4pNFc1kS6LpRRW/cTYOrD2gjN2LUFwJmsHkWMcyg1EqpEyVkt2kD35x59dC5RhXdck2+
	5qF2mnJicpcKSvXNvb9DHCOJGHnQMa/dcr3yClFAdivPj1hZtFyG+fwrtUTwvyJzvYIVcOUZbsF
	C91Xv+auw/HV3w3UwTkQeeX44erQdRoEyebiPr2A==
X-Received: by 2002:a05:7022:e22:b0:128:d494:a1ab with SMTP id a92af1059eb24-12c73f83681mr11273411c88.15.1776810153245;
        Tue, 21 Apr 2026 15:22:33 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:32 -0700 (PDT)
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
Subject: [PATCH v2 1/7] iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:33 -0300
Message-ID: <20260421222210.16016-2-natalia.andre@ime.usp.br>
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

Add helper method to deduplicate code in HID sensors.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c   | 12 ++++++++++++
 include/linux/hid-sensor-hub.h                       |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index c115a72832b2..3ee6e83c6cac 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
@@ -589,6 +590,17 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 }
 EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
 
+void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size)
+{
+	channels[channel].scan_type.format = 's';
+	/* Real storage bits will change based on the report desc. */
+	channels[channel].scan_type.realbits = size * BITS_PER_BYTE;
+	/* Maximum size of a sample to capture is u32 */
+	channels[channel].scan_type.storagebits = sizeof(u32) * BITS_PER_BYTE;
+}
+EXPORT_SYMBOL_NS(hid_sensor_adjust_channel_bit_mask, "IIO_HID");
+
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
 MODULE_DESCRIPTION("HID Sensor common attribute processing");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index e71056553108..6523d46c63e0 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -281,4 +281,7 @@ bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st);
 int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency);
 int hid_sensor_get_report_latency(struct hid_sensor_common *st);
 
+void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size);
+
 #endif
-- 
2.51.0

