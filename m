Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D800C07E95
	for <linux-input@archiver.kernel.org>; Sun,  4 Jul 2021 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D467613F4
	for <linux-input@archiver.kernel.org>; Sun,  4 Jul 2021 09:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGDJ7j (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:59:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53480 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDJ7j (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 4 Jul 2021 05:59:39 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lzys2-0007m9-Ml; Sun, 04 Jul 2021 09:57:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: Fix spelling mistake in Kconfig "Modul" -> "Module"
Date:   Sun,  4 Jul 2021 10:57:02 +0100
Message-Id: <20210704095702.37567-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index ad454cd2855a..d4e74738c5a8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -932,7 +932,7 @@ config TOUCHSCREEN_USB_COMPOSITE
 	  - JASTEC USB Touch Controller/DigiTech DTR-02U
 	  - Zytronic controllers
 	  - Elo TouchSystems 2700 IntelliTouch
-	  - EasyTouch USB Touch Controller from Data Modul
+	  - EasyTouch USB Touch Controller from Data Module
 	  - e2i (Mimo monitors)
 
 	  Have a look at <http://linux.chapter7.ch/touchkit/> for
-- 
2.31.1

