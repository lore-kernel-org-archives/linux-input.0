Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692243441E
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620447; cv=none; b=Q9V0Bi5OY5QzKcD0nnDTXx/ScIwcVHog/cwS3p2bwzaOsKZlxAMAJ7TsI4FcQDktgvr8H6CYB3ZgsqhYVNnp5RQ9SWyUwINF/8wPO4QwSW50BdwqfWkveOewFEYAeAGN9+Syx2YTXfq9dOKujKIlzf5JKBW3aojwB9aMdeegaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620447; c=relaxed/simple;
	bh=fGqqjYxRpJEquoSDoUijzydkeIkOzEwNSSUXC1u57cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhxC9bPgLKCrn97+VEGrO4VsqtlZ/H9Fpnvo5MFCG/1Yuo8C2S7rIM47BKegL+3a/xf8L9LUoFTbBQeyW5qKBEvYYd+wjRpYDcTZ+4A5BLIlf864ZwrifYB5jWTT66ogfj+2pnErUfEIgjTWj6xlgQkihuYVmOa6fb75PResQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AY+cYaQ6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AY+cYaQ6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ced3386430so72811045ad.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620445; x=1785225245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rCW+zOBgfvbnw9BhnKL6QqmG00TxqWezJ2oP+m8mTI=;
        b=AY+cYaQ6eaF0nDZ5s/z0NDllGG5k704vJ+ij2IACyMhsQ7Rs0yXHKInTAztdwlJ0tW
         FhkTJFLovCrFttnO8CgWIsTE42EnffgWPJAu+LmKbjwZMg4uE8zSLZ+IEIidjmUaYkpd
         vS2ME/oCz3lOvB69/+fTui+7uN4GkdJzL1b9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620445; x=1785225245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rCW+zOBgfvbnw9BhnKL6QqmG00TxqWezJ2oP+m8mTI=;
        b=gHst81c/0FIdu4iqZf0R+//rJFFmpyAOvrfOdfReM/uw7ma3j6MpWWrjiFCAPywYFl
         H4nfKs8H4nh4f9YZTI1G6UXJdyKcIHEe3RAMylXHE4+G65yU0xz4V7FDcExj3ye6bsG4
         lH8XaIEH4eKLa+0f9AFxJPMTMHCzL4eikZMSLwqfdYN8UMCem1pjQZ4xyltZQdT7XSM6
         B68b/6WWx3kvakVcdKH6vBjoxYHKou6IFeacru1G1ksardoduKZqJ1Iw1+RPPcT/OH7f
         d1GfqFZ4n7u+6lU04ZTnwCaWGKU9XvNuaDqA+tqlfYHkmdLtj9AxiXkmCCphah0sjsyH
         Y4Dg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7e8JIfYnyNghI0FCJETPNNFpAVQrGI9+eJl2AjluW+YLpu3QiDwhDx7d3W2768TbjggPugiU9N8JAaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zpcQNFi2Q1A/e3ZzuVGuYY2Ez0b48l21Stuw4dtPCXa4CnVV
	SYHqdt9tYQkmN3ftHHp1b7jzVK3Q4ijjdQHKETulutqRRXsNPg0V0utnsV11EVg2pA==
X-Gm-Gg: AR+sD13u5aLLSX6zfYb26QCLcOSFD6eRQUPHoFIlwyOkOhC/tYikF+PAkbyWmfUgHz6
	0lC8JJqOxCyW5DbQyPUfxO6dNkvkWydFPf1zC3ZWznMsmJ9H/u+LgfVSAf8tUDsBJs0M8MMVaSn
	2owPSPGFpwXidiDvkK5XGUft29BOaT8JcKbccO2UdC2Ukie52lvMquCwwn0UQENIZlymyqCjbFo
	9TzCtqiaUnzoCRWHZ/yUB0L/SAgx6diWND8sPx/qr54tEdSdtJK7DOxUqp413EWVyzEvw6uxVNN
	uXn9GpMh92WhC9V8l4Iky/Qcg+CQcYAOY6LIACmIqzsD22J2ELuvINy0SkP2HuACQHmKDJi6tPG
	Xm2GzqhWUB3P/LO88aBvDULnRZ3FSaJ6pei7DQwJyPNfhudjJKljWn6Sd+pLNf+6EDYZsUCPLb1
	E2d91qqbyAKeqKAUm4QvKisJnEhAY22l5cd+W3/xmCaXFNZuQnk8xNAJF8mXNmhnlxJUyScw==
X-Received: by 2002:a17:902:fb4c:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2cf34804857mr128068305ad.10.1784620445333;
        Tue, 21 Jul 2026 00:54:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:04 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] regulator: core: Add "enable and wait" functions
Date: Tue, 21 Jul 2026 15:52:15 +0800
Message-ID: <20260721075226.2347933-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721075226.2347933-1-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
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
Changes since v2:
- New patch
---
 drivers/regulator/core.c           | 53 ++++++++++++++++++++++--------
 include/linux/regulator/consumer.h | 21 ++++++++----
 include/linux/regulator/driver.h   |  2 ++
 3 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1797929dfe56..d14ce86d8f7b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -98,7 +98,8 @@ struct regulator_event_work {
 	unsigned long event;
 };
 
-static int _regulator_enable(struct regulator *regulator);
+static int _regulator_enable_and_wait(struct regulator *regulator, unsigned int wait_us);
+#define _regulator_enable(regulator)	_regulator_enable_and_wait(regulator, 0)
 static int _regulator_is_enabled(struct regulator_dev *rdev);
 static int _regulator_disable(struct regulator *regulator);
 static int _regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags);
@@ -3043,6 +3044,8 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		fsleep(delay);
 	}
 
+	rdev->last_on = ktime_get_boottime();
+
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
 	return 0;
@@ -3112,8 +3115,8 @@ static int _regulator_handle_consumer_disable(struct regulator *regulator)
 	return 0;
 }
 
-/* locks held by regulator_enable() */
-static int _regulator_enable(struct regulator *regulator)
+/* locks held by regulator_enable_and_wait() */
+static int _regulator_enable_and_wait(struct regulator *regulator, unsigned int wait_us)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
@@ -3159,13 +3162,24 @@ static int _regulator_enable(struct regulator *regulator)
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
 
+	if (wait_us) {
+		ktime_t end = ktime_add_us(rdev->last_on, wait_us);
+		s64 remaining = ktime_us_delta(end, ktime_get_boottime());
+
+		if (remaining > 0)
+			fsleep(remaining);
+	}
+
 	return 0;
 
 err_consumer_disable:
@@ -3179,31 +3193,36 @@ static int _regulator_enable(struct regulator *regulator)
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
 	int ret;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
-	ret = _regulator_enable(regulator);
+	ret = _regulator_enable_and_wait(regulator, wait_us);
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_enable);
+EXPORT_SYMBOL_GPL(regulator_enable_and_wait);
 
 static int _regulator_do_disable(struct regulator_dev *rdev)
 {
@@ -5372,30 +5391,38 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
 {
 	struct regulator_bulk_data *bulk = data;
 
-	bulk->ret = regulator_enable(bulk->consumer);
+	bulk->ret = regulator_enable_and_wait(bulk->consumer, bulk->wait_us);
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
+		consumers[i].wait_us = wait_us;
 		async_schedule_domain(regulator_bulk_enable_async,
 				      &consumers[i], &async_domain);
 	}
@@ -5423,7 +5450,7 @@ int regulator_bulk_enable(int num_consumers,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(regulator_bulk_enable);
+EXPORT_SYMBOL_GPL(regulator_bulk_enable_and_wait);
 
 /**
  * regulator_bulk_disable - disable multiple regulator consumers
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 56fe2693d9b2..a69157c9b5b5 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -145,6 +145,7 @@ struct regulator_bulk_data {
 
 	/* private: Internal use */
 	int ret;
+	unsigned int wait_us;
 };
 
 #if defined(CONFIG_REGULATOR)
@@ -192,7 +193,7 @@ int devm_regulator_bulk_register_supply_alias(struct device *dev,
 					      int num_id);
 
 /* regulator output control and status */
-int __must_check regulator_enable(struct regulator *regulator);
+int __must_check regulator_enable_and_wait(struct regulator *regulator, unsigned int ms);
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
2.55.0.229.g6434b31f56-goog

