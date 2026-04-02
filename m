Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2A336889
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095195; cv=none; b=YNWgDJcMY/X2eH7YUYiT8caj6uSeHhgaOiTyrNt2p69jeA+mjFA6KCKUQAI7+PrDneU372AGd42jyfAlYpRkMbCSkzaOrnccEAgkiCOe6bKamVIp7Z5xyUkaYnKa/tVgAT3DY51z6R3rG2iMBDQn7OhvgC5X3wyenti/e4FbF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095195; c=relaxed/simple;
	bh=GBCgfFdmNxX9+OgrVg4WaE5DIA07uRQnuGXMjbga6H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHFUg3wvDjzWmir2yvY4dtve01huyaPkNJ0IPLnclylGMaKXPSyWgSs3BEk3MDHs+aPkpWjC8zM9NMCLXMsHa1yt2HP+MmWF3C8/LRrzgoYR9edlzEfUpk4i+zYORHtiwUG8+Qh2xPUoSY2eEn89J2DrWVuVzQl2X1tIhFFjQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TifoRlnx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TifoRlnx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c1a131946so944347a91.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095191; x=1775699991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWRl/pdZN5I8n4vNv9o2RQjMPPH8QcZcS//VFK8KffE=;
        b=TifoRlnxA41757qDVJz0Fu17MMURDBQC0VPBin9YmQBqx1UiFSC7SnyicRqxDQUqKp
         C+5Zrypg4XA2ImPWVHdf4kPWYzQvNQdOBGK7f28vNhzv6idpbwlga7xIhgwC+C1y6g1E
         OGXrAeBMZl782vFqnUZLNWfxBYSj1Bhiwfj5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095191; x=1775699991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWRl/pdZN5I8n4vNv9o2RQjMPPH8QcZcS//VFK8KffE=;
        b=fCdL0ZVkqbHG9rCOps13pAM9pqY0AH+otRTNUkKPNotOKaKljy0cShodUn5/L5JMF5
         +wmddoq2/kPZ/tZ2iT4sbx9yOSFpU/1Cxa5WszOfBArOORfrBYXdUkQDkRv9or8HfyYm
         x9WWX6VmDX9rrZlC17txgM7NcDzBN1HtSl4EsyCCmz4eUbqu1RbWDarVemtcbKmWokLO
         zrtgoft8V8HfMgyLAjsQzLnNj0HOKsq7PCHzBAMgB4m0HRYLLBDf6sK2c0tHw+H8hvCD
         wQ0u+XnJJXCFxEAAZDfJiIJb8lNhPJtvBmnxlDOUMlEANGTqGaATRUEapCu2KllyLqBn
         LsbQ==
X-Gm-Message-State: AOJu0Yz72d6YBdZvuznVbGakeQScqb5KoOHitCJPnAwhJ77WiEICWkmR
	ajHjm/XJLhPn6oVBAjgLINFrV4glYwlreBJ2dn1tqK42o7Z7ZJHR11oPIXd0zPa4SrovBsr3Dly
	hjOU=
X-Gm-Gg: ATEYQzx9cUMOKo/qgZiiVCgC45/H4siPeu0Psir1dCKhIVIbiY6rhsNXCIZ//h7GKoN
	9Ndz5N01OdBd+moQppfaFErCF6m3TG4ZnZYaXI+maGDDrLSlNx5XPa1K9pzOLqin+VmhzccA91D
	mZN0DijG2BzlZl5S5Og//BAncH2iS4xXs4NRh8SHs2DMZB5YswiKhWG0ylT6vm7sonABc2lS117
	ESvC3VcMr1/rIDiVo/U7sXOiejW3sNmrzznKmelOmtl4D08aRZzI4ksSpyI+dMT19OZ6iNcb9el
	d+p9jugq4YhEYD4fVIiEpCb6nRxF18rRBtsf/CtS1iVHebXLpDHhFdvaoUeRxuyf3XSHq9ExwW6
	LnfmzwGV8bUC+a5ErRoTZ8UK9RNpRkLf0szkD20VwS+QjBP/f7CmO3h7/RwQafgViNa3x6vqmC8
	FW0gJLws+L8cfpa8gYLwG6TxnpH8aj2DAmmEUUOWFprCYyjZxPRq7khrHoywK4+qUFpkx6ii5AE
	2IO7O1rMj4Yeq2eeRxW0xAm68PbMHK35A==
X-Received: by 2002:a17:903:1aee:b0:24b:1585:6350 with SMTP id d9443c01a7336-2b277df754bmr5416395ad.11.1775095190960;
        Wed, 01 Apr 2026 18:59:50 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:50 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:48 +0000
Subject: [PATCH v3 11/11] HID: spi-hid: add panel follower support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-11-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=10416;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=GBCgfFdmNxX9+OgrVg4WaE5DIA07uRQnuGXMjbga6H4=;
 b=7f4b91lHmlf5TYFEkbbrgzi8PSgBr3/69XLfgY8PZh2sAcrCKQdt4dNTBD2zvy7mxEXouf84t
 zT2LB5hJEr2AJxS5Z1czURg1AYqDDJWcLBcQsD+NO2kypaT1TQEg8qG
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add support to spi-hid to be a panel follower.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 199 +++++++++++++++++++++++++++++--------
 drivers/hid/spi-hid/spi-hid-core.h |   7 ++
 2 files changed, 163 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 5f7a5bb692d9..9eedd4f1cba7 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -246,21 +246,21 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
 	}
 }
 
-static void spi_hid_suspend(struct spi_hid *shid)
+static int spi_hid_suspend(struct spi_hid *shid)
 {
 	int error;
 	struct device *dev = &shid->spi->dev;
 
 	guard(mutex)(&shid->power_lock);
 	if (shid->power_state == HIDSPI_OFF)
-		return;
+		return 0;
 
 	if (shid->hid) {
 		error = hid_driver_suspend(shid->hid, PMSG_SUSPEND);
 		if (error) {
 			dev_err(dev, "%s failed to suspend hid driver: %d",
 				__func__, error);
-			return;
+			return error;
 		}
 	}
 
@@ -278,21 +278,22 @@ static void spi_hid_suspend(struct spi_hid *shid)
 			dev_err(dev, "%s: could not power down.", __func__);
 			shid->regulator_error_count++;
 			shid->regulator_last_error = error;
-			return;
+			return error;
 		}
 
 		shid->power_state = HIDSPI_OFF;
 	}
+	return 0;
 }
 
-static void spi_hid_resume(struct spi_hid *shid)
+static int spi_hid_resume(struct spi_hid *shid)
 {
 	int error;
 	struct device *dev = &shid->spi->dev;
 
 	guard(mutex)(&shid->power_lock);
 	if (shid->power_state == HIDSPI_ON)
-		return;
+		return 0;
 
 	enable_irq(shid->spi->irq);
 
@@ -306,7 +307,7 @@ static void spi_hid_resume(struct spi_hid *shid)
 			dev_err(dev, "%s: could not power up.", __func__);
 			shid->regulator_error_count++;
 			shid->regulator_last_error = error;
-			return;
+			return error;
 		}
 		shid->power_state = HIDSPI_ON;
 
@@ -315,10 +316,13 @@ static void spi_hid_resume(struct spi_hid *shid)
 
 	if (shid->hid) {
 		error = hid_driver_reset_resume(shid->hid);
-		if (error)
+		if (error) {
 			dev_err(dev, "%s: failed to reset resume hid driver: %d.",
 				__func__, error);
+			return error;
+		}
 	}
+	return 0;
 }
 
 static void spi_hid_stop_hid(struct spi_hid *shid)
@@ -1215,6 +1219,132 @@ const struct attribute_group *spi_hid_groups[] = {
 };
 EXPORT_SYMBOL_GPL(spi_hid_groups);
 
+/*
+ * At the end of probe we initialize the device:
+ *   0) assert reset, bias the interrupt line
+ *   1) sleep minimal reset delay
+ *   2) request IRQ
+ *   3) power up the device
+ *   4) deassert reset (high)
+ * After this we expect an IRQ with a reset response.
+ */
+static int spi_hid_dev_init(struct spi_hid *shid)
+{
+	struct spi_device *spi = shid->spi;
+	struct device *dev = &spi->dev;
+	int error;
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
+					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
+	if (error) {
+		dev_err(dev, "%s: unable to request threaded IRQ.", __func__);
+		return error;
+	}
+	if (device_may_wakeup(dev)) {
+		error = dev_pm_set_wake_irq(dev, spi->irq);
+		if (error) {
+			dev_err(dev, "%s: failed to set wake IRQ.", __func__);
+			return error;
+		}
+	}
+
+	error = shid->ops->power_up(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: could not power up.", __func__);
+		shid->regulator_error_count++;
+		shid->regulator_last_error = error;
+		return error;
+	}
+
+	shid->ops->deassert_reset(shid->ops);
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
+	if (!shid->desc.hid_version)
+		error = spi_hid_dev_init(shid);
+	else
+		error = spi_hid_resume(shid);
+	if (error)
+		dev_warn(&shid->spi->dev, "Power on failed: %d", error);
+	else
+		WRITE_ONCE(shid->panel_follower_work_finished, true);
+
+	/*
+	 * The work APIs provide a number of memory ordering guarantees
+	 * including one that says that memory writes before schedule_work()
+	 * are always visible to the work function, but they don't appear to
+	 * guarantee that a write that happened in the work is visible after
+	 * cancel_work_sync(). We'll add a write memory barrier here to match
+	 * with spi_hid_panel_unpreparing() to ensure that our write to
+	 * panel_follower_work_finished is visible there.
+	 */
+	smp_wmb();
+}
+
+static int spi_hid_panel_follower_resume(struct drm_panel_follower *follower)
+{
+	struct spi_hid *shid = container_of(follower, struct spi_hid, panel_follower);
+
+	/*
+	 * Powering on a touchscreen can be a slow process. Queue the work to
+	 * the system workqueue so we don't block the panel's power up.
+	 */
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
+	/* Match with shid_core_panel_follower_work() */
+	smp_rmb();
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
@@ -1234,6 +1364,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	shid->ops = ops;
 	shid->conf = conf;
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+	shid->is_panel_follower = drm_is_panel_follower(&spi->dev);
 
 	spi_set_drvdata(spi, shid);
 
@@ -1247,6 +1378,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	init_completion(&shid->output_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+	INIT_WORK(&shid->panel_follower_work, spi_hid_panel_follower_work);
 
 	/*
 	 * We need to allocate the buffer without knowing the maximum
@@ -1257,42 +1389,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
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
-	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
-					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
-	if (error) {
-		dev_err(dev, "%s: unable to request threaded IRQ.", __func__);
-		return error;
-	}
-	if (device_may_wakeup(dev)) {
-		error = dev_pm_set_wake_irq(dev, spi->irq);
+	if (shid->is_panel_follower) {
+		error = spi_hid_register_panel_follower(shid);
 		if (error) {
-			dev_err(dev, "%s: failed to set wake IRQ.", __func__);
+			dev_err(dev, "%s: could not add panel follower.", __func__);
 			return error;
 		}
+	} else {
+		error = spi_hid_dev_init(shid);
+		if (error)
+			return error;
 	}
 
-	error = shid->ops->power_up(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: could not power up.", __func__);
-		return error;
-	}
-
-	shid->ops->deassert_reset(shid->ops);
-
 	dev_dbg(dev, "%s: d3 -> %s.", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
@@ -1306,6 +1414,9 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	if (shid->is_panel_follower)
+		drm_panel_remove_follower(&shid->panel_follower);
+
 	spi_hid_stop_hid(shid);
 
 	shid->ops->assert_reset(shid->ops);
@@ -1319,18 +1430,20 @@ static int spi_hid_core_pm_suspend(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
-	spi_hid_suspend(shid);
+	if (shid->is_panel_follower)
+		return 0;
 
-	return 0;
+	return spi_hid_suspend(shid);
 }
 
 static int spi_hid_core_pm_resume(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
-	spi_hid_resume(shid);
+	if (shid->is_panel_follower)
+		return 0;
 
-	return 0;
+	return spi_hid_resume(shid);
 }
 
 const struct dev_pm_ops spi_hid_core_pm = {
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 293e2cfcfbf7..261b2fd7f332 100644
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
 
@@ -66,6 +72,7 @@ struct spi_hid {
 	unsigned long flags;	/* device flags. */
 
 	struct work_struct reset_work;
+	struct work_struct panel_follower_work;
 
 	/* Control lock to ensure complete output transaction. */
 	struct mutex output_lock;

-- 
2.53.0.1185.g05d4b7b318-goog

