Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317713C2D
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104313; cv=none; b=UThRqaxOkk1Ov5SbfintGIOWWqX7HIz9PwsyArf8TOPccy56Douo4ioMow7DOnKujzx8CbPMnmjmb4Ox5VBaEbITL4EbCpAzD3EYhOFtrk3pOhwCS7yXWMlog2CUIsq4ujmBODe+iPiMqEHmQGtXucPtJ7gLtitzSRa6o6WzTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104313; c=relaxed/simple;
	bh=wNFqVlvuIkp+YVh4Q6ynzOaCsNnKtGcWs352JQ7G1II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oG5j2D+XEqHtLQKRtxxob4uqkoEbGdBxlTh1EtJUdii8zLXpniv2eVUkrDm4FD3uyisKecphT2jK2phT1Kbt//OA2R/KQcgDH+Mgm0LBxm+sjuHOoOE6GkFFxH3h6elA2grpQg1K7OCnHgylqb2jm9evH5W3W6fPHCzI8J1O8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zOSLIxXs; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zOSLIxXs"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d1872504cbso1925924a34.0
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771104310; x=1771709110; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PiSlYn5AXCQAcaElveJtUAJuu7BjjuAo+2c/8DlyUXs=;
        b=zOSLIxXsGp787xW2kjDgej5HPVq8LlA1XDcofzWboFd73IoU3NWq2uGhb6lHK/UASj
         vZkz3pOUwqinW7XiDjxatW4EHzCrT5xU4s05IiV2epNwROUMPAUnWd8UtHvLiqnzsMbk
         2RleZyzvI8jPgC1GtWCO6wo9tMiBiZWEbn8j+sAscu+NjQnXcfpxN79RSWnKNjU1K0ps
         gjk2fzDG4hwRMU6oHWP5iHUh6YC9y5TuHXyJItafLfbovquINEiR8npOKD0doDDFGiBf
         PjbJu31SknIUykKHX7GC8l3EwoljTDrljh2SrnwQw5VTb7lMz26EpkBDC4Ug9l9UoMGE
         8VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771104310; x=1771709110;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiSlYn5AXCQAcaElveJtUAJuu7BjjuAo+2c/8DlyUXs=;
        b=bLgLmKDr7PjKj5Y7MZINhrtSwnmCXgfdAdNelSy7iUvT98ght5zcxYx51XTSIauDRw
         5Vxn11T5MbFNN9sD++vPricRcumIasXH440GARTPb8Pn4HzA6M2/DoI/DQ8ylclXTfEX
         Pc8aZ8/Wy7+JJhhkihE/vsi/MN4uLyg2Oau7Oqiltr8NerTzaY4IydrgSUjTIveC1zC/
         Sn2JD5hQi7Mal/imd0+vrho4CTb9uZrWAJFBk2bOoVcts+6FvvdBy43Rmt6UVoVkpxoN
         Df5qmQL/V9e4z7muGdp0j2+pW8GAAmbGOQDWk+BdIW2yVBm+Ihb5jojGOp9KWzs8ckUM
         we2w==
X-Gm-Message-State: AOJu0YzQpBL63ds9ctVChrcNv6svDTu6aLKm+xTRIC91ztx8RZzyewfM
	rJVFR1UBsQlqwo0I1Z/CE2S5g4XOvLAdzxzTmUYgZ4LcWJWtAv9pcaUrVxW+z95Jw8Q=
X-Gm-Gg: AZuq6aLtLzawRCq0WW3ZqDiplCgpQWHrNQGkOYIcHKz/MrRenW/YBe9cStZXseSL/jk
	ZvnpcSwGqGrCQlsKF3pq1ndsC0d8kFuOtkn+sruxuEWciUa3XjLlPIqgYfQmd0ChqcoKP/1uo0t
	9SWg0isy4pjwxNoeWWMSOdIwa4Sd81U/f7F3SJEM7LK9n9RzwrtvTZ0LxhgmgpCSSPpp/C9Zew+
	FmgldZOsgP709bjlI5DuV3rxFt3zF+jnV0bjUNmYQO4WKVduniY31o6MW7lz01oN7GvaIR6wV5q
	KZjWGZu6WKevuAW1Q4XFUQ3q1z2id0lgjqJDIHELu04E+uOj3/NZZfWWTQcIYBEYP0zLMIaiZo0
	U1CIPO4TXOqpPcTnkWrLeoaD7NJ2uVOegXZZqY6aJYUzjK06yXIYXBtMsNcjiDyF+jr5/odKSBb
	9oehsLFtndpCAO0LfXqsX4w1N2xg==
X-Received: by 2002:a05:6830:811a:b0:7d1:5253:a0b6 with SMTP id 46e09a7af769-7d4cde099b3mr1480065a34.2.1771104310140;
        Sat, 14 Feb 2026 13:25:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530d08sm9169456a34.2.2026.02.14.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:25:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Feb 2026 15:25:01 -0600
Subject: [PATCH] iio: orientation: hid-sensor-rotation: use ext_scan_type
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-iio-hid-sensor-rotation-cleanup-v1-1-3aec9a533c0f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N0QrCMBAEf6XcswdJCKX6K+JDaLf2QJJ6l4pQ+
 u8G9XEWdmYngwqMLt1OipeYlNzAnzoal5TvYJkaU3Chd8FHFim8yMSGbEVZS021fXh8IOVt5SF
 iiN6dQ4+ZmmVVzPL+Fq63HyueWwvV/3gcH9KrE8GGAAAA
X-Change-ID: 20260214-iio-hid-sensor-rotation-cleanup-84e8410926ef
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5275; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=wNFqVlvuIkp+YVh4Q6ynzOaCsNnKtGcWs352JQ7G1II=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpkOgu7Jb75qdh3V/sBZFOoB8KnJxMeKJpF6deL
 nRTm0uI/IOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZDoLgAKCRDCzCAB/wGP
 wP1WCACcCuAhhnZfuGOM1usX39FsSfm9DwwvK+FfFQZquxvAFBPdkUc4z53yhCPyZaaRog7dDSs
 3qQYBsU2nikCmQUSSqrTqT7HgJtKQ82RNUz097EDFp+OF4EfObIXHsvPjlUKn8QG7ebwG9vmchf
 QabAAFHZVMvLnlLGEOMx/+Wl7AYdfw/VSEij7/9MNqplRLXvCQfsoPJ1ktvLnbAeg+zu3oTFa0W
 VCWiH9vKkM5vUKYpdqfxF9ZUJ4OZ0HSpG7iQ4VJAXujrJqNpwNUCxYIiBLjrn6eEFhmKkuCnsmB
 m3wsjQFz1CsDSa83ReIpGwvf4lGMT9jVeaAD9Go7bmDmZZip
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Make use of ext_scan_type to handle the dynamic realbits size of the
quaternion data. This lets us implement it using static data rather than
having to duplicate the channel info for each driver instance.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is something I noticed we could do while looking at an unrelated
bug. I'm not sure I have hardware I could test this on, so it is only
compile-tested. It would be good to get a Tested-by: from someone before
applying this. Also, I'm not sure if 8, 16 and 32-bit data are all
possible, so if someone knows, please chime in.
---
 drivers/iio/orientation/hid-sensor-rotation.c | 81 ++++++++++++++++++---------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index e759f91a710a..2634ebf4eeb7 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -34,6 +34,35 @@ static const u32 rotation_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_ORIENT_QUATERNION,
 };
 
+enum {
+	DEV_ROT_SCAN_TYPE_8BIT,
+	DEV_ROT_SCAN_TYPE_16BIT,
+	DEV_ROT_SCAN_TYPE_32BIT,
+};
+
+static const struct iio_scan_type dev_rot_scan_types[] = {
+	[DEV_ROT_SCAN_TYPE_8BIT] = {
+		.sign = 's',
+		.realbits = 8,
+		/* Storage bits has to stay 32 to not break userspace. */
+		.storagebits = 32,
+		.repeat = 4,
+	},
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
@@ -45,23 +74,14 @@ static const struct iio_chan_spec dev_rot_channels[] = {
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
@@ -136,9 +156,27 @@ static int dev_rot_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int dev_rot_get_current_scan_type(const struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan)
+{
+	struct dev_rot_state *rot_state = iio_priv(indio_dev);
+
+	switch (rot_state->quaternion.size) {
+	case sizeof(s8) * 4:
+		return DEV_ROT_SCAN_TYPE_8BIT;
+	case sizeof(s16) * 4:
+		return DEV_ROT_SCAN_TYPE_16BIT;
+	case sizeof(s32) * 4:
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
@@ -196,7 +234,6 @@ static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int dev_rot_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				struct iio_chan_spec *channels,
 				unsigned usage_id,
 				struct dev_rot_state *st)
 {
@@ -210,9 +247,6 @@ static int dev_rot_parse_report(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	dev_rot_adjust_channel_bit_mask(&channels[0],
-		st->quaternion.size / 4);
-
 	dev_dbg(&pdev->dev, "dev_rot %x:%x\n", st->quaternion.index,
 		st->quaternion.report_id);
 
@@ -271,22 +305,13 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
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
base-commit: 0f11bb7985ceef2aeeb5c45c3c7bfff3f5a16e03
change-id: 20260214-iio-hid-sensor-rotation-cleanup-84e8410926ef

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

