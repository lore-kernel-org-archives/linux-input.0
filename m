Return-Path: <SRS0=gD2E=CG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D541DC433E7
	for <linux-input@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B224F208C9
	for <linux-input@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598626695;
	bh=K1SfNqgOjhaw0jo9vFZ10HD935ePRAU+4AWSGMFavXQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vlXbUM7AcBsUfw3fZOuRCwEKyQMkc8NuB2jDvDRh41JTt9m5fGml3iM7gnW5VhMx2
	 6jGCcPPxMNCHK8aO5vLvzbjvNDZeTXMrOB/mwnf4J5NClCPkRQ2VkOhgpNRmPH1yxF
	 PnqYUO+Tr/57fCYyP3X0iIbTtc4+oSdXmKQ5TjZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgH1O6F (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgH1O56 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Aug 2020 10:57:58 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44439208D5;
        Fri, 28 Aug 2020 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598626678;
        bh=K1SfNqgOjhaw0jo9vFZ10HD935ePRAU+4AWSGMFavXQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u7mGWyBCv53nhsm+ewFH0Lek8v+LUMMY+RBpKUPflKcoShjuwHKnMnqHkLN+eTXdo
         DFttvg8e7bKPHfPMgrdlerNS1LS+HNU/i5fSQZ0zprWSVR0bZ8o8UBJi3FK8xt1Ija
         Ya6drbvzheQtP2bzUtCiRjxhUCTKj9M4NTh/kErQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] Input: twl4030_keypad - Fix handling of platform_get_irq() error
Date:   Fri, 28 Aug 2020 16:57:43 +0200
Message-Id: <20200828145744.3636-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828145744.3636-1-krzk@kernel.org>
References: <20200828145744.3636-1-krzk@kernel.org>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case casting to
unsigned and comparing to 0 would pass the check.

Fixes: 7abf38d6d13c ("Input: twl4030-keypad - add device tree support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also casting return value to unsigned.
---
 drivers/input/keyboard/twl4030_keypad.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index af3a6824f1a4..77e0743a3cf8 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -50,7 +50,7 @@ struct twl4030_keypad {
 	bool		autorepeat;
 	unsigned int	n_rows;
 	unsigned int	n_cols;
-	unsigned int	irq;
+	int		irq;
 
 	struct device *dbg_dev;
 	struct input_dev *input;
@@ -376,10 +376,8 @@ static int twl4030_kp_probe(struct platform_device *pdev)
 	}
 
 	kp->irq = platform_get_irq(pdev, 0);
-	if (!kp->irq) {
-		dev_err(&pdev->dev, "no keyboard irq assigned\n");
-		return -EINVAL;
-	}
+	if (kp->irq < 0)
+		return kp->irq;
 
 	error = matrix_keypad_build_keymap(keymap_data, NULL,
 					   TWL4030_MAX_ROWS,
-- 
2.17.1

