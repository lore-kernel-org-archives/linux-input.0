Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96253C5DAB
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334427; cv=none; b=qe6zSPto4jjc1eybR1ls9enQSPrUdMKnrt8AkOpLhZrRKSwybd4zzY1/R9MZKMhdXDf9taga7b+7ErMzZAAVmgELG3ouSPtW6KMgKr4GRpwWDfG8XWRZXSoKQhkbmUtfyGUwEpe6bgqpRMSI7K3rV17qZNqLjBq3lXq4PR89ReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334427; c=relaxed/simple;
	bh=IRrInqQtcOiaAEhp8wKGZA+QpgivXtu7wbojYzUNBKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5mh37bjJE6zUhXgeFPDJ7Fg/lO73p6JCtZdlLKbfVay0bh4LT5HTKF4U0VG0aAS6IidEsmpvH/kuske2evPzgjmqLpCbqrf5WXoFHvt9R5U96kzTDpirFQico1BJ0QZHqIjco6tp70J8205v0vh5P2iNfZVgZOe70tzVild+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=muwSloOR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muwSloOR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b06c43e6a7so18853405ad.2
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334412; x=1774939212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vM+2YuV3a9NGW/p128SptnqAT8+vbtKMpK5c1NDgHRc=;
        b=muwSloOR8qqdwvXkJofLMq4NhHMTYx4qDe2W5oHVbYe+zY0FMRPuV+pIEXKVIj23QR
         84gJR2BX3s86eCzXMzEglApgUUojGy6LK8m69FdxCaD/ksonXXbh8f4kSb4Mdpmbi+am
         SHtvohXKV7ZJTUzyup7la/Yu5WNUOn5Laf8M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334412; x=1774939212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vM+2YuV3a9NGW/p128SptnqAT8+vbtKMpK5c1NDgHRc=;
        b=AuiVmQYh0HyRmvjtqQzZGOtVTmadHs6f5MvK6/AaPwM+C2L4FiendbYkIwULsn6Los
         jKmc4NwNEwwW15Xpb9jeFG7MgWmvMJ3g3Iw1j+nhSFWhoReFCwohxQIRrk1ibZH2BOjE
         3ITqL8VzT9GwPwoSu6T1suCZxML2DPvoXBI7II4OJCPT9Cs1nsWpa3SWaxkpedn9gr39
         u6hIknSJn3jyTquZJhQ92d6K9jFcfor9wh8Z2k3XwireGIsgqZbKbqbPoGTHrDruYz9z
         ZtQsZoyRsvd22Ph6e8DiYybSSZDXMP6rvbAtA1EUUfoHgOOozpVmsILsCuOibsYB+8Ec
         8k2Q==
X-Gm-Message-State: AOJu0YwnI8z39FTZpGPXBgM0vqXUMtnHGPQgyhtlFt90rK6l0bsqKaHG
	47aqt4bObHJrFbGtv1kJ2eqb30NoC/n3byVE7ajktnQ+/T1YFjKGoD3uVVe/WcznUw==
X-Gm-Gg: ATEYQzyJOPtbJ+YkofrUu0zfWppwmWqTOo+zXAz+dcZTufAy8DmIU6Af2Tj9Kl+ypt+
	4Uzap3dDaz3FKu98Si3dOcYdjC21CKfSn7bF/+KZAvYxXmadqq7qUbfSSPx7SXIh3ESBpR7rwSn
	EkytOYaur1DBWHzRchBG7wyL6mhftyJsB06xz63a8f6taKQiuYOtIAZ6d2sPVxRGOuiY3YmP56Q
	OH2U6GfaWQVGy5ntPGG6vQUjhGp4YDGluVFM7o6iZNmaeIUV+S+AMXnjaxIrDuVYeCeymEHj4+d
	qe5mdKubUFb6xdy2EbBoURVU/NV+Mq8EUjhZaYbixM637d8KHwkWV6YnKpPDjyLbKMNtq0jal2H
	Dr01Lh8/HkVR760IIieKaCN3ZK3j86cDiosdzLkTYm1yJmB66jrnvB8yB8P3PItBzD+2uWj8VIs
	wOItf67AAMZmyOErJCVrQVi6kV7Zi+TuUEE7BoNF8sJ0jyAdZUC/pi2h5wMIqibsRU7/mm5PU0g
	UZp62UR8eefFDK06KjYYvq/wzO7v2zdsg==
X-Received: by 2002:a17:903:1b0d:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b0826ff371mr155178895ad.8.1774334412326;
        Mon, 23 Mar 2026 23:40:12 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:11 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:44 +0000
Subject: [PATCH v2 11/11] HID: spi-hid: add panel follower support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-11-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=10413;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=IRrInqQtcOiaAEhp8wKGZA+QpgivXtu7wbojYzUNBKg=;
 b=KYyIMQQOWQlzy+ILzxiWkvkxM0fyixw5VqW/Ryyc5KMjXzptm3hopTSacuEtuEgYiLof/bSUy
 JJHMAjdU+95A+JlLTZFAdlXa00g574IAt2PWzRPGRzrcxwt/gpJUfig
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add support to spi-hid to be a panel follower.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 199 +++++++++++++++++++++++++++++--------
 drivers/hid/spi-hid/spi-hid-core.h |   7 ++
 2 files changed, 163 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index ac46e2c7c8aa..6037496ad8a8 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -238,21 +238,21 @@ static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state
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
 
@@ -270,21 +270,22 @@ static void spi_hid_suspend(struct spi_hid *shid)
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
 
@@ -298,7 +299,7 @@ static void spi_hid_resume(struct spi_hid *shid)
 			dev_err(dev, "%s: could not power up.", __func__);
 			shid->regulator_error_count++;
 			shid->regulator_last_error = error;
-			return;
+			return error;
 		}
 		shid->power_state = HIDSPI_ON;
 
@@ -307,10 +308,13 @@ static void spi_hid_resume(struct spi_hid *shid)
 
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
@@ -1177,6 +1181,132 @@ const struct attribute_group *spi_hid_groups[] = {
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
@@ -1196,6 +1326,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	shid->ops = ops;
 	shid->conf = conf;
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+	shid->is_panel_follower = drm_is_panel_follower(&spi->dev);
 
 	spi_set_drvdata(spi, shid);
 
@@ -1208,6 +1339,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	init_completion(&shid->output_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+	INIT_WORK(&shid->panel_follower_work, spi_hid_panel_follower_work);
 
 	/*
 	 * We need to allocate the buffer without knowing the maximum
@@ -1218,42 +1350,18 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
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
 
@@ -1267,6 +1375,9 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	if (shid->is_panel_follower)
+		drm_panel_remove_follower(&shid->panel_follower);
+
 	spi_hid_stop_hid(shid);
 
 	shid->ops->assert_reset(shid->ops);
@@ -1280,18 +1391,20 @@ static int spi_hid_core_pm_suspend(struct device *dev)
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
index 61b35a4a4180..72792304c69b 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -7,6 +7,8 @@
 #include <linux/hid-over-spi.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_panel.h>
+
 /* Protocol message size constants */
 #define SPI_HID_READ_APPROVAL_LEN		5
 #define SPI_HID_OUTPUT_HEADER_LEN		8
@@ -53,6 +55,10 @@ struct spi_hid {
 	struct spi_hid_input_buf *input;	/* Input buffer. */
 	struct spi_hid_input_buf *response;	/* Response buffer. */
 
+	struct drm_panel_follower panel_follower;
+	bool	is_panel_follower;
+	bool	panel_follower_work_finished;
+
 	u16 response_length;
 	u16 bufsize;
 
@@ -63,6 +69,7 @@ struct spi_hid {
 	unsigned long flags;	/* device flags. */
 
 	struct work_struct reset_work;
+	struct work_struct panel_follower_work;
 
 	/* Control lock to ensure complete output transaction. */
 	struct mutex output_lock;

-- 
2.53.0.983.g0bb29b3bc5-goog

