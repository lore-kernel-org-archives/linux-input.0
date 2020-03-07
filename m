Return-Path: <SRS0=jwhq=4Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB1FC10F27
	for <linux-input@archiver.kernel.org>; Sat,  7 Mar 2020 01:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD23020848
	for <linux-input@archiver.kernel.org>; Sat,  7 Mar 2020 01:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCGBc4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 6 Mar 2020 20:32:56 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41276 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgCGBcw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Mar 2020 20:32:52 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 653D01A0DC3;
        Sat,  7 Mar 2020 02:32:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 619C91A0DB1;
        Sat,  7 Mar 2020 02:32:32 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 870F0402D5;
        Sat,  7 Mar 2020 09:32:18 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        linux@roeck-us.net, daniel.baluta@nxp.com, linux@rempel-privat.de,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, robh@kernel.org, yuehaibing@huawei.com,
        ronald@innovation.ch, krzk@kernel.org, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 6/7] watchdog: add COMPILE_TEST support for IMX_SC_WDT
Date:   Sat,  7 Mar 2020 09:25:58 +0800
Message-Id: <1583544359-515-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
References: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add COMPILE_TEST support to i.MX SC watchdog driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change.
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9ea2b43..6388154 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -712,7 +712,7 @@ config IMX2_WDT
 config IMX_SC_WDT
 	tristate "IMX SC Watchdog"
 	depends on HAVE_ARM_SMCCC
-	depends on IMX_SCU
+	depends on IMX_SCU || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This is the driver for the system controller watchdog
-- 
2.7.4

