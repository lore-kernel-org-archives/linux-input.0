Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBE47124F
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249014; cv=none; b=jAKVmAXcaZ3LMtcNTYeaCY+sPlCeZFdZEH6tvnaFPEqKk59xHbKfZzmONSVicLyvo/GPig0eY9b6jGOCEMW3GzR4ill9Jwk25Cy3U7eSvsehHILrE0YTWT6bUjMTqyYRQj4jMgL24bF82BFNVG9xxGp/yXg+eZxJkK6nvEjxgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249014; c=relaxed/simple;
	bh=pi+LmqXIY9yJrLb+q4YTgitdGHvgUDFnXpm0aWGBEfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTvifK+9+iwd/awqZmXI2b7zXfV7AE9fWjDS7f3PnO5SCxKAxyRa/xe+9cMUGrpF9Dvlzfrb2qZQ37BWulK7a+pOK/xbLw/vpDkJ4mZfo0x5PXpfjvSzcM/QxfwFFBfW5Ug5OzU/+6HNZN/E5jWzuVhUGTY9ubY8BO8LAS06v2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KHtxbtec; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KHtxbtec"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf452def93so6884125ad.1
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788249012; x=1788853812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWs+YupxZ44ht1HfvkGhk8oEQeiiBAO5zBbFEZpHIfw=;
        b=KHtxbtecrHGyH+XwE+ribIyy5vwWhnwwS4g1x+nyBhn6vn76S1VBsV/WYVT6tXK9xS
         zPNOWw0nbXgkVF+PTMzKdDHISatwhwCY+Fnt5ermYtlHvSz5pYj9jRioCal1K2RrkU+o
         PDPR4xW2b+5vux1dCjEDPGy1oR4w4hvmQUOHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249012; x=1788853812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWs+YupxZ44ht1HfvkGhk8oEQeiiBAO5zBbFEZpHIfw=;
        b=sPAMauM0y6z8mBMhJwq56TN+cclTm1ywzEkpsJde1rbULEqBr8E+gIYLdsGS7FLF8a
         QNZE0PieYih922D8VdPqIx07AgnsGgC/ppemqht4HU84NPHXmvbFxJ0YG713raaWEoYY
         G5xoQn28RCSZX+hCHF4nAgyluz66HzEOd76Cq1VNudHr8BgdgqAykBJWPqEw7m+g2d+f
         ywX6WSWr3xCFbhdIlA31yjWSyhpelVlOMCk1wc+soYSWDj3fl4yq9yqy9lfF7gyMFttQ
         O7LHR74xH74ei1dCzec5BSiS9MlplUM5mwFxo/xFxbN5r0qRtANxP3HHcsGFaYFVPkw/
         cVzg==
X-Forwarded-Encrypted: i=1; AKwUvBzSIFJ3WsCqiKj8SJdngIdfqU+RIDUGTUrXPau8d0tvTf2tbWTgXv+dAigCpiIa+lfuxc/1e8uimqnbVg==@vger.kernel.org
X-Gm-Message-State: AFuF++mmHMpYjVF8+CsLG9SjD2p+1up9W3dUr7Z7ndiIq5vEfR92Tsrb
	jLLBYHnf1B49ZNlvFALXJyONqsz3Xr0+j/fZCaaIqsgufrGRjUpZYzHhXSM0knWNmw==
X-Gm-Gg: AYBFou0foqVAMvaoGnxumPVEGpjkFiFC2ctDNBKpOGz+x+T70BOeWKOD7z8QMCR2aB1
	RA5hsVRgg+4PbFf3dG6n4EpO9gghgFF0Kx7xiMaErS0kyrMhbducZ5Wj/xXhUqCBGqktGl1+FFR
	O9py+eAqqZTFFjRaPIdQzC5aASuWr3WjBISWmUOKLzOpHyT+wbXv0BsFs/AV2mI0lkDdqVWRYE7
	0gzDNdIMMY9JhZCM5MUmQnMJsxvGh7BjbIyfpwflSri8QSV0nL67PJ01UOEQDP3PMfW2owwFr2k
	C+r0wVfFlCOLFrF8HmOy/Ydi2wC+qy3O+LKYLPbNlrV0c3gqClNJrBKJgJ9BVGUzj+ss9GzDJWe
	c+qizL2tE6EzVwCYW8Ip3vplegQg8XCILcedchBuvNxdrCjWfPNa4AUziaSRx6uGB4bvb9xnlO5
	HAqEgZbDmmCOD1ygaPR2w22HIEj2NjpkJXrMmgEL9lZBmWLWX6vghewte4AFePof5gbz6Br5Asq
	Wy/5dGTsY0MTCDyP2HZ01ykHvhM9vkhANcFOLzCVmwl/Q==
X-Received: by 2002:a17:902:e747:b0:2d7:1b20:e98f with SMTP id d9443c01a7336-2d952687ef9mr35651975ad.2.1788249012058;
        Tue, 01 Sep 2026 00:50:12 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:50:11 -0700 (PDT)
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
Subject: [PATCH v6 6/8] i2c: of-prober: Defer regulator_disable() on successful probe in simple helper
Date: Tue,  1 Sep 2026 15:49:24 +0800
Message-ID: <20260901074930.764550-7-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260901074930.764550-1-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
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
Changes since v5:
- Only defer regulator disable if a device was found
Changes since v3:
- Added commit message section showing average delay needed
---
 drivers/i2c/i2c-core-of-prober.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 97ef58bb4c04..f52ab3f54933 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -238,11 +238,23 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
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
@@ -359,7 +371,7 @@ int i2c_of_probe_simple_enable(struct device *dev, struct device_node *bus_node,
 	return 0;
 
 out_disable_regulator:
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	i2c_of_probe_simple_disable_regulator(dev, ctx, false);
 out_put_gpiod:
 	i2c_of_probe_simple_put_gpiod(ctx);
 out_put_supply:
@@ -405,7 +417,8 @@ void i2c_of_probe_simple_cleanup(struct device *dev, void *data, bool device_ena
 	i2c_of_probe_simple_disable_gpio(dev, ctx);
 	i2c_of_probe_simple_put_gpiod(ctx);
 
-	i2c_of_probe_simple_disable_regulator(dev, ctx);
+	/* defer regulator disable if another device driver could enable it in time */
+	i2c_of_probe_simple_disable_regulator(dev, ctx, device_enabled);
 	i2c_of_probe_simple_put_supply(ctx);
 }
 EXPORT_SYMBOL_NS_GPL(i2c_of_probe_simple_cleanup, "I2C_OF_PROBER");
-- 
2.55.0.897.gb25b4bd76c-goog

