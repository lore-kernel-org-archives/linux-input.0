Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7760638E5C4
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798819; cv=none; b=bQ3/0J78EusIZvkbLLKbn7ZNg0UzHfIEH2jrjjTqMQgvZJLbsNClnFXTvl0y287GoJ4xQfcLE7gsweUljC781IhOr1XxgHZKjPFiS8voMPM3vU0D//XfrrbAhYZFE7YN55Ty6z8kS+zkfr4znJ3Y006z+/fWOS3A/5DKQKPfZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798819; c=relaxed/simple;
	bh=BMyjA2CmGChdg1HJ8bO7//vNQzLWGBKCzzTI2pGO3F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a16i8WwAV/YFhSxZ9umy8XHH1/gcaR4c1Nvce7lUKALN6w9YeRS6l48fE3W8L62oc3Hmck6Hsiz63tiHzcpE/jIFZHu3DVOte07YK8ehgSnU+gVNgb2G18Yr+VUSMdRfV9DGmR3nxqhdx044GUlTo85CfDltOW4qF+JiD2Lv3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1mzJZkG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1mzJZkG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b790af67so3396392f8f.0
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798817; x=1773403617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97jIgM6P/d9EfNIE9WeYwD3m3n8Lqle2XokpQhzkWdM=;
        b=Q1mzJZkGgzNN/vrE9aIIUsbD/BQUXkx+ieGWACw3XHC32AeNzB1GCM2pt5507q0d40
         X+8nzqwLOX3NM6pAR7T7yL6u+d8+qMJyKo1KmRrSX/aVQLoLT5y1VOPBi5yjGqJCrFG1
         WN+yAVkWyo9evBheTg16N9BaFr+SsgSSr47sMA4sdg9iARthEuyk1qSsxGRArpi36f9O
         amKRK7ZegQDRLekrEVMloxi15IpSFyzDv1T8thn1wIOe8AUd5ocMGzdVST18qm1PPYbQ
         vF0T5XPbm5j1YrACuYOQH5XOqUi/Rsj0pTzfJHpuJlqH3MQSl+q/M9LLUmr1VCQfESUR
         ngaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798817; x=1773403617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97jIgM6P/d9EfNIE9WeYwD3m3n8Lqle2XokpQhzkWdM=;
        b=KIBHwnhgOBSAEJOVhbOpi2vIqNWuEhTVHmHuPHk1n8o6S/AnbctPhk8RPdUYCmK1A9
         MVyaDKKx5kjIleFmYWkv9oWWZDKN6DGLDpNWVdBUM7FTy64ctck8iwEF6vbHStVuFQBa
         03ZZOzjWvQg121Cu87LKqKRq024euPTRsz9Xkmskb+S7aDpM693EDdJUSLzhCSpJbe5W
         noiT62g2oWJ4qIGj9okKVNfH4B7lGdRrQJB7IhoujWTc6Xjd/oSC0kRDyYs6yAroKqa3
         O+gLteSdhDkELltnsLpugJnq4jkYJro19tA9WLC/v2aNxQZL4HdRAmGuMEFtUJbG08y4
         7dxw==
X-Forwarded-Encrypted: i=1; AJvYcCXmfe9EFd9Em4Z+69BkIfG7AOiTK63G42Qy5UKYCtWJblmK6twfMn5H9f4qHX6/G1/Bmj6K9oM/ciRckw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwhWPsyVyPTew4cUkkmEw00IEXOT9XkZ5zNpk+ZCxWn4HqSFS
	NfX46Bw/+beZi6CaKNA2TX0UkB/4hgwiVfzNndKZj84xMb+KDdkdO1Ot
X-Gm-Gg: ATEYQzwvTwGNrs4+rQlj2lKlHZrjXzWlXh6vPaECc7uwUbLKQFsxGcZBhaxzCrwCNIQ
	uPQl/zUvl1CVooXmwFoPZ/3W8MKlw/+p4rlfIfvmqhrv/w1tZzcAQ451zhaIcAxi6AfylVGBGp/
	oDz4BEyEOwBntTK9m5cXDJq/YFAChPgsVhAMctrmBVxN4TpW7joccwP3KZc9S91Dj5Jmh3EWvPp
	1Fkhaugky/5vsGMVtkRe253MhBHmEp0O/pnYYssclK62omKbHHfqQAw/56TqpM6MSyAUqX3JG0e
	q7zbDvO4Hu5WZIzhQkWDMz+JBIQSR3qFkE4OuQs4EFa4QBJZLsfWZCpNzAHqrhEwDY/L6Vvejo7
	YHtiMd9Z9vUfiFSQfa5/XmBwCYdJJxZwksBwaf8p2PpyG4cqACKrmo3Lz7ocg7IZbAznwilvL4S
	3VgcbJpkOG3BEFhPSqmpc=
X-Received: by 2002:a05:6000:40df:b0:439:c018:60e1 with SMTP id ffacd0b85a97d-439cfd76d02mr10149414f8f.21.1772798816912;
        Fri, 06 Mar 2026 04:06:56 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:56 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/7] input: keyboard: mtk-pmic-keys: add MT6392 support
Date: Fri,  6 Mar 2026 12:03:10 +0000
Message-ID: <20260306120521.163654-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
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
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..3b9a5b6bc470 100644
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
@@ -69,6 +70,17 @@ static const struct mtk_pmic_regs mt6397_regs = {
 	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6392_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
+		0x2, MT6392_INT_MISC_CON, 0x10, MTK_PMIC_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS,
+		0x4, MT6392_INT_MISC_CON, 0x8, MTK_PMIC_HOMEKEY_RST),
+	.pmic_rst_reg = MT6392_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
@@ -301,6 +313,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
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

