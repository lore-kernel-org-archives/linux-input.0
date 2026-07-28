Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707E472F8E
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273889; cv=none; b=VoBeb8yHKRrsn5t+ufVuRWcLvcYlnw3KMKHoyTr6QYWOysYkije0bmK2Hw5muiaixMKtVCsNet73+bxUDDyHDiw3rzllhcXT7K2kVl+iIoca+B756yMvyLqKNQiXVrVjVs69rleSqCZBIrGScScc0ImNlqPuMxxsHaIEXjT4fmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273889; c=relaxed/simple;
	bh=9ZCCI7CB0XR7oRQ585leDurfqqT92olbk8j3U9qOLdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVvCGITc55fUAQMJ9HUvPDC3zfVATMlCY8Gh7/aEEL7GS0KhKp2tzP0nnrRV9VPU9JcfVIiq/VnVjibaFhS0MSYAQK3Uy31JUNARqioPnZWX31eHDZBSyu8AzjK2O7tX5QlTZB9glD970VCch0HK333jhUAIKKnr5UChgmtyLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oi68ljnF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oi68ljnF"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso135720a12.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785273888; x=1785878688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vo05Sqoj/nxG6hyK1aVk2wjFZmiY47IquL7CFM1F4EE=;
        b=oi68ljnF4077EotvyJ3mhfivlbeWgmDBdjzeAZk7/elf2jDxRyBydh5QLXtBDRjZxn
         1UJRXLrt6iD7ZGcESeQZgemWMBaWQnuq6xR9a6JoxKj//UWFO+Pe6jzbAn61SIKAxTZO
         YdcOhgaE4VAZWKwFEFSiTMtaunEkeYtZA60iQwpk3ahFTLGmYkB1WXnujSa5eo26rldS
         99nZrz27w2ZMQKHCyxnR1LpymBQDgHcDzWfvhESCS8lO6x2E3Q/hCY2QNMO5NSJjHjUv
         +8eVuFsvbxTh62Akb1xAOYboDonCBBK6RzybsQDud2dCMvpX9Vhgh1iwOJkaR1QIaH0Q
         fJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273888; x=1785878688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vo05Sqoj/nxG6hyK1aVk2wjFZmiY47IquL7CFM1F4EE=;
        b=Lkhf1GJUtXq2t+g7Dju914n7gvYx2CugeUqh0KaJWO0H2WC8DT7P2NtCWYF/lgscns
         HIVaDl/v2peSlJIm5tbVvLjBA4qqh7z/eS5NFXhCIjn+eDyAv7ARjbiBlE801QS+CZvj
         mvTpSeqt9WO3x9rr1mxPO27ynV7C4A+m3LObbj8HTOIAEF3bkD4FnGIGnDX9BWzvUjcj
         6r2oIsHyzTNGK3w6W/Ho4fTwg0cd/0fXFE2vxCjNjojSCFkM83QA+T4DqVWoxfAhAnH1
         mEheQLEGtTXn5i49+/9Bqe3EZFSr1Qy0jx5TwIrooCvQQFzu8O/U01FmSMieZSX9pinZ
         V/AA==
X-Gm-Message-State: AOJu0YyeojBycFCr2kYMp5aV2qmlgazkebLpu2uoiTcPLJAyUv25vt3e
	HPubu8Y338zUSB1uyR/MvJwq6vZesQEFyrbibKRpPp8/bZqXNsOqv9mHItVUig==
X-Gm-Gg: AR+sD12HxMKjBMYz7qCm/igjiZRrW5JJsyQLjUu0FW7jqqjze/rWJzyBeNBjoVMBguF
	7/qvK7By/m7WpnWqVyn82ixVx4NSlomueyEILG/oAm/Ruq9LYRDqP0iAyzc/z7Vv50RD65P5X+N
	OykWQPBVZCuQrEb3fBnv+tSgpa6/cP2ivKsUkV9X/SHf8UV8Ot4Umfj0rfO7M3qlv8nmYPQiPEs
	yRFA5mQ2YsDopoS4OOOhRNLZ3YcJUQG+OirFblVre7SC+CPQP40il3Jb6Vg+8+hvPyYuWPasjF7
	DFKZXyDLupHK41RmfY82geC6KVo1hBCvAj4jHgyY2Thj0o2JPsHlwooi2+VXA7lq9jCB9ucEi7z
	3H98IIm3wnKfSfcaKWAP87jihflSOXi7JvvLkwgJEQVj5ICodAPibDVuId/KEoUWLuH5NxUvw+x
	nvr/o9LsDb2vN7Qlq0cGmas0WMnNDJsRs7YVkxtb8gFEvAEq4TfUxWbv/f4tc/AZv4Bi510AOi2
	zjyu3t10YPSSeBXggvj5Rq7IljZPw3Xw/rg4ZXv99blLI8qpqp6rKsSS1IFFnji/0/E/RLO7Ja5
	M3AfMAGqtkJEfDECNo9twr1YOMQJfYmOhYq5kQ==
X-Received: by 2002:a05:6a20:728e:b0:3c3:b4e8:5565 with SMTP id adf61e73a8af0-3c8ba5f67ddmr4982050637.61.1785273887644;
        Tue, 28 Jul 2026 14:24:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb83459f6sm80892a12.14.2026.07.28.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:24:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv2 2/2] Input: mtk-pmic-keys: Count available keys during probe instead of pre-counting
Date: Tue, 28 Jul 2026 14:24:38 -0700
Message-ID: <20260728212438.54078-3-rosenp@gmail.com>
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

Replace the separate of_get_available_child_count() pre-count and
validation step with a single pass through
for_each_child_of_node_scoped().  Skip unavailable child nodes and
bail if more than MTK_PMIC_MAX_KEY_COUNT available keys are found.
Set nkeys after the loop so suspend/resume iterate only over
initialized entries.  Use a local key variable in the loop for
clarity.

Add an irq > 0 guard to the suspend/resume wakeup paths so that
uninitialized key entries are safely skipped.

Assisted-by: OpenCode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 71 ++++++++++++--------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index fd684ac16938..e2ced6e5165a 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -267,7 +267,7 @@ static int mtk_pmic_keys_suspend(struct device *dev)
 	int index;
 
 	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
-		if (keys->keys[index].wakeup) {
+		if (keys->keys[index].irq > 0 && keys->keys[index].wakeup) {
 			enable_irq_wake(keys->keys[index].irq);
 			if (keys->keys[index].irq_r > 0)
 				enable_irq_wake(keys->keys[index].irq_r);
@@ -283,7 +283,7 @@ static int mtk_pmic_keys_resume(struct device *dev)
 	int index;
 
 	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
-		if (keys->keys[index].wakeup) {
+		if (keys->keys[index].irq > 0 && keys->keys[index].wakeup) {
 			disable_irq_wake(keys->keys[index].irq);
 			if (keys->keys[index].irq_r > 0)
 				disable_irq_wake(keys->keys[index].irq_r);
@@ -324,13 +324,13 @@ MODULE_DEVICE_TABLE(of, of_mtk_pmic_keys_match_tbl);
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
 
 	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
@@ -353,45 +353,42 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0001;
 
-	keycount = of_get_available_child_count(node);
-	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
-	    keycount > ARRAY_SIZE(irqnames)) {
-		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
-		return -EINVAL;
-	}
-
 	for_each_child_of_node_scoped(node, child) {
-		keys->keys[index].regs = &mtk_pmic_regs->keys_regs[index];
-
-		keys->keys[index].irq =
-			platform_get_irq_byname(pdev, irqnames[index]);
-		if (keys->keys[index].irq < 0)
-			return keys->keys[index].irq;
-
-		if (mtk_pmic_regs->key_release_irq) {
-			keys->keys[index].irq_r = platform_get_irq_byname(pdev,
-									  irqnames_r[index]);
-
-			if (keys->keys[index].irq_r < 0)
-				return keys->keys[index].irq_r;
+		if (index >= MTK_PMIC_MAX_KEY_COUNT) {
+			dev_err(&pdev->dev, "too many keys defined\n");
+			return -EINVAL;
 		}
 
-		error = of_property_read_u32(child,
-			"linux,keycodes", &keys->keys[index].keycode);
-		if (error) {
-			dev_err(keys->dev,
-				"failed to read key:%d linux,keycode property: %d\n",
-				index, error);
-			return error;
+		if (of_device_is_available(child)) {
+			key = &keys->keys[index];
+			key->regs = &mtk_pmic_regs->keys_regs[index];
+
+			key->irq = platform_get_irq_byname(pdev, irqnames[index]);
+			if (key->irq < 0)
+				return key->irq;
+
+			if (mtk_pmic_regs->key_release_irq) {
+				key->irq_r = platform_get_irq_byname(pdev, irqnames_r[index]);
+				if (key->irq_r < 0)
+					return key->irq_r;
+			}
+
+			error = of_property_read_u32(child, "linux,keycodes", &key->keycode);
+			if (error) {
+				dev_err(keys->dev,
+					"failed to read key:%d linux,keycode property: %d\n",
+					index, error);
+				return error;
+			}
+
+			if (of_property_present(child, "wakeup-source"))
+				key->wakeup = true;
+
+			error = mtk_pmic_key_setup(keys, key);
+			if (error)
+				return error;
 		}
 
-		if (of_property_read_bool(child, "wakeup-source"))
-			keys->keys[index].wakeup = true;
-
-		error = mtk_pmic_key_setup(keys, &keys->keys[index]);
-		if (error)
-			return error;
-
 		index++;
 	}
 
-- 
2.55.0

