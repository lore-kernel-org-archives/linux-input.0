Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECC274B44
	for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029900; cv=none; b=AvKF5PCo3r0gEZ1jdR6O6Ref2aPk1riq9f+nC3LZY0/j1LueRnC3E3bXymBq8EChfUROHAFD69oiACuM0+gt5xYlGrqycXmFNlBRzeNGMQInvqDVkeAFjvMfIk27+LgcGtsWKaqQrvb80EpN1B17iI8/3Zo/+iHQ1Lkd8bzyTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029900; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZO+hRj5Ut0ZyGoXmXlJXx9a15XUoMjsPrHDOXact0dQSKwwnZD96IerT7jyC2/XkacaAyhxxrYdvDrKog3AOqrybihi2zqrTK2WxCo637xyt24blo5axe5T3HP3EGqruysm4kXt/jeIv27GlzchOB0Lj1Od1ZhFYnFmkaVovX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0eLtDjo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0eLtDjo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b9318997so23006835e9.2
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029897; x=1782634697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=H0eLtDjo1M6DTs34J++HTmOYKpyPhHLh1+QF4GHZfdTgFP0VdggJs0p5ngDTQyrb8z
         jj01noAzjOVngeJYgxlVHPkeC1MYsLIGkGZU0hj3qQM/TLjn49OTd7Ub2CJVsoomDnZH
         yr0V+HL+w71Xm3vujFUK0Gtx3ZvKv6HDO+iA5iojOjBciaPgZZQ2om1ctumPKUIX+aTw
         zf9f4zfqnVewMo4eub52t15EqhPBxSSU4YVwNQEVmDczMrGLcDZMsB/sIx0DsTUQc3Lc
         kuDxq7MsHaPqATHMd14VKeLrFr2rgw8PgRcBRmmL4yov4AgnKzsF0rsLfU8XB+6u7kS7
         otQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029897; x=1782634697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=pjKSGoUnvkFxIvmbYz2ldcUgNkumzPQY1EDSdBAzlqHsNzXFmXP4Yl/tg8folaCYsv
         mvWAlcYAecLOiAxW7YNzBUAw/dgu9Fk7JFWGYZqL/EVpYhp175iK3s/eighLbeYCqUEG
         DQ87L7k7uoHIyQeB7fDjJiY90lQd4/1+PYGf6ua1mGPEuss6y28e5bJymiJlrBBxJZ6L
         fnt6EfXKPz8UDIuiVx+H0kB616Ep0h2FFrVLkwY81U6fSUPfX/7ncGi2sz+HIVf5qeyG
         F4BD2jnXmRMR70S0y9LDnksx/PPoJZ/dAOzElAKH8NvCeSB17yDe5MKJwujB3ALEZZUJ
         jC3w==
X-Forwarded-Encrypted: i=1; AFNElJ+pWBGdfbbLbi0PTOmnqQDlUM4Sl2AYQqgGCCcdp0LGQ4AuH/GrshJvdg3Rke80yxoJJ07gL9AKmn0FzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ap+TaGpYsY1W7Www/Hu4RxyLQBbasvs7C/Zh8/NyemtnMPOe
	fPRSAooYkUIMwVfxOSdYur87fxmYORAvmKc9LJGv6O2L0FxOB6ASXIl2RnGlwiek
X-Gm-Gg: AfdE7clkFcME0M6/XHM2+tukbe63kemMIBIzmv/c7bVys8ii9BWGtHigz5R9Ko1ryhU
	amDNy+PbG1cKGNYHgZyZSWtt3ZNew/ZJRCI2w2aCT2lPYEmqrwHzienoYtsOnXlDRL1ysXQxJmz
	Xmoi2xJafz/QKnHs8FL7MHZ7csHW5y4K6Gb7fwdDWIMfweVWhJNPYgg5NcCIa1QqM+fp0u1i3uU
	BgnkzGH519iU2todmTLRiGbY2dn3ZxzN1AaekJYV8xnuM67HGRR9NtB1UAqZbo3N++2eJjz+sbx
	YZxTKLMr/ANeG7e+95lk61qYRiSzcYzfmngWgUMHqswylrxf2vVbll44+U/5hPSxh2yFhqVxS6X
	wwor4pqK9n8htGtykbP3q4he5ZxKYYYtTULRBivkp3QPJ8K09TFrwb0xRQQLTzzFtxe5wCIn+pQ
	blgLHNQA==
X-Received: by 2002:a05:600c:45d2:b0:492:1e36:85dd with SMTP id 5b1f17b1804b1-4923f596bbbmr163549115e9.37.1782029897128;
        Sun, 21 Jun 2026 01:18:17 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm194100445e9.10.2026.06.21.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 01:18:16 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v9 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Sun, 21 Jun 2026 10:13:31 +0200
Message-ID: <20260621081634.467858-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621081634.467858-1-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

Add support for the MT6392 PMIC to the keys driver.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..8b4a89fce4fb 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
 #include <linux/mfd/mt6359/registers.h>
+#include <linux/mfd/mt6392/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/module.h>
@@ -69,6 +70,19 @@ static const struct mtk_pmic_regs mt6397_regs = {
 	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6392_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS, 0x2,
+				   MT6392_INT_MISC_CON, 0x10,
+				   MTK_PMIC_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS, 0x4,
+				   MT6392_INT_MISC_CON, 0x8,
+				   MTK_PMIC_HOMEKEY_RST),
+	.pmic_rst_reg = MT6392_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
@@ -301,6 +315,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt6397-keys",
 		.data = &mt6397_regs,
+	}, {
+		.compatible = "mediatek,mt6392-keys",
+		.data = &mt6392_regs,
 	}, {
 		.compatible = "mediatek,mt6323-keys",
 		.data = &mt6323_regs,
-- 
2.43.0

