Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FF50AC05
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584816; cv=none; b=HAR7azF+aTSRSVkgg/A56osJnt9sWTZP32MvRsmaK5Xbb7lSLDX7J8n5Hb2Av+Ezu5Jl9aNvMAKqws4c1q5MXCnnLxGoE56tcbfaoqCSHkwHCrgJOfyptFclbJkOPDtYKE00et3/kKY/OPKFONEPKM3mL8Xgq/pikjrT2P4Wp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584816; c=relaxed/simple;
	bh=unw5zMwdvMtoBVFWdrNPB7qFOqUjieNs37XXGa9Ul+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZG/Te3pQyp8TwjJQiedOauECRjTy0oV7O+GGRJa/2HHiY/F2rGW4dCC9B9OQZqtJ1OddKo3xRw9itzBH9o2BS0Mfzx6OEg+Y+5WESf+HeHwtS0x0kLe8rXMC5S4I7J7FUl4l7mM+0gmejfxOM9HglGYN2KYOynoP0EZoJ11GPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LCdqRi/b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LCdqRi/b"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dd76b1361dso1018245ad.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584807; x=1792189607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJ3I7IGk7h8CZdV1vx7rtIKO45AeWKr5K8KA6AozVQQ=;
        b=LCdqRi/b6BbDLniKKbC/PBZX4qViYyzDBwkzWD+NB76ieRHZTr7cgx2yKIqEO2go05
         YVIhSwqI7gMA7xHnPYqg+LglctWMksOHBpDVnB1OWF5jvr2KvIRXWVz/osHaUqXNHAJW
         bepsRhz3dV5zttp8OETMm2kePSMtNodKSDJ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584807; x=1792189607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ3I7IGk7h8CZdV1vx7rtIKO45AeWKr5K8KA6AozVQQ=;
        b=RxwN6E59XT+7jmLkWmzSnH+DzrMUX+h8SWMPVnPb5wX9KaaHJjnc4VpOdH23IZ0xZj
         jsOerwYh4XjSJO+lRzOOE1zwB4t/XPpHT6bSHhXI03MxbhwGuMAra0Cwb49JKtmT1/zE
         kciTEMYYvG59en+EE1L07eBL6XZf9FCfMtuEvVaMvcfmlMI1qsEWlqgf76qn3297GnUG
         2vYIcABTiMvFFS6etz5V5jrtdk7qXujDgiwmmc0MU1leLIDuN9/1aP+DUczYxVqRqnkH
         U9Q0Bhfm+xbYnVTElHCux+ENIQ3ZKzwyYXK98fIfWsnaZd3/vLz+Vnn4WyIV22d0pSXI
         /L1w==
X-Gm-Message-State: AFq9FYKgJlIqGKh8bO39Gdj7I/JwqZ88Llui5W7TBMWIGQVjC8dMqFpO
	qmvlwhI83b1/CDSrpmSJ90nxhMJI3mzYmce/vR1ZP4NKZisWDK4cQfHVn89O7u01a5GrGHXVw69
	5E8Y=
X-Gm-Gg: AYBFou0PBiyDbJ1CQqgxx+LnRYzejvsF+gsQWt7HnixaMV23Ysyb+4X3t7kH6V4zSz1
	HMzA+3IoET9krOFmWktZXULK3BPHnUexJ6irqw1VCi8pYR6bphh4duWC52c2Xg4doBLenAgYrum
	8D1D+7qCwRwFI9tweB7LFu3Ehsm5KowYKiceG9O3T7jbDogCPDl719tGJgm77qkZ371d3Tp597V
	1XaQmiPXHq8F8w0gdQYhZWgrFT2BczhFY6gVKgZX7BF/eh1mnd3k67X5xGtpg33xBsDTYBdm+SX
	cxGJNqPibtjzZKezD4IFNAzFlmn62CE3BltcEUekfA3kIRQdIIQiw5YuquNqabZRueC8aifDxsi
	7KsBybSE0LQBAlR+w0vTC8Ph/5fiYmLvxbCfWf6WbxT7R+V8z37PyVv5JqY+tFaI4U6K+TJjXix
	Dz6h+Xx8KKt/AUG1jVgmn7R6he3DOIlqnrIEqh7N14+EwZNnc0jyvohEDtarEnvPyqrhM96VM6I
	4xePNn6UcUHNdfPF2To5KqsqXNE8w5IumaZVLHHFNab1yTo4kN7b4RQvjQEMs1zeAkaGQAiLFSH
	EA==
X-Received: by 2002:a17:902:e748:b0:2dd:c100:4259 with SMTP id d9443c01a7336-2e842f13e23mr27084475ad.61.1791584806549;
        Fri, 09 Oct 2026 15:26:46 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:45 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:36 +0000
Subject: [PATCH v5 11/11] HID: spi-hid: add panel follower support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-11-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=11787;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=unw5zMwdvMtoBVFWdrNPB7qFOqUjieNs37XXGa9Ul+g=;
 b=KnSO/SunBYCSYVcTxf/1/1PsL30eDfCPt51pZKFhaLoM0NIknoyjS8KoWf0PGZwmKqD3HsyZm
 Gw/GqK4yxqFCHYwKlw/fz1f7ENvFKKQiEc68BcNjoIqFCS/mRUt2w5I
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add support to spi-hid to be a panel follower.

Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig        |   4 +
 drivers/hid/spi-hid/spi-hid-core.c | 213 ++++++++++++++++++++++++++++---------
 drivers/hid/spi-hid/spi-hid-core.h |   7 ++
 3 files changed, 174 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 63f202975ac3..656dbda1c5d8 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -13,6 +13,7 @@ if SPI_HID
 config SPI_HID_ACPI
 	tristate "HID over SPI transport layer ACPI driver"
 	depends on ACPI
+	depends on DRM || !DRM
 	select RESET_CONTROLLER
 	select SPI_HID_CORE
 	help
@@ -29,6 +30,7 @@ config SPI_HID_ACPI
 config SPI_HID_OF
 	tristate "HID over SPI transport layer Open Firmware driver"
 	depends on OF
+	depends on DRM || !DRM
 	select SPI_HID_CORE
 	help
 	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
@@ -43,4 +45,6 @@ config SPI_HID_OF
 
 config SPI_HID_CORE
 	tristate
+	# We need to call into panel code so if DRM=m, this can't be 'y'
+	depends on DRM || !DRM
 endif
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 66bfc251bd91..106e92b71ffb 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -281,7 +281,9 @@ static int spi_hid_suspend(struct spi_hid *shid)
 			if (error) {
 				dev_err(dev, "%s failed to suspend hid driver: %d\n",
 					__func__, error);
-				return error;
+				/* A follower powers off with the panel anyway. */
+				if (!shid->is_panel_follower)
+					return error;
 			}
 		}
 	}
@@ -311,6 +313,9 @@ static int spi_hid_suspend(struct spi_hid *shid)
 				dev_err(dev, "%s: could not power down\n", __func__);
 				shid->regulator_error_count++;
 				shid->regulator_last_error = error;
+			}
+			/* A follower powers off with the panel anyway. */
+			if (error && !shid->is_panel_follower) {
 				/*
 				 * Undo partial suspend before returning error.
 				 * Complete the reset; RESET_PENDING stays set
@@ -346,26 +351,28 @@ static int spi_hid_resume(struct spi_hid *shid)
 		return 0;
 	}
 
-	if (!device_may_wakeup(dev)) {
-		if (shid->power_state == HIDSPI_OFF) {
-			shid->ops->assert_reset(shid->ops);
+	/*
+	 * Check power_state, not device_may_wakeup(): power/wakeup can change
+	 * while the device is off.
+	 */
+	if (shid->power_state == HIDSPI_OFF) {
+		shid->ops->assert_reset(shid->ops);
 
-			shid->ops->sleep_minimal_reset_delay(shid->ops);
+		shid->ops->sleep_minimal_reset_delay(shid->ops);
 
-			error = shid->ops->power_up(shid->ops);
-			if (error) {
-				dev_err(dev, "%s: could not power up\n", __func__);
-				shid->regulator_error_count++;
-				shid->regulator_last_error = error;
-				/* Suspend runs next even if resume fails. */
-				enable_irq(shid->spi->irq);
-				return error;
-			}
-			shid->power_state = HIDSPI_ON;
-			reinit_completion(&shid->reset_done);
-			shid->ops->deassert_reset(shid->ops);
-			was_reset = true;
+		error = shid->ops->power_up(shid->ops);
+		if (error) {
+			dev_err(dev, "%s: could not power up\n", __func__);
+			shid->regulator_error_count++;
+			shid->regulator_last_error = error;
+			/* Suspend runs next even if resume fails. */
+			enable_irq(shid->spi->irq);
+			return error;
 		}
+		shid->power_state = HIDSPI_ON;
+		reinit_completion(&shid->reset_done);
+		shid->ops->deassert_reset(shid->ops);
+		was_reset = true;
 	}
 
 	enable_irq(shid->spi->irq);
@@ -1501,6 +1508,110 @@ const struct attribute_group *spi_hid_groups[] = {
 };
 EXPORT_SYMBOL_GPL(spi_hid_groups);
 
+/*
+ * At the end of probe we initialize the device:
+ *   0) assert reset, bias the interrupt line
+ *   1) sleep minimal reset delay
+ *   2) power up the device
+ *   3) deassert reset (high)
+ * After this we expect an IRQ with a reset response.
+ */
+static int spi_hid_dev_init(struct spi_hid *shid)
+{
+	struct spi_device *spi = shid->spi;
+	struct device *dev = &spi->dev;
+	int error;
+
+	guard(mutex)(&shid->power_lock);
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	error = shid->ops->power_up(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: could not power up\n", __func__);
+		shid->regulator_error_count++;
+		shid->regulator_last_error = error;
+		return error;
+	}
+
+	shid->power_state = HIDSPI_ON;
+	error = shid->ops->deassert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
+		shid->ops->power_down(shid->ops);
+		shid->power_state = HIDSPI_OFF;
+		return error;
+	}
+
+	enable_irq(spi->irq);
+
+	return 0;
+}
+
+static void spi_hid_panel_follower_work(struct work_struct *work)
+{
+	struct spi_hid *shid = container_of(work, struct spi_hid,
+					    panel_follower_work);
+	int error;
+
+	/* Also does the first power up: probe leaves the device off. */
+	error = spi_hid_resume(shid);
+	if (error)
+		dev_warn(&shid->spi->dev, "Power on failed: %d\n", error);
+	/* Even a failed resume enables the IRQ; let suspend undo it. */
+	WRITE_ONCE(shid->panel_follower_work_finished, true);
+}
+
+static int spi_hid_panel_follower_resume(struct drm_panel_follower *follower)
+{
+	struct spi_hid *shid = container_of(follower, struct spi_hid, panel_follower);
+
+	/* Powering on can be slow; don't block the panel's power up. */
+	WRITE_ONCE(shid->panel_follower_work_finished, false);
+	schedule_work(&shid->panel_follower_work);
+
+	return 0;
+}
+
+static int spi_hid_panel_follower_suspend(struct drm_panel_follower *follower)
+{
+	struct spi_hid *shid = container_of(follower, struct spi_hid, panel_follower);
+
+	cancel_work_sync(&shid->panel_follower_work);
+
+	if (!READ_ONCE(shid->panel_follower_work_finished))
+		return 0;
+
+	return spi_hid_suspend(shid);
+}
+
+static const struct drm_panel_follower_funcs
+				spi_hid_panel_follower_prepare_funcs = {
+	.panel_prepared = spi_hid_panel_follower_resume,
+	.panel_unpreparing = spi_hid_panel_follower_suspend,
+};
+
+static int spi_hid_register_panel_follower(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+
+	shid->panel_follower.funcs = &spi_hid_panel_follower_prepare_funcs;
+
+	/*
+	 * If we're not in control of our own power up/power down then we can't
+	 * do the logic to manage wakeups. Give a warning if a user thought
+	 * that was possible then force the capability off.
+	 */
+	if (device_can_wakeup(dev)) {
+		dev_warn(dev, "Can't wakeup if following panel\n");
+		device_set_wakeup_capable(dev, false);
+	}
+
+	return drm_panel_add_follower(dev, &shid->panel_follower);
+}
+
 int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		       struct spi_hid_conf *conf)
 {
@@ -1516,10 +1627,11 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		return -ENOMEM;
 
 	shid->spi = spi;
-	shid->power_state = HIDSPI_ON;
+	shid->power_state = HIDSPI_OFF;
 	shid->ops = ops;
 	shid->conf = conf;
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+	shid->is_panel_follower = drm_is_panel_follower(&spi->dev);
 
 	spi_set_drvdata(spi, shid);
 
@@ -1534,6 +1646,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	init_completion(&shid->reset_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+	INIT_WORK(&shid->panel_follower_work, spi_hid_panel_follower_work);
 
 	/*
 	 * we need to allocate the buffer without knowing the maximum
@@ -1544,20 +1657,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	if (error)
 		return error;
 
-	/*
-	 * At the end of probe we initialize the device:
-	 *   0) assert reset, bias the interrupt line
-	 *   1) sleep minimal reset delay
-	 *   2) request IRQ
-	 *   3) power up the device
-	 *   4) deassert reset (high)
-	 * After this we expect an IRQ with a reset response.
-	 */
-
-	shid->ops->assert_reset(shid->ops);
-
-	shid->ops->sleep_minimal_reset_delay(shid->ops);
-
 	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
 					  IRQF_ONESHOT | IRQF_NO_AUTOEN, dev_name(&spi->dev), shid);
 	if (error) {
@@ -1577,21 +1676,17 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		}
 	}
 
-	error = shid->ops->power_up(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: could not power up\n", __func__);
-		return error;
-	}
-
-	error = shid->ops->deassert_reset(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
-		shid->ops->power_down(shid->ops);
-		return error;
+	if (shid->is_panel_follower) {
+		error = spi_hid_register_panel_follower(shid);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "Failed to register panel follower\n");
+	} else {
+		error = spi_hid_dev_init(shid);
+		if (error)
+			return error;
 	}
 
-	enable_irq(spi->irq);
-
 	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
@@ -1605,15 +1700,27 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	if (shid->is_panel_follower) {
+		drm_panel_remove_follower(&shid->panel_follower);
+		/* Already cancelled by panel_unpreparing; be explicit. */
+		cancel_work_sync(&shid->panel_follower_work);
+	}
+
+	/*
+	 * Follower suspend above can be skipped. Disabling again is
+	 * fine: nothing re-enables the IRQ before devres frees it.
+	 */
 	disable_irq(spi->irq);
 	disable_work_sync(&shid->reset_work);
 
 	spi_hid_stop_hid(shid);
 
-	shid->ops->assert_reset(shid->ops);
-	error = shid->ops->power_down(shid->ops);
-	if (error)
-		dev_err(dev, "failed to disable regulator\n");
+	if (shid->power_state != HIDSPI_OFF) {
+		shid->ops->assert_reset(shid->ops);
+		error = shid->ops->power_down(shid->ops);
+		if (error)
+			dev_err(dev, "failed to disable regulator\n");
+	}
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_remove);
 
@@ -1621,6 +1728,9 @@ static int spi_hid_core_pm_suspend(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_suspend(shid);
 }
 
@@ -1628,6 +1738,9 @@ static int spi_hid_core_pm_resume(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_resume(shid);
 }
 
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 0b3248aedfce..631897dd9e8a 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -10,6 +10,8 @@
 #include <linux/hid-over-spi.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_panel.h>
+
 /* Protocol message size constants */
 #define SPI_HID_READ_APPROVAL_LEN		5
 #define SPI_HID_OUTPUT_HEADER_LEN		8
@@ -56,6 +58,10 @@ struct spi_hid {
 	struct spi_hid_input_buf *input;	/* Input buffer. */
 	struct spi_hid_input_buf *response;	/* Response buffer. */
 
+	struct drm_panel_follower panel_follower;
+	bool	is_panel_follower;
+	bool	panel_follower_work_finished;
+
 	u16 response_length;
 	u16 bufsize;
 	/* Response type awaited by a sync request, 0 if none. Protected by io_lock. */
@@ -70,6 +76,7 @@ struct spi_hid {
 	unsigned long flags;	/* device flags. */
 
 	struct work_struct reset_work;
+	struct work_struct panel_follower_work;
 
 	/*
 	 * Serializes request/response transactions: held from sending a

-- 
2.56.0.385.gd3acb90ef8-goog

