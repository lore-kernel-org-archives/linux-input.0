Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2934390CB7
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377750; cv=none; b=sCeLq2kODBcZRu//O67CkUpNZR7BN2oZTJQvF4aXLfp0mGkDTtF3TJwadVZ6+G+/0x3rF6KIHI0uK18Hl0Nt1qAP1CNsq25XefxNvHcVxRSwTN31tMSc4fEgVp/QDPUpynQXEwJvQ1+WGIXDHxynbnVNDFkdVpSkq9/EdY04F2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377750; c=relaxed/simple;
	bh=ooP6TPJaU7E3qtlNtmtW111JJoBfcaG4ECdsHkhEnPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm19ScUqCtB+J0V+WXxqje0W3dh3vDtB4XCB3XpfxfYDV4p8vm4m9U2JKOPdkYIIKdIBtKnB0+Vbr/PvMilfJ64jvpsCGpOSl50BYFVBNCDbWgsDraXzxKKW5MenG7g62cO5Y0Xb0FBI4cdfBOTq5YKh9AYNtNvUTK/foX7ZbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/NvM10z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/NvM10z"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so1039839f8f.2
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377735; x=1788982535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=n/NvM10zwi1pwbckGMiFNNtWFaWPvIPorKJuQKrHNhWnfQfz1ECxOwI4pzR3OEK8LT
         EZEmdJRltT7aWp+9gDl4mRl8RURw6pWOkSWTaZ/+4QfmKQYQdJjyCuj9qwie7jXKJsjB
         IQL9cNE9RR3jemk3NgTZBNxIu/+wb0t3I7ph5Df8Y/cojguvJx9SW8DHYhIlgA38ESK6
         MO3wxoqYNt8EbGuYEDQRxFt8543JTuvn0vibGJnnxuLHBjPx0qEMCY28S8wD7fFcheK8
         iEvD70TAkA0fr/KESMYnk4PBgr7vh+N2JgeW9PHXH+6nrXgFtLJbynGG/STRBTRdy9rV
         NeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377735; x=1788982535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=n6G27j/Jjpzv7NwBattfe5dM+wLyQ8/fnS5DaecQt4bpJxJxfIW5TIjE7uKiDCsN3b
         KFA1RrvNQ5SKV0XpqN1EK7hXJNfgoVF8hqIjMsy1X3HAj2HVE7BZnJQbGOsYJHQ7bAAm
         jgEg/X/TvOTUgqLo4POsX7psNhDqE5TvAhGaDin/Qsc14kmXdxZirgcZ93DwjLr5PsMN
         HmLVrVNM3KXdLwk7t8Pyiq/R/8NYiWZpp/SR5Vvd3NEQrdZbNA+Vm62xZd0OCVw+FFtu
         VrI0iywx6CIVKdLKvz5bZ02UfoTzkXIkaJ90ZwNtXfr3rmY1tqb/D3tGqBCg8/Ty0RId
         AZKA==
X-Forwarded-Encrypted: i=1; AKwUvBz3P1P1BqFDz4MrKT9ybT3WBeRw5gADI/ExmZ37LoI8xmN4S75JI0bjwJBq8lw+4V4IfmrEGSjkbXr+6A==@vger.kernel.org
X-Gm-Message-State: AFuF++lG+h+ZXCVrzL3zdevsWc5N5ZJLxTcK78XGv6OrCLbWqbh9cTig
	qHeE4OkK6vNt1mIzgXmN5Q55PMM/35XK9vjSBisnzTwKHe+dEUG4P7vF
X-Gm-Gg: AYBFou1qazn0pLlsf60gYu9Nb2GgOmlBU/ArVcMQITMAnDfra/IwF+g2xLU8GohLsvG
	SbjP1y/jaKu14zzCXD0f7Fnm5rsoc8Ju9POqNrPpqOAkFWOaNngYI46UFCsMkEX69BqtL9qzMwJ
	Q2tojvw/unQ7uM55NPZCovZn6zE4tzqGkLEbjmnUL/P8nPDw96f3LMLQ1OHFALyM3tyMs1RveWl
	RYynh2gRFhIB9I2rsm+wNNcAR1MyGKJL5QqdaXILMFs8qd16XFGUaZGbK3RmP3iV59DZbQwKyMJ
	dLhy2wDP3x5hXeX15AwrPLhrMkO3rrCxE0Un6tLU8RmDXVXQBkRzPns8KJvvZrG7fzSZLCRyfWs
	McP5FGL72Pw4bK/M27eBYXuDyRitrnppFwP4cNTykVjafvmtco287KRjUP2FsiKrd71duQJ8bSa
	zulN+8wh0TNwIfAM8bggmfc/rFjhCd5csr9PB3xggbmEMdrqQtRyODZFrQ
X-Received: by 2002:adf:e19e:0:b0:47f:f20d:8d4f with SMTP id ffacd0b85a97d-484913b9852mr14461136f8f.18.1788377734976;
        Wed, 02 Sep 2026 12:35:34 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:35:34 -0700 (PDT)
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
Subject: [PATCH v10 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Wed,  2 Sep 2026 21:25:42 +0200
Message-ID: <20260902193351.185771-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
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
 drivers/input/keyboard/mtk-pmic-keys.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..d758c7743f6a 100644
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
@@ -69,6 +70,20 @@ static const struct mtk_pmic_regs mt6397_regs = {
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
+	.key_release_irq = true,
+};
+
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
@@ -301,6 +316,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
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

