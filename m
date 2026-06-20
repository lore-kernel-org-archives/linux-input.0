Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150C36A363
	for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781985736; cv=none; b=ZW4t8Wo4qMBySJp0bAWCYxi7rSb9Z62irhl1m7/QuEz/HcdZAYENO8cwM/1WQIR/5M22sR1j6RwDgD2Z+y3ZbF/AYP08NrN43/nNnvtvD8/vAG7ZLRuNIcuFFcu0OkdO+usNeR6HRmKaUtwFnALtB3c3rHQE0xhRj/YFPMaLR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781985736; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHCr3WNPsbkmdKeyh7bCY/WeAbW0H2UXCvUYT7kDtxKJXfY+mff3l17QVu3htfcNq8zouveKAr2irjtZd49GEIutmJ78h4yEhnzEXKi03p6OoY0zprDILDt4mCCEJhD2V9U5ICEW8q07znkZVSEXFTdplI2sQjyayuBDNwi9UGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTUh8OsL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTUh8OsL"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4624c1409c9so2314146f8f.3
        for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781985733; x=1782590533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=WTUh8OsLs+xNh969pONactWNHYpmqpZtumv6qbzOe+uF2hUdlmZyzoBfweXKpSwtbx
         nBIQJgnn7LavsimXlXW+80AQ2j1kyiVXzELlxTDwr4iA5plY0wRuYo8z8iMWCAR98b3f
         QV4jGxdJy0j/rJ02X+gYQa9EIgsf2UpOjXr2SfNr77o584L8RJfpiavhdHAqXZ/GV7bu
         JEiNX1h0x998IlE1uNRW7ga40uBOXg7iOnzThvc9OhQAJzlQA/l57qX+i+QwqPf10MK6
         hl5oGPbbm+tBnnCF1u0H1jmaB2pnINb0OsyIvGmQr28Mblv0Zla1dzqeSkyvDoqt6Fsm
         bwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781985733; x=1782590533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=e0IfXQi1F2ei4lx7zzlx9gx1dqnYXqAdxC1EgSS4g+MruWkH33Pfw5E3I47aJQmbi4
         lkufZ8ro2ZN5q3c/kVQj9bkFKoWMsehwdS+RyO2II+99VoVxa+soJyCV7PsIQMqlwizs
         S3b8bCSyEQURxkQmuqmHBXI6cyV1ZrKEVKJ2badJvrFr7QZ1fy5vv0Jid4JNdGL6JZTl
         RJhZ7CXxCW9Cds0qf9ZcYsL3LcTqPnrbU7KAoBJkIo9B7odSEnPHCTE4IvCPAtXRijxQ
         9Umq9bMjdzH89nM3xgLrq8W7ibsarlJVBm1pJsn5gp6xECmByXgXVW0e8vUEkVU5lUBN
         SHJA==
X-Forwarded-Encrypted: i=1; AHgh+RoqDC5UIRs3pMQEipdwtK/AUSzwuynnarJ0AIwbd049NebhlmxkQlZiRLrHUC26Ya+H6WSZLZT+Mh5PHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tYBqOAMezNhMbShUxRpfupKWXAKdOcwZvW6LxQH98POJzG2P
	tCEIZPd30/OICLqjfjOHK+CH62S7V51U7kC5nBYjsOnbfT20it/uCYhq
X-Gm-Gg: AfdE7ckrXHKyTsiasfYNKqpjbc5Jwbwjw1HxSFVA4BY/QPENfPWE73V/Ucljw5KHE6L
	JEE71lzNgheSUxVaQP4vZ1LOjerZnqRp5qX3jgX0qfHU2igwXjLRaGj7EC3FMrM+UxbA5gFTt3A
	5amaxm6GJMonCKGApYBYsUl3NrIvO1Aq50TkDtfoD6nknnalPsKCvrxk6suBA1QeES39DgS5/Fm
	Nz+zsqpn6q2VQr4CZKQJCer6qG2jWdPECgqymK/rEQqAqTjd/db800U36wYPpp3f3rSSqe9TAl3
	WaPdAkH/6qGa3OSglHk2vKm1S9KJlpLMCslwsUMNBz45VIXRSC2tcj0irQeHyuy/2ICgnFYWlMI
	SVdL6cObaDGKFpLb4rR3cU8M503nrNvtfCHk1w5ogDjwM//Xxdp7hCEh50HabbA5WaBi9L+aoK/
	dAMhY+Hcbkxwv9fjrG
X-Received: by 2002:a05:6000:41e6:b0:461:d369:ece6 with SMTP id ffacd0b85a97d-46662806a6fmr6772688f8f.30.1781985732911;
        Sat, 20 Jun 2026 13:02:12 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm10708354f8f.23.2026.06.20.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:02:11 -0700 (PDT)
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
Subject: [PATCH v8 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Sat, 20 Jun 2026 21:56:52 +0200
Message-ID: <20260620200032.334192-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620200032.334192-1-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
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

