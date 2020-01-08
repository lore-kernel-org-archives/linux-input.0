Return-Path: <SRS0=5Ffx=25=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD8C33CA4
	for <linux-input@archiver.kernel.org>; Wed,  8 Jan 2020 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A1120673
	for <linux-input@archiver.kernel.org>; Wed,  8 Jan 2020 11:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgAHLLG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:11:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48613 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgAHLLF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2020 06:11:05 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ip9Ei-0003V0-Tz; Wed, 08 Jan 2020 12:10:52 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ip9Eh-0005Tf-8J; Wed, 08 Jan 2020 12:10:51 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, bparrot@ti.com,
        andy.shevchenko@gmail.com, simon.budig@kernelconcepts.de,
        hdegoede@redhat.com, fcooper@ti.com, mripard@kernel.org,
        alexandre.belloni@bootlin.com, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-input@vger.kernel.org
Subject: [PATCH v3 5/6] Input: edt-ft5x06 - use pm core to enable/disable the wake irq
Date:   Wed,  8 Jan 2020 12:10:49 +0100
Message-Id: <20200108111050.19001-6-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108111050.19001-1-m.felsch@pengutronix.de>
References: <20200108111050.19001-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

We do not have to handle the wake-irq within the driver because the pm
core can handle this for us. The only use case for the suspend/resume
callbacks was to handle the wake-irq so we can remove the callbacks.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v3:
- new patch to drop enable/disable_irq_wake() calls
---
 drivers/input/touchscreen/edt-ft5x06.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index c781952c3409..d2587724c52a 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1227,29 +1227,6 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	if (device_may_wakeup(dev))
-		enable_irq_wake(client->irq);
-
-	return 0;
-}
-
-static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-
-	if (device_may_wakeup(dev))
-		disable_irq_wake(client->irq);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(edt_ft5x06_ts_pm_ops,
-			 edt_ft5x06_ts_suspend, edt_ft5x06_ts_resume);
-
 static const struct edt_i2c_chip_data edt_ft5x06_data = {
 	.max_support_points = 5,
 };
@@ -1288,7 +1265,6 @@ static struct i2c_driver edt_ft5x06_ts_driver = {
 	.driver = {
 		.name = "edt_ft5x06",
 		.of_match_table = edt_ft5x06_of_match,
-		.pm = &edt_ft5x06_ts_pm_ops,
 	},
 	.id_table = edt_ft5x06_ts_id,
 	.probe    = edt_ft5x06_ts_probe,
-- 
2.20.1

