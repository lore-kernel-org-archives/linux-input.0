Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F487262B
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867103; cv=none; b=IL6LxGBzYEZ1QkB87uhJYqiu0MOCmFI87q3ElxYb/gZ2KCseO8yjSPytFd2VAratiS3YzqzTmjtmdT6fPU+eoCL5rGtUr1z1QPwHdObsOZ+ESexUW+d0U/cJA3Z8WY96vt5UYlqjDzHtC8LCCPx2fKAVnUC6rCY3KwFQCRPKHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867103; c=relaxed/simple;
	bh=af/yagtcX4I0+3jtdjbr6gdjXxsaceuEo/D9CvQnsQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlVaDQf7sMhYtJdZrtpPIFRNVhFPdU09Z875yMLFNU+lb36J9E19tpCiL4yr8pevSMyN8hQ1LTQULbKgE9weFJP74Ii4nVvni7McJhCZwiQQ2YzM5mnnnVX1PpFqSOnVjqd26PujDK9P+oUftd3BUP3cviUiagrtVRROEhQstMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvOnwKlP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvOnwKlP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359249bbacso3377905f8f.0
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867101; x=1772471901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePW5oPXSIMZFrvCYy2NgcvqQ/NoHzPv8EJgBsrDZt6s=;
        b=VvOnwKlPcTfODKE8OuLwU0SCRgptBaK1x9DFWHdKOxgOM5eohJPF3rxQqAiGMqh4XG
         ffK0IbGGWexEj2p9+bnW6EMwZeblXZZIx8UZRaVIEs0E9kCw+X0uJYZ7RUn4FPc6UxSo
         j0kytO7zGvas01hyQV/KHGry6Gk/3nzvYku3l4Cbi2pNylE6igGbooruV8exWgglaAnl
         uPi4ehAE3pVhrfH5So9vHKWQZaaOjYnFnSrjXJ1rbc7J4y4JbPQFYxqJ4q2FC/xtSbVz
         kATorzwNqg5VdAqRk2o8tvNorW1iRbyyMW055bI0ewHOKQHqG6ZIa16Mlj/kWTTAwRAu
         XtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867101; x=1772471901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePW5oPXSIMZFrvCYy2NgcvqQ/NoHzPv8EJgBsrDZt6s=;
        b=hvzDzkyb7Dp4v7VjihpSGb8yndH6AjbfSp6cNyKURV16JS7Eu0nNtP9h8egQRaEKwj
         DX06OdquM5z1Q2MSRHbpV8a74lnbbh0JtZsALVVb/TS00Z+q1h1K8I+aZ3F59jFIHQFY
         WMSBuhxXJLRGNkv2nVreuvFqnPhGC8lBmMJFPmsTGh84QtDEtcyybRZ+imVH1E9q3c/s
         KMRB5C+ieg1wZIbMb44a8rKeCnzLUjkCKUnm+T2VJpqnE+2rBwfhE2bSu4f3TvwcChWe
         d57JesI2WBFbi78OL68qzSn+Ng8qE6qElumdoJKtJOyA9k0ecPDpVU2wXqfYX2diPbpz
         kCzw==
X-Forwarded-Encrypted: i=1; AJvYcCVbQgvLmspDo1ELJOmPWsCLNuhVoNoyIl+D0opY5KzL4GyY3EkrryywWcfpPvR09ebpdCLziEzbE++4sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8Torep+aTmFw+xWIeysg0GiJmbd3coQMPvt0vT7B6TVhKwpk
	eKIWffftk79RYcc+eSjb1Moo7I0ueP7ZKYiLUen/mlVn68bN2xahMBcB
X-Gm-Gg: ATEYQzx1j9qpOhNZJipgh7x8vvqRkMxlcVLdfWcz8QbeEBud7eQRk5Uqx940hWTNG1j
	J6J0LHSMndXw42N6Za3v/2fkjqVlM9bHexRQjS9pwg/vioZLWwfbo+uKqVgW3FY0Yh7vFRq2Zx1
	s0I+BCYTF4BuSwqV38lUY4Dl3RrJhAsPPrsLhFph2YBz1eLXhCSXwd/UQ4zYJpDq2pNOJq5PCpf
	UGYQYIxcD35vsTrXU5gvlGUBSKQuUPWr/dweltD3vw4wCMz+rm7ZSpCbnW3Rn3LDPpEypaoN+Gg
	5Vs7qTSbl0eVdHCSCxKNQ7aPRtBF++ezJhKga/6Hf9PSe5qzZIOln0B/KdwagsjEvEGOghnfZkx
	GzTQKWChn6pJ5jzX2ICk9Ecpo47/OG8LlzSFPzcF6FVVCKM/JA5eICZP18mPGlATeOZ2J0TJu+H
	/Bt1xiTkgSgtvI5lTh68Y=
X-Received: by 2002:a05:6000:22c5:b0:436:549:e15d with SMTP id ffacd0b85a97d-4396ffd6befmr18768227f8f.18.1771867100114;
        Mon, 23 Feb 2026 09:18:20 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:18:19 -0800 (PST)
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
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 7/9] input: keyboard: mtk-pmic-keys: add MT6392 support
Date: Mon, 23 Feb 2026 17:12:46 +0000
Message-ID: <2c96591313084d240ac94b9d42d91d984fa9bce7.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
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

