Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F376306D2A
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650502; cv=none; b=jrJl7IOVPn1x9o4VURNh6J4/a3LsT7zqDIF2Cadwg869mGRYRU+Bsab6LpbXDkVTJcW21nEwQ629zptB49wLIQKj5ER8640HlijQsMbmJSbUOXI78tFMIKF2miUQe6WhrNHFn9SLRHeef/EZbaLV/hPaG3Ryyi2WRV4K4Jxe1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650502; c=relaxed/simple;
	bh=W5gnF4umn5R/mXT9OvMFHlxH8gMNZRMGEFrIVMfXR8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=On3u3VuFB4Lv1+e+FMQQGdzQLNaEhMbsb4TYRed/iY8ySP5IFxQYr6AigN/Tw3imP3A32zLyrSJZVvT9yixgchx0IDdQNVQ488dhGAiAUVZLBM8mx9l+GB8BnVGu2cq0LqKFWZdYWdekjssB0hnnufk0upl1N9TE8/How/QuzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUvsBGHa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUvsBGHa"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8379e010b01so3852280b3a.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650501; x=1780255301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69ODxsQsPuaw4bpcArkHHQDAVjJyQ7CsdRTlp6b9JkQ=;
        b=mUvsBGHaWTGtuDXK336IBKN2tOI4xlml63BqSa1FXqdfJU+oLQbNyS+j77hwM5ndF9
         rlV7Za63AJIgditDsdKoZUMtDokz9rFVfyUYaaLwOGn5hEja8bNAckZjdtvBmhTKbahm
         xnyuKLrSvv94l4CUjOxltwsIqGRzFfH6UG00iJeFiermkJYtrlozI78nGygZbKYjKBtj
         jIOJMNqphosaxatyu/Eh6YFLFEiEQDu3Zvil3iPGknsK5K4aW0TsLTm2eo64+oj0zwBD
         Gahm1PxrLNIb2M3uqlrVQyWEccaKZbgKp/NZ27ufF1v5A0v5eLN5y6Jz50iy+sxfz+/j
         DOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650501; x=1780255301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69ODxsQsPuaw4bpcArkHHQDAVjJyQ7CsdRTlp6b9JkQ=;
        b=Dh7z89y+SREaKGvF6j2gBid/cdlP3y+5AhfgTkdknL10Ciw41Ij7z1HXYp04lCRh91
         caeWyTe8RnZ0soeCagxrphHK6lh8/757Ypypg3GvwwXLbxNT/3VCA31yxz2UArPIh0uv
         /rj+7bYHDZZvjppM7t8YNuKJc2PXmbwHISAV/yN/ibXHOPM1fsq9N3qKSS60CXrVvGtp
         C69kXDlwvwBucvkG0fjj1XRpZR3uUG2h9MU3bWGMZI3pCZG93VY6Nw/W+qn0+dIi7ZFg
         TXZ7P5lJHfTpPChT3JAyM8HjQSuWh2JLeTije5wDOD0MjNosehT9sWPV/tw9WdLXcNQT
         Y/1A==
X-Forwarded-Encrypted: i=1; AFNElJ81puToLPIKIxapdicw9/VjkyL5MhMKOhTVbltAIG8pkit8gWaXYAE4/xDIKRLVhfhaPk7N26zyRZZ87w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMdaYkviaoHng+RFUIsu9dLwSYU7T/9/g/EJTbZi4qL6bgNYu
	uk7hG9XCjCLBZ+kcjEQwZWMyHdodp3x8aLtNh6CVoG3TgnoQx5MXCwZw
X-Gm-Gg: Acq92OFGWIymSjKzrjYj2/cHjSiuh9gIAmfWEiw8LtgcxizRrkiO4UYfZr7cDkSawVw
	l1auqUNLmTew+LQkwPWAsuZ8YuQk7FC8ckSTtqXYc90+8holh/J4dOAkHRj8BvYWniLakmFiO9R
	bGGumW+wAF28ZcAk4X3dBU1AoMq6vhlGxF1A+xazUpeSnxlDNJVF6t2XM5tmb/K+RLpoHBibWgA
	DdCvKQo7CA/ZqxnZtCe68wWIYmUOV0vlyi3s2LavOORyo0KnyCM4sJbV8TZijf3ypL/zVaJrp/a
	4wGvCP9VOmcevubzxepP6gFVYZtpsy9W0YOh86X40M8NCc1yQZqQyMWaX2/DDKyZYg0CUQ9UZBY
	/vSHl994MJLjrGySYeddFYhyf6TrDaa5+tHpbmokGHQahqFQff0mwAVl2BnvAtE7z3G2ykBah/O
	MnHDDR2KhTHgyjGbvtnqc4LAhjqPzerdokT08DOHIRyK2RuY8JEqcBuH69x4s=
X-Received: by 2002:a05:6a00:3e04:b0:82a:7471:eb90 with SMTP id d2e1a72fcca58-8415f66c854mr11971953b3a.30.1779650500931;
        Sun, 24 May 2026 12:21:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:40 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/36] iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:29 +0530
Message-Id: <20260524192059.1193716-7-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

