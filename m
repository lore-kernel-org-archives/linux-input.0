Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE392390223
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921549; cv=none; b=qdDCv0WRkHo+UxtVBn9t+d+t3S0SRGGKsvVg2LnxxiTefUWbtCgdjoCG0kvUqL3Wivru559lHfXrUVs5GZhnDL07mcm1sNHW+3kehhvLV4qAPBtp9DCtQm5k6G0TJ/zVPpjhAzkMQjjbneGbGe+Iszx/BewMmBZAHIR+oGtPUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921549; c=relaxed/simple;
	bh=n8sVAquVN8BEO/fdYcbz1G1zIp28b0thF6Sl8tfgQUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ob5KNoSdsnQcEAaqK/JkOlCky8vMmaAQU5EKoJfbbOUervCF0FLyRwZriG+2kof2rlp4bDV1cDNLN+AQR7gj7JDkYPwT56ARLmog+BmX4MRdmLZK8wmqiIdB7Vzk7vbKDojnlOYbbgtvv+ESRgbrI/G5uYguv92Lv6I6VnTAIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfEP7BQr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfEP7BQr"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b458ca2296so91856915ad.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779921547; x=1780526347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVybf3MGGtEv6SObEhz8sgYocMl2B9mPaPK11udoxs0=;
        b=jfEP7BQrY8qHyDSvhSb9K910Pn/30lhJ34Qr2ik7abQzwsIgfDymvrxZySkqhU8p5F
         PBU2DUeIscLYVi74N68jkdc5MsCzsZ+EuHd+cwnE932SB2WPlm2hOxmtKy1hwvqD4Y8t
         jPTYy5clELOZAHXRIcEC38c1+7Lj5UL+i9QQtsHgNHFaXbijnxcjHK4ax0rCN1TEYvYs
         9am+3Ai9C6hZ/976yISbHWzP8tQ6IIbcTdZS41kZSGRXX/lfh2hZY/17AohuEU9d7gzf
         +WBTHWn1aX7wZYm1NsgrguqgcO5ppmYg7wI2A7ZHFxBd8SuA0BR6YAOhv6zRtSu2RS55
         goXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779921547; x=1780526347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVybf3MGGtEv6SObEhz8sgYocMl2B9mPaPK11udoxs0=;
        b=SsehgdrnkIGtzqmmCDlhK939pcpA6XtXlIJ6isAHWo/bEB1gkoXEn98FyVISpuU3sJ
         G6q2MU3XSxAWN7cBE6F9OgflMXupCxOAFFl3JtZ61q/+lggXGVpV+1T91/d3ezjCQyPb
         WbxN9blNVO7cIRkwMR0xOPvwS1fz2aj51yYZIg1buofX+pTh2aqWb35gqaYjMmI2R21V
         c9DXtkQAURJgbOejvg3gnIfLI7oFxW+jrqiW+aLU0Dn9nZPnYiP18XFsjnJ+CKLW9iY6
         Mq7YdL1Rekjxgud2pX1g+acx2xodVdU0cl3b9QO5Ufa4YfQuP/RXJXXqZMdsqEotbC48
         Fs8w==
X-Gm-Message-State: AOJu0YwCJDJdCxbdfAIz5Td5G5mkOpp2zmeznqvinkT6qZhKgHsOp/GK
	f5QBkioI0+1UQX/QRAla0+B0yq+eNmUbSjguwmfK43E9bliAuiYP7ojHi19VkNCj
X-Gm-Gg: Acq92OF+cDYTCUGbZfF+2U1i3mZEAUOsFgnDot6EHdAjUYPbKLAqZDnHumr3TVFcLey
	qpDVjaNXmvKXoKfVp1tbD7ku7Zf+iFoaU57eNVV7aBRMvJQAVBgpbjvjxvvA/ELJ+CRJDwNohq+
	FtQqZhKEx3yQA67ZW8a5Ogsb+5gOenAM26b9S+av4RyiplnxikFzz+txzaZ1Pt/Y6YnlPZCU2wM
	i3ffGtoqw9llCL2hIxzUuDLeGjep07djUX2dby6y8O1dD+X6cfwHIPTWmV6YkTLczpYGGKcsDvI
	V/Q21xf+WfS8UR8ApaAscmIdgXVa/aD6oFP0M0ekoJnnXH0PB938JIyoJwEZFZrw0gSFgdaVRER
	Isy1lDfQ4XIv7PvtlulUMjsyi52pFGGb4mUoHu/NXaPsk/sQ6BTrbdG4rRUqkzhpQ+Uzp8exPCV
	/LFyvoNET0e+UPBplbL3yOVqyl7NO7zs3BiiW+rn84+XHL2IzhHIgkRcO6ero1OwLmSm47Jq9NX
	ATwHeXZvcrOk969ku51+G+NCwcJQdXMWBn186rTE0ihVA==
X-Received: by 2002:a17:903:4405:b0:2bd:8822:d8c2 with SMTP id d9443c01a7336-2beb06bc0a9mr260255915ad.36.1779921546975;
        Wed, 27 May 2026 15:39:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b51aesm211397955ad.19.2026.05.27.15.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 15:39:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] Input: mtk-pmic-keys: Use flexible array member for keys
Date: Wed, 27 May 2026 15:38:49 -0700
Message-ID: <20260527223849.25139-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the fixed-size keys array to a flexible array member and use
struct_size() for allocation. Move the key count validation before
allocation and use for_each_available_child_of_node_scoped() to iterate
only over available child nodes as the allocation uses
of_get_available_child_count.

Also use a key variable in the loop for clarity.

Use of_device_get_match_data() to fetch the PMIC key register data directly
instead of open-coding an of_match_device() lookup.

This also lets the driver drop the of_device.h include.

Remove platform_set_drvdata. Unused anywhere.

Assisted-by: OpenCode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 55 ++++++++++++--------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..5b8650f46105 100644
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
@@ -147,7 +146,7 @@ struct mtk_pmic_keys {
 	struct input_dev *input_dev;
 	struct device *dev;
 	struct regmap *regmap;
-	struct mtk_pmic_keys_info keys[MTK_PMIC_MAX_KEY_COUNT];
+	struct mtk_pmic_keys_info keys[];
 };
 
 enum mtk_pmic_keys_lp_mode {
@@ -332,17 +331,25 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	static const char *const irqnames_r[] = { "powerkey_r", "homekey_r" };
 	struct mtk_pmic_keys *keys;
 	const struct mtk_pmic_regs *mtk_pmic_regs;
+	struct mtk_pmic_keys_info *key;
 	struct input_dev *input_dev;
-	const struct of_device_id *of_id =
-		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
 
-	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
+	keycount = of_get_available_child_count(node);
+	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
+	    keycount > ARRAY_SIZE(irqnames)) {
+		dev_err(&pdev->dev, "too many keys defined (%d)\n", keycount);
+		return -EINVAL;
+	}
+
+	keys = devm_kzalloc(&pdev->dev, struct_size(keys, keys, keycount), GFP_KERNEL);
 	if (!keys)
 		return -ENOMEM;
 
 	keys->dev = &pdev->dev;
 	keys->regmap = pmic_chip->regmap;
-	mtk_pmic_regs = of_id->data;
+	mtk_pmic_regs = of_device_get_match_data(&pdev->dev);
+	if (!mtk_pmic_regs)
+		return -EINVAL;
 
 	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
 	if (!input_dev) {
@@ -356,31 +363,21 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0001;
 
-	keycount = of_get_available_child_count(node);
-	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
-	    keycount > ARRAY_SIZE(irqnames)) {
-		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
-		return -EINVAL;
-	}
+	for_each_available_child_of_node_scoped(node, child) {
+		key = &keys->keys[index];
+		key->regs = &mtk_pmic_regs->keys_regs[index];
 
-	for_each_child_of_node_scoped(node, child) {
-		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
-
-		keys->keys[index].irq =
-			platform_get_irq_byname(pdev, irqnames[index]);
-		if (keys->keys[index].irq < 0)
-			return keys->keys[index].irq;
+		key->irq = platform_get_irq_byname(pdev, irqnames[index]);
+		if (key->irq < 0)
+			return key->irq;
 
 		if (mtk_pmic_regs->key_release_irq) {
-			keys->keys[index].irq_r = platform_get_irq_byname(pdev,
-									  irqnames_r[index]);
-
-			if (keys->keys[index].irq_r < 0)
-				return keys->keys[index].irq_r;
+			key->irq_r = platform_get_irq_byname(pdev, irqnames_r[index]);
+			if (key->irq_r < 0)
+				return key->irq_r;
 		}
 
-		error = of_property_read_u32(child,
-			"linux,keycodes", &keys->keys[index].keycode);
+		error = of_property_read_u32(child, "linux,keycodes", &key->keycode);
 		if (error) {
 			dev_err(keys->dev,
 				"failed to read key:%d linux,keycode property: %d\n",
@@ -389,9 +386,9 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 		}
 
 		if (of_property_read_bool(child, "wakeup-source"))
-			keys->keys[index].wakeup = true;
+			key->wakeup = true;
 
-		error = mtk_pmic_key_setup(keys, &keys->keys[index]);
+		error = mtk_pmic_key_setup(keys, key);
 		if (error)
 			return error;
 
@@ -407,8 +404,6 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 
 	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs);
 
-	platform_set_drvdata(pdev, keys);
-
 	return 0;
 }
 
-- 
2.54.0

