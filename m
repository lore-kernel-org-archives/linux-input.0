Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795651640;
	b=qEgDL58l3fVGbGik91a667j5NfC6XIRuFd0/oNZFQ5bF21vM/vLIkzgr9n7I1FFKUEbN
	 +t9PUmCmmln4SsOOBZ1RmHA5LcxINgwHlUkodaw4nHQ2RyLdSL03KMK6TzkWh+Z2ENZcQ
	 peu6GlzGsR41+jyLeNvdGrjTpOuPvz1Nseo9lIpkxbAht10aZgrHf2hU+y7O3Z+euYK71
	 5bjhWuPbO9fx0NqjPKcibqOf3OGu2PqfN3+1t8MA04n1UItlDQZ6qX9HRWiXhegkCAryC
	 VCMMa/0X9K7dwsaRcm5YUuBV2jLXKEYEJBiyzcYSA5vhmkOMofCUP3Vno1wF0pEHlMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651640;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DmxVWbQtDMQqiEeIqIgo0HwoyTz8oaoNt+L9yRWyVi0=;
	b=H3L747V6UHncxALmVQH9r8WTNvE5MrJHlWN60wfLeLXs5gqE+WpMAhWHAoAjZ0CZbT5d
	 pZJ+Ht+C9LXvpa3SvfQPWZ1LkESVppizuv+ZxtiAZeuW1JhxmyDdXUeLxgbvQN9Pcr//g
	 rb7wm2/1z7OuAfCWpfKUMKB1vYBUTuKj5XwiKk+mL69e04rVroMCSDsachzbj+DMH7aWV
	 38K7UZB/HMtkV5nwlaDFpscPJ6m4Hyj2XT+K4+iM5+QR7cADcWTS/NxTWrtqPtPU65EBz
	 013S6AY7H/ordfwt5SfcdyKTQpdqiqf/O7/+kdyEaxXxiMaWi1UrouzCcQnzWvcLWTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2QlICBy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676B606A334;
	Thu, 26 Nov 2026 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2QlICBy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795651640;
	b=SP5Fo3NU8sOE0+9YgWCsYJ4AuAHLMB0GXHZi50ZJjUXx55/QI+0ZaaGkR9Cu3mV2adbr
	 X2qfRYETyS+WbuEE82Wb8jdO/XSsYU1xhsl105BIhIkTIJCLHZRiMIlHj9p+JbqjaTDs1
	 6wP7gj/qW+SbanSYkkk3WxMa1E14NYzeHVi8BVpLTp+euctL9ndR6rIbtHtKKgKHLkuxj
	 e0bGyITDpNxBuzU+PnKHZP2xurfXhQ9Rl9PiDteMe/8Y7mEE6D9Nl1hkdL6El4fhasQOs
	 ElxUaoDxlS3PcxZIHHczVUqfvNb9YD90jDcMt1dnwBwyX1P3TK13xJFaHN6dxnZ9wyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795651640;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DmxVWbQtDMQqiEeIqIgo0HwoyTz8oaoNt+L9yRWyVi0=;
	b=n7it3IMU267k17a8aao9OZGqt0NlmD9Rj1YhNZtY1fSHlFGu4KDtJJHtuPqscCjFeqwD
	 B3MjKgg62Op91qjcvf68ZdpldiQg6uZ2Dgzi8Pd4N3ML4EY9hNwjevzGdjjGZTMhbVDwj
	 4+I91MP7bDlLtyz5r+NDlSMHBgZtg9XyKwyRxXZ9dGNtCcnya0kJu6g11FkaWPAhcBs+v
	 7qHr7rwD6bGHOoDjqayd89EyPui7jFzNbHfCsm4MfyC7pOQyiF2Erv1vYzH951bHs3iYL
	 2smoj5UXlaCBdC17VUPjbXpEq8x6Tj/vtxfr6A5Dswlq34evgq3MR6Pbxfyg34mXPiQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 02DEA1F000C0;
	Thu, 26 Nov 2026 00:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651640;
	bh=DmxVWbQtDMQqiEeIqIgo0HwoyTz8oaoNt+L9yRWyVi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=Z2QlICBy/rfJfsn1uRKNM1sAXv0f44D+5QzwZyK4hRYU+cCHjPtdmhqIVqe5ccjuH
	 IiNH4ymRRgDTXzrAd8L/NY6UFW05RBLDwrZh9UvXpteHSATLjrfPgjyvHE4+enZ0Oq
	 S5vDsHb2bdCh03ENooNyJxmVTzITiFcG9D4Ge6eH1avGMbVqOr3rqZFU8IPTvH97I0
	 i0GdgFUge6TSkL+86VU5kbTBoMkHtCzdJziOxWmvJjfTiOWjHp53y6gpcX+af7oxhS
	 7c2aD7IQfGgcToHCAZeIVn5g+Rzmd8wHYG2rCZdaf0oxfkbZCBFhnjcXOBR/SsqVoi
	 fvn0K21JvGmag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 81F254D0D8;
	Thu, 26 Nov 2026 00:07:07 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: dmitry.torokhov@gmail.com
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: mtk-pmic-keys - fix MT6357 long-press reset
 bits
Date: Thu, 26 Nov 2026 00:07:08 +0000
Message-Id: <20261126000706.15649-3-iasnezhkov@gmail.com>
In-Reply-To: <20261126000706.15649-1-iasnezhkov@gmail.com>
References: <20261126000706.15649-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795651626; l=2249;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=yS1/exCajzsB+ZjgzM6lYxa7Xj5JiEYFeRxg/8WGWXY=;
 b=diOxS1vAsQ/Ar98FTN3N06GgLgjkeb67CkWLvI1iKnQ9PpMbiXhpSkE2OW6CSiMILCaaZTS97
 ZIXdX5QiDtRAX9VjAbu7HnH15VzFlgcCZcw6/HVMN5w//Zp8zXfLNPa
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

The home key entry of mt6357_regs passes MTK_PMIC_HOMEKEY_INDEX, the
array index 1, as its reset enable mask, so the driver writes BIT(0) of
TOP_RST_MISC for the home key. The other two bits come from the MT6397
layout: BIT(6) for the power key and GENMASK(9, 8) for the long-press
time.

MT6357 shares TOP_RST_MISC at 0x14c with MT6358, and MediaTek's
downstream mtk-pmic-keys driver programs it with the same layout as
MT6358: power key reset enable at bit 9, home key at bit 8 and a two-bit
long-press time at bits 13:12. On MT6358 and MT6366, bit 0 of this
register is RG_WDTRSTB_EN, the PMIC watchdog reset enable (coreboot
pmic_wdt_set()), so with the default mediatek,long-press-mode = <0>
the probe very likely disables the PMIC watchdog reset on MT6357 too.

Use the MT6358 layout for MT6357.

Found and drafted with an AI coding assistant while bringing up MT6789.

Fixes: 297770ec5c93 ("Input: mtk-pmic-keys: add MT6357 support")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---

Notes:
    Not tested on MT6357 hardware: the layout comes from MediaTek's
    downstream driver and from the MT6358/MT6366 sources cited in 1/2.
    Not compile-tested in this form; the change only swaps constants.

 drivers/input/keyboard/mtk-pmic-keys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 422a1f4..39cdb50 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -101,13 +101,13 @@ static const struct mtk_pmic_regs mt6357_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
 				   0x2, MT6357_PSC_TOP_INT_CON0, 0x5,
-				   MTK_PMIC_PWRKEY_RST),
+				   MTK_PMIC_MT6358_PWRKEY_RST),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6357_TOPSTATUS,
 				   0x8, MT6357_PSC_TOP_INT_CON0, 0xa,
-				   MTK_PMIC_HOMEKEY_INDEX),
+				   MTK_PMIC_MT6358_HOMEKEY_RST),
 	.pmic_rst_reg = MT6357_TOP_RST_MISC,
-	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+	.rst_lprst_mask = MTK_PMIC_MT6358_RST_DU_MASK,
 };
 
 static const struct mtk_pmic_regs mt6358_regs = {
-- 
2.54.0 (Apple Git-157)



