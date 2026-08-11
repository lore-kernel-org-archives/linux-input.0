Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2A4446E9
	for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450859; cv=none; b=IBeJL+4ueP2gVy924Tz8iDAojgroCBqaX9t/Cu22Zx5he7WdKw3H9037wCO40xvIoIebZ/yxq29pTLPT0OTE976bcyMYdUf2JbXKxHXi/ktAT1ZB58Y9waucvLoLeYGB0Qf6gPopBcJTiMrUEaUROykRTMjcD7Py6JufMA/+eC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450859; c=relaxed/simple;
	bh=eYYAZt1D/azsw9KiyzJSs5x1E12lPK58GJkuELjCTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEX3WP3duo1znpIz6v8jDACP9C8miINADVKvn3qCV7W9XfMFOMIol28bEHJPI/ku56M195inXY1msZnB1g6rlxC+CUnrAwPRK1E+txfdJngzTzfpjp0Yat3LHgFmsvBuJ6Qa8exEID55wg9p9+2tT65mw70eevP5KUE8HpaJ7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UmD2gsVl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UmD2gsVl"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485b358552so469790b3a.2
        for <linux-input@vger.kernel.org>; Tue, 11 Aug 2026 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786450857; x=1787055657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W0rjMz7r89FDG00LgKpSG7rJxKNH2nfPyMU32ONUt3s=;
        b=UmD2gsVlUCkjjjCgEhB1BENgxroVNIETQZHZCmnABrHU5UOkWXXEsRTLE2H6VlqswC
         Jwd9uk4puvmNyLdAv/+kOFXYWMaMEzwZVN8nDqoxsHFx15ilzAGsGF8XINHTtjhKO5av
         hQCaIKiV3T+hipr5e16zLCF9RhDKedg4OQyG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450857; x=1787055657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W0rjMz7r89FDG00LgKpSG7rJxKNH2nfPyMU32ONUt3s=;
        b=Lk/ZCd4dsfjcE7oIIQeiG6YzIpWdlYdgyjqGXeEjVThswZSUeG0Fxwjxr/wdFVeS3U
         xrkXiyR4/+C6C2EDiWFE2r8Z5JzojbsYDCWkOzw+OVGmiksUpUYt9uQxQxTJ+WxNCkiw
         K4xw60ElUI/u2vWjais2sy0/5oK4UA//f35GIt5sX+NsyRwDL84SMnXelwg+7tKU1iEr
         BI8cUGOvcYE7fCP90Wz5Rljg84Qsr5ga/VGsspa9SHir6JDGxfsyLK+6snf/MBmhR+O1
         IJPuEpFaOrZuAowA1roBt5Fx6c3sKnrugt0/pxpzccLB75h05EEoZr8vW1zeG2VdoIcx
         pP2Q==
X-Forwarded-Encrypted: i=1; AHgh+RooBclgDIxga6zq0G/qIN6DZtESrqpTNnxwm8MFJlAnFrbLShHvF+4I+ekpNI7UZu8iPcSyGewvj8SkDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcTkivloXOFjrVekkEcXwz/6vHDVcmKx416tKvaKF5tplaeXT
	/NLw4KQDZvM0lBDLCVplaUSXkcTfXJZLimitlwGVsBlJm5K8hkBa0H7VsTxncxT5zyMUZccA5nk
	llDnZoA==
X-Gm-Gg: AR+sD108qugmByZJzibOGmptjRkZTCBosCSZO+YKTvp2a1DE9CJ0qON0uOrg1bIx2qp
	Rc/v15nTXX9sABTYR+K8QjQxTde5CYG3RqDtrsFdtytOUURtEz8cADBd+VUxv+lHwYJnYYBGSZd
	AAuiId2hsjV1i6P94ftwNMLthf+UEUqP2mt6aEhdAVXxUP4D3cq6SZMVwk+VZUfDPl8Gw1iWM8m
	cdiOvtFQcJ3yJ4/BDzWiXDdxtg2yLZKPFo9WWBbDBTqcnj1gtjLJNPHJZrnn0DlO/WBtGHiTGVT
	+TOii/8Ebuc5AH9cyj61B+ctSy8dc7iBi0Op10eEQ9mKeFDHAsFq2++IoB64B9+pBnelhzLdvVi
	QuDEfEsAfd5V065vny6AmTIbsNLBBEamI0GovRIBHV9ZP8VB2bRHtU2xmRxNK/r3SknlFppCWtv
	90LH+24Z3+FNUy/aBtLgL948YMY0rNikGoplEZDOAQjRoPGl4vJtJz5caBQhDWZHdYcfaPC0QWB
	O9hQAa/D7BIBjAg1E+aQgeC3wDMgPNSx2eetho3lG/vkQ==
X-Received: by 2002:a05:6a00:32c3:b0:845:40d1:87fa with SMTP id d2e1a72fcca58-84fa873632emr3028343b3a.25.1786450856753;
        Tue, 11 Aug 2026 05:20:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:12e1:df26:6add:1ea7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa9574e9dsm662454b3a.54.2026.08.11.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:20:54 -0700 (PDT)
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
Subject: [PATCH v4 5/9] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue, 11 Aug 2026 20:20:05 +0800
Message-ID: <20260811122011.3539250-6-wenst@chromium.org>
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

On some devices the I2C component is powered from an always-on power
rail, or the power rail has been left on by either POR defaults or
the bootloader. By the time the prober probes the device, the device
most certainly has finished initializing and can respond. There is no
need for the delay.

In such designs, the system integrators tend to work around the delay
to avoid the boot time penalty by simply omitting it from the device
tree and the component prober. This is undesired, as the device tree
is not fully describing the hardware.

Switch to the new regulator_enable_and_wait() function that makes sure
a certain amount of time has passed since the regulator supply was
actually enabled.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to new regulator_enable_and_wait() API
---
 drivers/i2c/i2c-core-of-prober.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 6a82b03809d4..f9f3c0ef93ff 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/time.h>
 
 /*
  * Some devices, such as Google Hana Chromebooks, are produced by multiple
@@ -226,13 +227,11 @@ static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_o
 
 	dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->supply_name);
 
-	ret = regulator_enable(ctx->supply);
+	ret = regulator_enable_and_wait(ctx->supply,
+					ctx->opts->post_power_on_delay_ms * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 
-	if (ctx->opts->post_power_on_delay_ms)
-		msleep(ctx->opts->post_power_on_delay_ms);
-
 	return 0;
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

