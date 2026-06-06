Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9B3ACA7E
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748295; cv=none; b=EG+BPINgPlj0AsXfrPGxRPjid64lheueH05xqPqzUFAP01zsNd5Ocntp9Ps4j6/PFg2LjZ2Za6e7Mf/TbSHzl/n4HB4akI9JtJTOZtt9os9QotGE3237C+tbMlbXlKR42wHxF0hxsTKrvLq9d0sbp6pru2J36ZbneFvINAIpWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748295; c=relaxed/simple;
	bh=bsaWDuC4+cRvmh5t8sNHdcewxT9X5/WCHNtfRMGLUQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGaTnCt0tEZtayReK1aQJeTUL7tXro0PwO3mMnjgdcUZuZBYlSIEwGulBUOQSVyMnye1r7bDIUuxamJfFVG+zmQ3gGMZdkKQkLjqpoOP0X4EuL/JXN/aE6kTM3+F72Ifl24tBNBchik3Zo80HHAsj6h5p2HztIoXZcDOfXXLass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzs7QoQP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzs7QoQP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8422524cb38so931265b3a.0
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748294; x=1781353094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4588pint4NDnIkoxZzI34aKv3MZCanP9NRLjE1l7gAo=;
        b=Tzs7QoQPFUdBVe3Q+SYqwrTYkgsEA+x+eH4WRQKng6MmSI2nBGzqIPpbENYGy9siQs
         O2pE9rL4OpXx4prLGc8zFfxGk2tv+sExL9As/BR6scSJlkd4wlrEIZcIvMW3lyi0vE3/
         NUDCZX3TWXqAdny2+p7QlklHvwALsgNOAv7Xb4v03Pj6fR5pHW8DV3Lu/YCOgCnHQN+2
         7pVyTYOjpZ1SDkOsTJ/AR7i1cgJp66jzYZreZcKfd6ADkEVnn5uOGhhE1zPH3gydPb0X
         OdgGUa0aCSNDTevZEljR88qnNswLaX+6ryZfBSlk0bL2yDPXBBhmKJc3GE+waYD6AV3F
         44NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748294; x=1781353094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4588pint4NDnIkoxZzI34aKv3MZCanP9NRLjE1l7gAo=;
        b=grw6E6EYQXCqDwP+fgElIP0vrpn6E3wnzUK1xMpyLHDnYpQj06gYwmNMKOc9Vr/WIM
         BXdvgzE+seCJIMeLzaWPIM6OoSDc1WR5XXYe7KtX8MRHZIuwEg/ikEPib/rjTcJXt/b9
         7T68c7XS1+k/hqtP4T76XnqRjVULbrcs1R1n8SRs3wuxVL9i6BMcLwWNvaCveSjeGt9A
         pLtDp0+gOExBvi9XbKQ8sNQu1rddtsnVScZTQuRUE32p/xLKCbmd36/IVK+BIqTwRvsw
         xmIkXGyiqiiro8jUdaIF2YRgXsI74pbX/KyiogUuzs9TJEaWrBXv7tZi/COjo6b7XlYY
         Jw3Q==
X-Gm-Message-State: AOJu0YzeVq1DOBnH2XxQMPphYKxSfHsOd+49Q33/A1slmmkKOgSZ67ig
	2nVKt+4CeoFCc/TrPsWQlMW7+TbqqakotXP260LB8Q2quTswq8xuwdfi
X-Gm-Gg: Acq92OFBAfD4s1w7FQke/u09fPksFQkBSzsoUMheh5DV5BGqPmW8u+pHgIeXzAGRDPr
	nSLLId6hETZk0VlXOQFJTgL80rAqyDzfiP7yvxq0Nmx2NgFWCTEBZMhCo6WTwCfIFVI+8xq65L8
	a9V3LLpaKps5aLvTPCGsxHxwoT5+Rshg09qg+KF/stZf0xA5GfEWeJU89pPFSSX7lWGxhqRFHDj
	xOk52rI8CnwEbpHN1+eOnque25xmO4IsJheKk7OXC5uWcFaTOjKfFYiS65O1QOsEfVyYajZ7foM
	lSPw7UpoD3i4wdcRBhBYeNEwlVn3JknbgrFIfyC5y62LASmgw+gfHP5oT6tYK2zk45v+CxGipZZ
	4aJfHmQrxrpE2Slx0iNKCNfdKHdDYUfJ9Z9mcpyH6Zng9O4pAGEBFItF0NV6MnTrJXF1+JuMm7s
	jQp9+456zfiQC0GdEK8PlLtmek8p2RkkQPlxRXhugCzv1UcK8bzLGnAG/5Mb4=
X-Received: by 2002:a05:6a00:23ca:b0:842:5b63:6119 with SMTP id d2e1a72fcca58-842b0e2f430mr7999274b3a.1.1780748293753;
        Sat, 06 Jun 2026 05:18:13 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:18:13 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:46 +0530
Subject: [PATCH 5/7] iio: orientation: hid-sensor-incl-3d: use u32 instead
 of unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-5-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 4e23a598a3fb..c7fbff498be7 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -189,7 +189,7 @@ static const struct iio_info incl_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -212,7 +212,7 @@ static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int incl_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -247,7 +247,7 @@ static int incl_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int incl_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct incl_3d_state *st)
 {
 	int ret;

-- 
2.34.1

