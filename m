Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E3440A1E
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228814; cv=none; b=MCFMPDlDXk48vUvNexbz7yNM435g4c5XPnNDg2zjxqAu9VVSuHdJtlqMIraygtil1JfiPw8V68dRtJLPmhOyl596NiNxYiB76FW6Q+pnj2nUiDowTSndKwh+Cu2Ou59FhzGnJGrIVLzwhUMNdQpwTeqwRciohMDD5UgPcY/9kB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228814; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX/DQ7tcnwC4jkIhP7kWLd8UJ2KJyIp0wkd4QzrSbbq8+eMnv/vpRftVcnr1IhekzNKG1i0m71L8d2ClWxJbhBu/1KbiJw3tL2NkeTAjuOMr9aKsiPp87I6kCrU+oSBnd1aakM7n79lCZ8E4aAbsu6/NjMV1ctuwr+Xi8AwG8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdDZzalu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdDZzalu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954df200ddso17065465e9.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228811; x=1787833611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=gdDZzaluIIgXwAkRazz4PGcNUtM7nInLMop1Ivt0lrq45hxnecRpAM9vyYK7wFrppt
         Jri/z14SFNtwRIkVKil7BQ7RcO9mNRmBw++11+aMDlvrS3CEchjwqXzpefgsw+/3RZ22
         LHDqNCreBa9AGhOaEXEJZ0uLKT+uSPno8GeQuVGtpAPOJbO5rd/o/quVyrEMSgRVdT5I
         QfOC+ObQF3bPNsTNClVXAl6fLBG0Jww+sUhBLoJ8PllZW1sA4HdPMPb+XO7VF/5SKJcs
         2gO12GD6bKoFavu3byIXK0uar9dUs4pmX5EZXufHnKOXfVbYZey1WU2wSGKngGwcMAkn
         eUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228811; x=1787833611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=gncylbFuKBOPC+aMIIG4jvf/6HOtQ2IkBCZa9dm6C16Lem5r/gfgnrAVbZWspsOoP+
         hPFlX5gOh/xhGN+0eFlB+0tvs0HlAg+WTFHh08A/J99RmJRMhfUO0j0QQoIQgFOE6uOA
         kxCKMWF4kcn9GQ0bE+kVnCoySPVefFq7OOhmryNFOfLwpF3AsWxf0FkUT7dlCjS8WAvY
         W/LgQd1j4S393mwx0q2bBy6RoHJ8UYIpBxeih0KhyIB71gQKCESFdNJoIZzgmE3tSmkh
         +fP2LcGGbNktzKW0EoIT+xMF72exWt0pjK7LnBXhqIZtE3EIgNy528xhaMc+5swxrKXV
         m5+g==
X-Forwarded-Encrypted: i=1; AHgh+Rr++qRQXT3tb9XrDZ8A1XsLg95YZnlPdxYxzvdXDNIBS9kTeTpDZlIq08JGjyEIglMaTIYCV1cdYXyr3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JC/xp9MzT6pVXZMsy7RDOhGkW+9RCl0/EsgRcJuRu0/fI1Ox
	bwAaMsA5XT6VIetAHHdxkCiTztcRIlS11pm6M1sJcEdN9H62J1w2B/U1
X-Gm-Gg: AR+sD13PaOrZ+1jfyiRt3Sp63o7n5d5OwRdToYKbv7T9GBaMFLQuy281TqyfyqpT01v
	H4t4nxD8aqGf2QYL0Cm2Cw+xnfScaUHtbwptPXk3+vQ2Vkam+VRUeD/57+h8t2xFUZQHSrgd5Ge
	okqRP1X2xYt1/MlZI41Q/Rp4dar6CcjwmKu+dSX0kfHseegxir22BNBXpleBWc54jfgwDf3cHEG
	xa/1DIenzzcHm3qkVAVDo7NUD+aUhkberH0gl9h4nui3BDrxJq7r9vY7Y3XLVi7PSByGvl/E+tS
	xLuUz2qVKD1kDyoG0bPYPN9QaPkutJ4+EK5Ox2sAOmT53F0UsncJ4Sy3Uplx/mq2Gi0JQZ9BmcZ
	py8KfUAIghls3ibwpa9lFLcOqbic3kkwYoPB5lIxF9/OhiosKwZpjL7aOJeCLIB7EaZIjOd/Eit
	d1da/q8jUo9cYskw1QExTAmD5urjnbz4Bnkg1IlWrSKqbcyMueEPvkfw==
X-Received: by 2002:a05:600c:3f18:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-499aa194df0mr233187165e9.4.1787228810718;
        Thu, 20 Aug 2026 05:26:50 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:26:50 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
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
Subject: [PATCH v9 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Thu, 20 Aug 2026 14:20:04 +0200
Message-ID: <20260820122242.120039-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
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

