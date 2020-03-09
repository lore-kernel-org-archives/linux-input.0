Return-Path: <SRS0=L/+t=42=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A6C10DCE
	for <linux-input@archiver.kernel.org>; Mon,  9 Mar 2020 00:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5042B2072A
	for <linux-input@archiver.kernel.org>; Mon,  9 Mar 2020 00:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCIApb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 8 Mar 2020 20:45:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59558 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCIApb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 8 Mar 2020 20:45:31 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0157720151B;
        Mon,  9 Mar 2020 01:45:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BA57201527;
        Mon,  9 Mar 2020 01:45:10 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BF832402E5;
        Mon,  9 Mar 2020 08:44:46 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        linux@roeck-us.net, daniel.baluta@nxp.com,
        gregkh@linuxfoundation.org, linux@rempel-privat.de,
        tglx@linutronix.de, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, arnd@arndb.de,
        ronald@innovation.ch, krzk@kernel.org, robh@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 7/7] thermal: add COMPILE_TEST support for IMX_SC_THERMAL
Date:   Mon,  9 Mar 2020 08:38:20 +0800
Message-Id: <1583714300-19085-7-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add COMPILE_TEST support to i.MX SC thermal driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
No change.
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9f388ed..6235949 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -253,7 +253,7 @@ config IMX_THERMAL
 
 config IMX_SC_THERMAL
 	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
-	depends on IMX_SCU
+	depends on IMX_SCU || COMPILE_TEST
 	depends on OF
 	help
 	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
-- 
2.7.4

