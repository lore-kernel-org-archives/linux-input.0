Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517883;
	b=swDBrsp0LhiEG5jAoxvoUlcgXKd9XZRET+2TwZ0cW01VJ4DESdlIl6+md4UdokXLDtPt
	 HbPePYhr0DjOxLAn+cfn3IBTXg48MkSYWpXxQ4jKcpBFycVOl9qXyJTmxdTAaFlWyWseu
	 fWzvT/ejqn2n5MeEIPY/3AFGv++HUtqtOKW7vD/ni6fTVN/dxeln/T8HvwmmsRmNqfKH1
	 tUOcS61fzBPvZ6qAfPoc9GFD0aSM0UyLhv5rnftZscL99yqldm4+0UKzpaniXkSAsquOK
	 MW43SSa9yJbuacjtm0Hf/FUE+VjvQIrArULSklOzi8wMzhgqPq5uJvuqnZxKCCZ0SiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
	b=aQroZ8B/SEED1w4bebGm4KnskbXs03KYmXOYGUkwcrZ6TLaM/5glm82rD0Zs/rj6qIBa
	 uZVYnngtQWIz93YlYpT63j0ueMuVwExbadWeDTC/bFlwFsmDdoBwo6CzMlmU8X/RyntVB
	 M+hYO1s9jyBGxFz70BnYrj60TTez46S1Up0wf2M7rIOJ50ozNwQ7rUWDe9yPQBHqGkZ7S
	 I2+syEBVUShiB8d/FOPq6HTIRRfjGSrWYwlnl3IQFLGnj/BFeNNKPvgiNd9DXSS2ajtj2
	 ezZn5EVHhtRG+jto3HXDKe8Gf/OI39dg/rQUHE8Gr2r5SVoaSrNQYljyi0mwjkY5zTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GmlRKkzs;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947B606A334
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2947B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GmlRKkzs
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso35070915e9.2
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517882; x=1793122682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
        b=GmlRKkzsvSdtLCHmdZteJEXJKS8qVp37TbWjI+1duppJ5T+3A91EGiNYSSMd1vH9no
         +x8gcfrvRGCTFEu46jzsfHHtUXQa/GPII9U/hSH0aZNhN0hhGtVcl6cuG7n7U6PtPzp/
         Aqppn6vCN0usq0nBOl/GXyJ6NM5DHWlyR80Bkqj47xXPpadl4yNmlH0TNwfeftUoZIDh
         YgjITSX9V3RVsALF7rfmeresrwjX3Ph6WunegR6kw/E/TN66eDBsWP9N8rl3ItRfLKLE
         GJZHvexEFdZwoaDpa+cjslGHH0ipsbjJatxi8jh9d1uaAs6u5ArM1d9waxcuKnwhC7xU
         Dw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517882; x=1793122682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
        b=C05gqJTytG4bH47ZqjbNcftHOxX4r2FScWgRmlNvm5F560sFpm6w/bj3BcJGU8L7OQ
         yE9B8nGm8uzbJDuFmANyXXW9rDEYIVJ/PTMFKucsYXenyDjDQC4Om4W78yNbBS/5vpd9
         tNj7bnDMCYWXPEYLWd/0HjJVGTINyEMIxxlS1NFq7Gp9GPFZdW+1oscCh/87yRJsB3DH
         NAVKpGgAYeJ2sOHIbNmRkvqLUwjCEJ69HVPImKNKPSxz/uBukIBh3zRgorLT/dhgOPf0
         8NGz2gyxME8N0emA9rXSc/pwWf+QnUYlgkCw/lzSCI/X8WiCT2obOKpaAJMSzUYBFSnE
         vqkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFoJ49ZOnBnvFnoMOoRx1/tyRDtgKdD5I7nFbcx5ITT6el3tmmD3cNvDTJa+FJ2hMCgwSZx23wU5Hthw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKwVy7WzGMKXqoHOww1Nmhm/5ZicGf0ya/Spgcvu3ukjU3tm2HO
	aCn8F1M23V1JcDE6c5uca9dwJmSXVCsxG5ehfh3jogAVFRSLUIiUvKnL
X-Gm-Gg: AYBFou0pWnXeuLCfYwhL1+CLa0rNvvlJJCeAF0AOtXChy79BskzSF9noyYWOu440DuI
	LW1YikEUBH+J/Un1i46v+Rfqhunp8MJaDYOjhKZI7Z2SniOl2ta9b8RidBK0Hh7QC56/r1f+iln
	QQ6wZ3vPqM0nB9TGGf8cktq7210dzt+7qS0wBNraWWeExu6psKYZeQSAzrk/ixnFM2hC+WxeoIv
	uZ7tKhA2rRgou91InQ0JjPw3hD3jkBJCqiieNU7MjHsBpQNFCKue7LvMcZzShZ7L9xb3KABEkMv
	WK1EKvv1/Q+DV1o2+HG89jKfu+rN3UvwE70myYmaCNmVJqJPdsmFOUbqbwAHa7geMZ84Jeumckp
	SScyYF0hG0m6Ex2J0Gp4jRUzZ1i69TSkKitly4qtXSOGVWoeRuzMH+FnZHeO8WP/AudkZC/LPhv
	paIhMTqEUhDGNb1urY6OFWNyIhmlYIZBOmhwOLJVkWEVgzbscPpyFHsqQgN6tvk76X1xTU3ypNn
	unl
X-Received: by 2002:a05:600c:5494:b0:4a1:e0e3:7fe0 with SMTP id 5b1f17b1804b1-4a1e0e3802emr205945675e9.12.1792517881594;
        Tue, 20 Oct 2026 10:38:01 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:38:01 -0700 (PDT)
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
Subject: [PATCH RESEND v10 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Date: Tue, 20 Oct 2026 19:33:28 +0200
Message-ID: <20261020173556.632798-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020173556.632798-1-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
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

