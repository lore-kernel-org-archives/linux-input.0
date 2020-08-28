Return-Path: <SRS0=gD2E=CG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5399C433E2
	for <linux-input@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C1F20665
	for <linux-input@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598626686;
	bh=LsVu0rhAEPs3Kam00nbZ5Bzs8RCeve3QgJZPD8qDTQo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GCN4hvZa4JShDl3tc08SZCKYwHCVF2J3/2x5hHQygOtLLsJ7EjZvOqN7duwYs3Ywn
	 M8faQMB2oAmqUeptgTPwCQ9wSCOlNwHtjn1rydOTMjCl+G9CmzyDEmOwsZw4o3raq7
	 s9a8Kkeq8xaHN7rFShHgXVQMMRXfsfji8Q9MB4uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgH1O56 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgH1O54 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Aug 2020 10:57:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221BC20848;
        Fri, 28 Aug 2020 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598626675;
        bh=LsVu0rhAEPs3Kam00nbZ5Bzs8RCeve3QgJZPD8qDTQo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KCFZrlfduBuK2CPrFr9mjtzD5Vuj4OHVc4PP/ml/hbrFyqwLqu406kwjBv6cQaBY3
         OcForBG1hc/qCilHNA1lyjhsNa5PihGb+swuxvbFtN+vH/+goOYJR73eJT1TpmqRnQ
         irE4/lSf2kaEpEQfMU6f2OB4j3Q6aJmzHo21e8o0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] Input: omap4-keypad - Fix handling of platform_get_irq() error
Date:   Fri, 28 Aug 2020 16:57:42 +0200
Message-Id: <20200828145744.3636-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828145744.3636-1-krzk@kernel.org>
References: <20200828145744.3636-1-krzk@kernel.org>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: f3a1ba60dbdb ("Input: omap4-keypad - use platform device helpers")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 drivers/input/keyboard/omap4-keypad.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 94c94d7f5155..b075f1af0305 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -240,10 +240,8 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "no keyboard irq assigned\n");
-		return -EINVAL;
-	}
+	if (irq < 0)
+		return -irq;
 
 	keypad_data = kzalloc(sizeof(struct omap4_keypad), GFP_KERNEL);
 	if (!keypad_data) {
-- 
2.17.1

