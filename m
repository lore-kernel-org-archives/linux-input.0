Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C230E0E5
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650519; cv=none; b=o63TlVlrC5kO54ai3nfvdKEBFY9gpxMIrkMerbVNS7LuO4uBgQt3fYONQDVQOmE0unauCl+ywAuwc/QDaLE2qOwi3I2C5Gb+MCM674EJY6voAodZWFS+7Vb/8So2ljNvImjkdDiGNTfiI7TeQ6uH4DX66wKKKgDRiW5TJ2C5FfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650519; c=relaxed/simple;
	bh=pngA2fHYLMbsHAfUmVEEPk9zhqxA+vmpgzYNUf0aeHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryEX/c2iDx1A769wJwnsw3O9CeQsO5sKR79N8a0BMbNIDpZg8uP07uq6z6Jsw5KkKQt3yBMA/quQEv5iCgpkPxw0SBAbxMmq+8zcGk/WAE3Oiy8avIzagHG5Ir3ae9oYwZdYVAVclXeLvZ6ltSCgilpTk2wB6/rBfRcZkzIH3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfI6Gxs2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfI6Gxs2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so4128020b3a.1
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650518; x=1780255318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbrYaV7tYmRmUQKs4LOTtNhyw3TLJ8DpBeCaGDcrhew=;
        b=RfI6Gxs2RezYmWGH2tfIYiowWiJdVf3li1iTWlw2MSBerybiIRfCwQrUu8HlbQn3Kf
         87oMOd5HOQfWqgDMsiiWRlddVLUqibiodrQVOXHX6U+Dtay72mh0NaDm8tx6xzPQyZ6f
         t4JOd7cerUT7KvpGE13Hnp+9w10WIUod9f2Yftu8P+OsmQ7Hftd31VKw+j8EFHL6hrwD
         u1ntD5CmNXhcnL7ev3ghgcvtibZWjlr7BeI+jsTQlMMDYw4Zu3kWmpVkQjX6w1wcS48Y
         j+2zuPwQuUo7YUhX6TJLB4vFoaE0ZfIMQkdbC0BW0KIJRHL0vQICVecqtLuEbiRZsHDU
         CaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650518; x=1780255318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lbrYaV7tYmRmUQKs4LOTtNhyw3TLJ8DpBeCaGDcrhew=;
        b=ITxbpOIO+zZFUHD/9VFcrBDvbGH4HS9J7xLHY0YigO+y4izwqPFeXRfzEGso5+RQPu
         LylpFueF5BbXJnM8WAzHt1jtoLN6RkrmUrU3nNrozeqOmfIevyr7WtQRbS5T5ePZzjSz
         pRByrokWQzG7fOJku0gaGhBEmXCisxeqE1JGbUFAydEktQbfQQHti16U3OMS4N7g03Ni
         UecFQsPFpsZsjZ0dyv8M1VzWoG1IVSu/Cxk24ZwGaq/8H7sZR/nzJBw07enWieuvzGTf
         P2qQDlGXTr7h7UKLgmeAOJCC/arPGnCpABI89KskLTVQD+0/pHvwBFpw0jYQAyjqnw5o
         CM1A==
X-Forwarded-Encrypted: i=1; AFNElJ/9RXTSQSkGv9jzmhSzMITY+8p3qMS2lCB0knC+7MQBTCP//Wjr6FwFAv5z9TUs2BCDgN8Sa+JtD5Ve2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1xNF8rz8GBELsKYVlDTTkmv3bNHda5Kynlvogfw/lDDqq83m
	VFXmpvYyXkzr/VcT25SvzEdGSSlAwirrBOMg1jZF+rVCk3oyPRTtGMd3
X-Gm-Gg: Acq92OEXwKuIn1F/mAPb9aQzxoas2VMAQun0oIznDeCS9GVzQFm0DZ9brrCA3P7mz0O
	XbkGOCFEmfKu1sqN8E155iLGGIjN6gpx0LIh9pRKT6sahBTECAuUwQ4V1G8VUVjriU3XFemluKo
	7z3AdWceCXJp4x22hvDX+sSs6s5LlPNxE3dzQpumncO1Pc6zllgjxxmFNGgIVvOSYHQQotT2gC3
	v8KLkWCaQqWcHLeeKxNLVpQUcfmgqCLAgIrUC+Bu5XFuglxS3GG2J5hKmqq1N0o6NcVwqj45HEO
	obBgtcbtoAdXliDo+8INhNap13qaqjAm4Iq1I0rcwwXc10j5BqgBLddDcsRl5xlTzFePY2Twv+D
	ysc7GDugHopnAteqpPSwTVC+gJpPH1LF8gL3AXQjWAyAZKzQMpcbJww3/kS2Ywx48jPFbsGRFhk
	z3yf8XDZEdgo0me/l+ObHy5nZVsyjwwBDR1oAu9m8qt52RVI02x9KbkSOY62c=
X-Received: by 2002:a05:6a20:c783:b0:3a2:7ef4:81ed with SMTP id adf61e73a8af0-3b32900b4c8mr10913751637.49.1779650517893;
        Sun, 24 May 2026 12:21:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:55 -0700 (PDT)
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
Subject: [PATCH v4 09/36] iio: humidity: hid-sensor-humidity: align parenthesis for readability
Date: Mon, 25 May 2026 00:50:32 +0530
Message-Id: <20260524192059.1193716-10-sanjayembedded@gmail.com>
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

Adjust alignment of parentheses to improve readability and
maintain consistency with kernel coding style

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 46 +++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f407..6fed019f4099 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -45,7 +45,7 @@ static const struct iio_chan_spec humidity_channels[] = {
 
 /* Adjust channel real bits based on report descriptor */
 static void humidity_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
+					     int channel, int size)
 {
 	channels[channel].scan_type.sign = 's';
 	/* Real storage bits will change based on the report desc. */
@@ -55,8 +55,8 @@ static void humidity_adjust_channel_bit_mask(struct iio_chan_spec *channels,
 }
 
 static int humidity_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
 {
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
@@ -101,8 +101,8 @@ static int humidity_read_raw(struct iio_dev *indio_dev,
 }
 
 static int humidity_write_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int val, int val2, long mask)
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
@@ -127,7 +127,7 @@ static const struct iio_info humidity_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, void *pdev)
+			       unsigned int usage_id, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
@@ -141,8 +141,8 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, size_t raw_len,
-				char *raw_data, void *pdev)
+				   unsigned int usage_id, size_t raw_len,
+				   char *raw_data, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
@@ -159,17 +159,17 @@ static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
 
 /* Parse report which is specific to an usage id */
 static int humidity_parse_report(struct platform_device *pdev,
-				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
-				unsigned int usage_id,
-				struct hid_humidity_state *st)
+				 struct hid_sensor_hub_device *hsdev,
+				 struct iio_chan_spec *channels,
+				 unsigned int usage_id,
+				 struct hid_humidity_state *st)
 {
 	int ret;
 
 	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
-					usage_id,
-					HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
-					&st->humidity_attr);
+						  usage_id,
+						  HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
+						  &st->humidity_attr);
 	if (ret < 0)
 		return ret;
 
@@ -208,20 +208,20 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	humid_st->common_attributes.pdev = pdev;
 
 	ret = hid_sensor_parse_common_attributes(hsdev,
-					HID_USAGE_SENSOR_HUMIDITY,
-					&humid_st->common_attributes,
-					humidity_sensitivity_addresses,
-					ARRAY_SIZE(humidity_sensitivity_addresses));
+						 HID_USAGE_SENSOR_HUMIDITY,
+						 &humid_st->common_attributes,
+						 humidity_sensitivity_addresses,
+						 ARRAY_SIZE(humidity_sensitivity_addresses));
 	if (ret)
 		return ret;
 
 	humid_chans = devm_kmemdup(&indio_dev->dev, humidity_channels,
-					sizeof(humidity_channels), GFP_KERNEL);
+				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;
 
 	ret = humidity_parse_report(pdev, hsdev, humid_chans,
-				HID_USAGE_SENSOR_HUMIDITY, humid_st);
+				    HID_USAGE_SENSOR_HUMIDITY, humid_st);
 	if (ret)
 		return ret;
 
@@ -234,7 +234,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
 	ret = hid_sensor_setup_trigger(indio_dev, name,
-				&humid_st->common_attributes);
+				       &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -242,7 +242,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	humidity_callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
-					&humidity_callbacks);
+					   &humidity_callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.34.1

