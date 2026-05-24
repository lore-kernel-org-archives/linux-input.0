Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C573148CF
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650769; cv=none; b=qcRR40i9/OKcqHPl++sfBXwuNAfyXpwckWj2Q7JrxsEOgxIjy0g2m6PGOWf3NsVrJLcuroYInlvLy47yNkiWQfLK2u5Gq9pof2cjyPkzZCS1Q1zxyBTREjMyDPHSIeHTOviPJI2kyBS5OaLjllps9l75OS3DGqIQr1nigWyl60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650769; c=relaxed/simple;
	bh=UbDu/cIoGcdShOF421DZchJgiGKlnHcMa3vdMzr2ZwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdPDDZIG8NhDLGpccmOhOBdvDmRcKJZIwvU1xhrzRzNuniq0rGr5NeogWS5UN/StZw33tl6/DZEs1as0jD1B//eQSrP0rByGA5JF93dJcc9rY0yPBljPqXj0o2AluQrUtuxIVYU5T7MyQEHgIbP0EEX1HXCE9eDFhd3Pvacu9no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCW30BAe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCW30BAe"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bc763e2ba8so44764655ad.3
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650767; x=1780255567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWXevwdVOTeEM3Cej/tF5M/+ePHUTYqIX6HZwxRm4j0=;
        b=aCW30BAeSI9sMf+2qjq1Ixxu/lUgahFqeDzmuoKFurjP4fGfw632TEvEnzT7k9cUG7
         rh13qlvwTaqByg6nswZmsy9jn5YI3xdRlMOBA8pJgTDy1jGFijvErhCsVgBNxKJlOR7M
         iZMW4W+6K7rWOd937DDv+eqmbnqPBiYAfUj1CaftkYegfQ9+NBgIRVSwLULqn6a8JXId
         QUIlv2MUN/+lo2Jned6icqWZkUfLf5ful10RObqDN8US+sYq3moo3YlzlxcsTmhwJqzp
         NBUYKQFW0zPb33gBPNn0WopsNHfSCJS75k9zDNcwvjpQOJmMTKerCv/jgS9DaTGm2hY3
         rnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650767; x=1780255567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWXevwdVOTeEM3Cej/tF5M/+ePHUTYqIX6HZwxRm4j0=;
        b=aNmXDFEOVbfT+dlPAhfBpztb2cEnAFDhkeqZOJ2Re8oqKPytmu0sQTb2QcgTW+v5zv
         mMR4/wRTJol3v8dxgrbmVdqClp9QR7s/zuF7DH9u4/UWgXAQdlTTz0SavwbDUAzfZxiT
         W6s9Mi1IM2CQTEGtHYLHBk5bVBvkNxlNFZjtcSyjVubE2qnlprAeSGz35t4Y6LZNSse+
         PoONjmrnLwENnEf75It8lD5kbEEPfYW8io9XmzMif8/MVsnXOvdclIK6ym2FPcN9ZMCi
         VZ1y4qJq/wDsrxL6RvBEKFb1vhIr8SGBnsQT8snjXNinM8TxZW77feWl89IweAY3BLQF
         S6dg==
X-Forwarded-Encrypted: i=1; AFNElJ+Y7Q12l249KEv/8ZfEapFpnc7yUpJSjAXz0XdovOrUxgc26O7jzGHT8aDAthecoD9RjbXdsOhQSdMNBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1NAfTo10/BfWnXmEhXINxT6lmobvGPhCYNND3ZF11FQgvEvl
	agCCNVU/TgGpcFZCzP+LeBY569G7T5G5aihl61Plo5qe9SNUgM6BArgxy3laiQ==
X-Gm-Gg: Acq92OFuo4YBONf6pyij+RpFWmvimBUYSRq25rpRuk0Ene1Rxi5koevlqzlhrDvKGiX
	hcceYgDPEb+XXkvevnnHZMYXCI8xHZkGTrUdLbbIDkeSrkbMdOE+SRorRIud+HekWGxesF4pP6f
	PD9ts+IcXT1fAuWX4KAuWn9bqiRzqwxQ9Rzkw3bsSfwyg+kIYrjlIZUJGF8znRzQxyDLfW7aEJ9
	6BA+0W2OhBB0P9YBL5nm97b3ZjP36t1BU4V0fdHOnMEQt4/uvoSm3yJ/xc2dAi5mAeRySkJzVpp
	/OdUqZZWat3JoCJGIqVWxbvwV80Uci2XLE+7lmTP33MReaJlyWNF6KUDQcMdznofbKtXilC+58i
	a+V6eLVCJOMTifSR+4td1WxzJjcoadBDe0htKp/dramNkjbLPkixtLrTLInR1KC1O6ThdT/ZyYQ
	g3T7ZOAnaty0AqLuRZOCZsRFFVXOymQxavXrFSecmlE+MYRIVTmubEt6XWAdQ=
X-Received: by 2002:a17:903:2bce:b0:2b2:4260:109 with SMTP id d9443c01a7336-2beb074f776mr122632175ad.23.1779650767059;
        Sun, 24 May 2026 12:26:07 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:06 -0700 (PDT)
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
Subject: [PATCH v4 11/36] iio: magnetometer: hid-sensor-magn-3d: align parenthesis for readability
Date: Mon, 25 May 2026 00:55:48 +0530
Message-Id: <20260524192556.1195042-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192556.1195042-1-sanjayembedded@gmail.com>
References: <20260524192556.1195042-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Adjust alignment of parentheses to improve readability and
maintain consistency with kernel coding style

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index b01dd53eb100..73dd2e7768db 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -134,7 +134,7 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 
 /* Adjust channel real bits based on report descriptor */
 static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
+					    int channel, int size)
 {
 	channels[channel].scan_type.sign = 's';
 	/* Real storage bits will change based on the report desc. */
@@ -145,9 +145,9 @@ static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
 
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2,
+			    long mask)
 {
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 	int report_id = -1;
@@ -177,8 +177,7 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 				false);
 			return -EINVAL;
 		}
-		hid_sensor_power_state(&magn_state->magn_flux_attributes,
-					false);
+		hid_sensor_power_state(&magn_state->magn_flux_attributes, false);
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -239,10 +238,10 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 
 /* Channel write_raw handler */
 static int magn_3d_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask)
 {
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 	int ret = 0;
@@ -280,8 +279,8 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				void *priv)
+			      u32 usage_id,
+			      void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
@@ -302,9 +301,9 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				size_t raw_len, char *raw_data,
-				void *priv)
+				  u32 usage_id,
+				  size_t raw_len, char *raw_data,
+				  void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct magn_3d_state *magn_state = iio_priv(indio_dev);
@@ -363,7 +362,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		u32 address = magn_3d_addresses[i];
 
 		/* Check if usage attribute exists in the sensor hub device */
-		status = sensor_hub_input_get_attribute_info(hsdev,
+		status = sensor_hub_input_get_attribute_info(
+			hsdev,
 			HID_INPUT_REPORT,
 			usage_id,
 			address,
@@ -378,18 +378,17 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		return  -EINVAL;
 	}
 
-	dev_dbg(&pdev->dev, "magn_3d Found %d usage attributes\n",
-			attr_count);
+	dev_dbg(&pdev->dev, "magn_3d Found %d usage attributes\n", attr_count);
 	dev_dbg(&pdev->dev, "magn_3d X: %x:%x Y: %x:%x Z: %x:%x\n",
-			st->magn[0].index,
-			st->magn[0].report_id,
-			st->magn[1].index, st->magn[1].report_id,
-			st->magn[2].index, st->magn[2].report_id);
+		st->magn[0].index,
+		st->magn[0].report_id,
+		st->magn[1].index, st->magn[1].report_id,
+		st->magn[2].index, st->magn[2].report_id);
 
 	/* Setup IIO channel array */
 	_channels = devm_kcalloc(&pdev->dev, attr_count,
-				sizeof(struct iio_chan_spec),
-				GFP_KERNEL);
+				 sizeof(struct iio_chan_spec),
+				 GFP_KERNEL);
 	if (!_channels) {
 		dev_err(&pdev->dev,
 			"failed to allocate space for iio channels\n");
@@ -434,8 +433,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 
 	*channels = _channels;
 
-	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n",
-			*chan_count);
+	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n", *chan_count);
 
 	st->magn_flux_attr.scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_COMPASS_3D,
@@ -450,7 +448,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			&st->rot_attr.scale_post_decml);
 
 	if (st->rot_attributes.sensitivity.index < 0) {
-		sensor_hub_input_get_attribute_info(hsdev,
+		sensor_hub_input_get_attribute_info(
+			hsdev,
 			HID_FEATURE_REPORT, usage_id,
 			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
 			HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH,
@@ -485,11 +484,12 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->magn_flux_attributes.hsdev = hsdev;
 	magn_state->magn_flux_attributes.pdev = pdev;
 
-	ret = hid_sensor_parse_common_attributes(hsdev,
-				HID_USAGE_SENSOR_COMPASS_3D,
-				&magn_state->magn_flux_attributes,
-				magn_3d_sensitivity_addresses,
-				ARRAY_SIZE(magn_3d_sensitivity_addresses));
+	ret = hid_sensor_parse_common_attributes(
+		hsdev,
+		HID_USAGE_SENSOR_COMPASS_3D,
+		&magn_state->magn_flux_attributes,
+		magn_3d_sensitivity_addresses,
+		ARRAY_SIZE(magn_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
@@ -499,8 +499,8 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->rot_attributes.sensitivity.index = -1;
 
 	ret = magn_3d_parse_report(pdev, hsdev,
-				&channels, &chan_count,
-				HID_USAGE_SENSOR_COMPASS_3D, magn_state);
+				   &channels, &chan_count,
+				   HID_USAGE_SENSOR_COMPASS_3D, magn_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to parse report\n");
 		return ret;
@@ -515,7 +515,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	atomic_set(&magn_state->magn_flux_attributes.data_ready, 0);
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&magn_state->magn_flux_attributes);
+				       &magn_state->magn_flux_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -531,7 +531,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 	magn_state->callbacks.capture_sample = magn_3d_capture_sample;
 	magn_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
-					&magn_state->callbacks);
+					   &magn_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
 		goto error_iio_unreg;
-- 
2.34.1

