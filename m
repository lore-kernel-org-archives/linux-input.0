Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51E473C80
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273886; cv=none; b=TQ2N+1y7QAA/RkIbukPxF602uDziBYuO/KBBhJ92z/vCidH+9BDQ2/X3Bn4gyZ3tGXrVDNjWpMfgn9II7jaKFzA3YspYMpjr8cGYR7e0twRzNCpWp22nseZUxvAYBQz9dgR7kTOkPjkbZa22CbDz+EKXaAvHXCYM1CJlusiWMTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273886; c=relaxed/simple;
	bh=MpJZZelbDoSsGhggLnNkdS09MYtj+8AjCvq5NJYVGqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/08uSlbxdVdLT2ioHN7DxZTXYjCCvNQkZbO2qLUxXAx/Wr3SXGpu7rBXUokpdkXbfmQu6S36p+pVc1p+X7GLJSOsvKc6HwpxU4o+/jznokzTWycYAd9yHvkPyeNW1aOzIuR4aMedOij/OkiXz3uNKIf5rVPkuZZY2NJoHbqVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhW3XGNZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhW3XGNZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84864086bfeso293291b3a.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785273884; x=1785878684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhOoxyY9XuY/7ZJoPHMRfd57Gx1dlBIuWfd2YjK3Wy4=;
        b=ZhW3XGNZ7CR9OJrfobhBeuCkwuxyG5eJyjO0AT4N4STARvuV3AsWdTModJfjVN1dgh
         ZuUwMN9HPBD3bhggsIoFuLvOp5C3MjHTiLQtDk/wwFUghDUxa7iFHYYTkOiEDUlnx6Gq
         l3iVHA/J2uIS/QtqGBFq9KM07gHkxCUOOObl1YNQ7jaJDsWenvMeXOYMaWjnlYdsPGo0
         97J6FgyEC97TfQd/GRR4y3LinR2ykKeBHMT+0PgTafYnYrMpKmvMRgR4k0qskFQkW0oH
         Dy3wpATl02G2T0EKATTbPc8u6iQBtmYrjW4fGVjKdkCK0ia72K+oqYsWupXY/Qx76syr
         Or/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273884; x=1785878684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhOoxyY9XuY/7ZJoPHMRfd57Gx1dlBIuWfd2YjK3Wy4=;
        b=qwi6Vpugp6PYzhEEprckdsJ664U7p2oAtTRTzKcocsqUFJsms+JzzamaJX0ikqXkWr
         5/A6y8aTGmvQqumxz5CvcquuZXWKTKJ5YXcmhUxpC+E3VEGnD3KmheX6ilTcEzq+q1WA
         cX5qbEieas5UNCxAZbUc3RI0A8CwovryhPqtrLVATj3Jq7NTO0drTsAQIbDqyWus4YTA
         +dZ+Ve77eLvgoUA0gjfg/gUCDJf/NCCzhEppMTciIvSQyBiMI+gKWrhAmf1wj8WRh5ii
         aUyQtCOwy99Kxp/Tv72HvtXYt5Joz8cLo7k1E+2Smaqg3A09DPGfGhhzkhJo8oixze9B
         STag==
X-Gm-Message-State: AOJu0YwqluyTKZdPo/6uyJ0zBdjreeIfCy5reE9Ce4dWmVVdw1rRjz0T
	bRFkYa11CGhpNi8wvbEVULudFD8SK0+NTpxsXZ7GKUhoKBCOxFIH0C79Txy4TQ==
X-Gm-Gg: AR+sD1085HbbWpKaEIrTBWabzoclat6KBKpqkXMwV869jgyaWbw9kkoJtdh7Mx7MmWi
	e56iOiow726s6SjQgKBed7Snq5mcGC8sCUlEKzi5Snu2za6N2K2PT7mT4xrDdGImsq8Ci6iKNuh
	n0UPHA5Q0rmSbzrKfAk8W5NiN8n2+JBCFaqUWmSjGLgvXpubYzUFynN8Mx5NzVvRt9G+9x9AWrh
	/mD8AaPDTX0Ja7Ag1KOryILmWth+1D5nLvUixbl/oocWRKbPvdnhkq+7Pq2uz+OfwfqkNshKkse
	HdFl3+bmz3jtTpA2gf9Vqyivh6UDR9pfDyAfF5FYi6aadNyMbUV9IY2EBobeXlaJS5lW/JTpuWw
	z2V7Yza8AAzf8B4t3h2BI7DzC9x+SC4XFUo8yFA1Ha0DkGhUym5PbKhmWzfwLjh8ciDH9xI/GLl
	hikkJ93oJ/CSnOOn/Z0ijzZAw/fuXxFMMgOtrP+iHwCnXUSy8ONmnrX+chSnLOydZ5gGuocxenV
	xbyYzlReMccuqWvlzqn3yfaSnlOhZbOQYv60uzdUTA06BniQRe4sH5tKjvmisoWrIQkdsVBGOY9
	SqJgfxuhLRZlHLjd4SXnharzTHIKftyxSKhMz8ZgvuejQwkQ
X-Received: by 2002:a05:6a00:10c6:b0:848:2f84:730 with SMTP id d2e1a72fcca58-84e932e462emr3887694b3a.67.1785273884409;
        Tue, 28 Jul 2026 14:24:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb83459f6sm80892a12.14.2026.07.28.14.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:24:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv2 1/2] Input: mtk-pmic-keys: use of_device_get_match_data()
Date: Tue, 28 Jul 2026 14:24:37 -0700
Message-ID: <20260728212438.54078-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728212438.54078-1-rosenp@gmail.com>
References: <20260728212438.54078-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coding it, use the proper function.

All entries have a corresponding data entry so a NULL check is not
applied here.

Remove of_device.h as a result.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..fd684ac16938 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -16,7 +16,6 @@
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -333,8 +332,6 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	struct mtk_pmic_keys *keys;
 	const struct mtk_pmic_regs *mtk_pmic_regs;
 	struct input_dev *input_dev;
-	const struct of_device_id *of_id =
-		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
 
 	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
 	if (!keys)
@@ -342,7 +339,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 
 	keys->dev = &pdev->dev;
 	keys->regmap = pmic_chip->regmap;
-	mtk_pmic_regs = of_id->data;
+	mtk_pmic_regs = of_device_get_match_data(&pdev->dev);
 
 	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
 	if (!input_dev) {
-- 
2.55.0

