Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E83C141F
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360585; cv=none; b=QBMt7UL5UFwvUQXSnr84b58f8i01xgUySdApUhMZcQ0HFWqpC9xfFY3Jr4xDVjeO/pEaDcCjyMGSnL17c9W/4JjpBjYWlnzGwGNHnoqfeyEdWiyjLVWUS0ebpgRxilyQMU29qMyW+XxsTHu6vstpO3cL2/s6Vlc4K05pSwJxTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360585; c=relaxed/simple;
	bh=ifnmbOiTAaKA5N9L530ZePE5ed3hcT8nLx4J4jUOmAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kq5omI/JCtUacbWB+wiBBpqGnX8o1x3KWS8ZZv764s1wD+VVOuvkHJo2MsMDeneocE7R1SCbsV5PgfLPYEPhD5gZw2U4rHBq1SKFGnkAlSngCLHJPDhajLaXpmB+oc+KonZ+5gXcKY7oDBK8uxhPqD+KB5PKI0+fMsvsJKGLg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avIIt/6n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avIIt/6n"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f1f6103afso5130688b3a.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 00:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360584; x=1777965384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an6Y7XCXgxIhor4TOtxCGopkHxLN4AXeWyw2UxzqmNE=;
        b=avIIt/6nqs3WMq205RMEV7SaTKMsgAGLfZkpOOl/I7NP50SleNpAtQ3sK1+YjlzWbr
         m/gNNXAGoPqECfulHcRKQvPYoRsvouiAlorzQza/jFYPLmKjz9vVAiEGukpusUKaTEwm
         ID31UNuVpTKqN14bhYfEJz108sDBETFme8sNgty1ZK2B+8vtKqsNKU2Hr4fwygxWGLQh
         7r+fRBButsIqCjvZBiZj25/dQXtmOm+GDgOnGl8UEgowM+yt7+5FHk7Q6NslylLJ1c5l
         /zjkz6EexsTYhmVBTzIK0L4ozX7AIpChvPrqXI9z048jpP5j1XT2w8WrlZZkfydsm3tO
         kHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360584; x=1777965384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=an6Y7XCXgxIhor4TOtxCGopkHxLN4AXeWyw2UxzqmNE=;
        b=ZYcngVVID/NWivVovbl6MtF+X47PzuW6D9FtvyGmwwSEcd+IlFYRG3G+XkhjRLusSf
         sKPOHjPYXeoEXch6iAAbwljwANWzr9GljL5jOpPxvu1PwPT4fGwCTCFYyskfK0A9czq2
         XongcZElPRHOzXj+eZQV4HiAVdDtjNTWfhQrkChBkGav23Ioijlg2DkLYsYLx7TjCraC
         qG3G6nlZcsgQ7Qs1ootG0uI4vSlaGgNmGPRjTboIXu8QdNzF0a0a+wovKGgoj8Uo2JX5
         HBzkn6QRgxH02Bkk+EqQqnRdfo5LV97bKGJMB5qreLmpnFzPc1/PI278/4depOZxhqo/
         gXQg==
X-Forwarded-Encrypted: i=1; AFNElJ/Mu8XqKaOTk2LcR/o/+Zd0iSwJ+uA/cp4JtKh8kgF5gXZmStDvt8XzW9DXMy/kH8y5zM2d4DEOP67haA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMygXKEKyvlDY/8EGAINBWBDrPnTfzzUC1pNHsUjbPoAoxBvv
	HaM7zbFP8y5YncQec/tufxX2zxE2HcDV8MrzPSbzbbrUWqcyHTfm/BOA
X-Gm-Gg: AeBDiesFdgGT/Gr8U5gOhRCC6eMVwaGXBnG51gCekcEUJBCW5lL3yNrHTMDR5FSIBlx
	yRRgfdDI+36OV+oUjngOT8S8FPQ9WZY2LYqTCoWYsa7lXzel7GBhABetsf1RUEwMnhr9C68xMiX
	rggEGc+eCg172EW5U0cFAj4FsW9JcHzwrKiCCkavoDBWUYlUGq0t83o5i03dFSegjUX69z6d0U3
	LI8BuYfWKUILohvodCxjg1egDu4C+oqemgidUIkckSaFXsak06oqenP2M/jYuSm5sqGeBF6sCAt
	HAsPwtPWP+AD+hDISMx4Z17ip2LYVXUY4kRFnktLbTffK2UGeJBcIvwh78BJCcH0BO9eQW9Fgyf
	ymh5TBZLaJe8sgZOkbLPmbJn3wrwb0P+Js2p6RBZYCYNfYl800BWXQkcdEeT9LgHaXZ5lHYGcIR
	GTGNCdBk2fT5Ztby6PJ468q/TTJJ5gJ/hJH0SZnJ5z7LWq0645WiUZ/g6mDzE=
X-Received: by 2002:a05:6a00:3486:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-834dd91736fmr2214971b3a.0.1777360583715;
        Tue, 28 Apr 2026 00:16:23 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:23 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] iio: hid-sensors: drop redundant iio_dev argument
Date: Tue, 28 Apr 2026 12:46:04 +0530
Message-Id: <20260428071613.1134053-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_remove_trigger() uses struct hid_sensor_common to release
resources acquired during trigger setup.

Earlier implementations required struct iio_dev to clean up buffers,
but with the current code this argument is no longer used and is
redundant.

Removing it simplifies the API and is a preparatory step toward
converting the trigger handling to a devm-based API.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..28d050b45c74 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -218,8 +218,7 @@ static const struct iio_buffer_setup_ops hid_sensor_buffer_ops = {
 	.predisable = buffer_predisable,
 };
 
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
-			       struct hid_sensor_common *attrb)
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
 {
 	if (atomic_read(&attrb->runtime_pm_enable))
 		pm_runtime_disable(&attrb->pdev->dev);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index f94fca4f1edf..afec46ecbe71 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -16,8 +16,7 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
 
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
-			       struct hid_sensor_common *attrb);
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
 int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
 
 #endif
-- 
2.34.1

