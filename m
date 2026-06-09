Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCA3CB2E7
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 04:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980100; cv=none; b=dR4rO3Wwo7LxV+DkL/rkPbUjZAp0mnXCJuRIRkuov+ngeVjc19uLXFWvenABMPqU7+1DMjh5CBRZ5h18MWw4pohnhowfD2sNrF1jVsHyHIxUQfsi5+pPPV4vf2F1NWBAnVVG+opTgv0V9d43tcDw8/fY7yxzGPU161ntJKgASEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980100; c=relaxed/simple;
	bh=q5+kv26/nrZW6zX2FC2B8QfgxpMMxjfWrvpFimff1Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnEn6DHYqzHuNvQMHpC6fUr2WzffaONX0Of77k6KBpwfnax9vUxCXP3V/w1MKV8KrhJOmwA2/faUJYtcZX4uvYM/1uXT3J5WAZwCrLyBc781pQJgOCHyAA+3wOiImNhks9ZY1Dlw4oDpRUc7su+yW1EmDmJPJEY7kpc1aUD9fH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V528fGrv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V528fGrv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf18c30bb2so35515845ad.0
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 21:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780980094; x=1781584894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqxZiyw+e+cflpM3UG3hv/pwSFqmoCoCJh93jY7BBN0=;
        b=V528fGrvm5IxKvHDokrVB4QgLwDMENuostKetcBRvEtAVMYCQDhUSgGbqYiGeWe/DV
         LsO+iy+tCM5elaW/hFc2MnVr8hcW8geQX4BuS4qIcAUa1mg+EoRrmMaXhnR6vO54EJ3Q
         iAQXfwqFbqzxvVtnoohCAwZbLv6nzhlOyAaAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980094; x=1781584894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YqxZiyw+e+cflpM3UG3hv/pwSFqmoCoCJh93jY7BBN0=;
        b=Z9FxFpixqddBU78pZD3nagjVUQJpD+4NGTemurSAf0EZH+aZsG/ti/CCepbMey3Gd+
         4/hs2GiHgOECJ4LcvKoQsNqhmhveHxkhSdOKlnLHptdIiOq4oNN5BKhCAerPewFrtp+L
         /H/FhzRDegSYcxuV1ZABUuv0FPGy61tuYBT23HMV6voOUJxvWJ59R/uVmGQJripTeg6v
         XTC0D1mKxwaDfxVcrVvrHQF7FOp2BxEtwJihucQmG+F5fNbxNcN31FoRjeCr+mCwHoyu
         dz92ITfgYhUe800eVqsPoth+hCWj2xUoANepHq8FNzR65me5Muv8hj/czjSpFkUb6nwo
         nY0w==
X-Gm-Message-State: AOJu0YyleL+VPtmJM/+B78iT1MX5rwm9Gmv/4VYg1T7f4zbz8EWem3wl
	UHGComEogr0MvZfouEPh9SrmDJq1OZC738UJE6sHS0Fc6WgMwGziBM6DtR0crV1BAw==
X-Gm-Gg: Acq92OH3ujPPZM5YFAH1nlW41nhS4M+6CvPI1opTcZYr2PxLRh/e3nCZCfKtW4i89di
	MOowlcJSQ0970qlVO+1z/mpc0XJQXQGtZaEkoVJLb/7Bko1rhzQnBc8+cXYiu2kEai6CDuTs3Y8
	VWpA/inm39Uihcl8MoKc+aX3ldGxyyB6pCMqUJDuPwlKBbt8oudlJf7mo4CUsWqwsIS2dJBbflg
	kKUaWi9VCNDonJq9vS2bLycZO5+rgD6szv3+nIU9400JJluihTosmfV9Jsys4uuIm6tagED7m/O
	U/vlZpon0/cPU7v8TKWZUxfzvfaojb6qI+bGH+kbp6/2H2OobeMDDxMe17XbbA30EndwBNO1rru
	meawPW+JqzW1RXBDkn3cA2zVMYoUxqiETADZ9PzAyjCaLdTZsw3vkjoG3Rxsx+9hz7sHLHsoLds
	wZJXOZFBQE9iqcP1YTmsvNan72PPGaejcSqz3temJhvCcHxPVarO8ij3bBf0xSODTAMaEU3sTzB
	nEhAcfZ1JKBxgMoMKNQc5YwJJD3o8kI7wu4TcLgOeuj
X-Received: by 2002:a17:902:ce8f:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2c1e80f9ea3mr211630235ad.8.1780980092709;
        Mon, 08 Jun 2026 21:41:32 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm200736065ad.80.2026.06.08.21.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:41:32 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 09 Jun 2026 04:41:02 +0000
Subject: [PATCH v4 11/11] HID: spi-hid: add panel follower support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-send-upstream-v4-11-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
In-Reply-To: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780980084; l=8112;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=q5+kv26/nrZW6zX2FC2B8QfgxpMMxjfWrvpFimff1Mk=;
 b=glvstjxXTBww/N19Xbya/aWrvvQvSaP5TaaNakkGljtc3CQiYDCF/jG8C+3to9vC/UUJC+Lw1
 L1aAmFYVyZHAVg5Rm3YlkNvXaA8FPyjOfXvG8V9rGwrxZwz789SFwD1
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add support to spi-hid to be a panel follower.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/spi-hid-core.c | 164 ++++++++++++++++++++++++++++++-------
 drivers/hid/spi-hid/spi-hid-core.h |   7 ++
 2 files changed, 142 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 517f06913477..27f25d95ed28 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -1281,6 +1281,106 @@ const struct attribute_group *spi_hid_groups[] = {
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
+	shid->ops->deassert_reset(shid->ops);
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
+	if (!shid->desc.hid_version)
+		error = spi_hid_dev_init(shid);
+	else
+		error = spi_hid_resume(shid);
+	if (error)
+		dev_warn(&shid->spi->dev, "Power on failed: %d\n", error);
+	else
+		WRITE_ONCE(shid->panel_follower_work_finished, true);
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
@@ -1300,6 +1400,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	shid->ops = ops;
 	shid->conf = conf;
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+	shid->is_panel_follower = drm_is_panel_follower(&spi->dev);
 
 	spi_set_drvdata(spi, shid);
 
@@ -1313,6 +1414,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	init_completion(&shid->output_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+	INIT_WORK(&shid->panel_follower_work, spi_hid_panel_follower_work);
 
 	/*
 	 * We need to allocate the buffer without knowing the maximum
@@ -1323,20 +1425,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
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
@@ -1351,22 +1439,28 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		}
 	}
 
-	error = shid->ops->power_up(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: could not power up\n", __func__);
-		if (device_may_wakeup(dev))
-			dev_pm_clear_wake_irq(dev);
-		return error;
+	if (shid->is_panel_follower) {
+		error = spi_hid_register_panel_follower(shid);
+		if (error) {
+			dev_err_probe(dev, error,
+				      "Failed to register panel follower");
+			goto err_wake_irq;
+		}
+	} else {
+		error = spi_hid_dev_init(shid);
+		if (error)
+			goto err_wake_irq;
 	}
 
-	shid->ops->deassert_reset(shid->ops);
-
-	enable_irq(spi->irq);
-
 	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
 	return 0;
+
+err_wake_irq:
+	if (device_may_wakeup(dev))
+		dev_pm_clear_wake_irq(dev);
+	return error;
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_probe);
 
@@ -1376,15 +1470,21 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
-	disable_irq(spi->irq);
+	if (shid->is_panel_follower)
+		drm_panel_remove_follower(&shid->panel_follower);
+	else
+		disable_irq(spi->irq);
+
 	cancel_work_sync(&shid->reset_work);
 
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
 
 	if (device_may_wakeup(dev))
 		dev_pm_clear_wake_irq(dev);
@@ -1395,6 +1495,9 @@ static int spi_hid_core_pm_suspend(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_suspend(shid);
 }
 
@@ -1402,6 +1505,9 @@ static int spi_hid_core_pm_resume(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_resume(shid);
 }
 
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
2.54.0.1064.gd145956f57-goog

