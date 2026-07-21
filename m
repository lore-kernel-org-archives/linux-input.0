Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1360438039
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620464; cv=none; b=SVmNS1rhkcXqwMzZEDYJqPjha51X3Aq81G1xyryjRxACB6o6/pvgXNIst4m7ctvFNA/bSzPB5yEJAVd4uPyMesq4qBG9W1k/q77wAM7P83CijNwcshOYV2l5ZAq0lMS1jlvHQH2ojYbqyIZOrHoDy4Zsb+HI6dwssO1guG+GYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620464; c=relaxed/simple;
	bh=9Ni9zhrtKci5P2BRwTspKb8GrclLS+sUdzCWkor5diY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcNqO2IC48h7Q8pUbEuANAxok5Fc6ps5mSmVSzrCfZQH29hjLoTND83Dwe+qZGb/cCgpZwQbFy+0b6wu2hCf93EvHD2DR1FXV5HN9ZKTwipB6bUqhD1sDi+90JzpFYvS8Ff7mRW0mJdATNSUEpgKSl/jjkz5JuOCQBuFa4B7NGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jtCD3UVT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jtCD3UVT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cca0c5799eso87022535ad.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620462; x=1785225262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7iH2zA1ruu4tS3rL/ntmqLvjt6Xg4qydbdtr1Vk28d0=;
        b=jtCD3UVTieOZoQqULOsFiXtIiCoplzhCAv/fsA99FqyzfH5Nqxnw59NIdTh3ofLGUW
         qvtbHKYC16tah68FgbRWN1SeZy6kIrcsQ0YA06NLuzkN3R8jw3Nz4ISvdISJ+XV7U+73
         TRgTcJ+BaLButP4eeMzVzTttK+9/r0PnfRElI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620462; x=1785225262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7iH2zA1ruu4tS3rL/ntmqLvjt6Xg4qydbdtr1Vk28d0=;
        b=XcJVjQqhHXtJwreYB2ZzF4wY1s7jf78NhnAOvT/ZPmCnJtrC5GOGOeeAue4ReBYSFN
         AyHEKuSQdrFzlJXdhXRQIFMAa84vNlKxMsS8ziuXJKXV+rg8BDdjvhI5F17MKh63GcI/
         KQEyq24sSCpMcmQO5o+oLR3SR+bK39tqb95yTZ4g9yT8LOU/gvHlFDnA3kbdSFhQDI3J
         Tab5tXgS2RGU8yAEMK73OTjigmHAYKxVZS6S+z7QRmhhsknaD4yPnXaFP+Xvf6xdgAv6
         8MmOgQSNdRXvDOevYhzDd/jm6vVirdUK34htL9O+kf9r3jNK+ODBnrPaeHBj268RNPu4
         ddsw==
X-Forwarded-Encrypted: i=1; AHgh+RodItYifYpaW/LqgwIfgd2ucdkbZzR3IMgtDOhSjJ0sweb5Tw/VKnW+nTR5vGz4dXMAXRW2LL66pnNrtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdyhIBpE9tVOqQXxJZRg6JV3/GMchoANyi1Q/YBMjFzin4xAH
	y1dF22toOEewtsy4k0t7Tey+5VhmJKdkvibKeZBG5gst/h1ZdNx3NR6zaMFxStCM5g==
X-Gm-Gg: AfdE7ck0PZYDtVWY47C4wTO604yGC4AsI2KMQKwAmyfnv2X3A92kE1Re/re8eAHx5ql
	HArXvX2TOe45a6fIHzTQp/NORzOsLfNqkAcUK1Sy9z/aiKHI/AzXCEExSw+0NdLVaF+UHV3CLxA
	rqOk8LoQrrLtRqsaULpqUKs4l4sYynleRqko5DgXXzY2oBRwcFLrZJQVC0PltRm505NwEWDyeDj
	LhUvu+mltSa/fVuG0HZBF7WD5Ff8mil4uiEAhDBSmeFy4EZSep5ZTeiSGujqcAEIVlO7gBd8LOu
	cxwT9f/1gtapIt9lGfwrNPsFplzJP8FRYCtQo2ERgaICD92b5lJyZn7g9vD2SNplpvbLaXyJQCm
	XyYkDIp1S0/W3sjHDWazVsbUeKvy3TtQNAejV0d43se4KM0y9AAF2M/HpBxvxPG3y1ca9LJuf+G
	65t6uC9WS/xOn7GxYL9JP9sJskPTk8m098b8l8UcLXkDjMN4dn5HbQjnE5MPA=
X-Received: by 2002:a17:902:d586:b0:2cc:df15:91f5 with SMTP id d9443c01a7336-2cf34a2a314mr196331925ad.44.1784620462223;
        Tue, 21 Jul 2026 00:54:22 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:21 -0700 (PDT)
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
Subject: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on successful probe in simple helper
Date: Tue, 21 Jul 2026 15:52:20 +0800
Message-ID: <20260721075226.2347933-7-wenst@chromium.org>
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

When a I2C component is found, it's device node is immediately enabled.
This triggers device creation and driver binding. The prober will hold
the regulator enable reference across this part. If the driver probes
synchronously, then it happens within this window. On the other hand,
if the driver probes asynchronously, there is high chance that it
happens after the prober's cleanup function was called, in which case
the regulator would have been disabled when the driver's probe function
is called. This would then require the driver to wait 100 ms for the
hardware to reinitialize, even if the probe function was just a split
second late and the regulator was disabled a few milliseconds ago.

Recently, some of the drivers for the component that are targeted by the
I2C OF component prober gained the ability to skip waiting for hardware
initialization if the regulator was left enabled. This happens when the
PMIC has them on by default, or if the component prober left them on
after probing the component.

Wait a bit of time before dropping the enable refcount on our end so
that the actual driver has the opportunity to catch and increase the
refcount on their end. The 100 ms delay was arbitrarily chosen.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/i2c/i2c-core-of-prober.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index f9f3c0ef93ff..68c929b16b06 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -235,11 +235,23 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
 	return 0;
 }
 
-static void i2c_of_probe_simple_disable_regulator(struct device *dev, struct i2c_of_probe_simple_ctx *ctx)
+static void i2c_of_probe_simple_disable_regulator(struct device *dev,
+						  struct i2c_of_probe_simple_ctx *ctx,
+						  bool defer_disable)
 {
 	if (!ctx->supply)
 		return;
 
+	/*
+	 * Wait a bit of time for async drivers to probe and increase the
+	 * regulator enable count. This allows the drivers to check and
+	 * skip waiting for re-initialization.
+	 */
+	if (defer_disable) {
+		dev_dbg(dev, "Deferring regulator disable\n");
+		msleep(100);
+	}
+
 	dev_dbg(dev, "Disabling regulator supply \"%s\"\n", ctx->opts->supply_name);
 
 	regulator_disable(ctx->supply);
@@ -356,7 +368,7 @@ int i2c_of_probe_simple_enable(struct device *dev, struct device_node *bus_node,
 	return 0;
 
 out_disable_regulator:
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, false);
 out_put_gpiod:
 	i2c_of_probe_simple_put_gpiod(ctx);
 out_put_supply:
@@ -401,7 +413,7 @@ void i2c_of_probe_simple_cleanup(struct device *dev, void *data)
 	i2c_of_probe_simple_disable_gpio(dev, ctx);
 	i2c_of_probe_simple_put_gpiod(ctx);
 
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, true);
 	i2c_of_probe_simple_put_supply(ctx);
 }
 EXPORT_SYMBOL_NS_GPL(i2c_of_probe_simple_cleanup, "I2C_OF_PROBER");
-- 
2.55.0.229.g6434b31f56-goog

