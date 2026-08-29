Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AF41BA93
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044231; cv=none; b=MtXq06CbfdH1iJNK4pwTwnJYj/HiMpgxWodc2Z43DTp/EbUlJ5iLRPK7crbt+RnACAoE4N+r7FLtB10EXvDrdDsz5FI6tl4vHbjZ/3qiK3Cc3UxZrAfmOFVibzmcVA0svlgebaZiHkeIhpSxTSzrfdN9+hx7FHDx9Ra7j25lEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044231; c=relaxed/simple;
	bh=j5Ta560yYb7QSFZ/12qvEh2mtRhm7yqiutoob5yNEFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZCkNifGULqDFbP8U1aIkiWM5z3veoh1GRoq/6ojr2fBwHjEqP3MZiG6vvBB5Y9QYVBKxzr36hJ8dXmOl5I1g/kBbtE9jffj+UcYSDF0h3D9qm3gcqH8iEG1kVSPOSvSRAqE3xRoIJuJKyvpF4330dSu6Rkc1nItLR177L8OA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1RMNuc/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1RMNuc/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482e4998d28so1570782f8f.2
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788044228; x=1788649028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=16NZ1aE/Ccu1Qtv2yeNvMdFzRgZruQ1N1HEdny4sv7M=;
        b=n1RMNuc/takH4GFqo/x2RkiMH1r9GzFnfnOktE/y9+bEXBfcg3VJG26RVxKrJKqMDa
         v1RxCHQ5uPzYLdgeEB+FR+6sAImu+BcNGBcm1Am9RIr+RF0QyLDY9ruG3TZ2yp7TsoCE
         /q9L8qvBcxHePCD63dMQZaSVjyEK4Yt5XcmqN4Hsxo2p0VFdwggQayrjuNMOdiCGSR5j
         8+maQQpGn83dEh0+y8Pvtb5MjKB/T7RqtpopA04zrIemqx5Uwqo68nJU8kY2ZILi4oOv
         SzOFinnuE5pOXkzExMlKv+LBlM7pOyUQErxV35bx80Y+A7syLqAE/31cb7ENB2oZH1ho
         9p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788044228; x=1788649028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=16NZ1aE/Ccu1Qtv2yeNvMdFzRgZruQ1N1HEdny4sv7M=;
        b=RWnWd6eXqKA4Q+Tl/51ZMkB4y5wnFuJxsjlvr3dHnUZN9c/8axyNB8oQVNcmZoK43H
         BZNUO87OY6LeDV8eWWfZvLrfKdsU8xaKEs2SEQrU53bowGbKMsOLaSe1StRFMfQo8Ohh
         fIbUATFDEZvo3hA1VjK/TvRYsqfIAo1g1DgotFRaNzYciPOCVFjxtV5D0zZtGZVn+fJZ
         6tjRbhuxU1ojZ3lzlyKBNVFhVivrcQtd8NQzOr6SsYmpfMgaDnuph/1zhXfJEsbhBUFR
         BIBvH3ARtjDYtoxyJeGjVlsOs4GurPtRdohWCeeMFrgu6t6iLImP10QUsVZ+6sb6ifcJ
         tZBg==
X-Gm-Message-State: AFuF++kYTZza7BydWfrEAAy+S5g8NipvLnFe/0isZEuxtXfh2CzqaCYU
	z3TCGQcAdc0tu+g09bSmDTWn63VlSdi4n6EtLTXNozZiYogYsg4oLA5V
X-Gm-Gg: AYBFou2EMrviGSXj0+23b6958QdvGg4Z/n4o7mDoKm+0Gcb2l8MSeLtsBV1e8M/V2VO
	sO9Nm69h2bWZC0u3sMI2x/CUNOpkHFMxukwGQhm1h22qfRo+NsXBG8q82Sd0eYfVsXhj9W6RrXp
	lPCxzhW37haNY10zdznrGBTiwbpW7BO8plIhYZy4Du3JkqVYYJ1dQJkAlMhzmtKRw5BFslLNXZH
	p4tstJiiUpLx1dCnV/mMTX6tMK4sSSaQv2mg+X+FNk/YVoo6TsMQOn+Blcm7F10aApzHldVkE0a
	jYFZhkkr7l4x0EnUTinu0kEEke7EAI2H9AXklK0dlKaeOLBuCYZAeUA9hq0gmddvj0VFNymIIDk
	Fn4vF7kWpsxpVSv8Dov2BFzUnybMQrbZSRTGWn7HPXZ9Q0GBkVsv+L2LkTzP441uv27Et4qChnB
	WVw79/BK9qdJwCwjmvFxC9iPn47KZQVKpInXXf7/T6PnT9z9ON/8cRhiRTfiStuWa7dcyy7LFVi
	I+kBD7JEvsVpTvcJEaX3bGNXQJhkVorWk3XmhUhnyv+
X-Received: by 2002:a5d:5c8a:0:b0:481:4697:8808 with SMTP id ffacd0b85a97d-482f7a06e5cmr23399013f8f.22.1788044228356;
        Sat, 29 Aug 2026 15:57:08 -0700 (PDT)
Received: from 1Z10 ([37.161.113.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2e6e8sm13796244f8f.32.2026.08.29.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 15:57:07 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <mauriziocasciano7@gmail.com>
Subject: [PATCH v3] Input: drv260x: Fix suspend and resume sequencing
Date: Sun, 30 Aug 2026 00:57:04 +0200
Message-ID: <20260829225704.394707-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apLD91vzHIrLOPWC@google.com>
References: <apLD91vzHIrLOPWC@google.com>
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
failed regulator shutdown. Use goto-based error unwinding to balance the
work state.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/apLD91vzHIrLOPWC@google.com/
Assisted-by: Codex:gpt-5.6-sol [sparse]
Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
---
 drivers/input/misc/drv260x.c | 38 ++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 6c5c4c53753b..d8208b3f7645 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -569,18 +569,20 @@ static int drv260x_probe(struct i2c_client *client)
 static int drv260x_suspend(struct device *dev)
 {
 	struct drv260x_data *haptics = dev_get_drvdata(dev);
-	int error;
+	int error, restore_error;
 
 	guard(mutex)(&haptics->input_dev->mutex);
 
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
@@ -588,14 +590,23 @@ static int drv260x_suspend(struct device *dev)
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
+	return error;
 }
 
 static int drv260x_resume(struct device *dev)
@@ -612,19 +623,26 @@ static int drv260x_resume(struct device *dev)
 			return error;
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
 
 	return 0;
+
+err_disable_regulator:
+	gpiod_set_value(haptics->enable_gpio, 0);
+	regulator_disable(haptics->regulator);
+	return error;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
-- 
2.53.0

