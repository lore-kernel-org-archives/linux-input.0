Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573643784E
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620457; cv=none; b=aVS5/i/rHKHaT/ANsA9S6CLGDuC9MQPsz8Yyto9y9uK/RClUNt+p3wwS9vnQlp3vMtXhNyhAtH+/tXETXaTDXn8jvW3D4Ui9pAePWcax/ReWKzfv3zbltPUxtL2lrk8SDmQvatf6Lw2yRjQSOcaTOhjVKYJUMDSvDnX5tAPauyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620457; c=relaxed/simple;
	bh=J3v6D8PZoDet97Lhy7NyAMAWEZCEiDewv+amHOXW9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3Pf+1xUTCIMAvgdw9NNzc9MyZFWzaOU7dNEq3GCBKOtrojueq9c0MemnsVdYZxQrR79omQnhuBZ6laHd6qVKuSnr/ju1AKIOrAEtvw+4MUeLJHXXejwLhv8hrxBXZgbh2oIgv6S9wMYQcylqfG3m3uro1BePClqVun2e+X8yNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SUL68HRM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SUL68HRM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so69421765ad.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620455; x=1785225255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNKmqRLcn9Q9wFj4nPUvbsCt3JMsfIzkeIOJzLyzvCI=;
        b=SUL68HRM9N0nP1WKCb2UCBU8WNS8USD3r8qKfWisijf75G1XTCZgftHcPQTJkbiaOi
         KywUj8Ubf2/3s0WCHC/onG25jsQ61Uxvs260icpkH8xUwKTGCAisqdt+9WjAdB+kok41
         mSEp6ThAF7DhAjk5ptWS/nBFFrLg28DnFvlcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620455; x=1785225255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNKmqRLcn9Q9wFj4nPUvbsCt3JMsfIzkeIOJzLyzvCI=;
        b=hq0sI1XWiN4cTFj+ByHOGOkJjoxI7kv6kfNPHAA/5zERylmD/rPS5gq0VCDyLFGJKV
         oyS2rlbfnfAV0bmvgZokpp3sYrBycmIdwHG9CV06QWxFyBuOGROX8h71BtOhYFRFksAX
         JQlZRAAUbLTBuidPi4p4vmy+Crx5ONcJ/YVBBLt3jk3sR3KiMwI3+gpuGadilJwSNp2I
         RRttjSIIQT13SFJEd/+ApFwsUYYonPnmiFkYb1rvABK+QMF5nqxySvv7+axSNdEVEZN5
         Zg0CtpYhpv8sh8d1UjdRoEk33767dH6X32O3iMwbpoJqYKuSdgJ8onivLLpC1lX18tBo
         oRiA==
X-Forwarded-Encrypted: i=1; AHgh+RqGsc3m3T9+hTejg6s/Iec1DB+v5VQVogqXRWNkpXDLHDe0YQQAe0dBrvdXLAQZ3FN4rHNf8W/K2kdjjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx930VN6Z18n++TYAP8vp0SZ0/WZkuGm5GksDcqZwQaNFmd5d2B
	U8cXWAvsZL/ENlo1aZHACE4amfsZcdgDu2a9GEMCNi3lY6PNS9OeEPJQXPTSxRu2vA==
X-Gm-Gg: AR+sD12/uuX8RL4p7SvDK8owTYonDxPNw/5Q7X8/WYvyJ5SSNsqhz/rqi1efRKSJdAO
	eggDxI+BatEp6GlHdZcAAgys/7QU3AsYxpz+8xpBqMOfFbtAdyLXPfTuZiM/POZFhncvXOsymmv
	71OBrvU3Lq0XfOxBr6HaVrorQDaVFWK9qoJB9xR01c2NfRi4uGKykJh21+3IUIUh4QIdjsPEP8i
	e/FjivFzFMa1MqdEgYiFrJkTODhVNPahWliN8CsFt0wmwu6LMQblRX8u5VcrcZGtDQMO7R4MOhv
	48Xm9CnJ2ovXwBXqlUawi7AA5RX25YHIUfbf1BaRR54UlmTGLTrpBzpYRVIVz2tRpTqaxCVqT/F
	gXINhJXFWA7n5YdyhgLsejKihNLpw5EUJ9BiyiHN51caStUIXKG4hR8ec3AF41Z446z3BfF7u8c
	3+WbJHzkXnAk48SB8sJfNu7xCrP6MTmTguZqhOR3k8jsS2CpI9VtDUwgp+GzeO8OWWkH1h5A==
X-Received: by 2002:a17:903:2f84:b0:2c6:a012:6241 with SMTP id d9443c01a7336-2cf34850f28mr198999395ad.6.1784620455632;
        Tue, 21 Jul 2026 00:54:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:15 -0700 (PDT)
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
Subject: [PATCH v3 4/9] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue, 21 Jul 2026 15:52:18 +0800
Message-ID: <20260721075226.2347933-5-wenst@chromium.org>
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

On some devices the HID device is powered from an always-on power rail,
or the power rail has been left on by either POR defaults or the
bootloader. By the time the driver probes, the device most certainly
has finished initializing. There is no need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree. This is undesired, as the device tree is not fully describing
the hardware.

Switch to the new regulator_bulk_enable_and_wait() function that makes
sure a certain amount of time has passed since the regulator supplies
were actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_bulk_enable_and_wait() API
---
 drivers/hid/i2c-hid/i2c-hid-of.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 59393d71ddb9..fdaad451e710 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 
 #include "i2c-hid.h"
 
@@ -48,16 +49,14 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
 	struct device *dev = &ihid_of->client->dev;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
-				    ihid_of->supplies);
+	ret = regulator_bulk_enable_and_wait(ARRAY_SIZE(ihid_of->supplies),
+					     ihid_of->supplies,
+					     ihid_of->post_power_delay_ms * USEC_PER_MSEC);
 	if (ret) {
 		dev_warn(dev, "Failed to enable supplies: %d\n", ret);
 		return ret;
 	}
 
-	if (ihid_of->post_power_delay_ms)
-		msleep(ihid_of->post_power_delay_ms);
-
 	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);
 	if (ihid_of->post_reset_delay_ms)
 		msleep(ihid_of->post_reset_delay_ms);
-- 
2.55.0.229.g6434b31f56-goog

