Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BA3438BD
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012579; cv=none; b=YhJxUcrjhhlfcW++uOcbnNklhLTrjz4TEWUUAs2/mLyJrN1BDFQqrT5zjwhtLZa6vIDN/QqhxZE9FDCp2Dhp1KO9AvcocA45U4kSnzYwXT3ImUCe2c1iDHM3ykSivfLR9tAH/yo+yjcEdXEG4CTRyVHI2ZYVEQW8iIcze5SuvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012579; c=relaxed/simple;
	bh=AcXlsSOi3A26090BSV94lwQgs+NIh3bx3C/0rXz1gAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mawMazTB05140w2hjXbTk6jlL9KI/GOZMjCnGufswJVD5x/Y4sKdarh4qk/b88+ZUE/6CatHJFfrtua0AjQOqcfJy0IBO45gmU4lYfZzHctFDmFC/GlroIOTG9GUo6f/3vavUKtuMqklXxa9FxcCNMyXTe7lkb8nAJQt4gn5/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKVzdfER; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKVzdfER"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf2247e38eso556025ad.3
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780012577; x=1780617377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdkMSexsyMB1hw8szrf3taKS9p1kvVYpBmWW3eaAw/8=;
        b=cKVzdfERdr8gGIJHrWKwMtO5zrtH7parTuPE/0nr8Q5rVjzZl0hdW9TZ8mVF5mVoBQ
         rUGL+jIkiBQfSvXdKYjGcU7wLgapZUK3cA5kyT46z2IcbzqPlkewHgVFN8oD8hKjdOac
         edOE1CNiiT36BH8GyEqIe0yGPYxD+fuocOZdJM4ffG7yfM30Ubeoa5Pa+Tgq2W6klek8
         pEs8vLfO3MdwUq18/+3xHznkQJH9NtZ5EkJB71J3YlTEpSbuDUxoe8gdBBwEV4WrYph+
         YCzP8S+yjEuS4rn4jjObCQfU6WOKxT61orHsWburZKG8PVyCudSo1pZTDWNfcVQy21XX
         6auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780012577; x=1780617377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdkMSexsyMB1hw8szrf3taKS9p1kvVYpBmWW3eaAw/8=;
        b=d6I62xJ+4pYAHKtCwWVv4n0pbnzD/LVWdZfQJYs2twm7xhUT2KMardZWsGGAafuhtl
         MT0PVPAv172vVaSbJgfrfoeEPj43s05hllyCGXliOVroTqYvLiZ5kw0ZIEHkgye7m/3t
         +x3Qmb4fOYgiiOyZ7QD91k+pMJthG9bSs0s5DChLe6vPyjfhcnWSdAMfy+nVF7OUN9YP
         xaT/TDt6nllETNtxft6Kdy3C+dT+WaLDJUTEm1s+p1dCfxgy15u9ZbsEVbNOR8eb5Xpp
         CB4kAOQR+iG0Db8SNZuhz39X4cu+aTMNIsZ9SXKVEXm0XCrZwXkhurmkLKBLL1ogE83w
         ZTvw==
X-Gm-Message-State: AOJu0YwpsAj1o0JdX8yTwwVVyVEXrWmMV6mJvY4DETvvD1Wi+WjZXPXr
	RLWvr0EtfPRVIyRtAJi7reu8A9JDpnsIuBWZskVEU9lnTw3ioNwNNh+XrPP9yWvw
X-Gm-Gg: Acq92OFYErteE8FDlZ3STpA/NIiPWbaQQ0X+0lEb0Lfzh3KwdzTw+TVSZQuq2kMp1Wg
	Bto2DKY9kp/mbVQ5CnipsHxDhg45qRxGsPoeWDDVriZCXA8wCibJc0RWoYnt0Z70hWMcKlJBSME
	1sPt7Jkogqdz7a5Zl5Qesll2aOpopSXGEcy6C+nqDyh0SvzlgU7ZGU4tXBmv3g2gOdjNtnMDQrA
	UGxP2esaEPTePya1mVHR836iTwh9Y3Y0gM3WSOJbDG9EyPCnb7vE2YG6AfYV/pkNLVFT9QLTnlb
	NGjoX/r7823n60SoqxzRhIA4t6BK1HZplydjyaVtRk0UfLeu4McW482qeIwwBkM+5tvKXJLBrQv
	JOhmKCsmH4jhqu0S3AvMnl+q/PEmXW4UP4Dr19cPDzB6xUeZvdmq2pQt4AAV8PQCK7qVeU2eHLF
	88i7QIORgh07uR3qTmylypcoVYDCqD7TLJk/pv5PrhNEr1B1ltcqp3UX8PqWGkejQ2G0W6uEXzm
	3LWj7NAP3t4u1QJ/mgB46QOVTD4GeIamrnRjOwAigzDHNxkQfc1+R68
X-Received: by 2002:a17:902:d2c9:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2bf2051107cmr7138865ad.1.1780012577571;
        Thu, 28 May 2026 16:56:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf21e2b72dsm1543595ad.69.2026.05.28.16.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:56:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] Input: mtk-pmic-keys: Count available keys during probe instead of pre-counting
Date: Thu, 28 May 2026 16:56:00 -0700
Message-ID: <20260528235600.312045-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the separate of_get_available_child_count() pre-count and
validation step with a single pass through for_each_child_of_node_scoped().
Skip unavailable child nodes and bail out if more than
MTK_PMIC_MAX_KEY_COUNT available keys are found. Set nkeys after the
loop so suspend/resume iterate only over initialized entries.

Also use a key variable in the loop for clarity.

Use of_device_get_match_data() to fetch the PMIC key register data directly
instead of open-coding an of_match_device() lookup.

This also lets the driver drop the of_device.h include.

Assisted-by: OpenCode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 53 ++++++++++++--------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..e34856693ee2 100644
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
@@ -147,6 +146,7 @@ struct mtk_pmic_keys {
 	struct input_dev *input_dev;
 	struct device *dev;
 	struct regmap *regmap;
+	unsigned int nkeys;
 	struct mtk_pmic_keys_info keys[MTK_PMIC_MAX_KEY_COUNT];
 };
 
@@ -267,7 +267,7 @@ static int mtk_pmic_keys_suspend(struct device *dev)
 	struct mtk_pmic_keys *keys = dev_get_drvdata(dev);
 	int index;
 
-	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
+	for (index = 0; index < keys->nkeys; index++) {
 		if (keys->keys[index].wakeup) {
 			enable_irq_wake(keys->keys[index].irq);
 			if (keys->keys[index].irq_r > 0)
@@ -283,7 +283,7 @@ static int mtk_pmic_keys_resume(struct device *dev)
 	struct mtk_pmic_keys *keys = dev_get_drvdata(dev);
 	int index;
 
-	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
+	for (index = 0; index < keys->nkeys; index++) {
 		if (keys->keys[index].wakeup) {
 			disable_irq_wake(keys->keys[index].irq);
 			if (keys->keys[index].irq_r > 0)
@@ -325,24 +325,23 @@ MODULE_DEVICE_TABLE(of, of_mtk_pmic_keys_match_tbl);
 static int mtk_pmic_keys_probe(struct platform_device *pdev)
 {
 	int error, index = 0;
-	unsigned int keycount;
 	struct mt6397_chip *pmic_chip = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *node = pdev->dev.of_node;
 	static const char *const irqnames[] = { "powerkey", "homekey" };
 	static const char *const irqnames_r[] = { "powerkey_r", "homekey_r" };
 	struct mtk_pmic_keys *keys;
 	const struct mtk_pmic_regs *mtk_pmic_regs;
+	struct mtk_pmic_keys_info *key;
 	struct input_dev *input_dev;
-	const struct of_device_id *of_id =
-		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
 
 	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
 	if (!keys)
 		return -ENOMEM;
-
 	keys->dev = &pdev->dev;
 	keys->regmap = pmic_chip->regmap;
-	mtk_pmic_regs = of_id->data;
+	mtk_pmic_regs = of_device_get_match_data(&pdev->dev);
+	if (!mtk_pmic_regs)
+		return -EINVAL;
 
 	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
 	if (!input_dev) {
@@ -356,31 +355,26 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0001;
 
-	keycount = of_get_available_child_count(node);
-	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
-	    keycount > ARRAY_SIZE(irqnames)) {
-		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
-		return -EINVAL;
-	}
+	for_each_available_child_of_node_scoped(node, child) {
+		if (index >= MTK_PMIC_MAX_KEY_COUNT) {
+			dev_err(&pdev->dev, "too many keys defined\n");
+			return -EINVAL;
+		}
 
-	for_each_child_of_node_scoped(node, child) {
-		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
+		key = &keys->keys[index];
+		key->regs = &mtk_pmic_regs->keys_regs[index];
 
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
@@ -389,14 +383,15 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 		}
 
 		if (of_property_read_bool(child, "wakeup-source"))
-			keys->keys[index].wakeup = true;
+			key->wakeup = true;
 
-		error = mtk_pmic_key_setup(keys, &keys->keys[index]);
+		error = mtk_pmic_key_setup(keys, key);
 		if (error)
 			return error;
 
 		index++;
 	}
+	keys->nkeys = index;
 
 	error = input_register_device(input_dev);
 	if (error) {
-- 
2.54.0

