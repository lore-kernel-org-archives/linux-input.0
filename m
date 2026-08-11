Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C10443E31
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450849; cv=none; b=KbzAfxIst95kjoHgNt8n8n1JUYyikkWUuVMr0FwbCdqhziWJFGmFHwkyLMq9j2sRTy8mcHF8X4nH+cjwb83eSw/pGWuDG0il5rQQzG67G7Pwh9VlOzXOjWvg9HWrq4HEhdj/rno1++7/u7KuxRpY1NahHXxjxkxsL1gXpU4qqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450849; c=relaxed/simple;
	bh=tRbezXAeChB8yAzXWfWX++wNhT7E8rc/SaVPrOaXwTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqOTaeLmhVpPr2cwHod7lFMdR3/Mw0eMOIvh3lMMw1+6+ImgbsjFe+egbp2coLDjBEFa3+UBjMon+DiaNOkmJN0tndI8Gi8zZ8CPfgDtl/M+T9WjgDZdTFltX1NcnnBxZWR+b1mLgfn1ZmAdnDF3f6DuRAsTgQolf8rWyFoSFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aZmPNv/G; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZmPNv/G"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2016564a12.0
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450847; x=1787055647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AY/BjzRkfyU3t+6SOkz7/qVT24RkrhiWULr6d4aAG4=;
        b=aZmPNv/GVfjxDsuhWeYDuLKUHF8RfT5JCKCH0p672sSfhGIbmJyRW3Nj3UmXSKpx/m
         x5SuCNltcX+X34uuN8G5naUmrmOnQzCbdjY/ViOk7n+1mSKZNRPkei6HweBZhdf+ITwQ
         2uqUDk4ebtQPWoP5ZRxj/OZtVZduL5yI9Hhg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450847; x=1787055647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7AY/BjzRkfyU3t+6SOkz7/qVT24RkrhiWULr6d4aAG4=;
        b=APZxLSVGqqzd+/iR4NThuJwWaQ1O3gO5iBMTj9NH730bvXCL91U6JpY050xC/1o0iK
         G6zR7L7QAyOZ7hNGaWhtERIAUyzRA6qva1F0dVEa0dyS2ZU3XB6tfiYVkIJzh4ooH+p7
         qVSF+ogMbuknC+0jbnRuIeLYmjMaDnTw0ysWJ1Hmg1ten7HoFsaMTKFZMK3ivyMcbMqc
         P5wzPF5mxRhvjLYAUYwh4HLNS6Fq4q6AuaOMu7/ZBbTxjDIShlcjtgQGzGbstxgnGesl
         7rsbILpYSyOAGF4RzV5bs3bxztHpZA+SBQ7HPQH94x+JhUGGfYWg3J25YYIGm51Jyiuo
         BwxQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro8JVHboim3AAdusLpKK3H+mwFC+NrJvF3DL8zYAkMnWpP5ROiM7faql2/t2hxOd0g6ci3wAEwAyWAj1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kw21rGxh5K6OaTGUO3DHrAVBc4cLboSBrlFMwssJv4uIlNIb
	3ZP4YD0ZlIWE69THZXmjSKCDQbzFU+S4bo5xvDFtR0ciLIw45PdvK+AzqDMVBgxueA==
X-Gm-Gg: AR+sD10CiSqJbZmqo9xXiTVYvr8xNKt8mRYANqNMEI82/ZcXlUI9jDOzl/Il+pKW+Bc
	MVvQ9yr2ZpkbRmMcZNMo2ih0MxIBhxRHDhyIEosC1yLyImTcXgVYBN0a+Ajy1wdADKeafjhxtut
	vkB276liCB+Ise0zs4d4Yv35qtGd4bhqqIkA4UHA64BxBmoL2VwZHbwcWIAN7j43Ib7zhRKC/eU
	39SCJdFi+3WlGq//ceBTEZVozmS2S6wZQ9H8vSxYmnfztFd7TFD9ouVzpdJfSAGXzizvYREuyNH
	kj4qHwYRM8ZE77g72j0B7tyczM90f/eM67/by61KCmNT0eyYdR44fA14Q3GzFh1ab3WcUDdQe9N
	VVuX3Ip3OkpaKDBhAUbEMsX+0ez/k7JKKwDss8vPISc5Do/+XKWl7l3aMFbj0liYi4Ji8iYhI8d
	HlFGDRPQ0gTBTvj42MUDA9EhFZAKvxXQZ0fgY9BwgQ9R/qoA27G6icmPzuIKd7zfE8LATXmT4z7
	aF5Jr66Gdc9Lf45THWpjVaTsYYUvH8/8xiDNNk90XsAKw==
X-Received: by 2002:a05:6a00:6ca1:b0:84e:89a:b8ec with SMTP id d2e1a72fcca58-84fa86ab177mr2896532b3a.11.1786450847047;
        Tue, 11 Aug 2026 05:20:47 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:45 -0700 (PDT)
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
Subject: [PATCH v4 3/9] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Tue, 11 Aug 2026 20:20:03 +0800
Message-ID: <20260811122011.3539250-4-wenst@chromium.org>
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

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Switch to the new regulator_enable_and_wait(). This makes sure that
enough time has passed since the regulator was first enabled, satisfying
the power sequencing delay requirement. This allows the delay to be
skipped if the regulator supply was already enabled by some other part
of the kernel, such as the I2C OF component prober.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Link: https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_enable_and_wait() API

Changes since v1:
- Delay only if the regulator was previously disabled / turned off
- Link to v1
  https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
---
 drivers/input/mouse/elan_i2c_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 9f024a435dbf..77885930bf9e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/time.h>
 #include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
@@ -47,6 +48,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY_US	(110 * USEC_PER_MSEC)
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1250,7 +1253,7 @@ static int elan_probe(struct i2c_client *client)
 	if (IS_ERR(data->vcc))
 		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' regulator\n");
 
-	error = regulator_enable(data->vcc);
+	error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -1406,7 +1409,7 @@ static int elan_resume(struct device *dev)
 	int error;
 
 	if (!device_may_wakeup(dev)) {
-		error = regulator_enable(data->vcc);
+		error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 		if (error) {
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
-- 
2.55.0.679.g6767b8d81c-goog

