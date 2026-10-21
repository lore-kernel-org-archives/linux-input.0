Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580017;
	b=k3d0+9B/TjoQXOt7iVH/sWUgdsaHljDzrn+mvIx91LbP5UZhbTooRPQ5QWDUanqmn2Q3
	 +vJHAYiWIiJDK3EbwIWijaxGH6IpaoGwH1SJ08xYvwYmV3j8vSTMTairlIdAfeGcnFH0+
	 tVXfVYZ0I3DaJ+nueEboV1Cw25Hk6f68PUMypZspUVYaB3xqHkboosO0sgCcfTIGWXYoW
	 rT4MO8bbewUILRcsz1L+ppFSUO26svc4NysDLRKXDR2QEaYgf3lp516strsie2oyn8pbB
	 HFqBI1BVDpt4fYEi3gE38w99fRn1qeURqIVB6OPtRRLGp4RQQC19Lsjhk6gWrdxGKpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
	b=McOS3mxIuaysf/E5hwx8RG2aTXbIc4vUmYbEg+sdP1TpGLJMzQYwpIlo1jHWZiMWmPuh
	 PZXWQ1gmgYS8a6FHLR9UmRyb5RWTXzGwSLgJ05/ohG+H4HEG0m5o+3ECPLwaT7FdpcXnT
	 Vtu0u4gsWPTFdsjUhD9tDysXdrIZ8K1PhlZE0W3R73SCkmuOTypdl4ExyY79L79ZJplK6
	 r8Mfuj9BvII9xQC5GznVt7lJri9HupcEi495SVC4cmrkRcZXe2stZdO+pjxDVJywO3VGp
	 KbO4Y+KxD3kNVPaFOLZDNnMAfLl0nshaaqdk9y/B0oHFMuVseT/aHDzJTcCRgluDBrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqhnUmc+;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF90606A31F
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF90606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqhnUmc+
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so6500545e9.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792580015; x=1793184815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=VqhnUmc+IfS4dyLcwdf6o8jCet/Wr0E/jiJ3m3A47upXon3dtsVNqNWa67BzvlHBUg
         ctS27FXdI9Vsl+CAa7WYOzKIREPPU7di8eIWog/Ufj+GIrL+tg8tanndzUB7bHx+uhxt
         0JA3zlkJQxmu4y90tnFA8IGi9wup7y4n+aGLTxzHQmWNyaih7TvvP4H2cO37qcgB79oT
         KrAikpDILAnJbn6WW6nHFIcyUnyam7eA9xBRQ/ojAqAhpibdE3sCxV2qS6sd0FnAbvxq
         i4u4Fl/3EPgYMy1vfV2739UAO2TsCYI6ggwO9g5cPSpWXjmNe0zrB+BGOXoMiwif03e2
         +ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580015; x=1793184815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=BVGCI7m0pdLkLN9eRBwD5ez2opdzc6AQWOcW/qW6OkBJ0FxtU6S+AqqNn2Hde0jCLu
         LKrZuYGxigz3rm7nkUHpIh+3CNsEXjMy49TKK88sQGbIrqSFtwqpP7+AI5wdNPG+aRFS
         rjGm/rNHQTennRan/68ytXrY/k60iY4CO+xHfBPm9WvSK6Xtvathnd3sdESnrjSNJCT/
         vP/gEnouZB6sBTsjtgDXEWfC69g0V2cV+DzndcJZ94Wa6S4iCKSvLlmx+rxDDHn+P3py
         NUNWOfc08tAXOdxMQ4CadPsyQHHboGTGM1EdI2fx1mI6mG89vJhLyB/f46VDDl9Kwjr/
         hBVg==
X-Forwarded-Encrypted: i=1; AKwUvBzIHA7I1qz+wXmMRVAx0BpuOSfn4CgXWOmn2qZO9ZrXRAqNTGSWqspftUrPFug/ZbweJRpwRRmEkSIg5w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJbd1i391iVP9gn/A+dHeLMWo+tAjjs+CRSQCcj+oI1n0LpmtiW
	d9UMGHF9kRYEX5YB1TZwCiMT8khj7QrfXEmsrZ/tJ0oK7Lf78n8tCyVY
X-Gm-Gg: AYBFou2FkhFLglSTPgj49mITv+HICVkwYDzoz28VW7HyTVBF0FS3wXa2BUdlEJZKA5Z
	18k4j8QIr48dZe0nlOyuL6OnqOKE7l3eM4wIoy+c1+51Qwvd8mxfGluox/k6KpuBwOusipHrDE5
	lpq/hQdyzrfE7oeF+dRMYtm9iturMNIQdAtd9xDSA6+3osQVcwi/lXlK+LSsmJloRb+xiW4wWru
	rxeL1l0aU7iMREITXOpyl5KRb0bFV+EfKvgYNkl0IfNLMBfQgEyB3H9FkPLnLNRWWJENoqJkdyC
	LlI35jzgweXsPobHmmZPO4sgaVbhGL8r7To46MpvfRAMaq/pNVmfD1iVuuP2v4j0yOQTMeTLGdy
	SWK+gw2Be9LrlmQn72yI/cqrQXcm6KYsXASBZg/rZt6/s/RkgrD5Id5f73dIFxa1e7BHulYter5
	nzp8YGFFhgeOGFl9QOftYAxxYWYnKStzG495r6D8apF7ThRsU9rkmemh9e2E14JnXAsKFqm3Adp
	IqgaKa+nHZU2Ktc3vhawjX1tQbPw+dX5Uksf31dXDijh5wsIADG
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr35588045e9.14.1792580015036;
        Wed, 21 Oct 2026 03:53:35 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:53:34 -0700 (PDT)
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
Subject: [PATCH v11 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Wed, 21 Oct 2026 12:47:24 +0200
Message-ID: <20261021105109.199886-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
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

