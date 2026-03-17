Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B33F7863
	for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773194; cv=none; b=FI7U3A9Uqqp+y4uSpbOK4RAe62kL2WPwIte9n1LioAnktHjHxe6nNaCRXhwo4pkjCPiPj3pSzAqBXdVQPoWVgXWcIHxjsnH7dG7I08BNkrtffwAprjcWookKfnCVb2NPKzMOtjDomSput1tAKgS/pTrJ6ruNR/CRn5sudhnNQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773194; c=relaxed/simple;
	bh=Rm8YpEh5JQQnoCUNqX6MA0nwUURcH53A53KBf309gpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvHHPqZxjrIIdtBwSjXmp24PtoPAmpwAnjjjiQFUJbuCffWccxx0oCrkiGyHtUiXP+J3aI3LwJGhFt2TPDstcBf/iwjwSsO6+haAQb7ohIbtbOWhwcqfr65HPQqkWLD6pJhzEYo44zenxDE8wuD6j3C9YkEgOeZWdVfMwz+0bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkzHPmGW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkzHPmGW"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so14371355e9.2
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773191; x=1774377991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx9XOFf+F102qRgcBU1Wfi3j2xvaU33q9Wk8R7lTDqU=;
        b=CkzHPmGWyASMqdFQKuXmso+vWCPYcDPbKacXTQJJbYYnUIisRPL6SEQculzvVNxiWl
         gZ/U+14qbKkDCSqpoLSPh4KmqOn5NwsOYjhrsfxoP60bZ58ZyptSVwIg2iyrmw32eXZT
         lqsRUrHrD4Pdj5iLbUVgxnPz5YuxhBlFGHkJ06WJsx70sJdN/SgPLe3Fw5vOD6ZMQhtB
         PY0y/ylw+YRReR6Bh5+Qndz3PSpHA306FQIpk9aMsKkIucihW5wMzqiGVvwLFTHyAPme
         EaaP315NoY8aJ7qZXRMPNBlZqfcgoh9Rug+IAUKp8b1ryIPaJ+2SZALc6FI1C3dhHoa4
         T9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773191; x=1774377991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xx9XOFf+F102qRgcBU1Wfi3j2xvaU33q9Wk8R7lTDqU=;
        b=NG6WS90Z1KrEDYX4h4lejj4gjJdZog8Cx0Ho4dK0dCEF3PwjZphauKq+eY0x1IfFr4
         ISVTPYtERH88SaAI+6uftb01ch3KqilQtguOf7sdZqCuC+v/Ebdf3WujwKwmCuVCDJsR
         MQiJ65bILCPbrl+4l7mfNuxxNvRpmJUvjc3iMSV/sOb5YSYuP6uY1Pij1VHXnjvLOWta
         JK+j45BD+evWi9Ty/yunXCUnH9rojKNNbc5QAX2SZN7VcjYHET77inGZ01EbQnLZkOqH
         fBhd28nDEfFd3nXwVY4rNFSMNr9l5EjqnC+kITvluytbD+gKlLL6wAsvrPcbrbOiW6DF
         HJsA==
X-Forwarded-Encrypted: i=1; AJvYcCWGgmAZM5/nXDNQv0tAiKLou2NjmQaQUOIVkVK6e0qgfmIyQjhD5XTCCrqL1TBQaRWYt2RzLWVrkVopyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC4oH2oET+oqsaXMoi3+JDKV/8EEdKWOx6FcPWyrTcJlnkWlrv
	FlpQonGri88Ty7OzHXu0Wiqqpv2xP0KKzID7tKQvRjyD0nNyl7UhQxaf
X-Gm-Gg: ATEYQzzcHUV2dmkRQz6i9Ku6zW5lEMEYT8fBSZfR6YjZBqFj0RRLmGzLfjZJlXIKkzU
	BPPVOOiAcHZUr8CgA+zfasosHnq7fLlQQ4BFfdzeDIZtS1prVhZyCjaxOJxuaiRtczJkGLu4uen
	ju9NEibHxK1h9UO4PjphdvFQCBAYDcK8uZ8pnDsXgurOw3L8Pkjjwft+XwoKQzdwdQjrm9LanWe
	lQP4OwwXM7izbiHg1CFK8+gu5b1/cbIb2Bqf762XnHBVSMTNeu8ks/11GpoeKYKIiu3ihu+NhG0
	YyY1qkr0eezL/Ug8/vgZyMlv4jozrJa+K685+N8wD6GqZrPZKVCYKgVAaIIxEw7RuPNPh1mdH3g
	F02WlZ6PhsRek6ekJCf3OVM5ssyox1kHTYI/9sJrBckFcBYFQxe581ELupI3iX/u+OtbI5k7cih
	eknihRfqQdGz2Tt0sfpuo=
X-Received: by 2002:a05:600c:a43:b0:485:5981:1423 with SMTP id 5b1f17b1804b1-486f442e6f0mr11506045e9.3.1773773191445;
        Tue, 17 Mar 2026 11:46:31 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba760esm102725e9.24.2026.03.17.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:46:31 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
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
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 6/9] input: keyboard: mtk-pmic-keys: add MT6392 support
Date: Tue, 17 Mar 2026 18:43:09 +0000
Message-ID: <20260317184507.523060-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317184507.523060-1-l.scorcia@gmail.com>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
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

