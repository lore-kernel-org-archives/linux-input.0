Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE9425CF5
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105843; cv=none; b=Tr5tF6vXD09jExveS+Y1FT/4Jz93UpD6DEJwVpuD1ffae8qHro59NovpzIMPsAUix/dFdHunZR+SDPQdX/dcxAP2bSaWJYQABwqwpWGEMHK15XLLpu/D+7ff876QcNrP+O+DELWjfL0cq7GwpT6p62ANd+9N9JgnmnGr99A+uUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105843; c=relaxed/simple;
	bh=tENc3b2ujwLVWiIbulhKwWmXa6SPFnRuKhDqgfS/eJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCuNF74/kA5Mz9k9w1W0gF7fetNRxHNmzxo9qsNPchEJr0+AuotyiwCFok9jLrdUG8CzJ2tGx3PwD+htyDB62tDE7gKKd6u224X8UJohqaJSrv4PmlLD3MefjbuewITL0kqYV5G7peMhi/HnjUCWjqpJGRR4Xwbj1PGghHEqlsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYvGDhZb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYvGDhZb"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36da151a152so4852862a91.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105842; x=1781710642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0bp9Phx++dnFcpbOm454dLs1UbfqAsMiJVFEpCbTqI=;
        b=MYvGDhZbBSnz+1/ArbhNZ1tol65dKwNKrlMqfQEUtHdXIPxSMSwgQoQtA0csPVVsfe
         2jJIjmZaZvJkcTIGP/ewKOFrtowfeyBwV39MSrp1sw/JtJgDQZ1D1hvLOq5YTLalvpYe
         8nnpTZfmDAS6WODtEgeHz5BQfMzMDEwia/gN76Z4Ldqc9KvZAdRtU50+eV0hJBgprNrH
         3JA2x8e585EHkI2l4Nx9G8EYOJgDIN/2h0Bskk66+VHoYOCxilval1qMv2dfOFwgPp5a
         aiZhAaCul65i8dTa4QsFPtKn2H/0zDLmgwzW3k7mLXT3nJa1wew/m8FUIFhw4gK3FTBK
         7StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105842; x=1781710642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0bp9Phx++dnFcpbOm454dLs1UbfqAsMiJVFEpCbTqI=;
        b=Ptd9aP+9xtSTFfW+zbDyC8lm5HXM+VrQoGiH3S+OChNfW7r3fRIVzZ33FJRg8hi/V6
         hq7WYHjbaFH2Rmd+zgoJ78WiknIIGNx1Br2Qw+RpHrlUp5N5/UkjMvDnyVPDpiAGKrCU
         MdVK574TPg2WTQBP1V4OpuAFW2nJANdwpjW5sGgXHg7jZi6B1p3CavQSqQv1tP4ZNyrc
         I32Aln2Mshwue/pcTtxLgX68qB5fOCRYgPA9A72r82D0c++CcL84qgIq1DAFGWcj6U3N
         GKSc0iGwu94sY2KyTsWGQ0m8JXm4qyvZ+UkgHPoBjnxAW63PmCIwuiDXvi6c6SRMaT1P
         9SZw==
X-Gm-Message-State: AOJu0YzulizElCZAQtLC6+vampxEiUwwFge17Xq0cTVNou8GeE/FrAV5
	L65bu4nlhJdL04ukWWq8H9jRrZyUfi3P6OizQqvymvZ9ILW7jqAS11/P
X-Gm-Gg: Acq92OG7Ez+z8PsCyLIFfssi58kxSl14TWuduuSXtQRZztlHNdWWvVYI/MzK4NMcyKI
	wRbfmufBlKgJN4yajSGbs8qNW9xWc3plvHdQYzprJkRhUIcteri2430D39dHjYiUyQxQcqzo2Bd
	6sbHhjPsBJB9tkqhVH/0N+uEkVXkDH71XFwWRTk8A7WSuzE4HjVbUMM6mtcXWL5mZY0MEll9oX5
	lj8ZnmqZDmXp5MoJK6waj4OmJpWRLHCCxmDEnWMu8E/jKMGRs18yXSa32ul4V7WJ+nrFE6LnyVg
	VHfkpBaiAOLrXcXnWDZVwt6ro381+yfsKF4poYFwyhmjJv8bSb3hRLGczqH6CjuqoPE5OUO86QK
	u7igpUJ30mJE8E8hM67DM1im70F0GnY7xyioGMvR6CD5quqbs4+XK0EPovCcMpt3RqHYQ830vVG
	68yGa7tQcJ01qz8NgahxNhgVvF0m7Uxh9TUynf+c2QpTbHk9TPNyMVcUTMQko=
X-Received: by 2002:a17:90b:1f91:b0:36a:6ac2:8bc8 with SMTP id 98e67ed59e1d1-370f0480bd9mr26616407a91.14.1781105841878;
        Wed, 10 Jun 2026 08:37:21 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:21 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:03 +0530
Subject: [PATCH v2 2/7] iio: accel: hid-sensor-accel-3d: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-2-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2bf05ab5235e..42c4259bf209 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -223,7 +223,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data,
 
 /* Callback handler to send event after all samples are received and captured */
 static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -247,7 +247,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -283,7 +283,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int accel_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct accel_3d_state *st)
 {
 	int ret;

-- 
2.34.1

