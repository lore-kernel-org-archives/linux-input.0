Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908482;
	b=pBZjzC5/rUzhVlEUL+sVqI2olmza0HzCgxHcwQS+Q3Xp4WteUPozqHNhZTb7jVWAcPb7
	 m7k+2hjDQhsoQRuCb/Fn6AiWOyI4Se6KCdPgMafX6yMJRZuHWd+wwRv50foxjzuP5kKoC
	 hZrAGqai3PhX3OYdyU/e6GbUS8uqHSoYR+2P56Pwd2wBTiYcAOi/fEyCya3ylPz3iVOKj
	 4T/cCkdIhw1r0FidQXSaH+cfglW1mkZZTNYnT4v0zUNG+t5EY6uL/HHurbaFZQFcxgVU8
	 wQaJZoBBaDF2IVW50H8QyxSpoqtr/cCvcpqM2HR8gsHMOu7ixSwMiZVJSptYSaGLFHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
	b=5OaUvfgcphFFLlHd3c8uXWwWsTo3gk77ltVVrgS8krBtpnfQ4JB1HWL5h5Dh8Rsmp+zV
	 SeQCfkM69fXcYA5AO2Wkc02Gu3mSkl+EpAVVN25cNARjuwEb7cVfzDvxcDuwuEzpRPFnn
	 ZABYfNj6GJ8NN9eNyhHqDOSllS1PFA48e9EY5B+0TkZkD5qrmy22a2Vkoix4iJvvuAtGw
	 hZSBU0brw6FIpqZd4uYgDmAeBiJSjg1LIDeDSHxLvXI+yZd2ecUsh3tNSpfcd+pDu7o8N
	 4vZuHVzv5vJUGZGUuyPy4Wkvz97G7nVTe6dP9VDZUC68Lh11xO9iSU2l/qRP7s17QCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mk74D3vu;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB10606D51D
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB10606D51D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mk74D3vu
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so15133005e9.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793908480; x=1794513280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=mk74D3vugzXXG3Z0UBbXjsO5vv9fwUFrHaLSmpnapaKLj59lrS9CIODh6FYPMUYZcS
         iuVOY6npIpTyECG3UKm/6DjRfv7Y/TDgKQ1AzFdDHjRsU0ZIkgyFcwOLF876FS1ICGvI
         ShCDrobFbRdiXrsDDMd+E8Ndr5ox5zt37iaWXNXgSrfPn9bC4VDrIuVqkGFJEzW644KS
         vQr0Yw2iDSyZoWugNjf/CoDAh2E9n+A8sCBFV/R38uNwSJQeE55efL7mlobvAzNnGm26
         s6XraeIyXitNtpKyEtON1RnF8IxIudfAmDMsnVB0ypomWp6eUkRr7KPemXgud+VYvlP5
         M/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908480; x=1794513280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=RfYiGblvs6YuZS8GjYLiDi4ewRVDIbHpockj5jENDvGLYFxlmJnlQ5uWxrWI0emrod
         LcLmblsq48veqelCFADvBJi0g/NSmd+VwP6q0soY6OXFBbEqIEbE5FAwzjiVxRYcXH56
         fn/V3uKIVc6w+OOlnYbUrxMYUtoF2HMelIEz410AR+plaF4eq6bdRGlDoRa4/jFGyVUA
         Yf6ykjDeC66YtDiS3fv6akRJ4mdKIN221Q7tZ58yJvLiAZrvVXTZ7YaX92ZW6cKBnguF
         +WXMC/1KqypEqsj6gY6ldN5Ft2FTEAA5Xoo7dww4aJbnB7m+5sTrECaOwmM7irZhMdhd
         mHdQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9eQL5oRxy3KebefVZa4Xo9gMKWjrdRfdaPrXfxOROL6SlYCjt1mEXbsbGIUhQ4WCqluNZhswLi/3pYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cE2LWw6pCf+dWhBJ66t/NtkyxbKBV0pZ1HAr3lFaUea/PA7qB
	PwiIeyYZ7qGsUiAHNfXrlIV73JKYQAGRuqNkGoGA/DofAykWbHOYaf94
X-Gm-Gg: AYBFou3YgZXKGRpp4T+ra1L4OFLftsWvk774w+E0JvFS2Z4tXGDomkoC9o9lIdWSHq8
	Yg1+e8VSUCY5NfUXQRBnkI/qicc5FlqzXs4gEqrzH/x/OswrEal99IAk8RlywHH7KmSPbTh7jcl
	T3R2z3drClA5gU9A+1ycJVehv2yrK7Sb5vcPuZNTv3gLkVhlZulT4Ta4WnBbuDIbm+N0xia/UVd
	NiXmqe2K0zDhkEoACPHfizmJzc2r7y7rcoEaWree6O7nDh7rlEQvPt28ugSZyyg1ByAOYJWCh5A
	hVJvbBPtdLrZpkHj20jxkNvmLful9TclKOOL/e+NJNkLfo2n0+Nf0LAdFofa60uFmqdBVcHXZKD
	ZwIJLTdq4mDeGM+oy2vKTwJwMZWwBUhegmrYOK5YCcTsOwx8ss72U3hHtmhvTeh3chdto6KLUE5
	T0aJus7FStb7MQVVvyoBcxjNOme9+7zh0CXE/WGA3JmT53AqEmOl93YgSZ2wSuj8dbahzdIQmdx
	qs3A/QKfmB3Pw8xfTrhMy/7oo6LOKa8JNV/pxClakdK43Xbj6lGNPJFZ6QoFOzkY01LakUqia1d
	g1xvc418C15fajWweuYS5dR0
X-Received: by 2002:a05:600c:1f95:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4b6e063f1e5mr3032495e9.29.1793908480210;
        Thu, 05 Nov 2026 11:54:40 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725fb0d1sm83862895e9.8.2026.11.05.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:54:39 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org
Subject: [PATCH v12 5/8] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Thu,  5 Nov 2026 20:50:25 +0100
Message-ID: <20261105195206.3440-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105195206.3440-1-l.scorcia@gmail.com>
References: <20261105195206.3440-1-l.scorcia@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
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

