Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4E3AE707
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859759; cv=none; b=a3tGaRxrGBkQzrWjupKGAaIjti7UcxZgZ7SVDuj+DArePBSGVD0iKdPUBPe8s12BF7lkhCBL2h2FrqFb0gprk/ke60bzzyikVrixSlyA/RRtAAZ6YbJ1dAMn//+n4vMT70z6UXLtaqvRAAkqQ6bOzqOvsby5zQwA+DFcX5bgZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859759; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGU1j3AJTKBhQWbkw710nrtUsGskp8SQE9Fkw3YHTgilnE9n8akstsZQawoVrkBmEjghW8YUAuvqchY4ATa8ooYUI9D6fi5Q4tREL36dNv8B0LItecWsIY0qX31ervQ22llew3+2xDyuZmi9U8qpWTFZLQj6H9FP6gJNIqkzLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQbrjs+a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQbrjs+a"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fe655187so54359065e9.2
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859756; x=1775464556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=nQbrjs+akCqe6lLWCQSgAgXY8ZBciIWLld7oNToLgxGQ0GYgtgFGKEB10ZwXBvhuD1
         hFoUFaTYLoQXeAwRto0JeV8n7cFcERjiMg0h7U1eJ+tFHzl3VWC8r+OjqmOrEOg1OT2o
         mauX7SHxYo8NLX6MpmNcYEn/t6JAm0O1IhKahnhIm8IeH0Fz9SZjDC0k8WB8F8vDv+d7
         mrAzNw6gyZUuKiVXgmreU8eZy5SAn6g4uW12qe0xpP7lh8j3rYZz+JFiXZwOktmVUSYq
         2WM2i+Un+vr30EHlFloSKIiI30r07VMaM3C+qWUm94KW+z5lWN+c3wJUtk0FpzT28uND
         u8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859756; x=1775464556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=IPQsw+bmLlQioi2LgT8l4X3jFfQ/o8F+cw3xyfSqPUkV6MrnsqFFyndqcOfD5pWciJ
         rEXANEsCIGeGHMnuQJHaaKMTl+Lj3poAQLLlEDiqBf/ibLHsQQFf+pPB6Rv4cIbh6K5M
         THHiolMYO1zKMu0kXn0GnNj46IVTEccvtx1OwX+Swh7lPtNO4ys9cMUk+uydrhC3oGPV
         Rm0zVmH+PsX+fKDN7zxLNt+d6kqbSkfsdGaNiDwWTqgcFM0lFC2yHXNG1DqeZcEFy+BU
         t6uB/aNq49EgtJsuYR/3zrrOAxAt+mx9K+V6WQvvpFBWryTGJPcWhheqWTvFgXI4nVh7
         qGag==
X-Forwarded-Encrypted: i=1; AJvYcCVZjPiUrT/qQc6i8GieinT0FFCit0W69OoA03AjCv0aDCab0BD1loIVKd3OQP24a+Jza99sKWEYfZDi5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXR2l1FUhrCza2EBRep1vVbLep643l/Lt7baBiyTys5UYtCZG
	Yynj1mGXVlafbv92xFeYgTEb5u5c7wpCO1fXW6Af1idnovPKUhiTsGA9
X-Gm-Gg: ATEYQzz0gw3rDy824ZTAg3bMuI1OGXAb8PjZXx+/XyV+qx/pVuVUvn0ts2UeD3KWjED
	jgnfLwRnVB5fmC63KD+q4vQB3Dcf3LIpzVEYEEdRNwOXr+W/ZkpGwQg8Wzq+38BRiniqj2hZSEX
	qDojR8lfFHEi5hBncOuD2mxBpHsB++JyH++M44uVVjLTegcpKnn7yR8/9k2YM0WPKKW/lQlVVmR
	1HI7C9jrEjXU9uIx+TIlM68xfW4yCclivva87MXpKVAck1NU25WJDgNLRbs+/FklFNrvuf6i/v1
	4/eiClsMhKfuGTY9CwIWSbCw6lEvOf4cM1X+xD5NfnxSXHiIt0gf/Cj1BRVuEYzSBpB0n35pSCA
	DVr2azK6bY4QS9qcQtTt0NglNqD87fN1AYaPuIDSYo1DdqkPPcNC1zygwDT1Anwvyv+9Fvd3Ck6
	kHMLJsbiOS3PnTvP/Kjpgxvsb6LP67XA==
X-Received: by 2002:a05:600c:4e15:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48727d4583dmr192614775e9.6.1774859756104;
        Mon, 30 Mar 2026 01:35:56 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm508329995e9.2.2026.03.30.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:35:55 -0700 (PDT)
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Mon, 30 Mar 2026 09:29:40 +0100
Message-ID: <20260330083429.359819-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330083429.359819-1-l.scorcia@gmail.com>
References: <20260330083429.359819-1-l.scorcia@gmail.com>
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

