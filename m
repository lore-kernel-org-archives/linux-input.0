Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DC4A8A15
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188611; cv=none; b=SSlJB5xzd1KFYh32yaQ86De1r+ruIPFEBbZrvRu1QYA+8HK3eJ3J3VN5wCE7lq2NZ5JmqwP8/12/CA5awRH7NNBdfbfEsNcg3azJrIbGUixMMUoxwq4HcCG4hpIl62ynL3dwDOtIO1nTCJKfotuCdTenQqeJMyl7Ul9z/3usH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188611; c=relaxed/simple;
	bh=B+vAhdP9jHPlmTdF6Nwg6XSnuL073f88xMrD7YEyGLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBNpEKHPmRr37iuzHOw8lHEGKkdXxxgFdU2q+XsjsLt5Idr4AJE8NJuKmTvxH8a6I3FoUqqm7XNzfuo0iBRDtUXak9VwdX1KYl3tefikuMkdNYVJe58+wD7ZE6uZdZ+HA7vmLQIpAwXbF2xjLdcqronz6IqAW73frKT5hMnqcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fef0+dOc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fef0+dOc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843f205a5bso416920f8f.1
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188607; x=1788793407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owVS0SJzm5gU3Z17acnnop852XewDdkB8HGSaazL4pk=;
        b=Fef0+dOcTl5ZWvUMjjhLdlItdX2GVLoFUqeNIS957h7Hjsz+sV1EhxwEp/YD3w1nYP
         IpAYtmSBsBVTu6Kuxd5F/v7axDElC62FVpkaSx34da2sOwei4Ca+N2TpqwabLsCGTHR+
         vrquasNfXBwGk4NmcXuVjT3SI0QV+6TG9waQi7dks8cPJapzFdArYr5+harHNioJEH/v
         jUPYwLbmpgq+/wPNlzZNt9ZuozcLQggcaRFGy2LnhZ34OLMM5aGDc4yEc9TORP/eSz43
         orzayfliXhlGXniOGi5WJUNXJmXp2OfXxwUkOMZ+G/UrYunE8US0V7W7PhAVtCwoLZeo
         0jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188607; x=1788793407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=owVS0SJzm5gU3Z17acnnop852XewDdkB8HGSaazL4pk=;
        b=hr11Ja9KGDT0rwobOKaepPetVCQHZcovtBtCtO75NAWBRAZc34/Gg0h78qK2CcCcae
         URpAJrqpoEFsNTuemz0tLMuU+WrSYXuGU4tzg89AQfu/Gt/FR1mVIRVOJlxMw8gv2I6i
         5V7RoL160aijadjSGBi7of8Opk+IBMVpJxGiS8px4beSgKc9HhOvq++ZzL9ckiUn2kVC
         sXh0QvrWeLU4y5uHGzNT3dCtvoawSMLq6+fyzgc04dPvQ08xtj58VQBY1XUiBBT3li9q
         aPtXpA5LwWzk/pQtd/StWQ3S1wewwjOla8TZqz29vVA2byC7uHNClfNNkK2m3GmoA8YM
         J/wg==
X-Forwarded-Encrypted: i=1; AKwUvBwsQ/BavYRP87CcR3QUofHVRApIj2iVax4F/yWMdqmfdmUJZuiY5MR+qtMe/dOdZn/2bS3wwuefTeYm3g==@vger.kernel.org
X-Gm-Message-State: AFuF++nsb8wTffhOU/SV/AwNePliF93qHod4B71IdOY/ExNS8P1g4+9W
	/qKcbuWPwWWgJb1dygPLQ6tOL4FZbmU64yFCKPzrp1DvbAgJNaifQ4xCYKQB5sFYOvg=
X-Gm-Gg: AYBFou2zxcxclWgqwlY4Kz1eZrmVqCSQGEvCFhUllsRZ2O83XN2FgjvcDkgEy4d2u6v
	LaC/ESCLcSHSOaCUFVAFpLHjccXUVlVNX9kdn8V+yke/PyXu2ags5wSPPbFE10C6WqYq8YYIb79
	J1MQE1hoJDEGKafCAEMUh490uA9JOWuvF+4b5gDyLgmDQepS98iVycBYcexhu5STIIDmNqcMGIy
	j8RSoiT6ZWZQwgGZASeCII2RzuYbw1xlbFUtzJ9UpW3/AxRaKH5m/wJIpHCeGCpqkaIuyS7yy/z
	uK1NJNFdsM51wpnkJG03qC1AHtUxpYSbQYKLaUTJ2GW/7GQ3gDdYu3Z+sHlEZTttZN/UYCn+s5Y
	ffuNR2yXGOewXfR+KExobowOCHpFX7HQ91XKcuXO8lfFz8arLIq0dsxN1Yxps+46sxmZwjNjjFL
	c5V5DDPerONv19r+uLnokhyXnR+sBMTEK3uAuHuvBnZDEhB5nn2JsUkceJmuys4PcoFn9heGCws
	FVvFYeOnrCBcvr3MD/E0KIWmFtkqxDQB3/qHYJdSi/7qHBZX5fZVfo=
X-Received: by 2002:a05:6000:2512:b0:484:3f46:12f6 with SMTP id ffacd0b85a97d-4843f4615f2mr5572192f8f.19.1788188606127;
        Mon, 31 Aug 2026 08:03:26 -0700 (PDT)
Received: from 1Z10 ([78.213.92.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2794dsm24149228f8f.25.2026.08.31.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:03:25 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Maurizio Casciano <mauriziocasciano7@gmail.com>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v7] Input: drv260x: Fix suspend and resume sequencing
Date: Mon, 31 Aug 2026 17:03:23 +0200
Message-ID: <20260831150323.2922792-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831082820.063D81F00A3D@smtp.kernel.org>
References: <20260831082820.063D81F00A3D@smtp.kernel.org>
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

Remember that configuration may have been lost across suspend even when
the input device was closed and resume therefore skipped hardware access.
Restore it on the next open. If resume recovery failed, let a later open
retry regulator enablement and initialization before re-enabling playback
work, instead of leaving the device permanently inaccessible.

Track whether this consumer has enabled the regulator so devres cleanup
does not issue an unbalanced disable after a resume failure. Make regulator
and work reference counts idempotent across PM retries. On removal,
unregister the input device to shut down the ff-memless timer before the
final work cancellation, preventing the timer from requeueing work during
teardown.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-input/20260831082820.063D81F00A3D@smtp.kernel.org/
Link: https://lore.kernel.org/linux-input/20260831011526.24AB11F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/linux-input/20260830143050.03E081F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/linux-input/20260829230740.126461F000E9@smtp.kernel.org/
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/
Link: https://www.ti.com/lit/ds/symlink/drv2604.pdf
Assisted-by: Codex:gpt-5.6-sol [sparse]
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
---
Changes in v7:
- Recover a failed-resume work-disable state from the next input open instead
  of returning -EIO permanently.
- Mark configuration for deferred restoration when suspend occurred while
  the input device was closed, and restore it on the next open.
- Add an explicit remove callback which unregisters the input device before
  cancelling the work item, closing the ff-memless timer requeue window.
- Expand cached-calibration write error handling and retain idempotent work
  and regulator state tracking across PM retries.

Validation:
- Integration commit 780663f0af3b, containing the exact drv260x blob
  1eb71e6adc53, passed olddefconfig, a focused W=1 C=2 CHECK=sparse build,
  and a full Debian package build on x86_64. The full build log contains no
  warning in drivers/input/misc/drv260x.c.
- Lenovo Yoga Book YB1-X91L running
  7.2.0-yogabook-20260831-153058 passed a 15-second s2idle cycle with RTC
  wake. Both DRV2604 devices then passed five open/close cycles and a
  force-feedback rumble upload/play/erase sequence.
- Camera streaming, SOF playback and capture, and idle runtime-PM state were
  rechecked after resume. No drv260x, I2C, regulator-balance, or severe kernel
  error was present in the boot log.
- The tablet uses dummy vbat regulators for both DRV2604 devices, so actual
  regulator power loss and injected resume-error cleanup could not be
  exercised on this hardware.

 drivers/input/misc/drv260x.c | 264 ++++++++++++++++++++++++++++-------
 1 file changed, 216 insertions(+), 48 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..1eb71e6adc53 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -181,7 +181,12 @@
  * @work: Work item used to off load the enable/disable of the vibration
  * @enable_gpio: Pointer to the gpio used for enable/disabling
  * @regulator: Pointer to the regulator for the IC
+ * @regulator_enabled: Whether this consumer has enabled the regulator
+ * @work_disabled: Whether playback work is disabled pending PM recovery
+ * @needs_reinit: Whether device configuration must be restored on open
+ * @calibration_valid: Whether calibration results have been cached
  * @magnitude: Magnitude of the vibration event
+ * @calibration_data: Cached automatic calibration results
  * @mode: The operating mode of the IC (LRA_NO_CAL, ERM or LRA)
  * @library: The vibration library to be used
  * @rated_voltage: The rated_voltage of the actuator
@@ -194,7 +199,12 @@ struct drv260x_data {
 	struct work_struct work;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
+	bool regulator_enabled;
+	bool work_disabled;
+	bool needs_reinit;
+	bool calibration_valid;
 	u8 magnitude;
+	u8 calibration_data[3];
 	u32 mode;
 	u32 library;
 	int rated_voltage;
@@ -215,6 +225,24 @@ static int drv260x_calculate_voltage(unsigned int voltage)
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
@@ -243,8 +271,6 @@ static int drv260x_haptics_play(struct input_dev *input, void *data,
 {
 	struct drv260x_data *haptics = input_get_drvdata(input);
 
-	haptics->mode = DRV260X_LRA_NO_CAL_MODE;
-
 	/* Scale u16 magnitude into u8 register value */
 	if (effect->u.rumble.strong_magnitude > 0)
 		haptics->magnitude = effect->u.rumble.strong_magnitude >> 8;
@@ -258,21 +284,6 @@ static int drv260x_haptics_play(struct input_dev *input, void *data,
 	return 0;
 }
 
-static void drv260x_close(struct input_dev *input)
-{
-	struct drv260x_data *haptics = input_get_drvdata(input);
-	int error;
-
-	cancel_work_sync(&haptics->work);
-
-	error = regmap_write(haptics->regmap, DRV260X_MODE, DRV260X_STANDBY);
-	if (error)
-		dev_err(&haptics->client->dev,
-			"Failed to enter standby mode: %d\n", error);
-
-	gpiod_set_value(haptics->enable_gpio, 0);
-}
-
 static const struct reg_sequence drv260x_lra_cal_regs[] = {
 	{ DRV260X_MODE, DRV260X_AUTO_CAL },
 	{ DRV260X_CTRL3, DRV260X_NG_THRESH_2 | DRV260X_RTP_UNSIGNED_DATA },
@@ -338,9 +349,9 @@ static int drv260x_init(struct drv260x_data *haptics)
 
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
@@ -351,9 +362,9 @@ static int drv260x_init(struct drv260x_data *haptics)
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
@@ -374,9 +385,9 @@ static int drv260x_init(struct drv260x_data *haptics)
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
@@ -398,6 +409,19 @@ static int drv260x_init(struct drv260x_data *haptics)
 		return 0;
 	}
 
+	if (haptics->calibration_valid) {
+		error = regmap_bulk_write(haptics->regmap, DRV260X_CAL_COMP,
+					  haptics->calibration_data,
+					  ARRAY_SIZE(haptics->calibration_data));
+		if (error) {
+			dev_err(&haptics->client->dev,
+				"Failed to restore calibration registers: %d\n", error);
+			return error;
+		}
+
+		return 0;
+	}
+
 	error = regmap_write(haptics->regmap, DRV260X_GO, DRV260X_GO_BIT);
 	if (error) {
 		dev_err(&haptics->client->dev,
@@ -423,7 +447,13 @@ static int drv260x_init(struct drv260x_data *haptics)
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
@@ -434,11 +464,110 @@ static const struct regmap_config drv260x_regmap_config = {
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
+}
+
+static int drv260x_open(struct input_dev *input)
+{
+	struct drv260x_data *haptics = input_get_drvdata(input);
+	bool recover_work = haptics->work_disabled;
+	int disable_error, error;
+
+	if (recover_work) {
+		error = drv260x_regulator_enable(haptics);
+		if (error) {
+			dev_err(&haptics->client->dev,
+				"Failed to enable regulator: %d\n", error);
+			return error;
+		}
+	}
+
+	gpiod_set_value(haptics->enable_gpio, 1);
+	/* Data sheet says to wait 250us before trying to communicate */
+	fsleep(250);
+
+	if (haptics->needs_reinit || recover_work) {
+		error = drv260x_init(haptics);
+		if (error) {
+			dev_err(&haptics->client->dev,
+				"Failed to restore configuration: %d\n", error);
+			gpiod_set_value(haptics->enable_gpio, 0);
+			if (recover_work) {
+				disable_error = drv260x_regulator_disable(haptics);
+				if (disable_error)
+					dev_err(&haptics->client->dev,
+						"Failed to disable regulator: %d\n",
+						disable_error);
+			}
+			return error;
+		}
+
+		haptics->needs_reinit = false;
+	}
+
+	if (recover_work)
+		drv260x_enable_work(haptics);
+
+	return 0;
+}
+
+static void drv260x_close(struct input_dev *input)
+{
+	struct drv260x_data *haptics = input_get_drvdata(input);
+	int error;
+
+	/* PM has not restored register access yet. */
+	if (haptics->work_disabled)
+		return;
+
+	cancel_work_sync(&haptics->work);
+
+	error = regmap_write(haptics->regmap, DRV260X_MODE, DRV260X_STANDBY);
+	if (error)
+		dev_err(&haptics->client->dev,
+			"Failed to enter standby mode: %d\n", error);
+
+	gpiod_set_value(haptics->enable_gpio, 0);
+}
+
+static void drv260x_remove(struct i2c_client *client)
+{
+	struct drv260x_data *haptics = i2c_get_clientdata(client);
+
+	input_unregister_device(haptics->input_dev);
+	cancel_work_sync(&haptics->work);
 }
 
 static int drv260x_probe(struct i2c_client *client)
@@ -506,7 +635,7 @@ static int drv260x_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = regulator_enable(haptics->regulator);
+	error = drv260x_regulator_enable(haptics);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -528,6 +657,7 @@ static int drv260x_probe(struct i2c_client *client)
 	}
 
 	haptics->input_dev->name = "drv260x:haptics";
+	haptics->input_dev->open = drv260x_open;
 	haptics->input_dev->close = drv260x_close;
 	input_set_drvdata(haptics->input_dev, haptics);
 	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
@@ -569,62 +699,99 @@ static int drv260x_probe(struct i2c_client *client)
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
+			goto mark_reinit;
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
 
+mark_reinit:
+	haptics->needs_reinit = true;
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
+		haptics->needs_reinit = false;
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
@@ -657,6 +824,7 @@ MODULE_DEVICE_TABLE(of, drv260x_of_match);
 
 static struct i2c_driver drv260x_driver = {
 	.probe		= drv260x_probe,
+	.remove		= drv260x_remove,
 	.driver		= {
 		.name	= "drv260x-haptics",
 		.acpi_match_table = ACPI_PTR(drv260x_acpi_match),
-- 
With Best Regards,
Maurizio Casciano
