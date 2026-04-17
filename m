Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AB2E1EFC
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466898; cv=none; b=l0oBv19ZplySUvv1Yx0RjcKv94sbgoOLd9FG+kqlAtquEcrttQQrgdfj2AFp0qrU06Bshmyn+eQL+ZpjSqSsivzftYCra59mMXJXNn9hrB40pfNR01r8ve28exoEgA2gjF9P+o+D6xiBt1JbLWi901fFEzUzaicG6b4yB15GRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466898; c=relaxed/simple;
	bh=oSD6vd+aCBFYLgR2TiCTG3iBNbJ/i28TcOgGaLwWFlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HH/5Q5VPKvP+HKoI/hQTJJlmA38NdXUZti50JI50j/D29INqz1ZneFuW/zfxotFEdpjE1gAduMJddsY1dzYi308JgdpyCYlE0I264/9jXXCrEHo4nCmJNiHhPE0Hmq/aK1hYr6t6iLDh1Ggyu3iZZdoyJWZpFL7sfE3kCZUXaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=FfwMJbKW; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="FfwMJbKW"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1529048eec.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776466896; x=1777071696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5xHdxr+BnnZiKw5Bjj1jI+0XoYdNxIlHxnbJFtVPbw=;
        b=FfwMJbKWgwq1UD4IpEwiUIs+tcVSj90NNnM7fu4E/PF3P8aUj4k485KIz0wRWfs8As
         592s/BFBtXaDcJT9vlVRAispudPVe9oOb7oODNG6GNIe3JuTo4qtx2bmo+5hilMH5YSn
         NSRdBE0q1vXN9l9xhxIZopmkrScVAyP2OZduPjnYhrOhfiNwaVepcAYJbkkxVWbKmMTv
         9F7Tpn+P5Qqcq08WO/SNHLA5GwRHGDIJyDjR/tJWSgtK1zIe+tAOf5uEYWmqwxOxcVDW
         ivj80io/HkRg+StTaOI/ZibnVaKRJ0E8VdhqMphOdVppH/KnQ23MmfWKpi1fpv/MMkLB
         HlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776466896; x=1777071696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5xHdxr+BnnZiKw5Bjj1jI+0XoYdNxIlHxnbJFtVPbw=;
        b=RBONzekAOQGAYtQVBkDMtS3Gu1EO4jukFUSEg4PLOwS8hEWVgvZUkkd4xYnSC3KSnd
         gx0ecHEOTZ6YejC9uj4KUhlp2Q4fr25A5aU1VgUfiYC0RC0Kf4sZXbCHYrJS5Q8xAix4
         g/FNL48hwzOTKe7YxuiR4ij5Vzi/cYq+NNmklLUrOikdNTHkFkywcAF4/VaC8AUOFV1E
         8efHy/y0UH1iy0W9Kp0oC4ZmApeZpSxlwIMrCblzjH/AcNjvOzlb6AHUSVx4rk6dPnZc
         vZKTSaYvCgReywMM7zawDkv5It4wBrWqtRIlkZJHvNo0PzVORx+y0OkgA6pqz+oRAJ32
         KAjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+77grvF6wrHkN/oi59RAdic8dsFrW3qQ+4lcsBnF+4gw+9eSIL/P+fAeRnPa7aGl18AAdN0/p+0JJDdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysC4mPuKHzaeVc8BGu6rfH5pmHgY+9ZAmcPClpQSj0d7Z1EJma
	0hqv9Yl5zKNoWoJzuWphjB8u61KvjO2hpXkUaKZjCiT7PrhuOAtA0H48UcqooeHFG/M=
X-Gm-Gg: AeBDieuDbupMhMED5FhHomvnbpDoFzN1eWVf4quvS9eGtbZOh6kSRgdISu8YYA5RD1p
	gwqknGI/kuNgW+KAm1E/ziexGCQTbYwEnvX5FbpoXuG/V4yuFTkFt8dlimYJHi08ZolTSVF0Dqd
	w9u0tRZIUX5aj6otqsPcBF728Qh+1cq1CWUuFfLB7UFobnIT2dZWCz13hg8jnMyz2kowdKu2EyU
	Vp81pA7bFmzhFUF6HSrXF3tDY5Ah8lgPjy2KfDIcQYTpiYQl4UOgFv1i+MA2FlO385oRqYvqRLZ
	c3D1xxJBdPGeJkCwbtyA/pFL2tM7n3BEQCh5BZnmO0aoVvKxtpkuzC9KcslmW3Z8Mu5xXrlh6zf
	eWBPb7JcUqeoy0++DZjyp5xxsONAsbpkrLFXdYX+rxcm1tlzbwijFOJKVHZbQZWXJff9BltYHc0
	YEVF1vdu5SMne/TniyDM1oV/oxhant84q6bzm30g==
X-Received: by 2002:a05:7300:1351:b0:2de:2f38:a7cb with SMTP id 5a478bee46e88-2e4788392f0mr2307811eec.18.1776466896070;
        Fri, 17 Apr 2026 16:01:36 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:01:35 -0700 (PDT)
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
Subject: [PATCH 1/7] iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:44 -0300
Message-ID: <20260417225959.16688-2-natalia.andre@ime.usp.br>
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

Add helper method to deduplicate code in HID sensors.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c    | 11 +++++++++++
 include/linux/hid-sensor-hub.h                        |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index c115a72832b2..12728cfa5d44 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -589,6 +589,17 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 }
 EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
 
+void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size)
+{
+	channels[channel].scan_type.sign = 's';
+	/* Real storage bits will change based on the report desc. */
+	channels[channel].scan_type.realbits = size * 8;
+	/* Maximum size of a sample to capture is u32 */
+	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
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

