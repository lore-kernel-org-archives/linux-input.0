Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EE3B71DF
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099457; cv=none; b=o0BrrcD1lsTQV0+iSOpGmrTibv5t1CFzcYOH7x0Nel4z9rIsZ8xNzHusIAGIGX7PUejItME6xzY5oR6tTaNK+oXMjWqfdt8G/s9n8F3dKHHywwCiaVyj10myv4AvFDqVxBPk0O9uejL4ZB8CXZKIBfA/3BtTPvH8DUtifu37njA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099457; c=relaxed/simple;
	bh=YYpAuj1PY1RFub7ck2lahF5Gc0M1QLmgcRGitoqusDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxXcYTHyVJLa3lTw3df5FU8y7GLxUHmrd6DQ3qSTxmZKoPbZM2HEkFhe18yx0SHKruzy7b63WU4uYciFZoakPHxyR9MmcVmruletWEGqO0+YDMFikyBhmW9ApmqqaP8aENtRO+HdnTTiL1Vn0P+Em4B293vE37YcYuzh4DquZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjXjvjIQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjXjvjIQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso27651695e9.3
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788099451; x=1788704251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mm6NKReOgq/ERbyVD64APvzyNDdk3/BeVLkOCPhJjJU=;
        b=MjXjvjIQyqAnfMtqjxZDo3WbQJE1XZzNjMLboeja0zBZv4IqFXp4SBqNIYHkW6/hzd
         68ixfsZq+bhXE8VoUyPIOQh6ssCR7EV4wAbXGtoSaugAGLwyW3bEXdtw5sxF/lE4Siay
         63s9F1vgV5b37jR8gz4h3PsG/Ltc5vlHNA4wmG+lKiVEF23BqjTvuBWJKKwrI+iD5HVn
         rXJnitPtwN3gYAlRD7eOlU2PcTPiGN+aTAYLWdx96hX7Cem1MBUvGm6LSmOaH1i5Kei/
         dnlA6jucmjGfaKGzxHej55dOJkeeie3uXT5VyzySyBqFJDYGbk/MMLpRv/ss72CSdMiO
         rS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788099451; x=1788704251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mm6NKReOgq/ERbyVD64APvzyNDdk3/BeVLkOCPhJjJU=;
        b=NalBTU2sMYL0VGEP5mW0wSd8ktYgIDc88WsBJdrqqMNuMLsF4TaPZVZ4kVIy2nAQ5/
         FNIM2EuyqI4n0oVFLBKI8NwMVq+Z7RiuYJ1pzEStPWi0lhTXNFge7lP1YPvV/2c29wo0
         oZYazH+8ZHbuAo8/Pc4XpMaF9itfGc7TFrLUEiSoBkUSr79FHp5L866MRmlIzZVfTUjo
         bPqZoxW4bOLxCT/TTf9Y9xrcAieoD07FwmTahW3NHm2i6V+A+qoKglcD3xXW6GxuORcD
         RMFyThrcAcZiygr+7VpWTZ2MnT2rIFC1Ttz97typtHwZdLNOLgyAHJiCmfgsiAORArl1
         JY1Q==
X-Gm-Message-State: AFuF++moD+xSUskbsGyuqrLuhroDWpJkyOtQrAlrZnpILnFb9Yg7EfEg
	v6X0GJ8JItr/IJ/bTMdLrpubLfixMztnfByAKj1UMEmcm3MyjEu2UxQQ
X-Gm-Gg: AR+sD10Y27CG7VCStJDjWLVsMuLtowYjfNW7WaSIZzZbA4weM78YgbZsBxYdcgatbaf
	wUg3UXSWDQYqn+GZGM5orgm8jE7jKEc+njGE+31jpX96nU2oKe066SZPXoYsD9PSU3Lt97GEZdB
	iXLjRnFBvdLRt5wX0J2GROTxNZWJn9jTpMe/br8j5UcFwT/FlcYt18bzXgejXNqEiBEblcRU/VK
	EC3//Rwt4LahyzwzQWRL1Bd04pZpZofQXeMBhrfN6p+dU+rHEr1uED3brfZhKAEzLTtvfSweSnF
	WYb65MKqCTbxGzLG5Ecam+3nF10DwjJtDY3Peycx74sq4XehpA4eePaHDknJuxmmrbhggPy6NU0
	I4/nM1J28cyzNLbfGBv21hE5tOL1ZNQeJzQdQNuwL2ONvrQ63iOCIrSUQd2pNaMQBmrsGSDITwm
	SGoddhIzka1n4pJ4eW3g5tI++zSE4qmaxggLfRelkT/arEisG6ojurd2+RRtquRbb0IveDYnT3a
	ZvOX3k+epLSjpNmWvCHiEFwiqiQbgQwQIOjkkxDXvgOMonnHIua3Q==
X-Received: by 2002:a05:600c:4e14:b0:499:ae94:be05 with SMTP id 5b1f17b1804b1-49b91bd78c0mr339903405e9.0.1788099451081;
        Sun, 30 Aug 2026 07:17:31 -0700 (PDT)
Received: from 1Z10 ([37.161.215.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc1076sm203877985e9.3.2026.08.30.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 07:17:30 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Maurizio Casciano <mauriziocasciano7@gmail.com>
Subject: [PATCH v4] Input: drv260x: Fix suspend and resume sequencing
Date: Sun, 30 Aug 2026 16:17:28 +0200
Message-ID: <20260830141728.53320-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829230740.126461F000E9@smtp.kernel.org>
References: <20260829230740.126461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force-feedback playback is queued asynchronously, but system suspend
can cut power while the worker is pending. Disable and drain the work
item before entering standby, and keep it disabled until resume has
restored communication.

The enable GPIO gates I2C access without resetting the device. Raise it
and observe the startup delay before leaving standby after resume or a
failed regulator shutdown.

Use explicit mutex locking with goto-based error unwinding, and balance
the work disable count on every resume error path so a later successful
resume can restore playback.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-input/20260829230740.126461F000E9@smtp.kernel.org/
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/
Assisted-by: Codex:gpt-5.6-sol [sparse]
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
---
 drivers/input/misc/drv260x.c | 50 ++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..b6499b2fcd8d 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -569,18 +569,20 @@ static int drv260x_probe(struct i2c_client *client)
 static int drv260x_suspend(struct device *dev)
 {
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
-	int error;
+	int error, restore_error;
 
-	guard(mutex)(&haptics->input_dev->mutex);
+	mutex_lock(&haptics->input_dev->mutex);
 
 	if (input_device_enabled(haptics->input_dev)) {
+		disable_work_sync(&haptics->work);
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
@@ -588,14 +590,25 @@ static int drv260x_suspend(struct device *dev)
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
+	if (restore_error)
+		dev_err(dev, "Failed to leave standby mode: %d\n", restore_error);
+err_enable_work:
+	enable_work(&haptics->work);
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
 }
 
 static int drv260x_resume(struct device *dev)
@@ -603,28 +616,39 @@ static int drv260x_resume(struct device *dev)
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
 	int error;
 
-	guard(mutex)(&haptics->input_dev->mutex);
+	mutex_lock(&haptics->input_dev->mutex);
 
 	if (input_device_enabled(haptics->input_dev)) {
 		error = regulator_enable(haptics->regulator);
 		if (error) {
 			dev_err(dev, "Failed to enable regulator\n");
-			return error;
+			goto err_enable_work;
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
+		enable_work(&haptics->work);
 	}
 
+	mutex_unlock(&haptics->input_dev->mutex);
 	return 0;
+
+err_disable_regulator:
+	gpiod_set_value(haptics->enable_gpio, 0);
+	regulator_disable(haptics->regulator);
+err_enable_work:
+	enable_work(&haptics->work);
+	mutex_unlock(&haptics->input_dev->mutex);
+	return error;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
-- 
2.53.0

