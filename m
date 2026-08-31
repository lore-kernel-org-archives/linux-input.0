Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD7345CAA
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788138028; cv=none; b=VySSUUsPXFwJQf353hyzn4zG+6xXmm3zbO6RNlvM5yK+Sj9dvaZgAzL6rABqHSwlWHcK637A04GqYhTpWx+McInLvrCCAZYO5hRV0Du+K1y5wcZKscFAcp7IfbIe5zc+Au9J7O0Jdkni/lJ9IAXO2Bx6LAGYzwLAzrBCqWzI//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788138028; c=relaxed/simple;
	bh=XbWILXbWMzDMgR7qzIX1vHxh8m1MflRutzuKQqnUTsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmCY9ZH5fjmKMqvuUD1+G0WnxdXWi3sKrphkeEBfnlHoMoZWWLxt7GwRZokrh/96Vo0WQizfTSRLDBR9dB65s2RChuJnQdAadJ3vTx2kw8tHdFi7+/wj2WlNAuQjWoWt6OQQcaXTlOkO2XdqUcejR9qvdedJAtwpjY41REbYtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmkBeGMO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmkBeGMO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso28068015e9.0
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788138025; x=1788742825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCVsu0gee0/HYHL2XBs9n2zsPu5Jg0UWEowDR7lZR/Q=;
        b=kmkBeGMOPoSOSa9kLRm833vvBtxKDwOJNgYJdg+pMBd+M5+l5u/z5U5Hy2u0ucpBOq
         Bq5LdMtMnH2ft9wAOQMXsjLXPCKhe/q3QvFWF2ERWizOyTUA7traNBXVO7t5FGQ1gWJk
         YDu+B4F3SCht58PicshycmSlEoZG130QjI34eaFJE6r1Ol2Z1TopvEAnrtfCjCf8LdDn
         2WTVgeIL66q5FuUXUpHp2JWm6PHl5II41juIX9kSm7GMStjupJmz93jK9FNZaYq/qeAB
         e3PefxFD+ijeybSUjbATn1DoeS/NmGG5bJHPCJ7i1OLvIaFds+ChfjO4Nh7LtIfwiJR5
         iTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788138025; x=1788742825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FCVsu0gee0/HYHL2XBs9n2zsPu5Jg0UWEowDR7lZR/Q=;
        b=SYFXphyztlz5+NiTzmNhV6FUJDNxp25JH7OEz4A3tUnOeRkegtMGyEgRTs1jUUIUje
         tNvPPVvq0k8AjwHUd4CkLF+KNnM0xzSJpwdZyb4BL2HOW7iebwAoUkfIUKX5lz1Vh7hg
         qLP5UgJshrISDxWKnyBR1GnBCWzviT5rCm87Yz1JJLiFfJqz80W+ihks72wQmMTsz6dJ
         hVGqEHJFnind2bzreCxViWW7ZJmYk8oPcokeHbOLEe8BwwNNG3bE3BxF9E8hsFTk2sWl
         euu6MbalzehyZdHSR+OHjBsVMNW2h41KXhebqAGu7y8GtgkUzz95FryXMF4ZYFmxZmgi
         qQlg==
X-Gm-Message-State: AFuF++kARpIEcTWNIHptfqTorfzQR4vKpxJCck/UPMteW8l5tNOD9Hz3
	I9fsBjKibo5pItZiKCA2iGLzMji0EThT0tyxWiEc+eKiVhfp7AAxhDuE
X-Gm-Gg: AR+sD10fzdHAcCeZfOuxiO/d+twWeXd5YiPodR+1ytQkKAHJmm0sQMXKEUfG6sZIrn3
	fatYJmDOvbjYmI+3pkaavKGTBbzT0P3UCTDDkl9FPlopn1hWHbzC+KQtCkOsdh7sXP4MxpKP7Kb
	kvO46zkpC5iv7X1lH5cEAy6Rxu/K0UxBzsgWcVXxUiyN9v5MWFPo+yTmzauWurHw3yAQpyzwK/D
	t6V3fvy8rN8uT8dDRMy+GElSqWdtkh9rukStiZSJhdW92HITsGmUVY0e1+wasplX3f1PKav/fS7
	HYZxQ+5hjjx2qZeNQQfyvVTA87ljOxKMdEfzSD5peEn/TqL/NhVzvTVFyoVGBjkrXtQiq4ZpzHW
	+FiCaqE/tqny/tFdoUgNigblan9yVHvOahZ+z66vYG77RRYNWL3yrYxjGjWDSZIdAF5JhgAuKnI
	ncLw6qhlmhPHl3MAHFLsRYEJwDZAVuJ/Rf/J7sayQM8UxRsFbafH155xz7hqZYqv5Wj2HLAntnG
	4qxazHLh3eXavjVelKa0Lew11/CSoHpXYwswp4xUQs=
X-Received: by 2002:a05:600c:1c0a:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-49b91c1dd3fmr364364395e9.1.1788138024483;
        Sun, 30 Aug 2026 18:00:24 -0700 (PDT)
Received: from 1Z10 ([37.161.215.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccea87e1asm109869685e9.2.2026.08.30.18.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 18:00:23 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Maurizio Casciano <mauriziocasciano7@gmail.com>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH v5] Input: drv260x: Fix suspend and resume sequencing
Date: Mon, 31 Aug 2026 03:00:20 +0200
Message-ID: <20260831010020.673316-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830143050.03E081F000E9@smtp.kernel.org>
References: <20260830143050.03E081F000E9@smtp.kernel.org>
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

The enable GPIO gates I2C access without resetting the device. Raise it and
observe the startup delay before leaving standby after resume or a failed
regulator shutdown.

Use explicit locking and goto-based error unwinding. Keep the work item
disabled after a resume failure. Track whether it is already disabled
under the input mutex, so another suspend or a direct resume retry does not
increment the disable count and a later successful resume balances it
exactly once. Skip close-time register access while recovery remains
pending.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-input/20260829230740.126461F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/linux-input/20260830143050.03E081F000E9@smtp.kernel.org/
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/
Assisted-by: Codex:gpt-5.6-sol [sparse]
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
---
Changes in v5:
- Keep the work item disabled after every resume failure, so force-feedback
  cannot reach hardware whose regulator is off.
- Track the disabled state to avoid incrementing the work disable count again
  on a later suspend or direct resume retry.
- Enable the work item only after resume has fully restored the regulator,
  enable GPIO, and standby state, balancing the disable count exactly once.
- Avoid close-time register access while PM recovery is pending.

 drivers/input/misc/drv260x.c | 80 ++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 13 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..f261bb32fdc0 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -181,6 +181,7 @@
  * @work: Work item used to off load the enable/disable of the vibration
  * @enable_gpio: Pointer to the gpio used for enable/disabling
  * @regulator: Pointer to the regulator for the IC
+ * @work_disabled: Whether playback work is disabled pending PM recovery
  * @magnitude: Magnitude of the vibration event
  * @mode: The operating mode of the IC (LRA_NO_CAL, ERM or LRA)
  * @library: The vibration library to be used
@@ -194,6 +195,7 @@ struct drv260x_data {
 	struct work_struct work;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
+	bool work_disabled;
 	u8 magnitude;
 	u32 mode;
 	u32 library;
@@ -215,6 +217,24 @@ static int drv260x_calculate_voltage(unsigned int voltage)
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
@@ -263,6 +283,10 @@ static void drv260x_close(struct input_dev *input)
 	struct drv260x_data *haptics = input_get_drvdata(input);
 	int error;
 
+	/* PM has not restored register access yet. */
+	if (haptics->work_disabled)
+		return;
+
 	cancel_work_sync(&haptics->work);
 
 	error = regmap_write(haptics->regmap, DRV260X_MODE, DRV260X_STANDBY);
@@ -569,18 +593,22 @@ static int drv260x_probe(struct i2c_client *client)
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
@@ -588,14 +616,28 @@ static int drv260x_suspend(struct device *dev)
 		error = regulator_disable(haptics->regulator);
 		if (error) {
 			dev_err(dev, "Failed to disable regulator\n");
-			regmap_update_bits(haptics->regmap,
-					   DRV260X_MODE,
-					   DRV260X_STANDBY_MASK, 0);
-			return error;
+			goto err_leave_standby;
 		}
 	}
 
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
@@ -603,28 +645,40 @@ static int drv260x_resume(struct device *dev)
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
 	int error;
 
-	guard(mutex)(&haptics->input_dev->mutex);
+	mutex_lock(&haptics->input_dev->mutex);
 
 	if (input_device_enabled(haptics->input_dev)) {
+		drv260x_disable_work(haptics);
+
 		error = regulator_enable(haptics->regulator);
 		if (error) {
 			dev_err(dev, "Failed to enable regulator\n");
-			return error;
+			goto err_unlock;
 		}
 
+		gpiod_set_value(haptics->enable_gpio, 1);
+		fsleep(250);
+
 		error = regmap_update_bits(haptics->regmap,
 					   DRV260X_MODE,
 					   DRV260X_STANDBY_MASK, 0);
 		if (error) {
-			dev_err(dev, "Failed to unset standby mode\n");
-			regulator_disable(haptics->regulator);
-			return error;
+			dev_err(dev, "Failed to leave standby mode: %d\n", error);
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
+	regulator_disable(haptics->regulator);
+err_unlock:
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
-- 
2.53.0
