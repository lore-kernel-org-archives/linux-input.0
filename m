Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628A348C65;
	Sun, 31 May 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780218645; cv=none; b=PvNklpiyzyMaOFTSkPCGkVf6wlVpt4ZPwOvwBKWgzG+gLdnHVX5QX8OsEpmHHScSmWt405c9rbT7c4eFjPWsmNPasuXghd7KWcrnPhBmHLZwueVA09gKVqs8qd5RuDAORBLsZQ4qaKKXNfj5X6jU5UR6zbAxhE1gTpJS4dx1zgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780218645; c=relaxed/simple;
	bh=6/oMIOAJ1Qzv7x2FN/hHsOLQFSqBCNkvqDPY2Y8JW24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OitWnE2kNJ1poSYuHrSjrxC2YXMeddMVSz9UztbSujgLzbDX9VmwCpObHp4REPNnScqCdI1Y6IzujcVvod2f9J0mRde0ghi51i+NTOugGe6rCrR8wHyVa4bPqJkjSqYP55sGeXTKeIr05m9GOXrYEwvq2yp/LxVu9EMdM/6Rvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXzL26yt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXzL26yt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 292D9C2BCFA;
	Sun, 31 May 2026 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780218645;
	bh=6/oMIOAJ1Qzv7x2FN/hHsOLQFSqBCNkvqDPY2Y8JW24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iXzL26ytLKY2kWbtMH/8kkPcRAd5Ri2U43UyF30R34udyttJ9oNcm92e04e4iPZYJ
	 v9HEQdLnKUchGkU8BQ/li2h4ligNIAFb5b+JKr7Q5RJ4ZzCqb3NdLRgSWHyWW1W2RP
	 tWY60yFH12g+m0itr24pb+mTL45tdNKuWHQqBonIEAgNyfwio8Cb5HUUwwIETHgYLk
	 0vmDetHL4sJZyfAs1RHULpIBau3DsUGIOgjrRA5MU5TjKjI5+AIEJoE3GLyPOSzsnE
	 sH3YhntSnx1RBh1z5wnp2Cme6AcAfGf5v07TimLnNzrV2TQQl75sIzJ/jZYhcRGdxa
	 XuXgocVUctWOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20867CD6E56;
	Sun, 31 May 2026 09:10:45 +0000 (UTC)
From: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>
Date: Sun, 31 May 2026 11:10:45 +0200
Subject: [PATCH v2 4/4] Input: mtk-pmic-keys - Add support for MT6328
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-mt6735-pwrap-mt6328-pmic-v2-4-dac37bf92894@protonmail.com>
References: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
In-Reply-To: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780218643; l=1904;
 i=y.oudjana@protonmail.com; s=20260531; h=from:subject:message-id;
 bh=CI2JtjrfQGfceMW9Mo7uuZDEncWSbsLSjy6NPimDCZ8=;
 b=YumAYlYpzOnp4NdRv+QSZzgC27vFRedblud7yqmZoD1WccQnx+bmUwOBZrHH5iqjvuYbuKUR/
 4msldZHl4rBCGFN1KEIleh8cgcC0AuzhnP4TgGssjazW09rDi/Yage7
X-Developer-Key: i=y.oudjana@protonmail.com; a=ed25519;
 pk=sr7uwnyVqGKAIhvwnIwormkDM3d2VNc3VOTEU1GmsEM=
X-Endpoint-Received: by B4 Relay for y.oudjana@protonmail.com/20260531 with
 auth_id=802
X-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: y.oudjana@protonmail.com

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a compatible string and related data for the PMIC keys on the
MT6328 PMIC.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..6aaca67e7703 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/mt6323/registers.h>
+#include <linux/mfd/mt6328/registers.h>
 #include <linux/mfd/mt6331/registers.h>
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
@@ -80,6 +81,17 @@ static const struct mtk_pmic_regs mt6323_regs = {
 	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6328_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6328_TOPSTATUS,
+		0x2, MT6328_INT_MISC_CON, 0x4, MTK_PMIC_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6328_TOPSTATUS,
+		0x4, MT6328_INT_MISC_CON, 0x2, MTK_PMIC_HOMEKEY_RST),
+	.pmic_rst_reg = MT6328_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6331_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6331_TOPSTATUS, 0x2,
@@ -304,6 +316,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt6323-keys",
 		.data = &mt6323_regs,
+	}, {
+		.compatible = "mediatek,mt6328-keys",
+		.data = &mt6328_regs,
 	}, {
 		.compatible = "mediatek,mt6331-keys",
 		.data = &mt6331_regs,

-- 
2.54.0


