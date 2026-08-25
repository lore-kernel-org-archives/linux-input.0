Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306F37F73D
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632416; cv=none; b=bm6PJ3gCLG2k07OWQ/kGUZ6xM5wtH6xpksnYoG6zKnC/hqHND7VfHhMkBJXOQ7DzdGEPUZ7erPdyNHkWOvzl617Q1nqPFSBmgC/0g/pI7dHYRfU5fwfbTYhN0PewmKm0O1jez95I0BrPlE7zCD2W5ieiANox+mgvdo2ZKyHLvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632416; c=relaxed/simple;
	bh=5liJqj0QW6Tv4bSobBKxKVRFmiJfUE2WNmpCIGzcBLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoZ/96tpkkVlbpQPa81I0j88qrH+fXnz7F0cwyU/lq2FTHkanGT6W6t7QSoA7JuNj4bMufS2BFfGE0w0QQYz+NEMQ83f8MUYZmGVkLNvdFMwmuw6QcoslgIaC1bBEsZlhht7Xd7enacrZ4icrwRanNoAGTWRBtvsV8Y9ial6weg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VUWxEdEj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VUWxEdEj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso6057304a91.2
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 21:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787632414; x=1788237214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcqeYVtwEdBoGSrDXdk4fs5867JCY5OOBmzd0xKFWVg=;
        b=VUWxEdEjZOzPo4+xS0sT8mSHd8kXwsPSa15zl0dWGuye+sDDB1uxuuRfDAYPYPJo4m
         0R94uFYshkQipaPbAVDmTFTpwwPnPd5mQ5fRVuzZpWJTjq9J0l5IUScx9vDoWH53N2w3
         ftkJrrrNNLikjWxMjhAYaThEpPWhejL8CK4lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632414; x=1788237214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcqeYVtwEdBoGSrDXdk4fs5867JCY5OOBmzd0xKFWVg=;
        b=GGfio18cWgq3kp+HgRCGiteSny6t1wBylevw1LYegBUVg1yHPgVpTRLezFHj1YGo9M
         NG/tk+fcbKpt1ahpzN+PJzVNdyTTWwYrd7V3WLCW2DW2eZ26fGtO0ZZCrpn55NT86D8D
         Cv8KlT/Dr9ii6t4h8SjbrfotdFMfen0ACA9m474jkqiocBxcz1XY8Tbs/CSBl+T9tD8H
         Jd6gRCCBRK/AXq7V9wtrhpF+lMCXfro6ToPtL81edRR3e/S/Nk5WixnX+7oLXUK2syqS
         fsVoFkYP5xeRuUbksC+oars/f0EesR5uc8mA+ox+boJ9WEdhc1yaKO6j1T0vJJxFz887
         HNPw==
X-Forwarded-Encrypted: i=1; AHgh+RqPjy/zQTslT83975se2781eGw/hUNaliIkJBpbsWZZA1d1hmkQWb8fZOJ9M2b0KsDGnB74E7I1osTi2Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mk/6km74xK4HNwsdVd6r76nPjyjgD5ZnIWf8YEV3GfOwOvcPWO
	O5CJyH6yBr17PRtyyJGryqB2qgsD66/TOi1hIGsvLkfyfANAwwHfWBK4k/vIdfnTYg==
X-Gm-Gg: AR+sD12mFt4kJuTOYhffWpdwSjxAYEBVbp8mpSyvGrEjAuojTH0AdLOYg0j4kpJQQTX
	vW9PpvNzPjZk8Ulth99rA8lbEnpn1Iir9mMOEvsgBsfGzr5uBNZCp3zt6zJE3P/jibmn+Vj9ESX
	EAykVkttwPAHsLU/0FXOp6UgdktaKgBJah3Lj0m+5JdT/lBTvWpwGdhesASVmLq2e/Au5ORxHKN
	P3cjS+wgwDBeCYaK7jybIexI0uC7xNYNqM0CbfJKBEfY0VgZDko088pqV6IM6+q+J+/VeEDw2Y7
	PxqLVn4HJ1oB2QRT20oMZKVJl9w6bCYJNL0P4+VAEb8Q+j8GnOyxcO3UgmDRjew+/MCJrWlp94Q
	iSDKp/sUppYHLXyHRFTi94BuZlY6sdXVGI/pG/GPQ+8iqhL/q4PXIKm/AHjIIag/eAlCAvLkNiY
	4eWSLMIIN6Irt43j2JARCXWmaMFjM6D88yjLv9py6bzsllM+FW4hapDyoh1OcYJ5+wKz3V/VrXK
	8xN6Gydnd7yoNdrKPC7R/gR0be50sLgIPImQ+QMF23YM38=
X-Received: by 2002:a17:90b:3911:b0:395:543a:cf3b with SMTP id 98e67ed59e1d1-396463084famr7174715a91.2.1787632414107;
        Mon, 24 Aug 2026 21:33:34 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:a442:9780:24da:cb4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396458212absm2187823a91.0.2026.08.24.21.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:33:33 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] regulator: core: Add "enable and wait" functions
Date: Tue, 25 Aug 2026 12:16:19 +0800
Message-ID: <20260825041628.988369-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
In-Reply-To: <20260825041628.988369-1-wenst@chromium.org>
References: <20260825041628.988369-1-wenst@chromium.org>
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

The timestamp is updated each time the regulator is actually turned on.
For regulators left on by hardware default or by firmware, the core will
set the timestamp if it detects it was left on and its supply (and their
supply, and so on) is on as well. This is unfortunately best effort
only. The core can only assume a dangling regulator (one without a
supply) has power. This also applies to the dummy regulator.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Try to update last_on timestamp for regulators that were left on

Changes since v3:
- Added __private modified to regulator_bulk_data.wait_us field and
  switched to ACCESS_PRIVATE accessor for the field
- Moved wait outside regulator lock scope
- Moved "remaining" value assignment closer to conditional
- Fixed variable unit name in regulator_enable_and_wait() prototype

Changes since v2:
- New patch
---
 drivers/regulator/core.c           | 117 +++++++++++++++++++++++++----
 include/linux/regulator/consumer.h |  21 ++++--
 include/linux/regulator/driver.h   |   2 +
 3 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6a4008f387b5..3cc01b2f4c9f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -99,7 +99,7 @@ struct regulator_event_work {
 	unsigned long event;
 };
 
-static int _regulator_enable(struct regulator *regulator);
+static int _regulator_enable(struct regulator *regulator, ktime_t *last_on);
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
 static int _regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags);
@@ -1675,7 +1675,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		    (rdev->constraints->always_on ||
 		     !regulator_is_enabled(rdev->supply))) {
 			ret = (is_locked
-			       ? _regulator_enable(rdev->supply)
+			       ? _regulator_enable(rdev->supply, NULL)
 			       : regulator_enable(rdev->supply));
 			if (ret < 0) {
 				_regulator_put(rdev->supply);
@@ -2186,6 +2186,44 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+/**
+ * _regulator_is_enabled_recursive - is the regulator output enabled all
+ *				     the way to the root supply
+ * @rdev: regulator device
+ *
+ * Only intended for checking regulators that have been left on by
+ * hardware default or firmware.
+ *
+ * Must be called with dependent locks held.
+ *
+ * Return: Positive if the regulator output backing the source/client,
+ *	   and all of its upstream supplies, have requested that their
+ *	   respective device be enabled, zero if any of them hasn't,
+ *	   else a negative error number.
+ */
+static int _regulator_is_enabled_recursive(struct regulator_dev *rdev)
+{
+	int ret;
+
+	ret = _regulator_is_enabled(rdev);
+	if (ret <= 0)
+		return ret;
+
+	/*
+	 * If .last_on was set, then this rdev was either enabled through
+	 * _regulator_do_enable(), or had been checked before as the target
+	 * of regulator_resolve_supply().
+	 */
+	if (rdev->last_on)
+		return ret;
+
+	/* This is the root supply; we can only assume it actually has power */
+	if (!rdev->supply)
+		return ret;
+
+	return _regulator_is_enabled_recursive(rdev->supply->rdev);
+}
+
 static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
@@ -2370,6 +2408,14 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 		}
 		rdev->constraints_pending = false;
 	}
+
+	/*
+	 * regulator was left on but not enabled with .always_on or .boot_on
+	 * constraints, and thus .last_on timestamp is still invalid.
+	 */
+	if (!rdev->last_on && _regulator_is_enabled_recursive(rdev))
+		rdev->last_on = ktime_get_boottime();
+
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	if (!do_final_setup)
@@ -3061,6 +3107,8 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		fsleep(delay);
 	}
 
+	rdev->last_on = ktime_get_boottime();
+
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
 	return 0;
@@ -3130,8 +3178,8 @@ static int _regulator_handle_consumer_disable(struct regulator *regulator)
 	return 0;
 }
 
-/* locks held by regulator_enable() */
-static int _regulator_enable(struct regulator *regulator)
+/* locks held by regulator_enable_and_wait() */
+static int _regulator_enable(struct regulator *regulator, ktime_t *last_on)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
@@ -3139,7 +3187,7 @@ static int _regulator_enable(struct regulator *regulator)
 	lockdep_assert_held_once(&rdev->mutex.base);
 
 	if (rdev->use_count == 0 && rdev->supply) {
-		ret = _regulator_enable(rdev->supply);
+		ret = _regulator_enable(rdev->supply, NULL);
 		if (ret < 0)
 			return ret;
 	}
@@ -3177,13 +3225,19 @@ static int _regulator_enable(struct regulator *regulator)
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
@@ -3197,31 +3251,49 @@ static int _regulator_enable(struct regulator *regulator)
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
@@ -5390,30 +5462,38 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
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
@@ -5441,7 +5521,7 @@ int regulator_bulk_enable(int num_consumers,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_bulk_enable);
+EXPORT_SYMBOL_GPL(regulator_bulk_enable_and_wait);
 
 /**
  * regulator_bulk_disable - disable multiple regulator consumers
@@ -6243,6 +6323,13 @@ regulator_register(struct device *dev,
 			goto del_cdev_and_bdev;
 	}
 
+	/*
+	 * If no supply was given, then the last_on timestamp could not have
+	 * been updated in regulator_resolve_supply(). Check it here.
+	 */
+	if (!rdev->supply_name && !rdev->last_on && _regulator_is_enabled(rdev))
+		rdev->last_on = ktime_get_boottime();
+
 	rdev_init_debugfs(rdev);
 
 	/* try to resolve regulators coupling since a new one was registered */
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
2.55.0.860.g4b6b3295ed-goog

