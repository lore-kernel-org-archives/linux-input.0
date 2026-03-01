Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027C19ABD8
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772408829; cv=none; b=tad7jVg+uK9BAanhybdJzMz4+4TSk5+18LR2nABV8HYJuAiHy0bwY14FlRBKfW0RGpQAWiuqif/Vnl9dLk4QKRoDxCu2zHuEEDMYmG8LvH5cBNXNPPIEvdyW0ZNZIDiC77PHZ2zYV99hDkUAAgaIM6eVKuGtMfIBD6cl16pMj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772408829; c=relaxed/simple;
	bh=d2WnHgqmi2t0hFyj3qyly3wbZePdj7qu8dGp5arudvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lFamVM+rIRbiOjTmdRSut0YZNvnpcDl0O73dUSE7jcPvnZ5p/UjcBJMnApO6+nAAK/kFGOsWTOcKDDqXVvyYBgu4yn/ZSwOMFBxG/Qmwowqg8HamW1FEYfG/2CZ9VBoxKHemb7cGdugzrAVIfhrrhhINraSkrwfLLB1tYdqTow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WiCU2SL3; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WiCU2SL3"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45f09874c4cso2888072b6e.3
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772408825; x=1773013625; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dwT1q+TqqHDCYMVcm5xwnQXT5XtGs/pb1m0k2p2HzY=;
        b=WiCU2SL3Bw8olojpjv9WWa2j7NbEtLY1OocRswNGH+ArPk/G+tlYY7oMKJQbxWjMFT
         YAK5KzuuJhhNGeBij8FTG0AeQSYZ1mLUoQrj+SL2v8XAi14POgTExnrolmSgIkQQ5JZ1
         mP35Vm0egF3QjomlbwEQXhv4CwI0pSIvDzR464faNUUXemw7y+BhJorojxkRstegYanJ
         5F+9Hyj41oDKnEORJbqIWxwG0plMiZI607dF+r92t+YqP17VxcYeV2eTGCsMfgDogZDl
         eX6nQMPMOEgWOGQXUXiHgb2DWChDRFQ1qExlNjutotzIbmiz+1VvS4WzJGpUbD3Q3W3V
         XbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772408825; x=1773013625;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dwT1q+TqqHDCYMVcm5xwnQXT5XtGs/pb1m0k2p2HzY=;
        b=m+u2zTyxRx54LjsUNZVPeFwSIZctQ/QxSQNJEpO5yvUyp7t6h80wnRorCUkA5VKgy7
         NphU73UVHgxSYv5N/+/Qse7DiGS90vtvZmB3M9Xlfrexr4CyhVPNgfH/N9qtPMoLpWwB
         jAQpqJui+aWqSCRygCIuf8DUMeCsNu/tj67OpQl+iEwWg3wnNDqTLzbhZy6OF1NoF8QL
         KzaB/FVoAW2fa5JBWzU84ddMvSMIZKEk16jvJp0V+paX+C4LKIlHs2Wlsb3iMdhiOf1l
         ughMsx64qbdiOKBrqw9EnylkOcZG0Qghy0XLd/4iVi0bw4vF8MCBzjPbg9SX/LVSrNlE
         /7eA==
X-Gm-Message-State: AOJu0YwWc5FSKlAPUXI5ujy3Z0KWlt3rZAiROC+VARQkHfOvrMYulU2f
	FIRV8riA/aj33MRqGuKAxz5yBd2QQ40yypKXiPIVml4DU7trFmdeZbT0GeX7KeMXhGo=
X-Gm-Gg: ATEYQzy88y2sMtKkGP/vQNDbk11KlaA9cGjiBvZPxoAqkVtzOz0euMmxiB/R6gcEYeS
	LrO+Oi//QDkB9fYwKTDzvPGkCZF7VbkT+bvyhZtGR8ibo5+CZBuwgIwa02WcF8ZIs52JWQ7b9tU
	+oUPMmrPp2aUtNsPTcoOvJiEPpWKJ6RN1NPtemuu3Wi0FEYNZuorcToYeaZo+2LG6zHj9gMWUMn
	djHnosFksGIV5CtMFW5NSjNL3jY8tclnQMHQurbUNl+vAfWyz6O9NShYUfTGV14JJ5ntSGGP2qQ
	/xogjqHKOSlpsfXJqBQ2Dh+Zuv0mf04aoLSoUBWqp6qhDgkigVPmT+UNvqyXvKfM+dwx0ojoFzf
	kxiLXXIOqb2+wvLrY9wFRoRs6RwbE+5yzI/zThxuukrWvdoqNCWXnlDn+tANDfow6zn5MkCmPrz
	WUxZZNAgv1p06SC2pGxpKBS5gcWq4z
X-Received: by 2002:a05:6820:4b18:b0:66f:2d14:32b7 with SMTP id 006d021491bc7-679fadb8aebmr5703003eaf.9.1772408825368;
        Sun, 01 Mar 2026 15:47:05 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2da4390sm8152129eaf.14.2026.03.01.15.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 15:47:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 01 Mar 2026 17:46:48 -0600
Subject: [PATCH v2] iio: orientation: hid-sensor-rotation: use
 ext_scan_type
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-iio-hid-sensor-rotation-cleanup-v2-1-245c6ad59afc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQ6CMBBEf8X07Jq2IAFP/ofhUMoim2CL20Ikh
 H+34sGrxzfJzJtVBGTCIC6HVTDOFMi7BPp4ELY37o5AbWKhpS6kVjkQeeiphYAueAb20cTUATu
 gcdMIZY5lrmSlC+xEWhkZO3rthlv9ZcbnlETxF/YUoudlfzGrT/q/cFagIDNoK3POMiu7a2OWg
 RrGk/UPUW/b9ga3eEgI5gAAAA==
X-Change-ID: 20260214-iio-hid-sensor-rotation-cleanup-84e8410926ef
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5237; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=d2WnHgqmi2t0hFyj3qyly3wbZePdj7qu8dGp5arudvw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBppM/vBv88UMkBlPn8dCHUBhk8jgkIzWqMtohA8
 IT61NTktZ6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaTP7wAKCRDCzCAB/wGP
 wBObB/9PCXzB6uVauf004a+Ojx96a7UBtPuXvJza727xxOJHSIrawHfQy86MBJ+CTssCw1y3ioz
 oM6qc9ml4JONrOamrF13ppfjgxULDiqj7gVPLq1ClDBMT5xcVyVpeOFUnvqnTojGzeTEThPDnM9
 XmDqXE9okxfvcnlJD4neasvsXqp2g6V8yoBqpxjwaWQbd5eY4tXOAyi+7nkNfFLky3fnDN3WiH3
 CHqQ8+8+A9lBoYrOo4xv32fOYmLqNhLcWGUh1QPXxXmcS4BnGfkkzGmIG0co1jcOPVVvHUl9Pa9
 N6LhgxDZpb+zFM7m/gdCJz+LD40zv+oNgxyw7PgjbQrKB247
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Make use of ext_scan_type to handle the dynamic realbits size of the
quaternion data. This lets us implement it using static data rather than
having to duplicate the channel info for each driver instance.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is something I noticed we could do while looking at an unrelated
bug. I've tested this using the same script from [1] and confirmed that
that the scan type didn't change. Before and after are both:

$ cat in_rot_quaternion_type
le:s16/32X4>>0

[1]: https://lore.kernel.org/linux-iio/20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com/
---
Changes in v2:
- Dropped DEV_ROT_SCAN_TYPE_8BIT.
- Tested using /dev/uhid.
- Link to v1: https://lore.kernel.org/r/20260214-iio-hid-sensor-rotation-cleanup-v1-1-3aec9a533c0f@baylibre.com
---
 drivers/iio/orientation/hid-sensor-rotation.c | 71 ++++++++++++++++-----------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index e759f91a710a..3cfd0b323514 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -34,6 +34,27 @@ static const u32 rotation_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_ORIENT_QUATERNION,
 };
 
+enum {
+	DEV_ROT_SCAN_TYPE_16BIT,
+	DEV_ROT_SCAN_TYPE_32BIT,
+};
+
+static const struct iio_scan_type dev_rot_scan_types[] = {
+	[DEV_ROT_SCAN_TYPE_16BIT] = {
+		.sign = 's',
+		.realbits = 16,
+		/* Storage bits has to stay 32 to not break userspace. */
+		.storagebits = 32,
+		.repeat = 4,
+	},
+	[DEV_ROT_SCAN_TYPE_32BIT] = {
+		.sign = 's',
+		.realbits = 32,
+		.storagebits = 32,
+		.repeat = 4,
+	},
+};
+
 /* Channel definitions */
 static const struct iio_chan_spec dev_rot_channels[] = {
 	{
@@ -45,23 +66,14 @@ static const struct iio_chan_spec dev_rot_channels[] = {
 					BIT(IIO_CHAN_INFO_OFFSET) |
 					BIT(IIO_CHAN_INFO_SCALE) |
 					BIT(IIO_CHAN_INFO_HYSTERESIS),
-		.scan_index = 0
+		.scan_index = 0,
+		.has_ext_scan_type = 1,
+		.ext_scan_type = dev_rot_scan_types,
+		.num_ext_scan_type = ARRAY_SIZE(dev_rot_scan_types),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(1)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void dev_rot_adjust_channel_bit_mask(struct iio_chan_spec *chan,
-						int size)
-{
-	chan->scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	chan->scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	chan->scan_type.storagebits = sizeof(u32) * 8;
-	chan->scan_type.repeat = 4;
-}
-
 /* Channel read_raw handler */
 static int dev_rot_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
@@ -136,9 +148,25 @@ static int dev_rot_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int dev_rot_get_current_scan_type(const struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan)
+{
+	struct dev_rot_state *rot_state = iio_priv(indio_dev);
+
+	switch (rot_state->quaternion.size / 4) {
+	case sizeof(s16):
+		return DEV_ROT_SCAN_TYPE_16BIT;
+	case sizeof(s32):
+		return DEV_ROT_SCAN_TYPE_32BIT;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info dev_rot_info = {
 	.read_raw_multi = &dev_rot_read_raw,
 	.write_raw = &dev_rot_write_raw,
+	.get_current_scan_type = &dev_rot_get_current_scan_type,
 };
 
 /* Callback handler to send event after all samples are received and captured */
@@ -196,7 +224,6 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int dev_rot_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
 				unsigned usage_id,
 				struct dev_rot_state *st)
 {
@@ -210,9 +237,6 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	dev_rot_adjust_channel_bit_mask(&channels[0],
-		st->quaternion.size / 4);
-
 	dev_dbg(&pdev->dev, "dev_rot %x:%x\n", st->quaternion.index,
 		st->quaternion.report_id);
 
@@ -271,22 +295,13 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
-					   sizeof(dev_rot_channels),
-					   GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
-		return -ENOMEM;
-	}
-
-	ret = dev_rot_parse_report(pdev, hsdev,
-				   (struct iio_chan_spec *)indio_dev->channels,
-					hsdev->usage, rot_state);
+	ret = dev_rot_parse_report(pdev, hsdev, hsdev->usage, rot_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
 	}
 
+	indio_dev->channels = dev_rot_channels;
 	indio_dev->num_channels = ARRAY_SIZE(dev_rot_channels);
 	indio_dev->info = &dev_rot_info;
 	indio_dev->name = name;

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260214-iio-hid-sensor-rotation-cleanup-84e8410926ef

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

