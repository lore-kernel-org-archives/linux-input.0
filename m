Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680678;
	b=cjFxxMeSW6w707GLatdeMD2LOpST33oEFejgx+TouQU25xRtLgfAb2SpvzBxwHKYQ/OK
	 TwqoOduujXtF8qqvO/FHUZOpJEzUxXAjk2B8IFkH0HvMz5QdQkwm6NYCwthfXVkht1H4M
	 ly0stGtNqbs6dYiFNigkyPnczsnMwqQg+eeff3ACOng6HpHyZQXbElu37/2aNxjTGxqwT
	 ZNzKU3vm4eU0XZIOj0j7INRwUDvYOQigOzH0S7u+zaR01OQGC5wOsPfg5kHLLb1jTl2zv
	 NKgIs9S4cZZT7mIBZttRuf4Gp+HBxjeJ3UBSeOAfrfcttGkXzUe9Af5OIrei8NOeMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+m0KRotnRI6Y4M0Q7c+lnB20WP0kpPO3hQuPyKu7qTg=;
	b=v386vsKQ8YNAhbF1DQ8bOEusTgKWTibrK1Af1qWEiuwggOe7V3wfPhO2gw/92LobdrrY
	 Y0U/jrLe/CR2XBJFoBvJYCfKoES35IV71hb56LZR9kpybZB13a57AuH3vVZE5uFd6MV5o
	 4uVhJRv6DQRD0TVKZQpeOblKpqtmXLrjMhdQ2EC3PwoOqZ3raciwygKry7au9ktgzT6Nx
	 HuZC2IMMUDaBnzxmWdiu2btCqLbJN6Al+ZMsRoZqrGLIo2ryZ/Uvj33cG290gwfT/n4FA
	 j4RdVeIDpxfjZ09+FBCJUSy7GZkYiBmChi4diTigKqRM5HQNeUVIn6YnT28rAFLzn0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZKpGzlmX;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1251D606A327
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 04:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1251D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZKpGzlmX
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1201743a12.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 20:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793680677; x=1794285477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+m0KRotnRI6Y4M0Q7c+lnB20WP0kpPO3hQuPyKu7qTg=;
        b=ZKpGzlmX0djeNLrXuX9lTpy2ii6SP/KxxSi6BOaEFbrjgQBU3M2vDz2L4c67FfPral
         JfFDWMhXs1qA1QUSktgnWBvfFFLuvqdgkCOFmwIDZwxycU4385176BZckVSjX/CqV7ZQ
         +wfL45iXhYgGfu3vN5nwL+d1+dOh10dong9Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680677; x=1794285477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+m0KRotnRI6Y4M0Q7c+lnB20WP0kpPO3hQuPyKu7qTg=;
        b=duO1RmjooFJLkonaBV+qyJ9ZVmGs5Xy9kmtSskKoi4Q2qTk32XZqy3qYE3Catac5Lv
         pKPrUmj5zCKzTDNr4j348ZQVRLwSQ4yckHpamRzZLotCu0itTQUW3nAYw9dfTwaNbA7p
         azy0JIRgGqDvv00XVHSAB9VGd7TK3iiP0UicLowmV+R7A0tkwVlFKjDcR0tBYU3UDZtS
         UWbl0PMVfmEDKsKnSaDh7S7XddtcB8BcybMmvflwbfa9UzgGRdy8hPbNEp95ukwbTOTk
         V8QB8jG1+w4usfn1GA6jTLQ/Z6WttXaalyWyJ21BjR6n4XXx/UDrpLtCkTvLqbfMm/S5
         aU7g==
X-Forwarded-Encrypted: i=1; AKwUvBwmnCEjEVos5+u3XdtwmYLMmoOih/PezzHrNWGp5KZMrVxaqvxxLUKcJbAQAStufNae0DSlyMezjkuqew==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Gc1deACyjwVggM/Q3Qv/m6H+a9yDOZq+DCu5v5Q9qEvvrlBIy
	/wkgNYfH/Sta+ToUuDyP3DvG8lEfLCLl2JkcycOyUsbeQCba/PWpT8nI21UAZL7PEg==
X-Gm-Gg: AYBFou2ZVL6+EC7B0+0B0fK5WicpKzkkkg9vTxqUdLPypn5WaRahZmlZKTk+IsT2lfp
	FdlfI+QyJt8twsS/7rrT79DG407iQVptrkrNROw8rvGyJbo6f+44EYG8ynMFmJSULXy91PH6fuj
	BygF5bnWreUrMLXhq8QDpRAFQSGNChQvGEv89HQmU5Z/V6gpjQc8fbK23+z6Ok9h9O7iEwJo2A5
	bzC5b6ntikGkQP8x7Gk/6uicjIUchLpN0IGYpwnP2awblJRsTa5veulGysx6yBztfllQ8jhC0J4
	gybABdtOV+SJhTaxExfXOWAFqyZv1BmBTqVDFsILw2FVIcnkvN0APaWWBxMOP/ESKTu57BpWKYb
	Aue0KdFxnx51KLdWYSjhnQhiAEQY3GixArrVPretFjFi+pN0DW1f+18oW3KQdtZxUyGzVhOtunT
	nVqkxQ8XYOR0359uEcXfeKHYKKvh3/GCfwGeyFfx78xiNKOnBEWZu1kuJb4AxxmiB0vpCmtlDA/
	qOTr3r0FjhTSfgfN+noyfpQ8S/PtUPyryfDTViThFG7faPhJLmhlJswCL/ivlbWSwQM8znWSgOa
	aZdR08K3zW57OFRcm66FzE4SXTGIrt3AAjOGz/5+EMuQtNwCiA1OYDFIinQJcDCF4rUh6TaVSiD
	MKb0Irm3fRWgu
X-Received: by 2002:a17:90b:3b51:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3ae897c8800mr10534419a91.63.1793680677425;
        Mon, 02 Nov 2026 20:37:57 -0800 (PST)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:dea6:6326:4502:bb8b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c71c253sm2072761a91.16.2026.11.02.20.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:37:56 -0800 (PST)
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
Subject: [PATCH v7 3/8] HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long
Date: Tue,  3 Nov 2026 12:37:27 +0800
Message-ID: <20261103043734.2179858-4-wenst@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103043734.2179858-1-wenst@chromium.org>
References: <20261103043734.2179858-1-wenst@chromium.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
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
2.56.0.385.gac671c819a-goog

