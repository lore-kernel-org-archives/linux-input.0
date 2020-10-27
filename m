Return-Path: <SRS0=1svl=EC=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F087CC55179
	for <linux-input@archiver.kernel.org>; Tue, 27 Oct 2020 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6B92225C
	for <linux-input@archiver.kernel.org>; Tue, 27 Oct 2020 09:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896574AbgJ0J63 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 27 Oct 2020 05:58:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42797 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896555AbgJ0J5b (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Oct 2020 05:57:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kXLjK-0004UM-D8; Tue, 27 Oct 2020 10:57:26 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kXLjJ-0004s7-Ql; Tue, 27 Oct 2020 10:57:25 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v2 2/2] Input: ads7846: do not overwrite spi->mode flags set by spi framework
Date:   Tue, 27 Oct 2020 10:57:24 +0100
Message-Id: <20201027095724.18654-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027095724.18654-1-o.rempel@pengutronix.de>
References: <20201027095724.18654-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Do not overwrite spi->mode flags set by spi framework, otherwise the
chip select polarity will get lost.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/input/touchscreen/ads7846.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 8fd7fc39c4fd..f2dc2c8ab5ec 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1288,7 +1288,8 @@ static int ads7846_probe(struct spi_device *spi)
 	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
 	 */
 	spi->bits_per_word = 8;
-	spi->mode = SPI_MODE_0;
+	spi->mode &= ~SPI_MODE_X_MASK;
+	spi->mode |= SPI_MODE_0;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;
-- 
2.28.0

