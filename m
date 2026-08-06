Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E747D45C;
	Thu,  6 Aug 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019204; cv=none; b=Y2K+Etb339Ju9oIgQIlHgIHFRPlfI7RWcvmOAV7Ld/rfVUTkqSWFma1QxDCHK4h8LLODtkh1lrAPxPXZIOSPVlK62RUHw/4g49YDzlgSEyWn32iTCcd4IQHR1cGXrPNgMsExAZIhiDPBGOCm0A0qvOgsjfBGMNMXFR4ODAadZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019204; c=relaxed/simple;
	bh=zokDt6p0efWKRUUpl2vOZnLC2b68P0WDbNk5RWW/DH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hekMzQuI8c3zpG75rWr4izZlsulMpykJBRzSB5zJaii39PeOkNiH3uiIEf2z3R2vpwi99l/bZiTyJvd3lV0yBEh69wj0IAPF5LTrsjk2NfR0AtJrZXgUSTqKQGvjDTKHckNZsQhc7aqpx+IJk6AlBpSAdBiSvzc/ZiAKm1YnvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guwtVKdu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guwtVKdu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE314C2BCFD;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786019203;
	bh=zokDt6p0efWKRUUpl2vOZnLC2b68P0WDbNk5RWW/DH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=guwtVKduE6QE8fghUL1lUhJe2IuVHxixySWsZWTFoxSlo683oWvWe1k5l+J7fgu80
	 4sDmuutpboi3QKleEIPIx+yug0MCddpdW22FxB4PTh5hJXvbLDmPs/N9+w4ZI25r8b
	 JH/AD5TUSBnhK7Ms57cCXCnCyBNzI6g6YiAZpQzK38ZseWawZUORG7cPyiVc7h1bRc
	 /6lCiz7knoOid5cy6tsneYXrKNkoT3j4afe7Husut+Q/UwrWNHuBnGxwnSzSlhR52Z
	 BMLvzT2pZ9K9VRGM9NApRrsGadDn6SXgbUjMTaKHQjlu8sQJXyb3UYrPA1ABpdB6bf
	 4mwkkIaQNU/yA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F2C55ABF;
	Thu,  6 Aug 2026 12:26:43 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 06 Aug 2026 17:55:49 +0530
Subject: [PATCH v5 03/13] HID: hid-sensor-hub: introduce device managed API
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-3-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786019201; l=3632;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=E6NeHcHn1od2bjcFdG8WUYv/9lNEM6tJvVUI7ONP3w0=;
 b=JYVSUlbW7/7kXX43nB26KQ64ZWCJUNjHLe8ae/jXHO55V1lUuuI+ab73jw3FQ7IINPfYtSi/e
 TIn2NT4VigxCVb57E9lcYF7Kf85SoLH0LbsrSV8AzueVg1F3vEdmS22
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

sensor_hub_register_callback() is common API used for the HID IIO drivers,
prepare devm API devm_sensor_hub_register_callback() to acquire resource
during setup and release using device managed framework during drivers
fail, unbind or remove path.

store the required callback removal context (hsdev and usage_id) in a
dedicated struct sensor_hub_cb_devres, and register a devres action to
handle to release resource with devres framework and helper API.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/hid/hid-sensor-hub.c   | 32 ++++++++++++++++++++++++++++++++
 include/linux/hid-sensor-hub.h | 24 ++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 90666ff629de..31dbdce27dc6 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -187,6 +187,38 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 }
 EXPORT_SYMBOL_GPL(sensor_hub_remove_callback);
 
+static void sensor_hub_remove_callback_helper(void *ptr)
+{
+	struct sensor_hub_cb_devres *res = ptr;
+
+	sensor_hub_remove_callback(res->hsdev, res->usage_id);
+}
+
+int devm_sensor_hub_register_callback(struct device *dev,
+				      struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id,
+				      struct hid_sensor_hub_callbacks *usage_callback)
+{
+	struct sensor_hub_cb_devres *res;
+	int ret;
+
+	ret = sensor_hub_register_callback(hsdev, usage_id, usage_callback);
+	if (ret)
+		return ret;
+
+	res = devm_kmalloc(dev, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		sensor_hub_remove_callback(hsdev, usage_id);
+		return -ENOMEM;
+	}
+
+	res->hsdev = hsdev;
+	res->usage_id = usage_id;
+
+	return devm_add_action_or_reset(dev, sensor_hub_remove_callback_helper, res);
+}
+EXPORT_SYMBOL_GPL(devm_sensor_hub_register_callback);
+
 int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 			   u32 field_index, int buffer_size, void *buffer)
 {
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index e71056553108..c00347b15513 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -75,6 +75,16 @@ struct hid_sensor_hub_device {
 	struct sensor_hub_pending pending;
 };
 
+/**
+ * struct sensor_hub_cb_devres - devres data for sensor hub callbacks
+ * @hsdev:	Hub device instance.
+ * @usage_id:	Usage ID associated with registered callback
+ */
+struct sensor_hub_cb_devres {
+	struct hid_sensor_hub_device *hsdev;
+	u32 usage_id;
+};
+
 /**
  * struct hid_sensor_hub_callbacks - Client callback functions
  * @pdev:		Platform device instance of the client driver.
@@ -139,6 +149,20 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id);
 
+/**
+ * devm_sensor_hub_register_callback() - Managed register client callbacks
+ * @dev: Device for resource management
+ * @hsdev: Hub device instance
+ * @usage_id: Usage id of the client (e.g. 0x200076 for Gyro)
+ * @usage_callback: Callback function storage
+ *
+ * This is the devres (managed) version of sensor_hub_register_callback().
+ * The callback will be automatically unregistered when the device is detached.
+ */
+int devm_sensor_hub_register_callback(struct device *dev,
+				      struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id,
+				      struct hid_sensor_hub_callbacks *usage_callback);
 
 /* Hid sensor hub core interfaces */
 

-- 
2.34.1


