Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D23A6B82
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632431; cv=none; b=OCy+rOIfrZ11J3vMRQReS0J/2BLYf/yI5TyVleQy7Vlc3rD2dHF2gnr1mhhYkFekjWIl14+eF+RfD7TcB6ZXsqwZdWUSLeFvG4lwCYsAwAkZEmwEdD6/8PzwKV1bF1+Plq4B3ABnuHxLQ4ykK62pxEOvQ39n5CeeFQob0iolFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632431; c=relaxed/simple;
	bh=hcSfq4drLww4pOwuoR8efBtvnetanTEdlwrBXzAG9GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO4PGHaj0pdO6t9cfeckD/nPeTHc5VaDWi0MGnXczPbpUAMcyNWfXiLEivFbGTObDb7mc2L6BS2wAdOzAetpiYvI5WD+734grNjKofyzC5zv6BNgRDM7kJkZkjZ/2CHqUMZqFgjFjPwjxWN5xUeP4ZLNZYpridWmx+8q3W+4WIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=chhT4fmk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="chhT4fmk"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3649177a12.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 21:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787632430; x=1788237230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oxe4lxlNlfZyQDAPdCLYOQIha/yPu61CBjEM7zjIg/A=;
        b=chhT4fmkfKiupvyAt+5miI+Iv7pO3DyEyfsZfP49l0BVEF2YEGiAQ5Wjjmcs7/uSNx
         +OCFN9wBJtGBTIt1sx8SwZYqbI5zrlC5l+zZnLS6BIq0sK6WWtbRcoZYm+SFUfip8mz5
         yLD38I3l+3y6W7KSBhjb+sEsXiUFRBatqHmBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632430; x=1788237230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oxe4lxlNlfZyQDAPdCLYOQIha/yPu61CBjEM7zjIg/A=;
        b=S07wFdVo3+2rjjSOcrAkNkL9TPH6mGGJNEvFsj6u/NOZN6xlMiTd4e0jnmVa9X/VRm
         RwMlazLZAHcJT07cwRizvXg3+vRoHbl+Trf+qR5GUl59mTNtMHLr0ouvCzloLs2vaLOF
         MBiBP3D5n1wwCq6A+zL46lfE/tkq2e2hfMJ/va1l8upqAIxbUQ2TpV4p5FGdSy1xavQ9
         DbLPH2gMGYLF5RXVQNOl1WU5SheSSLEw7uXv8j8eO3zZjhuC0rU0dhWvREsCY9aYiEqn
         fO2XCXqVMvDNYAiMv6INqOE1qvkv49dUBqdTZjvbeYJHR6eWHX3zv2ANK65IOkO3TKLg
         lHaA==
X-Forwarded-Encrypted: i=1; AHgh+RpmxM2HhE3A+7mfwmZzKyqcCdenWtoRvZQMis7Cgg6YYFOD9sHGZerqg8WNcBrmGlF+R1cuaBO4XjQ9Kg==@vger.kernel.org
X-Gm-Message-State: AFuF++nwOU281pHhPV5abe8/cNmkoFYoWs9Iqg+heqS/xyr+ZxacqjbY
	7QQt9mHiClJeIwJYnKVx0ixFIwmgyGeuKg/gLfUIcqhxZ4tPBdKPexszP6Qzof08Rg==
X-Gm-Gg: AR+sD12TJhMlS6NklZxJO1HvJJj/D971Lj/j/9gHTMe7fSh4Of+lm5IseJVwtnVb/cE
	3LpGE29IgWSK4f4VIdiGKsHW29D+XthTugUFfSwaFZdId9SNary0fNvILpi1xEi6tVFZYXTtj+i
	q0B/W1T26MlNyqUhAw9Tb19v9yMvVZM452oYiSgyY9vWoVyt2vb5GWf3WmsHT2wN4XAhc/1kixx
	pjR5HTE+8yU3u1dJqrPWnT6jtKbAJBfm2nLbDVpYrO13fFrWQcli4wCBaxU3ULFYCZc407g0/SO
	7CBhzUVwp7ydb4AuCB6AtLB6gFpcXlp5OAEJkFNXCyzgZ9J5MKYWo6R4yRX0ZMtPw4XBxNWZKds
	wqUgh4SgtCynaRHReidUq7UlZI7N9j2DD2oDUHR0Y5ZZqQxBKFndYda0kFEEXGKPg7lUdRJcnX+
	53snvBjlXoOz9W9vBuLUxh6oRyyOfOAYOs3iW3GjrnaIqfao9b70NrHCnnPilQyRrgHEtGaApsI
	Sw7iHpWCethukkH8pw+Y/TInsrHUiJYsY1OluI9srWLnj0=
X-Received: by 2002:a17:90b:280a:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-395dee56103mr48478004a91.1.1787632429764;
        Mon, 24 Aug 2026 21:33:49 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:a442:9780:24da:cb4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396458212absm2187823a91.0.2026.08.24.21.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:33:49 -0700 (PDT)
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
Subject: [PATCH v5 5/7] i2c: of-prober: Defer regulator_disable() on successful probe in simple helper
Date: Tue, 25 Aug 2026 12:16:23 +0800
Message-ID: <20260825041628.988369-6-wenst@chromium.org>
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

Tests on the Hana Chromebook showed that if the prober and trackpad
drivers are both builtin, then the time between the prober enabling the
device node and the trackpad driver asynchronously probing is between
5 ms and 30 ms, though sometimes there are outliers exceeding 100 ms.

Wait 100 ms before dropping the enable refcount on our end so that the
actual driver has the opportunity to catch and increase the refcount on
their end.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Added commit message section showing average delay needed
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
2.55.0.860.g4b6b3295ed-goog

