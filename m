Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580037;
	b=NPLtPZr9cmDrmpOYVFwGDXPp8BsGb1+agrj4Uqi7r7gjryuW+5Wz0dQiPFaG1bonmViJ
	 UDNaiL6ThqbStLrion3UIuU2P+5GVXRVh5FVB9R1E7cVxeNzh3BehB8RC4Um1d13tivrt
	 MhIC4WgCk6sDYj+c04AJHoUlsHseMGCdP7lcv59LmNBdmW3qWS0RC9cJnvaN/5WitcTKs
	 dPgKHWGh5dI/6yKvZCU58pfn9vtUAY9abz1WN9B/uXvpmxfCWB6OUXYBraIl2hH8Ex0Ff
	 E5eTd+BI+3KkN7Anr/cM02Wum6ijJaYCQr7KyZVGmoRt+ExZyNARRRczCXMmG5j4WUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
	b=hYt5Tk9ftEj6b5m4LHK4FjVgiEOT2eaE0Sa43zf1WNS1uR0xNeK1sYfoItj5Ss63Dl5J
	 dRHYsnOh3Cx+fHK7/si/NpYTkbCl3otmDHiIm8uB3PxczFBoyJrecHCqoCq+D7Yfz+bzn
	 SXsWDe9JJJ/ORvwjJvYKq/2gKjnb9FTzCu/BgzbXqaKa09M8TKmvC95l31fc/HssgP5p8
	 txRq7/ayty3jTYEiQFzSMiD3XZmtprnY7PY5qp5GT2Pls91IeWhDE3K/NXZ+5czTbWtzX
	 ZAoqbeyr8D7OXRrgOQ2zD5TIL4NtFyPToqzvGpjcCfmBe5aK18Z5QFy0lSdNmmrPLgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q2rY8P8B;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03770606A31D
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03770606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q2rY8P8B
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so4434145e9.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792580035; x=1793184835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
        b=Q2rY8P8Bsl8yOeUp4qVBMjk7TbrmUu594XS7KqoA+bX9oGDtyYqBzATyJW9mYJkYfo
         Fhb+ycudX0fwmVYPhEGpavNN/3juPDghx9+GSlLCXwZGfBsHHS9snHSkYD+8BM8x1X/s
         9kuYqSSzvHv1rcRYJur1lvGRK1LytVLIGApPKAsMCOe+ZbsiJSzb4QjgSMWGtXnl7M18
         wOafauvI0BvGKNpmdHF9txt4J1z4N2IUcpa+1CI1qlXU39elJ2u7Fj4WjiMV5fNbNDXO
         YLl3B5/2clUQ5hF9QLcK4OXIbzbXqLqbG/jUuX5C3yKkE9+tEjM6tDuaaUkmEfkXdIQ+
         bmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580035; x=1793184835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
        b=bobyIvfQxVU9mPs+5B/XDIjbddt6zjiXH3NQLOSlN/PJGQxJxUMMeF5CIA+/Z7cuty
         WXhO6RqtCalf3P43kJgu8E8aMF74EI6R6/9AEnnyb7rkWulLvno4jq25VnpCUEXSldWM
         QwErYDdalZdtNC9+7TUvVkR8YOfeRkAy4u3gmK8KXNOPauUX8egL0xRPHGsVJjI1dhvR
         eiBxybDjhgvzXpwpNA5dm9ZBR1ng/h+V53HpkmD+zDJk9mSh9EEWQvk7ELlcBCMvdNZw
         Cg3uugFyUqJE43fdWZIdrT+uB1x7T/tCGBX5+0zH5lmMFH+jyxvBxxwmgPhG+9z6Asfp
         DX0g==
X-Forwarded-Encrypted: i=1; AKwUvBxx+tyGFVa/GExw9HgLvYkU231QCrF2XG+9N1qnrlLNzKvqYFAEboySNAUNYefcvdQlSi6uxwl9kBknVQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIKvKA/4jq9vNZAIL9u72i9usXT/s5B/r5ZrzzVhuGPvMhzohxr
	+qJV2UuNBo7w5vdsFv6Yr7Eury6BktKje38gfzYj6lxcwdqTpyH6L/QQ
X-Gm-Gg: AYBFou1qNJwifKCNVodjwp1dlISq31TmSpXXkbz3C9A7SXYFRSauJbTCvWKnJnnRa6q
	+H0AlrRUztiVYGY2US5Bfg/di6E9LEj64T8lq72whUroeaI6B9Tp4LX0Q7jnR/J4d2l80R/TJ5S
	HfQEKbbqJjSTXNWh0ZnbttTac9e3n/NyvZxmLpm+QhFQ/MKg4CiHZGZ99tYjHp2gVICIV1QXtAB
	jIoBJQwAXw8wS7iSIky5JynVA73dsMHHhnpAUtFASqkGL3fAWl9xE8VboaO5LHST96ff9PqT5Xc
	ooQG89Ae5Dgh5N+QUTx5v5gPvbrbsHY3fKAtKdoJ6ZwplnGtfwep1PZNj7WyQ0fN/xyeqabT58J
	Ndnjz764oauDNeYIiFLSVxX1Cvyqg+0x6U7DhiG3Tds3sl2Dk/aqSQnnKmukjemizl3Cmgnd09A
	Vn96yy2b/dvQ0avCXj3R/SR9BUEFdFCamR5yufoV1jrYL6AEfhGcfk3Qlz7O69zql4JCECsl4aQ
	lknaBxDMOlZjsDugMT8VIMatfeYCFGKNW2YJ8rwY1BQPT7DcKw=
X-Received: by 2002:a05:600c:4fd4:b0:4a1:7ba9:da2c with SMTP id 5b1f17b1804b1-4a1fdd4d220mr31805745e9.25.1792580035343;
        Wed, 21 Oct 2026 03:53:55 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:53:54 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v11 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Date: Wed, 21 Oct 2026 12:47:25 +0200
Message-ID: <20261021105109.199886-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
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

Add support for the MT6392 pinctrl device, which is very similar to
MT6397 with a handful of different property values and its own pins
definition.

Update the MT6397 driver to retrieve device data from the match table and
use it for driver init.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     | 37 ++++++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h | 64 +++++++++++++++++++
 2 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
index 13cee2a209c2..3944e39db7e6 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
@@ -12,10 +12,32 @@
 #include <linux/mfd/mt6397/core.h>
 
 #include "pinctrl-mtk-common.h"
+#include "pinctrl-mtk-mt6392.h"
 #include "pinctrl-mtk-mt6397.h"
 
 #define MT6397_PIN_REG_BASE  0xc000
 
+static const struct mtk_pinctrl_devdata mt6392_pinctrl_data = {
+	.pins = mtk_pins_mt6392,
+	.npins = ARRAY_SIZE(mtk_pins_mt6392),
+	.dir_offset = (MT6397_PIN_REG_BASE + 0x000),
+	.ies_offset = MTK_PINCTRL_NOT_SUPPORT,
+	.smt_offset = MTK_PINCTRL_NOT_SUPPORT,
+	.pullen_offset = (MT6397_PIN_REG_BASE + 0x020),
+	.pullsel_offset = (MT6397_PIN_REG_BASE + 0x040),
+	.dout_offset = (MT6397_PIN_REG_BASE + 0x080),
+	.din_offset = (MT6397_PIN_REG_BASE + 0x0a0),
+	.pinmux_offset = (MT6397_PIN_REG_BASE + 0x0c0),
+	.type1_start = 7,
+	.type1_end = 7,
+	.port_shf = 3,
+	.port_mask = 0x3,
+	.port_align = 2,
+	.mode_mask = 0xf,
+	.mode_per_reg = 5,
+	.mode_shf = 4,
+};
+
 static const struct mtk_pinctrl_devdata mt6397_pinctrl_data = {
 	.pins = mtk_pins_mt6397,
 	.npins = ARRAY_SIZE(mtk_pins_mt6397),
@@ -40,13 +62,24 @@ static const struct mtk_pinctrl_devdata mt6397_pinctrl_data = {
 static int mt6397_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mt6397_chip *mt6397;
+	const struct mtk_pinctrl_devdata *data;
+
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
+		return -ENOENT;
 
 	mt6397 = dev_get_drvdata(pdev->dev.parent);
-	return mtk_pctrl_init(pdev, &mt6397_pinctrl_data, mt6397->regmap);
+	return mtk_pctrl_init(pdev, data, mt6397->regmap);
 }
 
 static const struct of_device_id mt6397_pctrl_match[] = {
-	{ .compatible = "mediatek,mt6397-pinctrl", },
+	{
+		.compatible = "mediatek,mt6392-pinctrl",
+		.data = &mt6392_pinctrl_data
+	}, {
+		.compatible = "mediatek,mt6397-pinctrl",
+		.data = &mt6397_pinctrl_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6397_pctrl_match);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
new file mode 100644
index 000000000000..e7241af28fdb
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PINCTRL_MTK_MT6392_H
+#define __PINCTRL_MTK_MT6392_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include "pinctrl-mtk-common.h"
+
+static const struct mtk_desc_pin mtk_pins_mt6392[] = {
+	MTK_PIN(PINCTRL_PIN(0, "INT"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "INT"),
+		MTK_FUNCTION(5, "TEST_CK2"),
+		MTK_FUNCTION(6, "TEST_IN1"),
+		MTK_FUNCTION(7, "TEST_OUT1")
+	),
+	MTK_PIN(PINCTRL_PIN(1, "SRCLKEN"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "SRCLKEN"),
+		MTK_FUNCTION(5, "TEST_CK0"),
+		MTK_FUNCTION(6, "TEST_IN2"),
+		MTK_FUNCTION(7, "TEST_OUT2")
+	),
+	MTK_PIN(PINCTRL_PIN(2, "RTC_32K1V8"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "RTC_32K1V8"),
+		MTK_FUNCTION(5, "TEST_CK1"),
+		MTK_FUNCTION(6, "TEST_IN3"),
+		MTK_FUNCTION(7, "TEST_OUT3")
+	),
+	MTK_PIN(PINCTRL_PIN(3, "SPI_CLK"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "SPI_CLK")
+	),
+	MTK_PIN(PINCTRL_PIN(4, "SPI_CSN"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "SPI_CSN")
+	),
+	MTK_PIN(PINCTRL_PIN(5, "SPI_MOSI"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "SPI_MOSI")
+	),
+	MTK_PIN(PINCTRL_PIN(6, "SPI_MISO"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "SPI_MISO"),
+		MTK_FUNCTION(6, "TEST_IN4"),
+		MTK_FUNCTION(7, "TEST_OUT4")
+	),
+};
+
+#endif /* __PINCTRL_MTK_MT6392_H */
-- 
2.43.0

