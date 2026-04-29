Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75638C429
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485578; cv=none; b=PJH+Y5i11fswpAbwPJOQIJyRaGvX49fsYdp57Zof9GGsRPriKUKdBaBCC2nul7OdLUPYwGWCqFahg8V1Y0KY9uTJINdXOrzMhRrJyauSIX3jmi9sfYsG8WWf3jqY3TZvraoRBDUrD9vQXRFFKoQcpwufI4LZBhSyrftVoSWzECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485578; c=relaxed/simple;
	bh=qLrrmL4AkQqIOhkUpsgjITx9Rs/KUJY+W1QRMNh6928=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XHKcMc5DSyZisVFsyuqspsbQ0kWs0cUtVEA5S2oYAWp0//Dh+a9/wAQaV9HWTeMYGyv+RwT4SXUeMIKjWIona5tdu7T4TTe5WHou6Lr46jXw/nJuqxGAuULXabGH1kkxfjsmVpuGa/MKm+3Se7Abt2iRdXUywphAO6SNK2FqqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVUD85jS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVUD85jS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so32047a91.0
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485573; x=1778090373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLr5AK+EwC8gV79FD9GoQQ4ntxH7YLzxoj/qCWXjquY=;
        b=ZVUD85jSkyDGGSorM8elm8CDuXektUFwPkELUM0tVbPmDIEoyOWGofEbVJ01m4syAh
         p5/SJwXahpyhw8+7glAGIVpHZNHX0nRztnl5lugljNGw8uxo/GijjO9W+HCirBgpESpk
         R6jcNEePUCm+avT3tTAWMzL0HnEilPj+sMEVqfYC55i33NyGj2DEVxusDjS0nfvc9C9J
         ECrCFGi4v0R+qH6DQvtM+0Ll/vqyMI8Bn/sKKTiA5czXcsENhsX4MF2sbfe/ktE+KXsN
         qMA8Gsq1JfC/QTrxZK10lbg1YdCrN2rRbEn2QbwHUoGutCfnjfG8F+LPUGvAxfY3BAzU
         n62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485573; x=1778090373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLr5AK+EwC8gV79FD9GoQQ4ntxH7YLzxoj/qCWXjquY=;
        b=YECXIA+sG3V6M5NgjLHQ3PE5eb+PGV0EKDNG/izRPySpVR30Ps93JFrRltOD20uY0w
         +ZEHFrwy9/5gFtt33+xMrrNEmMg9MEz8EHZqwzaAqvU7zL82sDJtbJ7mlu0MHysoShwV
         c+bhwOkAMRFc0q12IGqN9HJ29tWCqwBhDf/wnMaSyl0q9YVZFKgAf9BnYQuO+Yg/FMrI
         E2r+Zg0IauMNCUZyBxXI4R3KLPqeBvlUVynLyHuoUUHV55E1ohmFHUtNM0Ug5Uq62hXY
         eLXlxcfNaIZhbqLZF4SrMyZfWDgdiVleG9KQXPO/6Wn5G0IrBhN2x0F7h9+7jvI9GWzS
         0E/A==
X-Forwarded-Encrypted: i=1; AFNElJ9Q/6qyqTJ653P/kRWiM6lsnV7jMNJWsdkeWhfbCHrQYriIxC4WjNg0GcY7Deew19BuDC154i8KXadC8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9B5v5v2Jf5NQf8ejrKIxQ5ZzDaqwBIJ/iVMK6is8NFm9l75zq
	DWgb38RkcV26tlrjks6Mwrtqymc6300oKOqRLw2NAEaTjx+EM0jdbUDY
X-Gm-Gg: AeBDiet/BLWJ0gar4pJ21CX2FJYrl6FbOKRi/H85flacXcJL/NJFGDEBtwJDmUm+PU4
	whjZXDYDcTUUlOX5Mq1bWGpQVNU2GvGj5/VwRdqG1gqjkH84lrapnv8+UDe2jPf9BokPtqVrOQM
	V//QHjmI3X8B55gmcSBdg/avdXBU7A6+kJQ2RIpV674D348ZKVISVRT9SLPP2emq0Er2VFh4CPx
	Royhe9LBMfPbIVOSEZxYO2TxgGyKySUez8lg1NnR0RSpetQ9h0Y3YGsiw6ifDHC/x7fqgOI27nM
	AE+zYDpgRif6fShhtWea+9rRn0W5IyurWSkSZBevVx1DvREPxzOJr5AkwOHckJue5kq68sgxaZ8
	EoQnLfZMYMLM2/2ICwd6QwGRcB16wU63UgDw43ewuZqnWsLis5Yu/uJ46rfhLlGSXo3laHonU+s
	m0ZWtiCBf1fw0N/v2G8EDK4eHg2RBAgpFZkyzakjZD6y0IkEmv08hiM4QjQVI=
X-Received: by 2002:a17:903:4585:b0:2b7:bba7:5b07 with SMTP id d9443c01a7336-2b97c49a51bmr87501495ad.36.1777485572911;
        Wed, 29 Apr 2026 10:59:32 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98897edefsm27726805ad.74.2026.04.29.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:59:32 -0700 (PDT)
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
Subject: [PATCH v2 2/4] iio: hid-sensors: introduce device managed API
Date: Wed, 29 Apr 2026 23:29:16 +0530
Message-Id: <20260429175918.2541914-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429175918.2541914-1-sanjayembedded@gmail.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
during setup and release using device managed framework during drivers
fail, unbind or remove path.

Register action with devm_add_action_or_reset() to release resource with
devres framework.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 .../common/hid-sensors/hid-sensor-trigger.c   | 24 +++++++++++++++++++
 .../common/hid-sensors/hid-sensor-trigger.h   |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 28d050b45c74..6692f403c8ec 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -301,6 +301,30 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 }
 EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
 
+static void hid_sensor_remove_trigger_action(void *ptr)
+{
+	struct hid_sensor_common *attrb = ptr;
+
+	hid_sensor_remove_trigger(attrb);
+}
+
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb)
+{
+	int ret;
+
+	ret = hid_sensor_setup_trigger(indio_dev, name, attrb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(devm_hid_sensor_setup_trigger, "IIO_HID");
+
 static int __maybe_unused hid_sensor_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index afec46ecbe71..6fd7c39a240d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -17,6 +17,8 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
 void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
+int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
+				  const char *name, struct hid_sensor_common *attrb);
 int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
 
 #endif
-- 
2.34.1

