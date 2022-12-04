Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3A5C4321E
	for <linux-input@archiver.kernel.org>; Sun,  4 Dec 2022 17:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiLDR47 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 4 Dec 2022 12:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiLDR4l (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 4 Dec 2022 12:56:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2585140D2
        for <linux-input@vger.kernel.org>; Sun,  4 Dec 2022 09:56:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BF1BB80B89
        for <linux-input@vger.kernel.org>; Sun,  4 Dec 2022 17:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60510C433D7;
        Sun,  4 Dec 2022 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670176598;
        bh=5Xqe7+TpXazbJZsPvdZ7dk3sGkxOgsOgTQudFoDy14Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhHCN4naH/pNgE6SJKYWzsEi744afHIp4J7lGaBuq6nSi5Zwhuvialjocb9v2k0hK
         rvBBoD4cfGNaz2nBB1NlXAqDUIywG0RUgdCAs+ejncZFPDXCxymSGu2lUaxmbrBpKo
         X8q2Dkp0Z95LIeINJvmRY3Wgd8AHbV9ElXNKYsl9Qaz5aVujd+v5JxziXjIOzpZKWm
         DxzuRI67fDLvPvuWXBLoQDDM70OvTpwSlgipVkeoJW0GuTGehMHMWtU87Oy35csh+G
         p/WdTHGjPAa12nkr3VMjpeJ7EmYf+oK8+KkRKLHNSX3sdHilnTCGbaVCD0zRXkuHw5
         uhlg7UAlHustw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 26/32] Input: tegra-kbc - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Sun,  4 Dec 2022 18:08:35 +0000
Message-Id: <20221204180841.2211588-27-jic23@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221204180841.2211588-1-jic23@kernel.org>
References: <20221204180841.2211588-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

SIMPLE_DEV_PM_OPS() is deprecated as it requires explicit protection
against unused function warnings.  The new combination of pm_sleep_ptr()
and DEFINE_SIMPLE_DEV_PM_OPS() allows the compiler to see the functions,
thus suppressing the warning, but still allowing the unused code to be
removed. Thus also drop the ifdef guards.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/input/keyboard/tegra-kbc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 570fe18c0ce9..1eba06bcf27a 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -713,7 +713,6 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void tegra_kbc_set_keypress_interrupt(struct tegra_kbc *kbc, bool enable)
 {
 	u32 val;
@@ -802,15 +801,15 @@ static int tegra_kbc_resume(struct device *dev)
 
 	return err;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tegra_kbc_pm_ops, tegra_kbc_suspend, tegra_kbc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tegra_kbc_pm_ops,
+				tegra_kbc_suspend, tegra_kbc_resume);
 
 static struct platform_driver tegra_kbc_driver = {
 	.probe		= tegra_kbc_probe,
 	.driver	= {
 		.name	= "tegra-kbc",
-		.pm	= &tegra_kbc_pm_ops,
+		.pm	= pm_sleep_ptr(&tegra_kbc_pm_ops),
 		.of_match_table = tegra_kbc_of_match,
 	},
 };
-- 
2.38.1

