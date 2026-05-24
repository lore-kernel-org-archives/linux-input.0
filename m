Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0593309DB5
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650486; cv=none; b=Ey3GKXLFsJpi2J9+CyA/tSDzDW8f/Q3V8XqFIdE0cid9lkVyPqxFA5OGzoOGMB8bW2BWsJHLbTfarCK4l6cCDibI2NVL1fiYer9c1/PmE7W/UImaIqfd3wGzOSTUjgz79UhM9GMHO54Uh2lSQQOfztlZSHutRknlBGtXR2/q02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650486; c=relaxed/simple;
	bh=/QVszgJnEkulS/iRv/AhAx7SOz9/GjOk+6xLdakh/wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ty3yIHPjoiXWfKH1gLdlAOSKc+BDvRPdbBvyFnArvJNv5oIp6MYhpgU+K9QeWeVMfPVKFGI97hzOPEa7rx66TSp/R9zvIDKExuw+vST6NXp72M/XyPilLwNT5VZDTqSrby4IP/sq7gPtRTQCxtY3X1dExMl184bmFFLncVjcak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTfzvWha; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTfzvWha"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8354461da74so4012248b3a.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650484; x=1780255284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NLBl9QxXqe4Ee+9JSBYGMFAkrfzp6f/9EsOxzh5s+U=;
        b=oTfzvWhaQlWQEMNla1/8EVMzfPms54qL6aKUV2T4ErLEMdBG+nhdwfG9s9pqRcRHRK
         FiDAyixLUEakM2Uqlt7YPfP7TGfig0Dqq7eNusRvc4MLucjRJFG2Ow+ilL8zXugAkNtH
         dZTfstL3Dlk8pRF4hWIbC07UUDTSTKVlCSuOWOj3mLGQjvT3E6/Fq2r9/ad5jMVmwaTw
         D4Ogsu0AyuNpXGMWzRH6GozbQ4yNg6AlzCOKlvy6GkyZE3WyTIxzqfzlQcCoIWheatHc
         SNIXH8F6JXCC85b4qttAekkUcdmTICSB9Qpikzz2/4CrpOA5daHXTkwHHwjX/ClENTGj
         mfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650484; x=1780255284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NLBl9QxXqe4Ee+9JSBYGMFAkrfzp6f/9EsOxzh5s+U=;
        b=Gbix/SlrPdg2/F4vHYgUddbnlHcqZG9DS3vCcgIu60HiKPa3bg/LT1dXXasXEYe3wQ
         xD5aMB3gjT5Eahp73/F7xMGQo4MoYpKLZk/kuXlgqMzXqJ/yS/H9U+8VOKhXHEKorQ+V
         vXsF5TmM/bmN9KDYg+hYx+auttAJAe2NMDHvQ7/sTJV/Sp7k9/cjr6h7C/r3qGMwUHvt
         4dNl5DA3bM2cmGcDdGWJfsk8BiNMOtq5k3b41feKO9ypN5m9et+kfcqcRB/iYoFaN55b
         zhmlGQHkyOZsLaEx8CNdg+UElMbDxYhGEBKtZD0iIAX/hI1U6ORPPZcWRZSvLcCYoHxY
         mtCw==
X-Forwarded-Encrypted: i=1; AFNElJ+HVSfUQK0xQ8hDvswTWp9muGavyy18vzQKsYXjl4RJzZtq4GP3dsI3eXzBqx0HbFu+GAjMaTBTa9rgqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7h7RJO8xhIUd88WvpMXgSVNYq5iEEPjmJEdOMO6MNAToI49yN
	qdG0YK7EMTc86KsZvWuwoeG/FUISIXyEKnWXlZx6DgMqA3N7pJVAsSky
X-Gm-Gg: Acq92OFDa6GftIINZWso8bJGDNubVKPt4ON8LxxrHbuihc5gbRJP2H+cNj95DQsRPGE
	720Sb0NVUGU7ogRK4X/3l39pa6kn2y/gPXBmXkbp24F/XWT1kffsgnYxaBmSlN3Ua6bpDCXp9c7
	nmGBxB4KnbbDfBUNvVMadFdLh6gwROM/xzBDdJvZMJ4nb2JMGNDcqZ19q2By/9peTLO6d+Wu+5Y
	rLAAY8sFtr9N5auJNQhVjQenFa1+BW0RzUrUX2oMYUopQhxP2sXDNGk7hHNafm8PoTB9JLwg8Xc
	vecnCnt8Ud89tZYD9cC8L1W5HUvLPpRkrMdh0mThuolq2ixsJ7wisBiMebiP+5ukaZSzc0yoth5
	ktL4nmMiG5aZGTNCEWn4ClfmONQ9RWxJAnZOwdDFxCidIJWlFMMCrOLFqIwA7j8EwmIhFU3F/a/
	s2GkrD+i7D4tef0+M/aVuzePhIyiCMyYwJxxxJYATJ6ilKOkch
X-Received: by 2002:a05:6a00:3911:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-8415f5e9a44mr10387787b3a.40.1779650484186;
        Sun, 24 May 2026 12:21:24 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:23 -0700 (PDT)
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
Subject: [PATCH v4 03/36] iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:26 +0530
Message-Id: <20260524192059.1193716-4-sanjayembedded@gmail.com>
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
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..67fb8efd6b10 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -233,7 +233,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data,
 
 /* Callback handler to send event after all samples are received and captured */
 static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -257,7 +257,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -293,7 +293,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
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

