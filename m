Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3515437111
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620461; cv=none; b=pFN9wal1ZJIVgDQIPqHCOkqeHNArlFLYu+MWt9f6d/zk16WgQQsqOj27GNfs7XLZHcXxvZ0vv4/xMi3tSaWOzFyGeZGuXFzNaHEznIFMz7iwyKRjjMlOUQOWPzBGiI6NK2sBnebSxhp6GGe3jZ3IrOf/U4cPrKEIDL86KW4QXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620461; c=relaxed/simple;
	bh=v6GPocRuAdYXxfW5GCiY7PkoQqyVIhzeyfAlaB/90Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqOB/75TGmc3oxvSDtPAN+jS2dE7ynhxkdSWzSxxR9+F8nXEd3wM4y+WAzJ130E4qF1z42NlgtS+nXI8FH6Id+Xcr4waMUT81smdMVqi6Ca4h3SwHjaPC4U9jdGRNVpyLOq5RIH7NihFQsBL0dosbeVMWK6/UDmmjgUhzDMs048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QD/LPHKO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QD/LPHKO"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381216921aaso10536161a91.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784620459; x=1785225259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwE3F1d5K76sODY+n24O04o43zDEBUUtH4OGbkRqhTY=;
        b=QD/LPHKOGNi2+XaBdLMGVgrUjfGg41mV5vzf5LDIL0lxu/nj+B8IiK4L7jv2Q6jqLy
         idSCOH5tFaGoXd08tPcjpA3XsK4McqhItPoWhaeqM1mmHcB5NQlTWcipQ/c0X87htmTr
         0wS2zOACOf6tn4IXzjpPw/leCVAUW5QjfVkws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620459; x=1785225259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fwE3F1d5K76sODY+n24O04o43zDEBUUtH4OGbkRqhTY=;
        b=dYmFNRa5NcNW7p4Js6xAET0IJ0ejo11qXJXlB2VP+ZLBWgS3hxP6s6VByi29VAbSOk
         m69l8QcJktYNbXGoGiHcrYvtT1ge35yqSme0LY0ZySyw9pwFaWK24JkaZz6MmgzIjNOT
         Y4gI6neN4NZmp2qeoFeDyOJBN1fhWK+ACDrnUtOmIEK5pqWCZEK9SKh4/7r7v9TDGCyr
         Nmn+EEISvLP2oVAtijrUOSbn/9DqVmtTgimZWK8kryKg8xxkn0sp412/PgjRW8pRcOsC
         kLUKJddzxHvs5OY1v5z8LL8BmVVP0fRSMBQawYl6T/v6mjSzoFMGf8LWwvzBReXgENtX
         yr/g==
X-Forwarded-Encrypted: i=1; AHgh+RqY9N/jDrKTIZ20D9HmMyM1Ijn8GtMuuzfOTDbssEQGxjWtzHfcD1DQ/d4BLAl88h18j8y+qM5DUpNilg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB99ps9/mHUbd66Xnrw9PZCzUYEYMQxL3N+dZWPn1jprptS/Bf
	/oTfvMk7+V6QWFJgZ+Qd9UfM2QhfSGrG/EAfYcNNO8ukoXcgAr6oFkdq5/Z9O2zHJg==
X-Gm-Gg: AR+sD12ioMI3M9G4AO8ebIP/P03lXLqBFvmiH8o/wz1zSz6VJV0YtD/h1ss9m/gjte0
	WLM8gvdZ6KnYmCiM2dSlT2JsTFTrg5XVtSj7relm6bYftAFza0AHrGwojvIYbjJQ6+Dx4DkPd8d
	jyH12zULXsdSn+xjLcVK4ThF/5Uv4/gqd//13f+jVPunrfqiu2mfx7xeQ25Xo30BuWgCJZILs9H
	xMSdngov/kbgXP6t6wN8webMfPKFkR8vfJ+Tp5YfqKy7kbbvloB1TpugyAwxdtlEGgGV8jQbVtq
	TJ07sVF56zT6diChYHu4s3/7hOSeC6CtyCPj9qqS58lHYIQMfm8KCSSdRcisFURUxLE8oxmEYXe
	UK6CRBx54A3zItJNFGuqrGRdsB5TWO8VUo1Z6QoQ447LkIH56LLSu35/wYbhc8VDgD5MhmjbLs/
	H/A6G9S2KJlxJwaeTNnVKbzIc3p/1AzPBe2srRgy+gO49COczIM+Lk6EictYI=
X-Received: by 2002:a17:903:1ae7:b0:2c0:e5ee:f554 with SMTP id d9443c01a7336-2cf34895672mr185287855ad.8.1784620458954;
        Tue, 21 Jul 2026 00:54:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f705sm70724175ad.15.2026.07.21.00.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:54:18 -0700 (PDT)
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
Subject: [PATCH v3 5/9] i2c: of-prober: skip post-power-on delay if powered on sufficiently long
Date: Tue, 21 Jul 2026 15:52:19 +0800
Message-ID: <20260721075226.2347933-6-wenst@chromium.org>
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
2.55.0.229.g6434b31f56-goog

