Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184ECC433DB
	for <linux-input@archiver.kernel.org>; Sat, 20 Feb 2021 18:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53C064DDC
	for <linux-input@archiver.kernel.org>; Sat, 20 Feb 2021 18:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBTSKT (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 20 Feb 2021 13:10:19 -0500
Received: from m12-13.163.com ([220.181.12.13]:41807 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhBTSKS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 Feb 2021 13:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TjEyC
        rN0Dxxy8C0CP5JTiP1d5AvXCV8LfvEJ+9l0vlg=; b=ArkTtwDpXMvZ6JIvNhxfx
        z7jA99GgYDRGjRJkaOKEMA8RgK2PhVz5yV5ta9sN/mU3loL5660WJC53h/xAB0tE
        kOfaYKEebNj+0oIjXgKzlSK57nu74vUsv3JHgNc1B7iH+NZHy5MXnHIptkfUjRFA
        FuZIHUtele965WcqqEJMr8=
Received: from jiangzhipeng.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowAD3iozdRDFg7ZlUgA--.32257S2;
        Sun, 21 Feb 2021 01:20:33 +0800 (CST)
From:   jzp0409 <jzp0409@163.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, jiangzhipeng <jiangzhipeng@yulong.com>
Subject: [PATCH] input: adp5589-keys: Add err log
Date:   Sun, 21 Feb 2021 01:20:40 +0800
Message-Id: <20210220172040.1559-1-jzp0409@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAD3iozdRDFg7ZlUgA--.32257S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW3uFWrCr4UZr1xZFWUArb_yoWftrg_uF
        W0v3Z7Wr4jyF13KrZ8Aw1fZry0grn8uF95uFsYqF15Cr1fArWkJ3WDurWrtw4kAr1qyryU
        C3ykWr92yws3CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbRpBPUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: hm2sikiqz6il2tof0z/xtbBiAE-hlaD+CVIvQAAsN
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: jiangzhipeng <jiangzhipeng@yulong.com>

When devm_gpiochip_add_data() failed ,print err log

Signed-off-by: jiangzhipeng <jiangzhipeng@yulong.com>
---
 drivers/input/keyboard/adp5589-keys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 654e047..e99c0bd 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -526,8 +526,10 @@ static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 	mutex_init(&kpad->gpio_lock);
 
 	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
-	if (error)
+	if (error) {
+		dev_err(dev, "devm_gpiochip_add_data() failed, err: %d\n", error);
 		return error;
+	}
 
 	for (i = 0; i <= kpad->var->bank(kpad->var->maxgpio); i++) {
 		kpad->dat_out[i] = adp5589_read(kpad->client, kpad->var->reg(
-- 
1.9.1


