Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296A3A782A
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296030; cv=none; b=npzQYLJ9cRW0J42E5SCJvKr3LEJebiyfGdcmNg5yxYKzAPnGSg1hsCJYX3Tu9mSuCRvwm95rrfbW40sZ6JtBQt6rZvjJOzQFMCraQQS4C9x0M2aoefv8hXmAAk8tfzhojQYZCXMpKThJER89aNOUdC+BXSaaqLcdrpE53OujkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296030; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JePCr2tfPH0t8d0wXi3n/BAzDyI2SGS3ltxItde/C5/qJXAwYHjrLNRP60DB5jEyMGLqeMbHOXfdv3uJpKHCUs6vM+zVgFpiguIgzx/UFC1yh3MFnfLOLZeKJTy11/YlCwiTIfyK75DPNqZDNHl+2BbF0Z9y7T+r4ceEKYRGRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npXKP+yk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npXKP+yk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1095203f8f.2
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781296027; x=1781900827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=npXKP+ykQJbcKG8KBz95UF8rst7yKpaxGMIE0IdGcwEjxm0r84cCaXSgK3aSSao1w7
         uDneSaJk4HNu6NbP3izRvI3YuaV3K/Z8DuCntkBDOWcykNI+INjCaFdaAiSjXaMMDI5o
         9IRFSaBolxAMGYOYAKOiEJxHA3pQ2v+lQjfu3AuOkSf0gmTLAgzHuFSEmIh+5y0vb7cH
         3bGTkhl2TF6HUO6HlrlluigMusnM+XYC5HcV/X2bAnUobRHx8soAt0plUU2oQ2/eTM+b
         2T/tgnVw7QwWALxPIbratGmUwfgucu7+tGlTtjK7JzMZdOOrkhLf/Z4SsNQ3W3ZqniA4
         /Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781296027; x=1781900827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=s5Dsteiz4Y3aota3QVy/SLE/bwzVYo0pVYHC7xGZ6+oz4CRvIjpShw+S+SKzPef2zS
         3XuA7Up+6oqyCQ4wmKl0lkPkfhox41KMxYJpwBHLRd+o2z88wNXWx8OX8f5IMkFDMpkt
         kP7sKr/W7zIZD3qAZm1jXHr/nbeRM9uLcqcMSFwtXZ5IyRz3ws39j8wZMv0JoIiz1jOS
         vEs80enYXdOh1xdECMo4+ynJKV1q1dmoKsnRwr3FHqk6qHOP6Yxu6n9LBxHiHWCmqwEr
         2Om7rtCedhG3KmRmN1+hD2OfDi3lxABt8tXmbR7VRvWKihvus46m2Fwa9jHv9A1+q+eo
         2HHg==
X-Forwarded-Encrypted: i=1; AFNElJ9orz6z2DHNEPB2Vn9QPM2rOPrL5zLx+XBaqM2/0MC7OPUVgFFJmpyWqpgC5SLYmE8k2gsTbczkSdorpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMWVpnDgAHyTUw4gIpHYMKRSRlW5I3CZGsfyvNdQuOqeqVz2u7
	HKXLiYjRG/jClCSpHb2jQd9c7AMeSe1qRL54wh4Qu5fzEoY47AQCmaj+
X-Gm-Gg: Acq92OHxRix/KS/Jsfo8iYYqmF094X17ek/iD2GN8GPVQ1EtRrRLmIxXWS1mJboUcQU
	R/brS8bjRUN+Uacw1GIwjOgG4VbR+sQ71Fi3KRNeg+x7J4Lj4gMZ+9CJK9rY/JWuhnyx1vHIBre
	p7Sm4YPcJa9NbwrehJ/G51HRez8tQDGyafcJO+3G0w9M3kXL4v04nSvBlgv2T/LU2vaNl4TNx6b
	mTMlKiXsDENs5Tq2DvSHhmXJhcP51hoaO9FALfAhc1mxUHEPWvFIyah34dL5iVOAhejgckJY04y
	zpG6oLio9Z6oDWvT2VUWmlt0PX0YTaMnjKBE9kFgztg4TsUaz5Hb//ypETvKaSxz14+wXaae8S0
	DE4+4x2iPAsCJAuSGsNb0GlbiaTWPqQsu30esJ+OG6O5xNtRNkRqDbUGse6zTh+dUzz3S5VBEEE
	d5j1dQuHEQOVpgwbif
X-Received: by 2002:a05:6000:402a:b0:460:f4e:a481 with SMTP id ffacd0b85a97d-4607ebee2ccmr873998f8f.34.1781296026959;
        Fri, 12 Jun 2026 13:27:06 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:27:06 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 5/7] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Fri, 12 Jun 2026 22:04:10 +0200
Message-ID: <20260612200717.361018-6-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612200717.361018-1-l.scorcia@gmail.com>
References: <20260612200717.361018-1-l.scorcia@gmail.com>
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

