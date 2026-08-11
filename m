Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55466443AA3
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450839; cv=none; b=ewlBeDIl8TfC49+1skhbV3m1x1XOHBaK5Kmn7MBVK4ETOxDhvZ+WBLmk8z8QHlBTGUnFzCRcWjzQ4JbSDPLCz2nNnx138zdvbBFG6tshH0sfaykIqONnH0TKhVuXlBpKtBG3zjJVK9LjXeSZKS0yOzq5XSe1mxXPd5lFZP8BjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450839; c=relaxed/simple;
	bh=u+z0AwRO8/TSAUMbuMg66Cd0/+Rr78HnvpPXb+NIM+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOdYLKq4r6eeOXlQkv+L23vz60YD6VP6Sh3luNefiqINe158L0KDEe/JrPJJlcmKEFtt0onqK8mQaf0ODYN4D9vuE5kYyWW+QCjC49n63kWRa09g3V8p/vHrxTXG4zAdG2X3eh7/Ed4h75vszcNW3AirqiSD3jVM4n2px7EYYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ButOzhgM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ButOzhgM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so3024017b3a.1
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450837; x=1787055637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mhe3GkzE7TtO88F1kpNcvywePxi+2kbW1KiUnFj6D6w=;
        b=ButOzhgMoWMmUi8u3EdW6sI9W8ols+M+JFndKECFMcauOl3FlibEr7bJMw3vau+a+K
         okaKVW1AMctBLbutMaPhkTRTYMikEcMo2m120OL2TxjErnIyBPa97ukVU6nmWKL9QFgY
         rT3aTIP7qaaRhxQYuGyjs3j9AptBWC8rXoxNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450837; x=1787055637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mhe3GkzE7TtO88F1kpNcvywePxi+2kbW1KiUnFj6D6w=;
        b=Q+4B+iGpiQyyWEm1AXLPuQ7WQkWTp8fiXZnIOrc4Fcww9AqemFU/T9cxFqax2Annek
         L7L/J+6GnrwlZYM1CDE/5/IGmYdg/xzrNCWFCtVww6CO1HP6yMeiWQlUaDcliVwH4460
         a77aUej1p8A/htVUIVHBekhUVVPxPAhT+1iKWKpQqG9R/kvm+vkxjOOY89FTGGVZNpDS
         yBAmU2exc8h4/7QDtDcXt6GxJXn2EzwWBXVaYgb6wzJ7km8fmpkygagySxNoYh+yjYOY
         6CD52vrdRQMMGpQGw3ed3iK4WgGBkfxFOTqs+oxsjzoglnPW2cuoxIE7tYInF5F0udrr
         WQ4A==
X-Forwarded-Encrypted: i=1; AHgh+Rr0YpZ4HYXEN2WeJUA/BLJh2xzVzCNuIr4Oh1Q26KQML0ZDxOtqdgVpsdF04CIr0QqCRXxAp3Z7HdLA6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1biTsTA38S4uH34doT/KFDXCsy0wm8uY8TTz924bXsUar8bOb
	sEARTV+iN2Knh3ibooZFOGXINS/ngSDGVBItr1slUIneeyAFLdBv2QtAFjX8Mj9K6tG6QaMN4Uf
	MbS9AvQ==
X-Gm-Gg: AR+sD13meJFP4SDXU1Ub6kYoh+jueI9Pw7rZX/WNobglSGQoSkbFOm6W5/IyP6rhUw+
	WVeEN20tC+a1yBJGgjnPw5s2MDGonysEqBoPelXz0aGa4Uo5xqGGX4n/UNBa7QhaaLFdE6tDQul
	TZR28sLS3z0u9IS7sVguhRrHWJ0nF/cOb1Sxq7+7L360m78STOGqbSdw+QP5oGDFLECCbuOzESg
	FyZWWDGAjBZVWKaE3gP/QJ85pZuk2JJ3EUknx96sTiSRb01NEBCHL14RH0WOZUJUPLuqkbMJF+E
	vhSyP3UJJB2L9e6bix8yN/+Qr0PMSPbIL5KN9bwDEsrX73xcFJeEUSa+dat1Z4Q5n31QYmcVw1o
	VRuYVlXsOQW+BfRWOOY9AxUjupocBPf8NZvDJR/3IsGXCAkgNPsEoQEOq/wRLL/AWsGifJU8LSn
	6e8aDrJq6BSmoax1WXaf1S/Ute25bZIOwL4qJAX8ybOBYmtrgFDkG9Zw06ecHUvWXzDR5DXF02u
	+fnkYYgTmv5Z2jgNjxW+UOX0D8UsFHNABrSD7CT5qoKqw==
X-Received: by 2002:a05:6a00:a93:b0:847:9315:fb8b with SMTP id d2e1a72fcca58-84fa8686d1bmr2586060b3a.6.1786450836537;
        Tue, 11 Aug 2026 05:20:36 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:35 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] regulator: core: Add "enable and wait" functions
Date: Tue, 11 Aug 2026 20:20:01 +0800
Message-ID: <20260811122011.3539250-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260811122011.3539250-1-wenst@chromium.org>
References: <20260811122011.3539250-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In device power sequencing and initialization use cases, it is common
for the driver to enable the regulator and then wait for a certain
period of time to pass before continuing.

In cases where the regulator supply is always on, or has been turned on
or left on by another consumer, the driver could shorten the delay or
skip it altogether, provided that enough time has already passed since
the regulator was _actually_ turned on.

Tracking this requires support from the regulator core. Introduce a
"last turned on" timestamp field to the regulator device, and "enable
and wait" functions to the single and bulk regulator consumer APIs.
The existing "enable without wait" functions are then converted to
macros that expand to the new functions.

One case in particular is not optimized yet: a regulator left on either
by hardware reset default or by the bootloader, but does not have the
"regulator-boot-on" property set. As the enable timestamp only gets
updated when enabled by a consumer or by the core, the first enablement
always needs to wait.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Added __private modified to regulator_bulk_data.wait_us field and
  switched to ACCESS_PRIVATE accessor for the field
- Moved wait outside regulator lock scope
- Moved "remaining" value assignment closer to conditional
- Fixed variable unit name in regulator_enable_and_wait() prototype

Changes since v2:
- New patch
---
 drivers/regulator/core.c           | 64 +++++++++++++++++++++++-------
 include/linux/regulator/consumer.h | 21 +++++++---
 include/linux/regulator/driver.h   |  2 +
 3 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2e61606fc1d0..9b766302bdba 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -98,7 +98,7 @@ struct regulator_event_work {
 	unsigned long event;
 };
 
-static int _regulator_enable(struct regulator *regulator);
+static int _regulator_enable(struct regulator *regulator, ktime_t *last_on);
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
 static int _regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags);
@@ -1674,7 +1674,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		    (rdev->constraints->always_on ||
 		     !regulator_is_enabled(rdev->supply))) {
 			ret = (is_locked
-			       ? _regulator_enable(rdev->supply)
+			       ? _regulator_enable(rdev->supply, NULL)
 			       : regulator_enable(rdev->supply));
 			if (ret < 0) {
 				_regulator_put(rdev->supply);
@@ -3060,6 +3060,8 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		fsleep(delay);
 	}
 
+	rdev->last_on = ktime_get_boottime();
+
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
 	return 0;
@@ -3129,8 +3131,8 @@ static int _regulator_handle_consumer_disable(struct regulator *regulator)
 	return 0;
 }
 
-/* locks held by regulator_enable() */
-static int _regulator_enable(struct regulator *regulator)
+/* locks held by regulator_enable_and_wait() */
+static int _regulator_enable(struct regulator *regulator, ktime_t *last_on)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
@@ -3138,7 +3140,7 @@ static int _regulator_enable(struct regulator *regulator)
 	lockdep_assert_held_once(&rdev->mutex.base);
 
 	if (rdev->use_count == 0 && rdev->supply) {
-		ret = _regulator_enable(rdev->supply);
+		ret = _regulator_enable(rdev->supply, NULL);
 		if (ret < 0)
 			return ret;
 	}
@@ -3176,13 +3178,19 @@ static int _regulator_enable(struct regulator *regulator)
 		} else if (ret < 0) {
 			rdev_err(rdev, "is_enabled() failed: %pe\n", ERR_PTR(ret));
 			goto err_consumer_disable;
+		} else {
+			/* regulator already enabled somehow, but timestamp might be invalid */
+			if (!rdev->last_on)
+				rdev->last_on = ktime_get_boottime();
 		}
-		/* Fallthrough on positive return values - already enabled */
 	}
 
 	if (regulator->enable_count == 1)
 		rdev->use_count++;
 
+	if (last_on)
+		*last_on = rdev->last_on;
+
 	return 0;
 
 err_consumer_disable:
@@ -3196,31 +3204,49 @@ static int _regulator_enable(struct regulator *regulator)
 }
 
 /**
- * regulator_enable - enable regulator output
+ * regulator_enable_and_wait - enable regulator output and wait for time
+ *			       passed after regulator actually enabled
  * @regulator: regulator source
+ * @wait_us: time to wait after regulator actually turned on; 0 to not wait
  *
  * Request that the regulator be enabled with the regulator output at
  * the predefined voltage or current value.  Calls to regulator_enable()
  * must be balanced with calls to regulator_disable().
  *
+ * If wait_us is greater than zero, then check that wait_us has passed since
+ * the regulator is _actually_ enabled before returning.
+ *
  * NOTE: the output value can be set by other drivers, boot loader or may be
  * hardwired in the regulator.
  *
  * Return: 0 on success or a negative error number on failure.
  */
-int regulator_enable(struct regulator *regulator)
+int regulator_enable_and_wait(struct regulator *regulator, unsigned int wait_us)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	struct ww_acquire_ctx ww_ctx;
+	ktime_t last_on = 0;
 	int ret;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
-	ret = _regulator_enable(regulator);
+	ret = _regulator_enable(regulator, &last_on);
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
+	if (ret)
+		return ret;
+
+	if (wait_us) {
+		ktime_t end = ktime_add_us(last_on, wait_us);
+		s64 remaining;
+
+		remaining = ktime_us_delta(end, ktime_get_boottime());
+		if (remaining > 0)
+			fsleep(remaining);
+	}
+
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_enable);
+EXPORT_SYMBOL_GPL(regulator_enable_and_wait);
 
 static int _regulator_do_disable(struct regulator_dev *rdev)
 {
@@ -5389,30 +5415,38 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
 {
 	struct regulator_bulk_data *bulk = data;
 
-	bulk->ret = regulator_enable(bulk->consumer);
+	bulk->ret = regulator_enable_and_wait(bulk->consumer, ACCESS_PRIVATE(bulk, wait_us));
 }
 
 /**
- * regulator_bulk_enable - enable multiple regulator consumers
+ * regulator_bulk_enable_and_wait - enable multiple regulator consumers and
+ *				    wait for time passed after regulators are
+ *				    actually enabled
  *
  * @num_consumers: Number of consumers
  * @consumers:     Consumer data; clients are stored here.
+ * @wait_us: time to wait after regulators actually turned on; 0 to not wait
  *
  * This convenience API allows consumers to enable multiple regulator
  * clients in a single API call.  If any consumers cannot be enabled
  * then any others that were enabled will be disabled again prior to
  * return.
  *
+ * If wait_us is greater than zero, then check that wait_us has passed since
+ * the regulators are _actually_ enabled before returning.
+ *
  * Return: 0 on success or a negative error number on failure.
  */
-int regulator_bulk_enable(int num_consumers,
-			  struct regulator_bulk_data *consumers)
+int regulator_bulk_enable_and_wait(int num_consumers,
+				   struct regulator_bulk_data *consumers,
+				   unsigned int wait_us)
 {
 	ASYNC_DOMAIN_EXCLUSIVE(async_domain);
 	int i;
 	int ret = 0;
 
 	for (i = 0; i < num_consumers; i++) {
+		ACCESS_PRIVATE(consumers, wait_us) = wait_us;
 		async_schedule_domain(regulator_bulk_enable_async,
 				      &consumers[i], &async_domain);
 	}
@@ -5440,7 +5474,7 @@ int regulator_bulk_enable(int num_consumers,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_bulk_enable);
+EXPORT_SYMBOL_GPL(regulator_bulk_enable_and_wait);
 
 /**
  * regulator_bulk_disable - disable multiple regulator consumers
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 56fe2693d9b2..0b83acc015d4 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -145,6 +145,7 @@ struct regulator_bulk_data {
 
 	/* private: Internal use */
 	int ret;
+	unsigned int __private wait_us;
 };
 
 #if defined(CONFIG_REGULATOR)
@@ -192,7 +193,7 @@ int devm_regulator_bulk_register_supply_alias(struct device *dev,
 					      int num_id);
 
 /* regulator output control and status */
-int __must_check regulator_enable(struct regulator *regulator);
+int __must_check regulator_enable_and_wait(struct regulator *regulator, unsigned int wait_us);
 int regulator_disable(struct regulator *regulator);
 int regulator_force_disable(struct regulator *regulator);
 int regulator_is_enabled(struct regulator *regulator);
@@ -209,8 +210,9 @@ int __must_check devm_regulator_bulk_get_const(
 	struct device *dev, int num_consumers,
 	const struct regulator_bulk_data *in_consumers,
 	struct regulator_bulk_data **out_consumers);
-int __must_check regulator_bulk_enable(int num_consumers,
-				       struct regulator_bulk_data *consumers);
+int __must_check regulator_bulk_enable_and_wait(int num_consumers,
+						struct regulator_bulk_data *consumers,
+						unsigned int wait_us);
 int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
 				   const char * const *id);
 int regulator_bulk_disable(int num_consumers,
@@ -410,7 +412,8 @@ static inline int devm_regulator_bulk_register_supply_alias(struct device *dev,
 	return 0;
 }
 
-static inline int regulator_enable(struct regulator *regulator)
+static inline int regulator_enable_and_wait(struct regulator *regulator,
+					    unsigned int wait_us)
 {
 	return 0;
 }
@@ -457,8 +460,9 @@ static inline int devm_regulator_bulk_get_const(
 	return 0;
 }
 
-static inline int regulator_bulk_enable(int num_consumers,
-					struct regulator_bulk_data *consumers)
+static inline int regulator_bulk_enable_and_wait(int num_consumers,
+						 struct regulator_bulk_data *consumers,
+						 unsigned int wait_us)
 {
 	return 0;
 }
@@ -676,6 +680,11 @@ regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 }
 #endif
 
+#define regulator_enable(regulator)	regulator_enable_and_wait(regulator, 0)
+
+#define regulator_bulk_enable(num_consumers, consumers)	\
+		regulator_bulk_enable_and_wait(num_consumers, consumers, 0)
+
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_REGULATOR)
 struct regulator *__must_check of_regulator_get(struct device *dev,
 						struct device_node *node,
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index cc6ce709ec86..8a74aa681df3 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -658,6 +658,8 @@ struct regulator_dev {
 	unsigned int constraints_pending:1;
 	unsigned int is_switch:1;
 
+	/* time when this regulator was enabled last time */
+	ktime_t last_on;
 	/* time when this regulator was disabled last time */
 	ktime_t last_off;
 	int cached_err;
-- 
2.55.0.679.g6767b8d81c-goog

