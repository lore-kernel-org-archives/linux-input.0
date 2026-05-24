Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED62314B73
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650765; cv=none; b=TBpCaZ8g7uyuaqucE7kixmY0ACpQSLOo0/kNSWkIKeFH2n75u0i7Kl1thg1CU10XeIRXfKKhLu3TvYfol2YmiSAh/S6KdzMIzhKcoLYsOrfmu34wpbHWG3OiI65P17FsgnCUycxDVttQ3hQvXAsfUT+q5NH8Ar66BkqbUq06CHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650765; c=relaxed/simple;
	bh=8Eqjp5bkB29L8ni89pdWdxVPTmAr7zrKFAZk0VrtD3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fltOxRviYRJ6YXdLJRhyGHGvYieJuLBe713CJww8BkxNfydTglKz5Z74q3xo+XUZCY2s6UwUDc7AHNdl5C7T7RowrQxBKL6Hcuu1JWIkwAglFGN3lXAGIhiMZh4+Gdesi/gQhdeE9b37CEw2sUk67lSWqpdC2NqPFOzURYbGKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+X3/32E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+X3/32E"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2baca4df358so55303725ad.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650763; x=1780255563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0yJ/pUlU1aqmXWL1GkRexYrAhtZgWV1GFqDhWDMILk=;
        b=X+X3/32EtqtZLE0mV8AWF0j5vk3tSuPIDWNQG9Fxg/paZ3/oASsys4exuxJAJx99PC
         9RM5wt8B4Dfm1nH6s4Y1YfegIUS8a3414OZ+TAUYjg/6YHSKmI2hv2iacorOrGB1L/+T
         hS7/D7CPuNRZSLvOaIixhRIKu8Spmn/j+VK+0Sz37Z+rfc6dDRjlUlgmO2IEO1OOL+lW
         FNyxhD//KDupIxV7flk/GjwmtPUEFty4kvjexmJMKasiFXI1DiP64IzjQrvvoifq/9JY
         Ci5v+Qu60XewNFTg4gPVfPiL6apYCwG5hP9WDZV2QENxCj8XaAS2qrVmIj96jQDgE9Rt
         h0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650763; x=1780255563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0yJ/pUlU1aqmXWL1GkRexYrAhtZgWV1GFqDhWDMILk=;
        b=FseQI6GZQ8wkmjdGvyKpewX/dhi3ABn49mCpxJYGGRFiZ+9JNxpjbxVRKWvD66HMuC
         QeilEG3/yCZ4Dx6lEe/GggDOpvNkNRMKqYDA9PNXJ1ee3F+rUU/caies+Vx44uToEOuR
         1dc1QWjoQAy66KQVvRedGWQFQO0CvSFJcmgmqxPOepyV94AcZhcjBGpf6WhcIGfy4m4X
         RyIoQOQxA6EPtspdOz/3rqOkZ9148EfFI8qN3sd99YleJnbpk6ET2tEnUfJkwsFcDJ3n
         aCeqQl85tUmzHLyM5SkEXXfsXCPviVvCcrCZU8jEeb3aTFg1kWKj+17Az3E5jD+9YmVz
         +JIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hTJfwqNiQ+ldOnL+6yTWStYqgtvwp6NfmHLB45RPrmz+0amyWEAeJn1LTNomLm/vHzAO88ofiPn2sYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznJEb0sqlG2c+Jyhyn9FkUfewjg71Ki49acL88Tdzkh4PGN08q
	fd141nftKml8IER19AcpPoZWSdFxhRDcq+hvBDgNT1k6s40/gbZ5q4SLQN/taA==
X-Gm-Gg: Acq92OFLqGVI+fNi3JlEdyI/CzaNHU26unzdBIa0e7IidyflYE24l2BP6DTl9R35zTN
	fRTDoDYo0TzFAoEMXLky4wdJLc0XjjxbZq0AWD0U5c2xr0EJAZWQ3c+SufP7LWD1nsLD+1UT8iL
	2dV3PC7iUedQJU7Ao9psLyqrKYWyA6BemSWIJVWCU1U0X1nnrTCj9VpSYK7lpATDo6MjBM24ZMy
	Dgoesz9pUkLexWnWA5cEQniZSFNq29NEA1pO8M+FmiO2jP05Pl0U5UpMRcqzwkBtMP4U0JcivLC
	hEjBVKdAhgc6P7uemzWmPE+pxE8ZgcWBkFUpkVO1br3SiVX8VqAp8AlI8/C+SckZjx8SA1xBvWs
	BBDCbScbUNyMIJEcKZ0BSoZnGxS3P+ooDJzzR8A/WlrLN3AyenlbyYLZ0k3qENjFpizjgIrP99q
	ma4EEs/fbCxJgZMsHa402vE2Ba0NHgJEjpRthjUN82cz+1eDEU
X-Received: by 2002:a17:903:2ca:b0:2bc:fe65:4e9e with SMTP id d9443c01a7336-2beb076f99emr124928025ad.27.1779650763045;
        Sun, 24 May 2026 12:26:03 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm16394465ad.2.2026.05.24.12.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:26:02 -0700 (PDT)
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
Subject: [PATCH v4 10/36] iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
Date: Mon, 25 May 2026 00:55:47 +0530
Message-Id: <20260524192556.1195042-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 67 ++++++++++++++-------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 020812639947..05ce6258fd3b 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -84,7 +84,7 @@ static const struct iio_chan_spec gyro_3d_channels[] = {
 
 /* Adjust channel real bits based on report descriptor */
 static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
+					    int channel, int size)
 {
 	channels[channel].scan_type.sign = 's';
 	/* Real storage bits will change based on the report desc. */
@@ -95,9 +95,9 @@ static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
 
 /* Channel read_raw handler */
 static int gyro_3d_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2,
+			    long mask)
 {
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 	int report_id = -1;
@@ -122,8 +122,7 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 					min < 0);
 		else {
 			*val = 0;
-			hid_sensor_power_state(&gyro_state->common_attributes,
-						false);
+			hid_sensor_power_state(&gyro_state->common_attributes, false);
 			return -EINVAL;
 		}
 		hid_sensor_power_state(&gyro_state->common_attributes, false);
@@ -156,10 +155,10 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 
 /* Channel write_raw handler */
 static int gyro_3d_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask)
 {
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 	int ret = 0;
@@ -187,8 +186,8 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				void *priv)
+			      u32 usage_id,
+			      void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
@@ -209,9 +208,9 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				u32 usage_id,
-				size_t raw_len, char *raw_data,
-				void *priv)
+				  u32 usage_id,
+				  size_t raw_len, char *raw_data,
+				  void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
 	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
@@ -251,22 +250,24 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 	int i;
 
 	for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
-		ret = sensor_hub_input_get_attribute_info(hsdev,
-				HID_INPUT_REPORT,
-				usage_id,
-				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + i,
-				&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
+		ret = sensor_hub_input_get_attribute_info(
+			hsdev,
+			HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS + i,
+			&st->gyro[CHANNEL_SCAN_INDEX_X + i]);
 		if (ret < 0)
 			break;
-		gyro_3d_adjust_channel_bit_mask(channels,
-				CHANNEL_SCAN_INDEX_X + i,
-				st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
+		gyro_3d_adjust_channel_bit_mask(
+			channels,
+			CHANNEL_SCAN_INDEX_X + i,
+			st->gyro[CHANNEL_SCAN_INDEX_X + i].size);
 	}
 	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
-			st->gyro[0].index,
-			st->gyro[0].report_id,
-			st->gyro[1].index, st->gyro[1].report_id,
-			st->gyro[2].index, st->gyro[2].report_id);
+		st->gyro[0].index,
+		st->gyro[0].report_id,
+		st->gyro[1].index, st->gyro[1].report_id,
+		st->gyro[2].index, st->gyro[2].report_id);
 
 	st->scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_GYRO_3D,
@@ -295,10 +296,10 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	gyro_state->common_attributes.pdev = pdev;
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
-						HID_USAGE_SENSOR_GYRO_3D,
-						&gyro_state->common_attributes,
-						gyro_3d_sensitivity_addresses,
-						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
+						 HID_USAGE_SENSOR_GYRO_3D,
+						 &gyro_state->common_attributes,
+						 gyro_3d_sensitivity_addresses,
+						 ARRAY_SIZE(gyro_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
@@ -327,7 +328,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	atomic_set(&gyro_state->common_attributes.data_ready, 0);
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
-					&gyro_state->common_attributes);
+				       &gyro_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
 		return ret;
@@ -343,7 +344,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	gyro_state->callbacks.capture_sample = gyro_3d_capture_sample;
 	gyro_state->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D,
-					&gyro_state->callbacks);
+					   &gyro_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
 		goto error_iio_unreg;
-- 
2.34.1

