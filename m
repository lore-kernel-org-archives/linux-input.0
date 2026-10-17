Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FB47F3DF
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246133; cv=none; b=hAtyDbtKGbOaCcE3BczGgOyxjmjRo+itgDOgIBHCaXJu1O8fFocAYDHFwLgzvltn295yZBzttSS04OBs4kxMAKuZ+ubA1C4OJV15JdPQYIN25pxRf11XJfRikPR8yEZ+D0YFugkwpK6KME0sMoM+TF2yQCDLgCZRIj0lmoKmfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246133; c=relaxed/simple;
	bh=M/fO2fPNKEJuGGAETlGpiAMAmlXI8AfDa1ul3FclVRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXWai3/09ltTYk+msZPhW/+33yNoRyoBurRMXNlS9Ak8KuCciF23yyCCh4ls591VciIP/tlzkJ7XwMdqQxeBNoaUgng7YNZyB+hRGor99+RfpfDMqrbNqjaKjNr8PqWAbMTqKfCvbuyJiA/wPvTo4xW2bwD9SZ9RIS6nb409Xjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk3NblTs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk3NblTs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1df146015so1614235e9.0
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792246127; x=1792850927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfOl1kjHpYXnvDQ7klGKtwkq44SiCg69dIWYFZz39rU=;
        b=Xk3NblTsJX1dwlOid+CvUf8moW7AfhQGV3rhkBY8eSb+6xtvvJMjQ8DGFCE2bfrrqs
         BCkYLuYNKYGriFPSDsBnHevB5ZTyV9gFIRpjQafiKZosUXAHBMj7sCpRKcm39fHKCvYu
         x3GgGn4GbKpGAupTtrGcoXMO0KbhkRHxxD6jCLyKk+tTWZTR5ZEa6/OhYo6CoULDvhww
         HmdeiI9M6aqd3Whkqj2rF0oaQAeXtvYiJ7CM7edEC4Z79LqvuNwgWg8tJdeP8dS813eE
         jkHuX7fYIzzKJ1VNr3UghYV5NWypp1j0NxoX7sCV2PA/vYNzJgF3fgbQcBfrOu2nmtUA
         m/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792246127; x=1792850927;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfOl1kjHpYXnvDQ7klGKtwkq44SiCg69dIWYFZz39rU=;
        b=pyEFx3TMBXYa9kAgJU2199qyG569+A4lWfa5LHxl1Hh4PWhraz32k1ZWkBA4L0EjGk
         egqtRm0vPW54PAmXif55cK+8ZrwgV+sQKKZZutYvHkWICvN3tY1ZPFp9G1Zux+kIAWyu
         ESpU+VEovT6j0dLSNF21MVw0l8OqQwp+mumjH6tTczyttaY2mr5vsYYTFjSU7O7yfn2e
         8Wcdt4mH7Qh8F3GBUtNYkXSNTuTeMtRXFFmmluZ4TNJ2My2phwbnhDfwQmcDjBDTcKGB
         dLxl+Zunn5P1Q7swTHw+Sml117F/dVmz1WJvuI0jxuAV7RsDH/aP7/zqdd03CEx/Nxbn
         zTyA==
X-Forwarded-Encrypted: i=1; AKwUvBy3xC+1wU1Q8Zn+yK8TBm1l6BJ8dUdYWua8lyw/Kz7Lc4Q8ZWTDX3zV7AAR+uGNJirlTPaeJbnoCbS8Aw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLPme62QuWhGJS5z0JBO45ZWr5FLFRxRNPmTmKL5i9DvgfYeQNQ
	xSORR7ip6kqVdCHPSaRFh8U+JU3Jvp9xtRBdxOFMft9L9/VSpVqc2hm9
X-Gm-Gg: AYBFou0Bu3ZdQLqCmZBdB6Ie0zB6SxTlSva4xagI2QHGHf9+NWtmpSm1F1X+HQ/tbYu
	LD5F+2icMshoQmzmsNHGHStAZcsUzj77s56i+NbQXBWIgkNMEsn/gv7I8RNlZuyisKThji2j8n/
	u7y89aYQnGXJ798wOM2ihosKKDbEP4McLOjWcBCGeJUOEI0pLKcPweK67yiM6L23DArRy/6lsbb
	7fRY2AnjOlMucjI93rLaK6lzkAQ8LhnGuoBPptwXDXw+5vBkw1rgorH2Uru0bsP59iDst4F0bC1
	T8aYuHZmETXWOIJOuKzqE0JLSukVITqdMEvzv0tHycyCeG11TE8RNQIznSCft6ltWkdJyYod0ne
	QIg4sf55TcZ5tyhfLTB5hyDlNQypxEE3NiLdc26hZCHjfVF8rtlBu9yn0/UfRRTjHQB/t/0JEft
	1w3pmKeKM6wo3esojTB4AlRWO+ndkyGVABsMDmQtde4hh/z0mMBUtKK+mZOWOlgHkfT3/HUk42p
	bsy43YhcEa52egeQcin006hKOYHHPebfDI/pdn4aN0/pw6UmoRiKARUNGIilhwtk0vN5VUaP4pu
	YA==
X-Received: by 2002:a05:600c:468e:b0:4a0:12d7:4c88 with SMTP id 5b1f17b1804b1-4a1d7625f71mr59997585e9.30.1792246127263;
        Sat, 17 Oct 2026 07:08:47 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:08:46 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 7/7] Input: edt-ft5x06 - support following a DRM panel
Date: Sat, 17 Oct 2026 16:07:55 +0200
Message-ID: <20261017140827.290666-8-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017140827.290666-1-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On touch and display driver (TDDI) chips such as the FT8722 the touch
controller shares its supply and reset with the display panel, so it
can only be accessed while the panel is powered and loses its state,
and for RAM-only parts its firmware, every time the panel goes off.

When the device tree links the touchscreen to its panel, register as a
DRM panel follower, like i2c-hid does.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 drivers/input/touchscreen/Kconfig      |   1 +
 drivers/input/touchscreen/edt-ft5x06.c | 156 ++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 92840ea9c65f..b4fd55028a04 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -794,6 +794,7 @@ config TOUCHSCREEN_PENMOUNT
 config TOUCHSCREEN_EDT_FT5X06
 	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
 	depends on I2C
+	depends on DRM_PANEL || !DRM_PANEL
 	select REGMAP_I2C
 	help
 	  Say Y here if you have an EDT "Polytouch" touchscreen based
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 7bcc48e07d62..b2fca6c37205 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -4,6 +4,7 @@
  * Daniel Wagener <daniel.wagener@kernelconcepts.de> (M09 firmware support)
  * Lothar Waßmann <LW@KARO-electronics.de> (DT support)
  * Dario Binacchi <dario.binacchi@amarulasolutions.com> (regmap support)
+ * Luka Panio <lukapanio@gmail.com> (SPI and DRM panel support)
  */
 
 /*
@@ -33,6 +34,9 @@
 #include <linux/uaccess.h>
 
 #include <linux/unaligned.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_panel.h>
 
 #include "edt-ft5x06.h"
 
@@ -150,6 +154,12 @@ struct edt_ft5x06_ts_data {
 	enum edt_ver version;
 	int (*boot)(struct device *dev, struct gpio_desc *reset_gpio);
 	u8 tdata_reg;
+
+	struct drm_panel_follower panel_follower;
+	struct work_struct panel_work;
+	bool is_panel_follower;
+	bool powered_off;
+	bool hw_initialized;
 	unsigned int crc_errors;
 	unsigned int header_errors;
 };
@@ -383,7 +393,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 
 	guard(mutex)(&tsdata->mutex);
 
-	if (tsdata->factory_mode)
+	if (tsdata->factory_mode || tsdata->powered_off)
 		return -EIO;
 
 	switch (tsdata->version) {
@@ -441,7 +451,7 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 
 	guard(mutex)(&tsdata->mutex);
 
-	if (tsdata->factory_mode)
+	if (tsdata->factory_mode || tsdata->powered_off)
 		return -EIO;
 
 	error = kstrtouint(buf, 0, &val);
@@ -1120,7 +1130,8 @@ static void edt_ft5x06_disable_regulators(void *arg)
 
 /*
  * Take the controller out of reset, identify it and register the input
- * device.
+ * device. Called from probe, or once the panel is up for controllers
+ * following a panel.
  */
 static int edt_ft5x06_ts_init_hw(struct edt_ft5x06_ts_data *tsdata)
 {
@@ -1206,9 +1217,117 @@ static int edt_ft5x06_ts_init_hw(struct edt_ft5x06_ts_data *tsdata)
 
 	edt_ft5x06_ts_prepare_debugfs(tsdata);
 
+	tsdata->hw_initialized = true;
+
+	return 0;
+}
+
+/*
+ * TDDI controllers share their power and reset with the display panel. When
+ * following a panel, power the touch controller down before the panel goes
+ * off and bring it back once the panel is up again.
+ */
+static void edt_ft5x06_panel_work(struct work_struct *work)
+{
+	struct edt_ft5x06_ts_data *tsdata =
+		container_of(work, struct edt_ft5x06_ts_data, panel_work);
+	int error;
+
+	guard(mutex)(&tsdata->mutex);
+
+	if (!tsdata->powered_off)
+		return;
+
+	if (!tsdata->hw_initialized) {
+		error = edt_ft5x06_ts_init_hw(tsdata);
+		if (error) {
+			/* try again the next time the panel comes up */
+			gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
+			dev_err(tsdata->dev,
+				"Failed to initialize the controller: %d\n",
+				error);
+			return;
+		}
+		goto out;
+	}
+
+	gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
+
+	if (tsdata->boot) {
+		error = tsdata->boot(tsdata->dev, tsdata->reset_gpio);
+		if (error) {
+			dev_err(tsdata->dev,
+				"Failed to boot the controller: %d\n", error);
+			return;
+		}
+	} else {
+		msleep(300);
+	}
+
+	edt_ft5x06_restore_reg_parameters(tsdata);
+out:
+	tsdata->powered_off = false;
+	enable_irq(tsdata->irq);
+}
+
+static int edt_ft5x06_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct edt_ft5x06_ts_data *tsdata =
+		container_of(follower, struct edt_ft5x06_ts_data, panel_follower);
+
+	/* Downloading firmware takes a while, don't hold up the panel */
+	schedule_work(&tsdata->panel_work);
+
 	return 0;
 }
 
+static int edt_ft5x06_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct edt_ft5x06_ts_data *tsdata =
+		container_of(follower, struct edt_ft5x06_ts_data, panel_follower);
+
+	cancel_work_sync(&tsdata->panel_work);
+
+	guard(mutex)(&tsdata->mutex);
+
+	if (tsdata->powered_off)
+		return 0;
+
+	disable_irq(tsdata->irq);
+	gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
+	tsdata->powered_off = true;
+
+	return 0;
+}
+
+static const struct drm_panel_follower_funcs edt_ft5x06_panel_follower_funcs = {
+	.panel_prepared = edt_ft5x06_panel_prepared,
+	.panel_unpreparing = edt_ft5x06_panel_unpreparing,
+};
+
+static void edt_ft5x06_cancel_panel_work(void *data)
+{
+	struct edt_ft5x06_ts_data *tsdata = data;
+
+	cancel_work_sync(&tsdata->panel_work);
+}
+
+static int edt_ft5x06_register_panel_follower(struct edt_ft5x06_ts_data *tsdata)
+{
+	struct device *dev = tsdata->dev;
+	int error;
+
+	INIT_WORK(&tsdata->panel_work, edt_ft5x06_panel_work);
+	error = devm_add_action_or_reset(dev, edt_ft5x06_cancel_panel_work,
+					 tsdata);
+	if (error)
+		return error;
+
+	tsdata->panel_follower.funcs = &edt_ft5x06_panel_follower_funcs;
+
+	return devm_drm_panel_add_follower(dev, &tsdata->panel_follower);
+}
+
 int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 		     const struct edt_ft5x06_chip_data *chip_data, u16 bustype,
 		     struct dentry *debugfs)
@@ -1331,14 +1450,24 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 	tsdata->factory_mode = false;
 	dev_set_drvdata(dev, tsdata);
 
-	error = edt_ft5x06_ts_init_hw(tsdata);
-	if (error)
-		return error;
+	/*
+	 * A controller sharing its power with a panel can only be accessed
+	 * once the panel is up, so leave it in reset and do the rest of the
+	 * initialization from the panel follower callback.
+	 */
+	tsdata->is_panel_follower = drm_is_panel_follower(dev);
+	if (!tsdata->is_panel_follower) {
+		error = edt_ft5x06_ts_init_hw(tsdata);
+		if (error)
+			return error;
+	}
 
 	irq_flags = irq_get_trigger_type(irq);
 	if (irq_flags == IRQF_TRIGGER_NONE)
 		irq_flags = IRQF_TRIGGER_FALLING;
 	irq_flags |= IRQF_ONESHOT;
+	if (tsdata->is_panel_follower)
+		irq_flags |= IRQF_NO_AUTOEN;
 
 	error = devm_request_threaded_irq(dev, irq, NULL, edt_ft5x06_ts_isr,
 					  irq_flags, dev_name(dev), tsdata);
@@ -1347,6 +1476,14 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 		return error;
 	}
 
+	if (tsdata->is_panel_follower) {
+		tsdata->powered_off = true;
+		error = edt_ft5x06_register_panel_follower(tsdata);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "failed to follow the panel\n");
+	}
+
 	dev_dbg(dev,
 		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
 		irq,
@@ -1374,6 +1511,10 @@ static int edt_ft5x06_ts_suspend(struct device *dev)
 	if (device_may_wakeup(dev))
 		return 0;
 
+	/* The panel powers us down and up */
+	if (tsdata->is_panel_follower)
+		return 0;
+
 	if (tsdata->suspend_mode == EDT_PMODE_NOT_SUPPORTED)
 		return 0;
 
@@ -1415,6 +1556,9 @@ static int edt_ft5x06_ts_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		return 0;
 
+	if (tsdata->is_panel_follower)
+		return 0;
+
 	if (tsdata->suspend_mode == EDT_PMODE_NOT_SUPPORTED)
 		return 0;
 
-- 
2.55.0

