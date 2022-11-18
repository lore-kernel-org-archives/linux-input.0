Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D6C433FE
	for <linux-input@archiver.kernel.org>; Fri, 18 Nov 2022 22:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiKRW43 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 18 Nov 2022 17:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiKRWz2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Nov 2022 17:55:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E262645
        for <linux-input@vger.kernel.org>; Fri, 18 Nov 2022 14:48:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8c-0002QY-Ob; Fri, 18 Nov 2022 23:47:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8Z-0058So-M2; Fri, 18 Nov 2022 23:47:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8Z-00008s-Nd; Fri, 18 Nov 2022 23:47:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 265/606] Input: wdt87xx_i2c - Convert to i2c's .probe_new()
Date:   Fri, 18 Nov 2022 23:39:59 +0100
Message-Id: <20221118224540.619276-266-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118224540.619276-1-uwe@kleine-koenig.org>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/input/touchscreen/wdt87xx_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index 166edeb77776..3f87db5cdca4 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -1064,8 +1064,7 @@ static int wdt87xx_ts_create_input_device(struct wdt87xx_data *wdt)
 	return 0;
 }
 
-static int wdt87xx_ts_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int wdt87xx_ts_probe(struct i2c_client *client)
 {
 	struct wdt87xx_data *wdt;
 	int error;
@@ -1170,7 +1169,7 @@ static const struct acpi_device_id wdt87xx_acpi_id[] = {
 MODULE_DEVICE_TABLE(acpi, wdt87xx_acpi_id);
 
 static struct i2c_driver wdt87xx_driver = {
-	.probe		= wdt87xx_ts_probe,
+	.probe_new	= wdt87xx_ts_probe,
 	.id_table	= wdt87xx_dev_id,
 	.driver	= {
 		.name	= WDT87XX_NAME,
-- 
2.38.1

