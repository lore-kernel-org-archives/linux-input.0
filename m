Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620E3A785A
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632428; cv=none; b=FriSEqiCX2O+rvJExqLwQVE5zoVUT3CVGz2HHBYozJYNeju5ohcfOp4yG4PWYWlAnD+cf29o6hOpxb+QABMkfGgpO2qxOI65Yo1XIxyDkx2Ls59LBJsPOBSt5ADBkKM2q4P7KNDT1glCsQ8dZlfNoGaPGNgydTbOjeK666LtWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632428; c=relaxed/simple;
	bh=RLvkM8rAzL3RhKW8i1oL2AWPBIGjPlkazQkJ9ggYoGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6BvCSxX1TiL8RIu8muSJ8mgM7DHAT3GqxnCtvFY01sABBj0QgfBPfViGaPBsXhVMzOjYsv05ffQz8HZ9S+lUOy4TMmOtjOvkbGzZV7wSXZjrBMkSYQ8nM1Ob8YYD0IEMH8m6f+a+Jcv4uS16XPXrv22pYPY740tilYKQ70JAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nckBrc4R; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nckBrc4R"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so3110627a12.2
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 21:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787632426; x=1788237226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwfUQZyxeQn6CZecIrqNJeI2DT4d3jBF64B9NW5XMEM=;
        b=nckBrc4Rqk6p2KSHLYVlCfj524jyUNtTthzfSHPiKEznsc4le02TxNdlM4k9Ib4867
         ge4Nj30U5tNOVz4j+2Lh0fo3lDfs+3uHy2oI+RTIiC3JpZizx8x/namANmy5ka/+Z5RS
         bGWGgg/+Aocacvev/t+oJqQ4i1C5HUXB8XKm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787632426; x=1788237226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mwfUQZyxeQn6CZecIrqNJeI2DT4d3jBF64B9NW5XMEM=;
        b=fQGmL4SHb/xNLfX2xmphrfTmDSg3psZyyf5OBOSDrI8ZlKEoqncbz9O/rEZXC4MRhf
         fonbxm4kVF9d1yakhzPA8WSsWjN2FxzqOQGy4OX6HCkyiY3GOCZqsu8+kXndLxTBifdB
         lW/o8l6o/bSjxrm0y18YxAHmPpaZOzwcnLHmKocMiNzfMURXD9tYHmMeA8iZjs5YACHf
         kbkCdUm35UM31tPCMjG0lPzw2LV0Y9o+T7DaDuFMpp+YIQiGY50dRfDbJNRgAEYDmwDP
         ZmWn6VgHWKLosZN5qfSVSNAdE+irQfREbHBapaYCXnFHAjL/BxfHrfEfH4keBsouMF2r
         iEAg==
X-Forwarded-Encrypted: i=1; AHgh+RpVKpZdHgXylsY5qb4TBIz1+2+h2vWMwnUeONqHFxQcHM9fM8lt6GNqhlUI0eDH5qSNSXXIToXXhSoQ+A==@vger.kernel.org
X-Gm-Message-State: AFuF++m7BbQkYy9JJdhfykxbp+T/tt6FGHJn01LVI9WeuVJY3QbI39nM
	aEsk0OBHyA7pfi1vT/xoRs3xv/pmkzFOwYn6g4sgiK9VDhnAFthzOIk7Yqk5QndeFw==
X-Gm-Gg: AR+sD13j8QSZUDKOwCqa3ZavvKWrPc4rvB+1ldVEW1diwoDSRyXqqcPMGCrnwSUgNNz
	bf/UTqHWcJcKIJTvREgvbcWa4FxN68+YmKDtsGowoTloV+Q4N0Cpkcp9tkGGnYma/5tDfNrzVoI
	t87IZO3ZTdcOjTlmNIs1hqPm7vpkiTDXZeKbbt6B4kOnIiub6dTof4upBsSBnSJSomypB7Oryub
	GVYxg+pNps57ATnu/hUky+T7wIeHAPzp0/DW77k3kJBlA8VkQIpoXowXAS0AfT1enWvDlWukzFt
	T/QMt0vFUe8N+s/103QSotz+lg0/YnwuXlbDSSy807AqP7ctLd05wOVHYmsowPzzInDLW1Nnhpq
	LAxx2aCHkjiDKTQS/5TRn/uktuOfgavJ98t/oBPWjtwsMF8aAOEnuFO6SlyefFXezVumhnUrtn/
	u5LYuSUkeb9pBAowpR5v8ksCmh5bWIOvBjQ+MPE7B55E8vN9FLXebnthWwC6D2DNxiBEWtsvZMM
	itgyBcSSCI24GtTZ2fvRpwADGNdz6skqkQMvKVmFe5jQ8eZ332Cie4qeA==
X-Received: by 2002:a17:90b:2e4b:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-396464a18c5mr7911836a91.10.1787632425871;
        Mon, 24 Aug 2026 21:33:45 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:a442:9780:24da:cb4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396458212absm2187823a91.0.2026.08.24.21.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:33:45 -0700 (PDT)
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
Subject: [PATCH v5 4/7] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue, 25 Aug 2026 12:16:22 +0800
Message-ID: <20260825041628.988369-5-wenst@chromium.org>
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
2.55.0.860.g4b6b3295ed-goog

