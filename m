Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42F413628
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105839; cv=none; b=j+7eqRpK/ojHefFHHPZm3q80GKIePq/JF+YSu9zzTNBmgyqWTzwcpklNVJHpGoCQk/CMXnOGU99vE0/wmdWNSgyO2rnMTGg45W4f7Rk3KBopY6SiDKtFVF5kbfpaRKPRzFHqvnGf3DmMzWNVBMMpfFvkuix/ewVdHKQSMlrfu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105839; c=relaxed/simple;
	bh=eLvsJsSNEYODUgJ5BV6BVXNCTbjIWoNBX442lJG/w0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sl0Php9OqQngog8VLeQgwbsF4EY3PUYhbfsB+LIQNJMfxRVYSext3P/kuigi7+cw6CgW4KGjxY1clddSCBBscHUQ7/WkpK4Ksa/fzo48oA9NTDQQbewY6yhAyektF3IbNhJ0qlamNtqJ2DGa5TaxcAW+WmmPV+/X0qTyo4kHIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFfsHPRM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFfsHPRM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so4248056a91.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105838; x=1781710638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kB45J2K2UbRbT/i/6u2S+2cyuTXfrpfRajrA7U/h6oQ=;
        b=LFfsHPRMjg5rVdKCUV5/y2RlRHWDwjkhbR0M7val43difh07rCND9QfpfmrEojVMfZ
         Wv9nVxWlGCUPo8DPPqd2XMnZNq0LThcZ+cAnvTooYE9aku3G0Oy1SdxvUdV/AIhGHMtV
         rYq3ZAiZyqBvhtNiJXTU2szOJCMtfU6rERd/VPW/OQwl+fVsGfnX2zEPfyqme5ZPiXjQ
         glN5uNHCN2b3HsY6TCorcAIFj8cLmqvkDmfY1rGXW7/POwk6HiDjNhi0T/O9ARkO72ni
         s7jPZ3+Djfb+XMghrBieQWhN18KsYrFVFsfbhzhoFAFO+pvV/LD3TJ/efR98+8Auh7f6
         L+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105838; x=1781710638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kB45J2K2UbRbT/i/6u2S+2cyuTXfrpfRajrA7U/h6oQ=;
        b=oXNwicnHXdiG325CaW7CwjpbKfbAsffSnLhdMOoWud4r7N8mYv11LW+tpPzF9oDKs1
         nbR56j5iC5sbuKdyoIRHHH8EQGmKoQllEGhsAUmBGnzp0de23LaORbXH7e4nO4m8aisL
         E8bL/WPQhCQIFKa2zQNLC+rCr8tW9GmIe1pikZ1sBXc17flwXjJf8ur5cBaBT1FKSdKF
         khh/FdPM7XrI1x9jtsF4MXWYWbJz22aul1WqU31ARCXwXhGwUy0yLJgu2X7u1C5ss42d
         aWwJZ9uYTwY9gHC5t29W5vwvhKUrWk7wGxWe2DbVkr+2RAKxgJ583ytwMkWZJipzGFbD
         OeUA==
X-Gm-Message-State: AOJu0YzPMqEvPrm3yTaBg40RKrKYlMwL7Awfp4IcMac+ypDljbyUtHbA
	MHZ9IheptaPsK+7Y2mt+AQ5b07K4lr0xScmbW346MHg2zBl6DcGcQDEX
X-Gm-Gg: Acq92OFtyBQXwyWT7G2dFC+AgxznYvaDLlBBDm0PKPH4xDGMvIuOxy9MU+q/lH2cbyM
	qEKLLvIPy9/ThXlHl0qYlZUV4z3KjUmBWV/ue0ZJJLXvCKvUerDReoBxYUpOOff2wSzEwMEtuPC
	n843r5WuUG6/q4gWbkXWWzNgVLE4Yd0nfgW4oiqsvwukDVBARHlAmIQvrOsXfc/OMzym0IGMvur
	P+7Hnc4pS9B3ATiT2a0e0vGuPe6GZgWBDc+tODCICeLb8JkcZGyef5qSiWANrR2Wy4YSuw6mBqe
	fQtvEqwiAJBCtL0uBHuNPC7YkJ5qs6OQkx/YTIt3ePkffa+sZqNSyAd+LqkcOpB3FTdnSF0nfkq
	6cgq1jd+gfuyZsfevOdmZ2jXhKnpy17J73WFoqzhyMV+tjWiABeM7mT5N6KZt8OXvI+dP+SQGXJ
	FTRV8BRYBtr1oOVw6RI+skVLgbYdOJKJHyaK1bbiznvu0kaT7RoQn/asMEV54=
X-Received: by 2002:a17:90b:1f81:b0:36a:5b56:5c1d with SMTP id 98e67ed59e1d1-371323bae7fmr20784948a91.11.1781105838015;
        Wed, 10 Jun 2026 08:37:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:17 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:02 +0530
Subject: [PATCH v2 1/7] iio: gyro: hid-sensor-gyro-3d: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-1-c3c5f0720493@gmail.com>
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index e48c25c87b6d..bbca2111e79b 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -177,7 +177,7 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -199,7 +199,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -234,7 +234,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct gyro_3d_state *st)
 {
 	int ret;

-- 
2.34.1

