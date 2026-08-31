Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4903B8BCC
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163973; cv=none; b=nfzz+cEIf4y/+lTJ2JRJOpl8VuyyLX20b4h7I+p3siU2Uq6s1tPCm2coJZl7CACWloZlyRAgAfeNqrwCZl+i8e2SSPaWHDfNRqY6AcI0mYkV8nuk0ra2FeaA5xn9mZRluz979UVuCYKyKHl/JkrtuSjOctvUd8FFuav9X7oAzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163973; c=relaxed/simple;
	bh=SI0KtZwvMUILN/hDtGjS/7nrR1HaiiJ8KS3di14dvjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pj8q4YBgacZW6cWAhNrvOZCeIpf0+6/EoVYSekXgzUrLTXzMDXVA9QcnzWmKCvICzJweb5eGv5RZknQnDxgX9li1JqPiq1y0exasjXGkC7oomQwUOPDieJajY71jCHwe8/bbcG86EWfvaAoIS5QX04BuABRgsQVX+ldtlBS9XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk70idRx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk70idRx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482fc2b44a7so2618318f8f.2
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788163970; x=1788768770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FicFc67fgcIc5tl+0E7N6HsbJ3qaqQibwFytoA9PM/c=;
        b=Vk70idRxQptciHOzqHYCM5udLCwczZDzlzL1mLM2ERjG7BTNbWB7/veGeZdbjFvPiV
         wTfBldri4s8v4g+ejnZpOLeu6wmeNUcGUKwL/+l/Kg2jTkZtrrwN5BE/T2ay+BVIgJrO
         piWw7scrHPF0ZnhVwR4yWtZPCKB0w3zOhnR8Yce0QEgMuvgbUHd2DsZ1QMfvVOx5DgMA
         qGV8tH/03IDNjrAgMJajBMBX4KwuakuVKKOUpCRYoKjzcmckybbila0cT3ZvgTCPQI3o
         LMdRtrxMqGpjdWgHGFIZ9zGTjmX13/ftzk7qSsnaVMpXQtFJjRdptdpyirSdXB2bhdXB
         Zp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163970; x=1788768770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FicFc67fgcIc5tl+0E7N6HsbJ3qaqQibwFytoA9PM/c=;
        b=iMyBMfhJ6/05GuTAAevwRePe5IhrQE/ed61YJMldTw6Pjk9IUD8tcx/cdyJtSx1LkK
         5h+uDEVVGxuyoQbn0K4KIsRYZtJp9aNcIBLYKIPoacm+wq2TwNw8WKD2d0df48MmtOjj
         +EFXNrMgryqUg4vt3wLMRGKpnOpxqngwUa5YULMjSiXO2RHAN6G8aaymuj2vMes1AO9U
         4D8RwVCEcYJhGfFNGnaMoaQMTbLiQTkehnwewXqoZpE9hBew6mjqa2u8O/8AflGTZZd7
         v/+08H1FJv3nGZHQCQ9+Ullgn2iUpIEsw+FH7490mD19xQCeXWtZEkW89xDSEhRRVKsc
         wsYA==
X-Forwarded-Encrypted: i=1; AKwUvBwU5oEZnqui41UW5GTss34jabOT5Q/G40/J7KJcwoSne/ec7UTtN2w3rN74tMhCbKLndqpFziC84LF7Vg==@vger.kernel.org
X-Gm-Message-State: AFuF++nX2sc1CJD8taRPK5NP3Uu3OWBmLZwbU9TGl0iLhsR5Q41QSBSU
	Gj7xgX/pNFcSy0Wtg1/bOMVItydFFxIhfLaYKEYVfJIFy3az5APCXhD4
X-Gm-Gg: AYBFou2Ujv8djWmXwB4qosr0uP4Nd2JD/gvie5CTzXGmSv06OMBiCMOMn3jCX8NYMT6
	4lcM/xSOc4qt4iKE2JUirrInf/Ed2cNXNSQfYEHij5+qKDzAq09d/64q25ScDR8rliM+pqEODSy
	fKPBpSWsRRotR6iPr/XxgxlFQ2Gi5a6BYhZ+Y2RXsLpLzCsTqIvJJggAftyN+lnYosNEnutcHdR
	bi/Mk4hR3N6E55RuvOWRaDvPPfC4UQCfMATmQDHRBVcGhK+ymqzgd7IMZnUffD38zj/iXibt9O0
	YB9C1982/p0so2c6SqL+wglgssEgYWVjk5ZT6U3IvcdqcXLTTxKrIPThlm9BaUrdJPUX4cnE7s+
	LR/agIff2ssF+fWxPqY05bsV9toIRhPl72A55BgwQNz5V0KmYbKFnnrlk4as79x3hkCMFvpzXGz
	rtGs1ShJ/t1Sql+yAvHTinWTvOZfgCrr2ivWd9t/ci4A819vTKMO1GwGdZlbAWXNNoS5K9dqVfS
	9l7Lor6ldM/ITNi2bNFoQLHW0NC6jn3chO7MNYtnohU
X-Received: by 2002:a05:6000:41dd:b0:484:3311:6f68 with SMTP id ffacd0b85a97d-4843311735emr19882504f8f.25.1788163950308;
        Mon, 31 Aug 2026 01:12:30 -0700 (PDT)
Received: from 1Z10 ([78.210.155.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3fcesm20061275f8f.5.2026.08.31.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:12:29 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Maurizio Casciano <mauriziocasciano7@gmail.com>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v6] Input: drv260x: Fix suspend and resume sequencing
Date: Mon, 31 Aug 2026 10:12:27 +0200
Message-ID: <20260831081227.1794986-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831011526.24AB11F000E9@smtp.kernel.org>
References: <20260831011526.24AB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force-feedback playback is queued asynchronously, but system suspend can
cut power while the worker is pending. Disable and drain the work item
before entering standby, and keep force-feedback quiesced until resume has
restored communication.

An input device can be closed and reopened without playing an effect in
between. Since close lowers the enable GPIO, assert it and observe the
startup delay in the open callback so a following suspend can access the
registers.

Disabling the regulator may remove power and erase the device
configuration. Preserve the actuator mode selected by firmware, cache the
initial automatic-calibration results, and reapply the complete
configuration during resume. Use repeatable multi-register writes instead
of registering persistent regmap patches, which would append another copy
on every reinitialization.

Track whether this consumer has enabled the regulator so devres cleanup
does not issue an unbalanced disable after a resume failure. Keep the work
item disabled after failed recovery, and make regulator and work reference
counts idempotent across PM retries.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-input/20260831011526.24AB11F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/linux-input/20260830143050.03E081F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/linux-input/20260829230740.126461F000E9@smtp.kernel.org/
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/
Link: https://www.ti.com/lit/ds/symlink/drv2604.pdf
Assisted-by: Codex:gpt-5.6-sol [sparse]
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
---
Changes in v6:
- Assert EN from the input open callback, without reinitializing the device
  merely because EN was toggled.
- Reapply configuration after regulator power loss and cache the initial
  automatic-calibration results instead of rerunning calibration on resume.
- Replace regmap_register_patch() with repeatable multi-register writes so
  resume does not append persistent patches to the regmap.
- Keep the firmware-selected actuator mode immutable across playback.
- Track the regulator consumer state and make enable/disable operations
  idempotent across PM retries and devres cleanup.
- Retain the v5 work-disable accounting and explicit PM error unwinding.

Validation:
- Server build at integration commit f565dc5ad36e, containing the exact
  drv260x blob 71996f6d7d7745ebbc1a8c099d2e6c18657c822f:
  olddefconfig, focused W=1 C=2 CHECK=sparse build, and full Debian package
  build all passed.
- Lenovo Yoga Book YB1-X91L running
  7.2.0-yogabook-20260831-033805: both DRV2604 FF devices passed before and
  after an eight-second s2idle cycle. The test stopped the only userspace
  consumer to force the last close(), reopened both devices without playing
  an effect, and then suspended successfully. No drv260x, I2C, or unbalanced
  regulator error appeared in the test journal.
- This tablet uses dummy vbat regulators for both DRV2604 devices, so actual
  regulator power loss and injected resume-error cleanup could not be
  exercised on this hardware.

 drivers/input/misc/drv260x.c | 183 ++++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 33 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..71996f6d7d77 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -181,7 +181,11 @@
  * @work: Work item used to off load the enable/disable of the vibration
  * @enable_gpio: Pointer to the gpio used for enable/disabling
  * @regulator: Pointer to the regulator for the IC
+ * @regulator_enabled: Whether this consumer has enabled the regulator
+ * @work_disabled: Whether playback work is disabled pending PM recovery
+ * @calibration_valid: Whether calibration results have been cached
  * @magnitude: Magnitude of the vibration event
+ * @calibration_data: Cached automatic calibration results
  * @mode: The operating mode of the IC (LRA_NO_CAL, ERM or LRA)
  * @library: The vibration library to be used
  * @rated_voltage: The rated_voltage of the actuator
@@ -194,7 +198,11 @@ struct drv260x_data {
 	struct work_struct work;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
+	bool regulator_enabled;
+	bool work_disabled;
+	bool calibration_valid;
 	u8 magnitude;
+	u8 calibration_data[3];
 	u32 mode;
 	u32 library;
 	int rated_voltage;
@@ -215,6 +223,24 @@ static int drv260x_calculate_voltage(unsigned int voltage)
 	return (voltage * 255 / 5600);
 }
 
+static void drv260x_disable_work(struct drv260x_data *haptics)
+{
+	if (haptics->work_disabled)
+		return;
+
+	disable_work_sync(&haptics->work);
+	haptics->work_disabled = true;
+}
+
+static void drv260x_enable_work(struct drv260x_data *haptics)
+{
+	if (!haptics->work_disabled)
+		return;
+
+	enable_work(&haptics->work);
+	haptics->work_disabled = false;
+}
+
 static void drv260x_worker(struct work_struct *work)
 {
 	struct drv260x_data *haptics = container_of(work, struct drv260x_data, work);
@@ -243,8 +269,6 @@ static int drv260x_haptics_play(struct input_dev *input, void *data,
 {
 	struct drv260x_data *haptics = input_get_drvdata(input);
 
-	haptics->mode = DRV260X_LRA_NO_CAL_MODE;
-
 	/* Scale u16 magnitude into u8 register value */
 	if (effect->u.rumble.strong_magnitude > 0)
 		haptics->magnitude = effect->u.rumble.strong_magnitude >> 8;
@@ -258,11 +282,29 @@ static int drv260x_haptics_play(struct input_dev *input, void *data,
 	return 0;
 }
 
+static int drv260x_open(struct input_dev *input)
+{
+	struct drv260x_data *haptics = input_get_drvdata(input);
+
+	if (haptics->work_disabled)
+		return -EIO;
+
+	gpiod_set_value(haptics->enable_gpio, 1);
+	/* Data sheet says to wait 250us before trying to communicate */
+	fsleep(250);
+
+	return 0;
+}
+
 static void drv260x_close(struct input_dev *input)
 {
 	struct drv260x_data *haptics = input_get_drvdata(input);
 	int error;
 
+	/* PM has not restored register access yet. */
+	if (haptics->work_disabled)
+		return;
+
 	cancel_work_sync(&haptics->work);
 
 	error = regmap_write(haptics->regmap, DRV260X_MODE, DRV260X_STANDBY);
@@ -338,9 +380,9 @@ static int drv260x_init(struct drv260x_data *haptics)
 
 	switch (haptics->mode) {
 	case DRV260X_LRA_MODE:
-		error = regmap_register_patch(haptics->regmap,
-					      drv260x_lra_cal_regs,
-					      ARRAY_SIZE(drv260x_lra_cal_regs));
+		error = regmap_multi_reg_write(haptics->regmap,
+					       drv260x_lra_cal_regs,
+					       ARRAY_SIZE(drv260x_lra_cal_regs));
 		if (error) {
 			dev_err(&haptics->client->dev,
 				"Failed to write LRA calibration registers: %d\n",
@@ -351,9 +393,9 @@ static int drv260x_init(struct drv260x_data *haptics)
 		break;
 
 	case DRV260X_ERM_MODE:
-		error = regmap_register_patch(haptics->regmap,
-					      drv260x_erm_cal_regs,
-					      ARRAY_SIZE(drv260x_erm_cal_regs));
+		error = regmap_multi_reg_write(haptics->regmap,
+					       drv260x_erm_cal_regs,
+					       ARRAY_SIZE(drv260x_erm_cal_regs));
 		if (error) {
 			dev_err(&haptics->client->dev,
 				"Failed to write ERM calibration registers: %d\n",
@@ -374,9 +416,9 @@ static int drv260x_init(struct drv260x_data *haptics)
 		break;
 
 	default:
-		error = regmap_register_patch(haptics->regmap,
-					      drv260x_lra_init_regs,
-					      ARRAY_SIZE(drv260x_lra_init_regs));
+		error = regmap_multi_reg_write(haptics->regmap,
+					       drv260x_lra_init_regs,
+					       ARRAY_SIZE(drv260x_lra_init_regs));
 		if (error) {
 			dev_err(&haptics->client->dev,
 				"Failed to write LRA init registers: %d\n",
@@ -398,6 +440,11 @@ static int drv260x_init(struct drv260x_data *haptics)
 		return 0;
 	}
 
+	if (haptics->calibration_valid)
+		return regmap_bulk_write(haptics->regmap, DRV260X_CAL_COMP,
+					 haptics->calibration_data,
+					 ARRAY_SIZE(haptics->calibration_data));
+
 	error = regmap_write(haptics->regmap, DRV260X_GO, DRV260X_GO_BIT);
 	if (error) {
 		dev_err(&haptics->client->dev,
@@ -423,7 +470,13 @@ static int drv260x_init(struct drv260x_data *haptics)
 		}
 	} while (cal_buf == DRV260X_GO_BIT);
 
-	return 0;
+	error = regmap_bulk_read(haptics->regmap, DRV260X_CAL_COMP,
+				 haptics->calibration_data,
+				 ARRAY_SIZE(haptics->calibration_data));
+	if (!error)
+		haptics->calibration_valid = true;
+
+	return error;
 }
 
 static const struct regmap_config drv260x_regmap_config = {
@@ -434,11 +487,39 @@ static const struct regmap_config drv260x_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static int drv260x_regulator_enable(struct drv260x_data *haptics)
+{
+	int error;
+
+	if (haptics->regulator_enabled)
+		return 0;
+
+	error = regulator_enable(haptics->regulator);
+	if (!error)
+		haptics->regulator_enabled = true;
+
+	return error;
+}
+
+static int drv260x_regulator_disable(struct drv260x_data *haptics)
+{
+	int error;
+
+	if (!haptics->regulator_enabled)
+		return 0;
+
+	error = regulator_disable(haptics->regulator);
+	if (!error)
+		haptics->regulator_enabled = false;
+
+	return error;
+}
+
 static void drv260x_power_off(void *data)
 {
 	struct drv260x_data *haptics = data;
 
-	regulator_disable(haptics->regulator);
+	drv260x_regulator_disable(haptics);
 }
 
 static int drv260x_probe(struct i2c_client *client)
@@ -506,7 +587,7 @@ static int drv260x_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = regulator_enable(haptics->regulator);
+	error = drv260x_regulator_enable(haptics);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -528,6 +609,7 @@ static int drv260x_probe(struct i2c_client *client)
 	}
 
 	haptics->input_dev->name = "drv260x:haptics";
+	haptics->input_dev->open = drv260x_open;
 	haptics->input_dev->close = drv260x_close;
 	input_set_drvdata(haptics->input_dev, haptics);
 	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
@@ -569,62 +651,97 @@ static int drv260x_probe(struct i2c_client *client)
 static int drv260x_suspend(struct device *dev)
 {
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
-	int error;
+	bool restore_work = false;
+	int error, restore_error;
 
-	guard(mutex)(&haptics->input_dev->mutex);
+	mutex_lock(&haptics->input_dev->mutex);
 
 	if (input_device_enabled(haptics->input_dev)) {
+		restore_work = !haptics->work_disabled;
+		drv260x_disable_work(haptics);
+
+		/* A failed resume can leave the device already powered down. */
+		if (!haptics->regulator_enabled)
+			goto out_unlock;
+
 		error = regmap_update_bits(haptics->regmap,
 					   DRV260X_MODE,
 					   DRV260X_STANDBY_MASK,
 					   DRV260X_STANDBY);
 		if (error) {
 			dev_err(dev, "Failed to set standby mode\n");
-			return error;
+			goto err_enable_work;
 		}
 
 		gpiod_set_value(haptics->enable_gpio, 0);
 
-		error = regulator_disable(haptics->regulator);
+		error = drv260x_regulator_disable(haptics);
 		if (error) {
 			dev_err(dev, "Failed to disable regulator\n");
-			regmap_update_bits(haptics->regmap,
-					   DRV260X_MODE,
-					   DRV260X_STANDBY_MASK, 0);
-			return error;
+			goto err_leave_standby;
 		}
 	}
 
+out_unlock:
+	mutex_unlock(&haptics->input_dev->mutex);
 	return 0;
+
+err_leave_standby:
+	gpiod_set_value(haptics->enable_gpio, 1);
+	fsleep(250);
+	restore_error = regmap_update_bits(haptics->regmap,
+					   DRV260X_MODE,
+					   DRV260X_STANDBY_MASK, 0);
+	if (restore_error) {
+		dev_err(dev, "Failed to leave standby mode: %d\n", restore_error);
+		restore_work = false;
+	}
+err_enable_work:
+	if (restore_work)
+		drv260x_enable_work(haptics);
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
 }
 
 static int drv260x_resume(struct device *dev)
 {
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
-	int error;
+	int disable_error, error;
 
-	guard(mutex)(&haptics->input_dev->mutex);
+	mutex_lock(&haptics->input_dev->mutex);
 
 	if (input_device_enabled(haptics->input_dev)) {
-		error = regulator_enable(haptics->regulator);
+		drv260x_disable_work(haptics);
+
+		error = drv260x_regulator_enable(haptics);
 		if (error) {
 			dev_err(dev, "Failed to enable regulator\n");
-			return error;
+			goto err_unlock;
 		}
 
-		error = regmap_update_bits(haptics->regmap,
-					   DRV260X_MODE,
-					   DRV260X_STANDBY_MASK, 0);
+		gpiod_set_value(haptics->enable_gpio, 1);
+		fsleep(250);
+
+		error = drv260x_init(haptics);
 		if (error) {
-			dev_err(dev, "Failed to unset standby mode\n");
-			regulator_disable(haptics->regulator);
-			return error;
+			dev_err(dev, "Failed to restore configuration: %d\n", error);
+			goto err_disable_regulator;
 		}
 
-		gpiod_set_value(haptics->enable_gpio, 1);
+		drv260x_enable_work(haptics);
 	}
 
+	mutex_unlock(&haptics->input_dev->mutex);
 	return 0;
+
+err_disable_regulator:
+	gpiod_set_value(haptics->enable_gpio, 0);
+	disable_error = drv260x_regulator_disable(haptics);
+	if (disable_error)
+		dev_err(dev, "Failed to disable regulator: %d\n", disable_error);
+err_unlock:
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
-- 
2.53.0
