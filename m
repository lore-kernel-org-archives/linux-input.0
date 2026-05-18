Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F1376BC2
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779078066; cv=none; b=OrDcnbIeyLoJwEguteFV0OLw6Uxxe6ywvnHM4Oh6Jz0KZ6SsdB3t3K4yZDmTe2Z6D4cQHF1pOrc954cSQCtqp6pUX7ALJrcJcwVhSb9hZfwSmqotZHtQa4asqSppMnu9EuU90XNalNZlC8Fau2SEzFMYR2Z7A7goG7uMxwY38LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779078066; c=relaxed/simple;
	bh=pGACRVAdenIM9RlN9qinva2cLK8md4MphALVdQc8S0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3e43FqJcU4iW6goX6yAUGzbgzIfiWlh/soD5BpmA+U7FZDEOOJd3lDmYC9+5gM0EhgHyxtMaOnhcpk/bNXNwOA49qPf+u/AEKJWxZiIPFo0ZwdVCI4WfsvFnqTC3ZeesamOLt6odsVaXsy9wmINmybG0HP6n9098bkFAq267cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/04H90W; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/04H90W"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b9e9a6802aso6404925ad.3
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779078064; x=1779682864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1NeYPzkew/lg8N5iZf3wRciXirvXJuukKHofoQ/xo4=;
        b=W/04H90W0nOkHbjbdQyE+7XcDYg6WhinnyGqJNuwr3v191GABbk6TG6Df1mYyxpjSz
         IkmNcm5uYf5iZMfUAJqgg4QcB4zKUQ4FlvWfzBaFEobGTPPyTDc3ScC39UhI+KX4VhTd
         20Vu7u5Q97+HfPBbPckOmOfnNSNk2h4jHvZC3ZXFcFZgP6/Bw14q1eFeleSgA/NBjOQ5
         cXqyL++7fSDuU9b4L8oiYlBRTu/X9BLc3Elxh+roUbn2cKvBTE15J2x/JdQIhvVo2Qud
         HwFnCQh5JtGZD9qcTAAa0t3CwI7TQWmjuGtNrZgJH0tcPS2FQjeSzF8VtntIsZ2BWYCp
         FW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779078064; x=1779682864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1NeYPzkew/lg8N5iZf3wRciXirvXJuukKHofoQ/xo4=;
        b=ZUDIUmUs4BNdvyaQZ0V43PzmPMQfIQSBKjivr7RpyxT6caHaO2n51MhVBTIAg5d/gl
         Pz/rq6ql5EMiZcGHktXjFWKOyEChbAXEu7LAe00kRL27rEMxPIOaVdkSCjq67uTvt4Wc
         6/ZOxlnHvnBu4mK6BalidpY88g/KImhOszElYtqvuPKmmjNwNe+LHkAU3HlhlkvlZyet
         TwgAkLvggqIsPka9ozpjsTuqElDmwYiKDMxffoXOjaJWS8/fZLIH5K8X7c47kJisekI9
         LZ5TgiEsWQUfEulTAImRbHf9444/VQi1OMU2ZzVUxoMt1RFjfC0ARyYRQcbCWQG5CM3R
         BLMw==
X-Gm-Message-State: AOJu0YyJ2kOjsck40MOfTWB7kZcg2tgc2qtLMAQ/UlE0V6G6zNIwzYh/
	Q++8HNr9pNs5z58sGCqDGv6bSvMHyIb48yLWFSeZ6QEUwAkg4YTbgpKan0grTXsy
X-Gm-Gg: Acq92OGtfRZMu4cdogmqFgf38bQwpdcwLwQC+OaKbzGUw0TQCviwE1jzPx/9UO/VcQs
	8Tv7WYnBsuAkDYqhH6FtJ4vCExbNXMN29HxMpQHBgjSMgpLnnnBMkOJ3TPBgBIq88IJXsSW2U1i
	mc6qVJOgbX+BK9A6uHfX/ENoH/A4zdfoykwuvaObZe8G1V+oswgqaAgBQt/RNwL+fa1c4ohAID+
	QsTlVy5tSmV8/urA+C18E04qAhzgcl9dsVzuv1IEQzcfRPUOnyeWEZRHtd/ddTpGPNd8jXKH+Pp
	mI0NuC7w5MCvKkMlYq3Xwq/ru8xHd8VSLXTNTVeI6v39wNEau0nhw8mankT8Cal5gdcdR4BeTWK
	ia0LIGkjM7L4YktujJ5TDEjgQMRac1NHr/Spak+36UdVn4Jxul3xnwrlqQboxJg3nWWMW7mDcbj
	wt6IgocBG5HaW8JkubxlksrmzwhopWR/jmxgo7J1G6w//b9dVQ66ISGoOb/iKDZsHmOnLgVA6E2
	z6TcnQO4s0ji7sd1fZFtpzE+X7q4zdeJv0=
X-Received: by 2002:a17:902:c194:b0:2ba:6013:eeaf with SMTP id d9443c01a7336-2bd7e8fbda6mr106088815ad.19.1779078064386;
        Sun, 17 May 2026 21:21:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe51sm130747005ad.2.2026.05.17.21.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 21:21:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] Input: mtk-pmic-keys - use of_device_get_match_data()
Date: Sun, 17 May 2026 21:20:46 -0700
Message-ID: <20260518042046.981861-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_get_match_data() to fetch the PMIC key register data directly instead of open-coding an of_match_device() lookup.

This also lets the driver drop the of_device.h include.

Assisted-by: Codex:GPT-5.5
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
2.54.0

