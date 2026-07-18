Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5D245020
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382839; cv=none; b=nyt+TFjHqvLy0zmpzsLkYM8R4Qto5jwSHEmaGrm3JcfDHdfj2QfKHKluMPDfoVwGCxd0RyJ5KUJ2qtO3w5jZQnUjhJ++9xfmta4C+RXWpcyEyl7rfWU1MxDpfjcKkGDQ3CEwfj9lBW4F2SWPqMSkkSnfTNmJiGMckOOHV2CL14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382839; c=relaxed/simple;
	bh=C5CW+BEus7Sa95ONi9QFZjP2wx3ThcA3MJQWYYdh6kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TKNY+ZYC3f/HG5t2c5axqQu95icOq+BDTIQMi8bAick0VpfRbidFdFtSSWR8veWQJCysb9bdXny30hKOoXmQ1pnrVA2PLR9J3iS9ujljOloO5n+UHvQdQhX1Vp9LT7gcxVpyR8uMJfg/tfobywqUBi+0XDZ5QJVbTM0Q9mm7vKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe7bKOFW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe7bKOFW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f703a9d05so45020f8f.0
        for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784382835; x=1784987635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWwN8n4vyYN8UoQsLoi6pJMnHZOnDLj3ZZivbSTwi2U=;
        b=Oe7bKOFW9dkMAE0Uzxgl984zlblQKhIwuJNT/gPvg4E2qu9fM0aHqzhS1y9ZMD7yM+
         2yDMx6S3de2r78JgL80kQCknnV9ofujdaTOLtdMTRsj1nfdI8aISc7l9FR830qhItQUG
         pVXtUYWg8RQwZyTsyWcxVI6MbSZJaM7Ny+A+ryu8r5GqxW+shqS/XTEsCa+scn10mg6Q
         wRQqNABOQsK42YFbcmZadKJXGHNDqZx0B9oJ6VYf3JN4fBO25bB2c8jgQ/TSoTe6H6pk
         zM8LQgWO+dBB5zWJGqkxHbJMDbM/wqXwTRPSXTANTvYKgOLvB2tJGW8GFDo+SBF0BQeG
         AzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784382835; x=1784987635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWwN8n4vyYN8UoQsLoi6pJMnHZOnDLj3ZZivbSTwi2U=;
        b=SyhAGM1+l+EMnAhrT7hVbpbNqLrdx6c7FCqT+WSUoocxM/utL8AGKu2ODyiVOEN3Jq
         CPhqIzhDcoo1Notl5XQv3pqIe6aITsNE6fBQSMfyffHtrHei6Sb7Y1tC7W2EMV9c4zQB
         leKApLH5A7HsBigCgjgxzipW49qVfTdJlVCzwaPdw2q0d0UB6F03hmerfPpj40AuTISb
         Bk65PFnG4w/0WyXKJNeJ4RYI6gPWVMJEbbQKDI84bVBTyG7FTPV7Y3SQv5BxsbUcAIup
         UaLwUSgzPx25yIkqK7+FfFY5tqlp/K/CCeXc2rv8RR1WjP47lCyn568Rs+UNKYLrljqV
         Urbg==
X-Forwarded-Encrypted: i=1; AHgh+RqeqbuZTO0QJ3cFvDcEKjxXTEuKdvmDenoN8rUNFjx1C/gChGcGcYU8VG6W3nhNfZ8Cmr6GnPDg2fh1uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuKqXxcNsoSH0EUHhIk4kug4y1cm3nzCQ/2uTQWiJRiGlwcZkW
	F9AdgveUV/WAQtm8gAxNWlLduMHrSYUsa7fzs9IkUQCashRW+mOv2sMy
X-Gm-Gg: AfdE7cnBRuv7g5bxfCs30WvV18k1O+liFtX7JJq40pOTfuMBS1KWvvCUzqsz9chnKvG
	9EXLAHdK4WD0VAwP7lVopU5cyG+hsqQg0Io5Nqj+MuWnjjuQ5ZBZWbR0bvDfMxq2eT5La8jVQQR
	9SGIBYZtWCgknftz/0/cUi4d5RIWoUueQsTmHtZBi8KM6VGa0wezj7sGeuZ0OI2Rg7dOoNIO6Fl
	J60UF1LSxXF6aEqdtA9GVeBr9UVRuaf+xbcZUoCcPq/VLbr70M4Jp/MIebJavP/iM9H+VcA/+V4
	q9ujp6Ba+w1Q+RwIybI0zsespe3tCkD+5+MVU2FWKtSWUZAw0Q84NyjkNl5986nBwGgfiI7Byni
	c/pOEVqOK25gUPzx9SgaMPSp8byycnZ6m76Y1MSENB8Jm5pm4lRZZEmoftzaB93xUhxnPpnpDQw
	rM45w+eeXR93Gd2Eibk7dmLQ==
X-Received: by 2002:a05:6000:2084:b0:47f:5cd8:d0a2 with SMTP id ffacd0b85a97d-47f62318709mr8353561f8f.27.1784382835277;
        Sat, 18 Jul 2026 06:53:55 -0700 (PDT)
Received: from unknown.tail46804.ts.net ([2a02:b023:8012:c057:b692:106d:cc69:217c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e49500sm12646941f8f.2.2026.07.18.06.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:53:54 -0700 (PDT)
From: Gianluca Boiano <morf3089@gmail.com>
To: hansg@kernel.org,
	dmitry.torokhov@gmail.com
Cc: alexeymin@minlexx.ru,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH] Input: novatek-nvt-ts - support being panel follower
Date: Sat, 18 Jul 2026 15:53:16 +0200
Message-ID: <20260718135316.785467-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Minnekhanov <alexeymin@minlexx.ru>

Sometimes Novatek touchscreen is paired together with Novatek panel,
and they both need to be powered together in sync.

Add support for nvt-ts driver to operate in panel follower mode, in
which touchscreen isn't in full control of its lifecycle. This is
managed using callbacks from panel, to get informed when the panel is
powered on and off. From there we can match the nvt-ts device's power
state to that of the panel.

Without this probing touchscreen before panel sometimes randomly fails
with I2C read errors.

Split some code from probe function to a separate
initial_power_on_and_register_inputdev function, which is called once
from panel_prepared callback, or from probe function, depending on
mode.

No Kconfig dependency on DRM is needed: drm_panel.h provides inline
stubs when CONFIG_DRM_PANEL is off, so the driver remains usable as a
standalone I2C touchscreen without DRM.

In panel-follower mode, nvt_ts_stop() can be called twice for a single
nvt_ts_start(): first from on_novatek_panel_unpreparing() when the
panel powers off, and again from input_close_device() when userspace
(e.g. systemd) closes the evdev file descriptor. The symmetric problem
exists for nvt_ts_start() on panel re-prepare. Guard both with a
'running' flag to make them idempotent. The flag is safe without
additional locking as all call paths already hold input->mutex.

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
Co-developed-by: Gianluca Boiano <morf3089@gmail.com>
Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/input/touchscreen/novatek-nvt-ts.c | 122 +++++++++++++++++----
 1 file changed, 103 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
index 0f771f681952..8b290f75a8e4 100644
--- a/drivers/input/touchscreen/novatek-nvt-ts.c
+++ b/drivers/input/touchscreen/novatek-nvt-ts.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2023 Hans de Goede <hdegoede@redhat.com>
  */
 
+#include <drm/drm_panel.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -59,6 +60,13 @@ struct nvt_ts_data {
 	struct touchscreen_properties prop;
 	int max_touches;
 	u8 buf[NVT_TS_TOUCH_SIZE * NVT_TS_MAX_TOUCHES];
+	/*
+	 * Sometimes Novatek touchscreen is paired together with Novatek panel,
+	 * and they need to be powered together in sync.
+	 */
+	struct drm_panel_follower panel_follower;
+	bool is_panel_follower;
+	bool running;
 };
 
 static int nvt_ts_read_data(struct i2c_client *client, u8 reg, u8 *data, int count)
@@ -95,6 +103,9 @@ static irqreturn_t nvt_ts_irq(int irq, void *dev_id)
 	bool active;
 	u8 *touch;
 
+	if (!data->input)
+		return IRQ_HANDLED;
+
 	error = nvt_ts_read_data(data->client, NVT_TS_TOUCH_START, data->buf,
 				 data->max_touches * NVT_TS_TOUCH_SIZE);
 	if (error)
@@ -145,6 +156,9 @@ static int nvt_ts_start(struct input_dev *dev)
 	struct nvt_ts_data *data = input_get_drvdata(dev);
 	int error;
 
+	if (data->running)
+		return 0;
+
 	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators), data->regulators);
 	if (error) {
 		dev_err(&data->client->dev, "failed to enable regulators\n");
@@ -154,6 +168,7 @@ static int nvt_ts_start(struct input_dev *dev)
 	enable_irq(data->client->irq);
 	gpiod_set_value_cansleep(data->reset_gpio, 0);
 
+	data->running = true;
 	return 0;
 }
 
@@ -161,15 +176,23 @@ static void nvt_ts_stop(struct input_dev *dev)
 {
 	struct nvt_ts_data *data = input_get_drvdata(dev);
 
+	if (!data->running)
+		return;
+
 	disable_irq(data->client->irq);
 	gpiod_set_value_cansleep(data->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+
+	data->running = false;
 }
 
 static int nvt_ts_suspend(struct device *dev)
 {
 	struct nvt_ts_data *data = i2c_get_clientdata(to_i2c_client(dev));
 
+	if (data->is_panel_follower)
+		return 0;
+
 	guard(mutex)(&data->input->mutex);
 
 	if (input_device_enabled(data->input))
@@ -182,6 +205,9 @@ static int nvt_ts_resume(struct device *dev)
 {
 	struct nvt_ts_data *data = i2c_get_clientdata(to_i2c_client(dev));
 
+	if (data->is_panel_follower)
+		return 0;
+
 	guard(mutex)(&data->input->mutex);
 
 	if (input_device_enabled(data->input))
@@ -192,30 +218,17 @@ static int nvt_ts_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(nvt_ts_pm_ops, nvt_ts_suspend, nvt_ts_resume);
 
-static int nvt_ts_probe(struct i2c_client *client)
+static int nvt_ts_initial_power_on_and_register_inputdev(struct nvt_ts_data *data)
 {
-	struct device *dev = &client->dev;
+	struct device *dev = &data->client->dev;
 	int error, width, height, irq_type;
-	struct nvt_ts_data *data;
 	const struct nvt_ts_i2c_chip_data *chip;
 	struct input_dev *input;
 
-	if (!client->irq) {
-		dev_err(dev, "Error no irq specified\n");
-		return -EINVAL;
-	}
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	chip = device_get_match_data(&client->dev);
+	chip = device_get_match_data(dev);
 	if (!chip)
 		return -EINVAL;
 
-	data->client = client;
-	i2c_set_clientdata(client, data);
-
 	/*
 	 * VCC is the analog voltage supply
 	 * IOVCC is the digital voltage supply
@@ -275,7 +288,7 @@ static int nvt_ts_probe(struct i2c_client *client)
 	if (!input)
 		return -ENOMEM;
 
-	input->name = client->name;
+	input->name = data->client->name;
 	input->id.bustype = BUS_I2C;
 	input->open = nvt_ts_start;
 	input->close = nvt_ts_stop;
@@ -292,10 +305,11 @@ static int nvt_ts_probe(struct i2c_client *client)
 	data->input = input;
 	input_set_drvdata(input, data);
 
-	error = devm_request_threaded_irq(dev, client->irq, NULL, nvt_ts_irq,
+	error = devm_request_threaded_irq(dev, data->client->irq, NULL,
+					  nvt_ts_irq,
 					  IRQF_ONESHOT | IRQF_NO_AUTOEN |
 						nvt_ts_irq_type[irq_type],
-					  client->name, data);
+					  data->client->name, data);
 	if (error) {
 		dev_err(dev, "failed to request irq: %d\n", error);
 		return error;
@@ -310,6 +324,76 @@ static int nvt_ts_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int on_novatek_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct nvt_ts_data *data = container_of(follower, struct nvt_ts_data, panel_follower);
+	int ret;
+
+	/* Is this the first power on? */
+	if (!data->input) {
+		ret = nvt_ts_initial_power_on_and_register_inputdev(data);
+		if (ret)
+			return ret;
+	}
+
+	guard(mutex)(&data->input->mutex);
+
+	if (input_device_enabled(data->input))
+		nvt_ts_start(data->input);
+
+	return 0;
+}
+
+static int on_novatek_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct nvt_ts_data *data = container_of(follower, struct nvt_ts_data, panel_follower);
+
+	guard(mutex)(&data->input->mutex);
+
+	if (input_device_enabled(data->input))
+		nvt_ts_stop(data->input);
+
+	return 0;
+}
+
+static const struct drm_panel_follower_funcs nvt_ts_follower_funcs = {
+	.panel_prepared = on_novatek_panel_prepared,
+	.panel_unpreparing = on_novatek_panel_unpreparing,
+};
+
+static int nvt_ts_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct nvt_ts_data *data;
+
+	if (!client->irq) {
+		dev_err(dev, "Error no irq specified\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	/* Check if "panel = <&...>" is set in DT */
+	if (drm_is_panel_follower(dev)) {
+		data->is_panel_follower = true;
+		data->panel_follower.funcs = &nvt_ts_follower_funcs;
+		/*
+		 * In this mode, we defer everything to the panel callbacks.
+		 * The initial power on and input device registration will
+		 * happen in on_novatek_panel_prepared().
+		 */
+		return devm_drm_panel_add_follower(dev, &data->panel_follower);
+	}
+
+	return nvt_ts_initial_power_on_and_register_inputdev(data);
+}
+
+
 static const struct nvt_ts_i2c_chip_data nvt_nt11205_ts_data = {
 	.chip_id = 0x05,
 };
-- 
2.55.0

