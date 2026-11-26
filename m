Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795651634;
	b=5JqgTVcRgNzthZhtme4bXH6M/tcsfvOQ9V4JIl3IPhpqYLuwWS7lZcFjvUkdDkOPA5VY
	 kLq6b+3QGS4Ay/r2v1o4y1LgznmIRXsyg/NE0QIBo8KeyEYXsq+t7UTr+oT04Fdbv2QWn
	 Rp3z5uu0CFz+QK/GjYPRE4cQV2H4tO9bpyT7aDBtXjagJdq0lrHbFurX9XOQCB6jPNCNS
	 tKJ9uh6tgF8g840NC5/dLIMYvPB86KoXipCnuYjQhMK72dfV/sTpnYt8lPmPhE+W67Stc
	 cvWbE6DHOTmb3M/Vpcwx8jC517mfjIlLvikVsRGMN+xkljxuAu/bR8JVGD+sFzO0Y2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795651634;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Jm1w8UDV20OXda72KTEVGxoSWqVP6gtwcMTUrb2vPg=;
	b=Y/vN/M0MincSlbjAj9lNdhGIUGoq71TNpuXjdxiBc+kSqj/geKawIL/eQ7TvmXpRVhmZ
	 wC17GMuVpTHFIJVaHYFVa/2BpDzj9b79wYMerg4+X2Q/towp9Xo5jfI9ocq+jngsst0g7
	 lmhYKiUBm+VLCIuv58o/+bmZYFR5dO0RVQLSmqAytR1RyHVzOxRPzgmqemS+1eXGw4V2O
	 YVEA/MHkjzZwnQu2UafDiH24+S4LUVSrKOCVEiS+6XtoFkih/mhfQNUO6Cbr+wblVAQ55
	 uGuv6i8ocKUJgVCTlrr1XBoZLvslEjLcYithCrukn/phYqcko4yB4ihnkJ3EKgIR5Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXx25cDg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644E606A321;
	Thu, 26 Nov 2026 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXx25cDg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795651634;
	b=f9tOX6oEExVQP2C9GcHGJ0F6wLoqBo5Ix6fwUlzDJdwzcv8ckzIi4xojuwjPZOmsZ2V9
	 DvwMQdQKTO1ujpvxUXipkn0WZ6+3/zUwkRxR/HppYhQ93euutYs5BS3P1jdFYpfxl8Ljw
	 IdYNZ6Yt+H/iJYAab2hLaIm7GKWQrHGImIXnB2SMytIhXyOxjtKj84zLatyICIr+opkcf
	 8hZ3iABusfF5DVuelKN2LtFw+ki1YoOSCBaDWVPeZ/AJ2ROB/jIqsEaq+6ZK/2VbrEnSM
	 rezhYi/CaH3uMd8iTYU7Cu0HNjLXNL1MguqQGmGnDsmYMVPr7Fg1kuKpd/f9pSqN/OQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795651634;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1Jm1w8UDV20OXda72KTEVGxoSWqVP6gtwcMTUrb2vPg=;
	b=SghH7qBEv0GX4a9zM7akcW4EZl2GE9VCx9Myt+3jZRR2XMhpwp7Hc+mrIllxjbwIdQ2y
	 3ORBzA9POrzx6zK5PSfVNoE2hRk2CHUf75js+bklxSgXxiBEXZ57ygEWMbjDWP9R5EfWU
	 QxqjlV7T0k1NouIXNzjkx9Mr7CNT2QQ8luONbGBRSI8k179ii3jjfYHVFCiGPubdw5LXv
	 bDLyok/DVlZLaIYsqM6VVjVQgzqE+JSReSEooz8lQX9EFlYLiqJViLi6o0MkuWj05jiWw
	 fNsUayqcgjUMrnbLIMXTi7X8QWo8YzscA2AScMVPfwmDSJs3B0gAwK1R24+TN+9EGiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D5DC61F000CA;
	Thu, 26 Nov 2026 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795651634;
	bh=1Jm1w8UDV20OXda72KTEVGxoSWqVP6gtwcMTUrb2vPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=BXx25cDgUD2Figfsn72R9ZW3Aoin+/utyGmJjEmT9GT60p9hFna3oFqACZc5DI+0o
	 vpJJBY80obwQrSvAP6Jr7E26ljYTjJw/hR3F23gPFRDumLpf9l9krW0Hhd+U5vSXJF
	 E4aUdzwL2JnfWYgoSXbfNnT0cazTZbJ8g91JgmXJNuC5NyqivfNix4nkZG3Bswzc70
	 oP4gX2EywWqhTnzNxZxTaHwuPkvDytQROsnDi8Nh03eTTvp8ULGuMDU2I2J4jBlJ0I
	 BhBra1FTNtZM2KZiNPTYlL/62XWngeMdC582r19o0ETIYRHkwqv4p+gCRm528/Z3ut
	 GlIG9y0Y29hBg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 615514D0D3;
	Thu, 26 Nov 2026 00:07:07 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: dmitry.torokhov@gmail.com
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: mtk-pmic-keys - fix MT6358 long-press reset
 bits
Date: Thu, 26 Nov 2026 00:07:07 +0000
Message-Id: <20261126000706.15649-2-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795651626; l=3562;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=8Ps8xDSOLQnt6t9Mmu3NbmTDcsWme4WN7eNETt0rZx4=;
 b=AJVBhriT9ut+JHiqczAXuXI9TjkJQ/GIfCqGAZjc8xS3cMU3/83FthCHrGxSlrCqz4NIHZPRF
 LLBUBAI4UcGBlH4n6LyaXsIaoKQH1NnGck6Z5spgzFC5EehMJRAfVWP
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

mt6358_regs reuses the MT6397 layout of TOP_RST_MISC: BIT(6) for the
power key reset, BIT(5) for the home key reset and GENMASK(9, 8) for
the long-press time. MT6358 and MT6366, which uses the
"mediatek,mt6358-keys" compatible, lay this register out differently:

  bit 0      RG_WDTRSTB_EN    (PMIC watchdog reset enable)
  bit 1      RG_WDTRSTB_MODE
  bit 5      RG_WDTRSTB_DEB   (PMIC watchdog reset debounce)
  bit 8      home key takes part in the long-press reset
  bit 9      RG_PWRKEY_RST_EN
  bits 13:12 long-press reset time

The watchdog bits are set by the boot firmware in coreboot's
pmic_wdt_set() for MT6358 (mt8183) and MT6366 (mt8186). MediaTek's LK2
names bit 8 RG_PWRKEY_KEY_MODE and bit 9 RG_PWRKEY_RST_EN of
MT6358_TOP_RST_MISC, and MediaTek's downstream mtk-pmic-keys driver
uses reset shifts 9 (power), 8 (home) and 12 (two-bit time) for MT6358
and MT6366.

With the default mediatek,long-press-mode = <0> the probe clears
bits 9:8, 6 and 5. That clears the long-press reset enable as intended,
but only by accident, and also clears RG_WDTRSTB_DEB. With modes 1
and 2, power-off-time-sec is written into the reset enable and key
mode bits, while the enable bits land on bit 6 and on bit 5
(RG_WDTRSTB_DEB).

On an MT6366 board (an MT6789 phone) TOP_RST_MISC reads 0x0225 after
the boot firmware: bits 0 and 5 (watchdog reset enable and debounce)
and bit 9 (power key reset enable). Under the MT6397 layout this would
decode as a home key reset without a power key reset, which the driver
itself can never configure.

Use the MT6358 layout. Its values equal the MT6331 ones, but the
fields are defined separately for this PMIC family.

Found and drafted with an AI coding assistant while bringing up MT6789.

Fixes: 994673dc6657 ("Input: mtk-pmic-keys - add support for MT6358")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---

Notes:
    Tested: TOP_RST_MISC read back on an MT6366 board (MT6789 phone) running
    MediaTek's downstream driver, which programs the MT6358 layout: 0x0225.
    The mainline driver with this change has not been run on hardware and
    was not compile-tested in this form; the change only swaps constants.

 drivers/input/keyboard/mtk-pmic-keys.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 6f14318..422a1f4 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -29,6 +29,10 @@
 #define MTK_PMIC_MT6331_PWRKEY_RST	BIT(9)
 #define MTK_PMIC_MT6331_HOMEKEY_RST	BIT(8)
 
+#define MTK_PMIC_MT6358_RST_DU_MASK	GENMASK(13, 12)
+#define MTK_PMIC_MT6358_PWRKEY_RST	BIT(9)
+#define MTK_PMIC_MT6358_HOMEKEY_RST	BIT(8)
+
 #define MTK_PMIC_PWRKEY_INDEX	0
 #define MTK_PMIC_HOMEKEY_INDEX	1
 #define MTK_PMIC_MAX_KEY_COUNT	2
@@ -110,13 +114,13 @@ static const struct mtk_pmic_regs mt6358_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
 				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5,
-				   MTK_PMIC_PWRKEY_RST),
+				   MTK_PMIC_MT6358_PWRKEY_RST),
 	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
 				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
-				   MTK_PMIC_HOMEKEY_RST),
+				   MTK_PMIC_MT6358_HOMEKEY_RST),
 	.pmic_rst_reg = MT6358_TOP_RST_MISC,
-	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+	.rst_lprst_mask = MTK_PMIC_MT6358_RST_DU_MASK,
 	.key_release_irq = true,
 };
 
-- 
2.54.0 (Apple Git-157)



