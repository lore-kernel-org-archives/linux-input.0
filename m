Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDA3CB8F0
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079782; cv=none; b=DlzB5Fb+Ds/9gs8Z62Ln7bDr4W4Pbyg2moAOlq6PQ3Z3KgmMmPiZ477Td/tsIVb+5bNMeGOO5hxpEHTJrQtjoCKa/Se1gP/YHahxJ/Xo7RmXZmrYWPND+ojZ7C65+zcpC5wBjoNV9meFjifjHk3FnQMhy9rwUQZflN3hLj6bMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079782; c=relaxed/simple;
	bh=3WB9kbXi8DyC6RwIxVdplZ8Uu2gMCJjc4fYI7bbEIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4MlnJUL4lSoPptpPFXlNk5eXIBOnU7U/flSpmf0P8asb6iccx8NbmlG/VBZB2GRsHxyIxqM6AopJTIbhGZub8JeBKZoPa9ihqOpzA1VCnRAprLMcxl/pAYwJc7bZX8p9AIRz6KpWP9reIu9Mztmdskn0ufhX/Lg+DuRz88Yy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ex8k8qtB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ex8k8qtB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-845eb7b96feso398231b3a.0
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783079781; x=1783684581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZuI6x0GxmbjrjyvyYJDyx48WMW5UeshcsiZCb+EBSg=;
        b=Ex8k8qtB0hQVtWNcMFxcxcC0olBLY33kVAxT2WEh9LpCGGZusORVfEsKnbhZ2vTv7A
         /zqKibvgFE7naCR/x8GulqYH+N8x8KcwCsm1KlWT53JUfuzRzzvP8gSyWn/RGzJqouqq
         pCaWvGA7VKLuOBMAvvH2H51dXPCo+McDzMFP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079781; x=1783684581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZuI6x0GxmbjrjyvyYJDyx48WMW5UeshcsiZCb+EBSg=;
        b=mmer3nI87LebCXKHmUMClQfoT8xPQ4fQiLD7NSfm+LVs2XBMcAKnf46UZ/+t67EKKA
         VNDv+aE+/tI131h857AQ0iTezwMjPmnp5Uy9YG8f5KAOT5S3dXvVacJ7Uizbv6nBdltR
         /v/xSobrtv2Ey5T4QXL+KQKpO1xczH6tLwvTYoPRqCBwhiFYioZTGN4RRLLWoAT4OoiG
         vcbwZciCxJHcg2Er0kf+zsAKjslIRlcquP3+drgY4pMUZLClWhyowTX9Lv6BAnvsMfRQ
         QySa9qoHURvQfSOJQhFxuTI713etsZC8NHRd20g7H/COcGmRDq/STpaE05IU7QkbvmLY
         IFeA==
X-Forwarded-Encrypted: i=1; AHgh+RpdBPUJM2Lwcjgek0taUq0NvM3mSSWDsU4XPetLtzhMtRSqf5o1jQEAuBD1xfEA7Wan5HssbsUEthI5tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxguJVV1gQMYEZ5Gh3fAeypc6kGDGexkVSPwctWKluA8dRovVQt
	/1QDvTCwjPY7dQKyQk2wZSpczM4F0CAs/BYTBfUlTu8rpNMoO34ukdVcbrmpMXG98w==
X-Gm-Gg: AfdE7cm+zOx2mr4CZOziysDBwpAWc8XlfZMyLdFB/ZUAbmJ9ziVmpnsC2Ptvw/HjX4V
	9+x3WNwSqdC8nftp/H3wWqOiYItd24jmOFgGd+M3hLpU23A+EUWiU3Z0oYiQbauoCehjGc6H8lQ
	/Bfco++pAxF9pzlfdh99z1PbL+fsCNloJrExx6hbsH7+ACmwIh+43viDWJklBZu3avqLQvn6e1p
	v+EsFiMH33kblx1VomVyDbI34Gl9a8alyahCuuOHbAuvOkiDs79FG00j5zSw/UYWG9jdT8NQVsF
	IP2S8GRaHAA2dAp47UpOGCHd0yueIXpwFcZfWSX+Pu2VPZqvrI38bHIwurw1q4duaYYEuqmE7m3
	lDPHmDBrAkqyXc3tqumB1y8yt1em68LkdnVsIpjpKe8Zwu33JJ0dxjfKenaZKVAq0uEZSBPPn2y
	rHPKNa9H02VYroBXLP5Y64xsN3EabMPpWRzn1cK+TRh5cH/l1Jfte+963ipjGz8yzbLRUkJQ==
X-Received: by 2002:a05:6a00:94c6:b0:847:902a:57c1 with SMTP id d2e1a72fcca58-847c0ab579bmr10089691b3a.57.1783079780697;
        Fri, 03 Jul 2026 04:56:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8bd30ca5sm2569540a12.0.2026.07.03.04.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:56:20 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
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
Subject: [PATCH v2 3/7] i2c: of-prober: skip post-power-on delay if already powered on
Date: Fri,  3 Jul 2026 19:55:56 +0800
Message-ID: <20260703115601.1323491-4-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703115601.1323491-1-wenst@chromium.org>
References: <20260703115601.1323491-1-wenst@chromium.org>
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

Instead, check if the regulator supplies are all enabled, and skip
the post-power-on delay if that is the case.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/i2c/i2c-core-of-prober.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-of-prober.c b/drivers/i2c/i2c-core-of-prober.c
index 6a82b03809d4..f274e260353c 100644
--- a/drivers/i2c/i2c-core-of-prober.c
+++ b/drivers/i2c/i2c-core-of-prober.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
+#include <linux/string_choices.h>
 
 /*
  * Some devices, such as Google Hana Chromebooks, are produced by multiple
@@ -219,19 +220,25 @@ static void i2c_of_probe_simple_put_supply(struct i2c_of_probe_simple_ctx *ctx)
 
 static int i2c_of_probe_simple_enable_regulator(struct device *dev, struct i2c_of_probe_simple_ctx *ctx)
 {
+	bool supply_was_on;
 	int ret;
 
 	if (!ctx->supply)
 		return 0;
 
-	dev_dbg(dev, "Enabling regulator supply \"%s\"\n", ctx->opts->supply_name);
+	supply_was_on = regulator_is_enabled(ctx->supply);
+
+	dev_dbg(dev, "Enabling regulator supply \"%s\" (was %s)\n", ctx->opts->supply_name,
+		str_on_off(supply_was_on));
 
 	ret = regulator_enable(ctx->supply);
 	if (ret)
 		return ret;
 
-	if (ctx->opts->post_power_on_delay_ms)
+	if (!supply_was_on && ctx->opts->post_power_on_delay_ms) {
+		dev_dbg(dev, "Waiting after enabling regulator\n");
 		msleep(ctx->opts->post_power_on_delay_ms);
+	}
 
 	return 0;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

