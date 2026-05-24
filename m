Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203730F94D
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650900; cv=none; b=fV7wHD/NmcuPpfm/YKvCqFi9Z4Ad2nYEIcz0bfIyfg6r6vnNojmd4WGgir+U7xm+1IauQzn18bRX17kZJH1GZlsCiyMjsdd4Ez5f4UDRcC8coz+PouKZfNi2L5xpjr20XAzbxZWmRrVS+X+278kvTGsNXICL7PbU3P1Ot7oZyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650900; c=relaxed/simple;
	bh=7rWPsgjTg6A5zkgLqVjcHYBm51EamTh/i0HBYIDLjMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o2TIlsZ17qpV4VdVyN4ydW+jPULw/OefSae1hduSwjT1Uuw4HJyv8HcAU9r9sQfhiorEiV+9LJpthIggZRxZOF1xDJ5GDik7unttBg2C5y9g32kk/zaIToPrO9iY1OFarJzmfMDZUwTeFnWm33sa59rmb8xQickKMyf896KWkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/zYQCYt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/zYQCYt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b4583f0a1aso62585775ad.3
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650899; x=1780255699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJQ8EdbnMqqdWkgNwl8JeFNzEKvmTn4BJmvszB6ugw0=;
        b=W/zYQCYtrM4IaYpg7s9iUWcNuQnqItZ1/DEyCTabgEfveMvEO2l1lI5GRRZlZrHXYM
         2DdynDR1Q2AZWCIldcOftJq/2kSvjiti7jk2naDkB4H/iRxfAqaEwJ/AtIJhegDQEdo6
         7JL0KzbIrMqwwi1ggcLKPo51mInjyMpXvmUinCGs4D0y15ZJuW4gOY0MjDajGamnW29K
         o2X+UV2ArKN/QKn/fHbJF7iFmTFkR34aE6l3CGnPVlrfrzEhACzLM2rHiK5CjFj76nLp
         eb2GUuz3PONn2tmAqbrrIhvP9CjbeRH/j1Ui5qNecE0ecn0bSsIlVFZol6jOdCaeDMzQ
         kezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650899; x=1780255699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJQ8EdbnMqqdWkgNwl8JeFNzEKvmTn4BJmvszB6ugw0=;
        b=dDKJfFh+/XKRJVZ0xOZvLLBR0iR5F48EuVOo8Z0MfXDFURyI9BNiEfwinktayI19hS
         l6YnHoRuOmhNvU+RM9MEd/wu1Fo9NlSYKICcapm/N3+gQTWSXkGVUC1iyGKEMaY49JNe
         jqkvk/gRpLCotOmuU8aG+pBXfeEP/MJhXiUOkzEaaf9dk+kPqeyN8u5ez0EtPGtb7Kui
         kq0oiYLhIeAY0sKx/luMTdaIcnBpoMOwHRCUQKRrcoYgod+1m8WskTN6h3FYKnkR9IzS
         YZgDQ91Za+63h+pprEvzsnaGQpyPLox6s77dic7v1BaqFWuhI6tj5ICnf1xK2w3PbUl4
         CzsA==
X-Forwarded-Encrypted: i=1; AFNElJ/hauVfTgq3k/489tn1aWooDUynXMnUaKI4xR3sTuYDOUXGS68i0hVcwSptdSLt7UWr29G4//3uQbInSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/Dn39+WZ745W0hJKikAglYzzlbpWemGbXdiPwzGMhWMKBg5+
	bzOnOmdx2b3KTDI4jEV+F7IMpUgcA69NpB9HLxuTHwXYROa700T4PMs0
X-Gm-Gg: Acq92OHdW8YnhqrcBqsyoHLJnp4g7TJh4QiUgiWD4imgQ7EKUECaFoEn7P80JmEuPyp
	MwCHYP+QoiRuPksuuNXggvp/uxznP0KpfwFhDXV4XGQByjjS2UDf/4gyzPlIni//nerqLsIGyWV
	BBRp98M70sRlV5LKXy/if3MrZDReReJQJhv5LylfrV0PhVbcE8EhfEcDYyDV3WUqS8yrC4FRiFQ
	eQWCbuJFObrILEcK/k8NkEz/AYigG09pH5uOfPlJrl2feLtkNqK93QQUTzBCtEPuVUFHxaRff1S
	N5wjZUsDkwM3zaoN4Mo5hhCzMxpUnWrVXv9I9a01F7iRNCY20+Inn/gQE+oW4JPu9oH0znmDFcS
	wbKVaXNk4ABa2wsAvbbqpLVGMZh8QG3TOoSxni2mVVgUzASM1ku8SjAKwAuJDmBYnV6urTawM3f
	Aksmm4ZuAWJf1CLtkU3F+anZQ+M0gQk36iiY9Fg4nbkn2hkwFQ
X-Received: by 2002:a17:903:4405:b0:2b2:b117:1e1b with SMTP id d9443c01a7336-2beb0758814mr123561725ad.17.1779650898727;
        Sun, 24 May 2026 12:28:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm71489785ad.65.2026.05.24.12.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:28:18 -0700 (PDT)
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
Subject: [PATCH v4 20/36] iio: magnetometer: hid-sensor-magn-3d: use local struct device
Date: Mon, 25 May 2026 00:58:03 +0530
Message-Id: <20260524192812.1196549-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &pdev->dev.
This avoids repeated &pdev->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 36 ++++++++++---------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 73dd2e7768db..cf08503ff1ef 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -352,6 +352,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				u32 usage_id,
 				struct magn_3d_state *st)
 {
+	struct device *dev = &pdev->dev;
 	int i;
 	int attr_count = 0;
 	struct iio_chan_spec *_channels;
@@ -373,34 +374,34 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	}
 
 	if (attr_count <= 0) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to find any supported usage attributes in report\n");
 		return  -EINVAL;
 	}
 
-	dev_dbg(&pdev->dev, "magn_3d Found %d usage attributes\n", attr_count);
-	dev_dbg(&pdev->dev, "magn_3d X: %x:%x Y: %x:%x Z: %x:%x\n",
+	dev_dbg(dev, "magn_3d Found %d usage attributes\n", attr_count);
+	dev_dbg(dev, "magn_3d X: %x:%x Y: %x:%x Z: %x:%x\n",
 		st->magn[0].index,
 		st->magn[0].report_id,
 		st->magn[1].index, st->magn[1].report_id,
 		st->magn[2].index, st->magn[2].report_id);
 
 	/* Setup IIO channel array */
-	_channels = devm_kcalloc(&pdev->dev, attr_count,
+	_channels = devm_kcalloc(dev, attr_count,
 				 sizeof(struct iio_chan_spec),
 				 GFP_KERNEL);
 	if (!_channels) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to allocate space for iio channels\n");
 		return -ENOMEM;
 	}
 
 	/* attr_count include timestamp channel, and the iio_vals should be aligned to 8byte */
-	st->iio_vals = devm_kcalloc(&pdev->dev,
+	st->iio_vals = devm_kcalloc(dev,
 				    ((attr_count + 1) % 2 + (attr_count + 1) / 2) * 2,
 				    sizeof(u32), GFP_KERNEL);
 	if (!st->iio_vals) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to allocate space for iio values array\n");
 		return -ENOMEM;
 	}
@@ -426,14 +427,14 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	}
 
 	if (*chan_count <= 0) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"failed to find any magnetic channels setup\n");
 		return -EINVAL;
 	}
 
 	*channels = _channels;
 
-	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n", *chan_count);
+	dev_dbg(dev, "magn_3d Setup %d IIO channels\n", *chan_count);
 
 	st->magn_flux_attr.scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_COMPASS_3D,
@@ -454,7 +455,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
 			HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,
 			&st->rot_attributes.sensitivity);
-		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+		dev_dbg(dev, "Sensitivity index:report %d:%d\n",
 			st->rot_attributes.sensitivity.index,
 			st->rot_attributes.sensitivity.report_id);
 	}
@@ -465,7 +466,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 /* Function to initialize the processing for usage id */
 static int hid_magn_3d_probe(struct platform_device *pdev)
 {
-	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct hid_sensor_hub_device *hsdev = dev_get_platdata(dev);
 	int ret = 0;
 	static char *name = "magn_3d";
 	struct iio_dev *indio_dev;
@@ -473,7 +475,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	struct iio_chan_spec *channels;
 	int chan_count = 0;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
+	indio_dev = devm_iio_device_alloc(dev,
 					  sizeof(struct magn_3d_state));
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -491,7 +493,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 		magn_3d_sensitivity_addresses,
 		ARRAY_SIZE(magn_3d_sensitivity_addresses));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		dev_err(dev, "failed to setup common attributes\n");
 		return ret;
 	}
 	magn_state->rot_attributes = magn_state->magn_flux_attributes;
@@ -502,7 +504,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 				   &channels, &chan_count,
 				   HID_USAGE_SENSOR_COMPASS_3D, magn_state);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to parse report\n");
+		dev_err(dev, "failed to parse report\n");
 		return ret;
 	}
 
@@ -517,13 +519,13 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_setup_trigger(indio_dev, name,
 				       &magn_state->magn_flux_attributes);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "trigger setup failed\n");
+		dev_err(dev, "trigger setup failed\n");
 		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "device register failed\n");
+		dev_err(dev, "device register failed\n");
 		goto error_remove_trigger;
 	}
 
@@ -533,7 +535,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
 					   &magn_state->callbacks);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "callback reg failed\n");
+		dev_err(dev, "callback reg failed\n");
 		goto error_iio_unreg;
 	}
 
-- 
2.34.1

