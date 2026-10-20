Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517871;
	b=zrFLN5aqW1Xn7sqQ465W5O7GxydBUX0HzhQCnRNk00RDSYo0TTURi2IID/6SuGkbgnJg
	 LwkvPIeifXAgIa7hqL5KRTjn5vA5+BkxERhjbj3UDQor+w7LFQ6/zNAaeIo4CLdunB0kH
	 QWKHGzTQyijy3JIi73YxeJJfCbJXL4r4XpvytkQJjWWhsNYauuxQC0o5yw5Gncx6J0goj
	 pqqRPE0q/yKHvwhrmIFugrub7f0aPLHnzQYGbibQVUarYCHgLVhqjtCpT6j8B+Zep43SE
	 aCeU4OiOkIIsDSwCtMp8tWxUWlNo/wFrIvBUQs9lIZetLXcEIaNCpndg4FAZdCZMqtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
	b=ZUHezhwe51qZhU2pyCpGCvuvk2hAcpFHLx7Vk5Gk7YxvBURzus4h4vCTKJIlowEASw34
	 V49io1wuJpB8SIxcKIoJE6y65woYn6ErvqxcD4z1Lv7Qtv1D9MUF9kw5iFxpIhc0pxy05
	 eqGPTWFNfnNOX25kCIfWYk6JGd86ZckaWSTfHeLQIiL0VZ6VpAnaoaxoItRibD2AM4E6k
	 hC0XOGjrcngztQ1O77GjLzlhFgWqP42v0QsDps/1Jf3hSp/aG1zLg2Q6Fzd9XEIiN7fIl
	 foOq25IoiLWhwRDCVr4hAu7vc3GMLWzc4A88LHCHo7PYNGQ76CnMTJ8zn1yu9+Ifuww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L48N4DES;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08560A4AC9
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C08560A4AC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L48N4DES
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so24345725e9.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517870; x=1793122670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=L48N4DESJPMuvTIdKy+bXJAL0dZnouK6wG/XF2R1DWSaZzsOTOsvBy/sGuBN3pyhEQ
         QAxIwReDLqmluK3WkWr/pb/iKA/CgH9xAf7bJUntUWGgIwRFGBOxJgAffbyEapj5s5Ax
         Q0WNz5FmO3zq1gD0DL+xeT8pKuIgd4ffIHSk06vnA1B9R6Nf3BwiTdapE5X7ZjQTSIbW
         IF57BlZ10S87JVLWyj5n2lu6oSZlmDckSMXEd3+A3l8+OyjNrLGxUK55CwPTE+OqhEik
         cKpe3KC2ALiE2wEBsknqgggnq0gITQtCLCSXTFp9yoYlHP7WAlPYS1LC9DOmKC+1cAHm
         BjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517870; x=1793122670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=F/Ztj7Vk/58pygQlMZlmWe53VVUW9622cGtYN4K/HBca1jsJz4dWyasDvTZ5ZmAUTl
         RrzvndwE5CfgVxZMaNr3dHE4y8zDjoKEHqq4NgxjXVmlpdUdBvt7OxhzM9CqUfGbekZH
         nzLwjs72/exfH6uGJ8X2qXWB1v+An+fWFu++Nx4HbXVl9I4a3uy0YkWVTHaQvdGbXfif
         3bVmRYEn60q2D7yBfqBMIyjADjP34P9UNegLr7o/jaxrm2l99aZD7QxSsWP4bF8tzqr2
         sBq8DoYqpvBESNTjRkdoPUtixQWgkv40d6mDkMJpZrNXxbCjQdf66A1YbjTeJUYD6fCn
         NcNQ==
X-Forwarded-Encrypted: i=1; AKwUvByrTixR/1NXLJ5AOZ2KSsMQhsQo3VbPEgq+NOBSOSvF298N9V1t7km1wSIRW0IDQjNoBFxP8YTvsUlCOQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI14rHi9/wGF2YuPrqVjOT4+ddeVZsF3m5WZppiEzW3CE38LKw6
	W/BGhaVWdUkvKna28Or5T3iWwsIHUpgD4ewSRXZ43eEroVoHme05+iXt
X-Gm-Gg: AYBFou1f67En45dWjVM8siU/7jMLfrhe/ivpSBxqiK5rU7092JLlxALndcSwqqKkyga
	CS+Q+zfdVS5t5UmJsqguRLcOAXU5XIP1Cehxqc/hcJ7BResh2KcbbUFMtRv9FPvdIgjqWEguY0t
	p1BKC6KBjOtbNPwk5MaCFb4RET6HLxCYZKqFjE1MEwsYCVTZVPXFxj+XP+yv1SSQR/M8GY15cuN
	O80WnhLLXEcyvzk1w2uMMbW6h2/F/37gmkGw627wLhrsRweogc6G1EMOzAOvI+Zn2jfMLcXphk3
	kF1Gh6N9YbKQjhY7YhvxTG6y13QM5YuUi2OTTMY5T1K9F9RrDRF4HOq7bYp0w5p6w/4XOBwHzFv
	xO2pdkkt96KIK73kFjLdEv+un2TnGJV02xFunn4uGz64ERJYjy09Aftx8cDXziWmwhXRXeqzG5X
	W+9UdwGbVktdkm/wK/LZC683rg7uVcvnZjwUVvHhbxZoJjZUgQCEDI7J8kWzAfUcRiei6wZK1ZM
	6nx
X-Received: by 2002:a05:600c:8706:b0:4a1:946c:953f with SMTP id 5b1f17b1804b1-4a1d7601873mr254696305e9.20.1792517869433;
        Tue, 20 Oct 2026 10:37:49 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:37:48 -0700 (PDT)
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
Subject: [PATCH RESEND v10 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Tue, 20 Oct 2026 19:33:27 +0200
Message-ID: <20261020173556.632798-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020173556.632798-1-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
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

