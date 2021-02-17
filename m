Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B59C433E0
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505E064E6C
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 19:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhBQTTO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:19:14 -0500
Received: from ec2-44-228-98-151.us-west-2.compute.amazonaws.com ([44.228.98.151]:58882
        "EHLO chill.innovation.ch" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232548AbhBQTTN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Feb 2021 14:19:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 9600C1B6411;
        Wed, 17 Feb 2021 19:07:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at chill.innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6nrywUIMZ8Du; Wed, 17 Feb 2021 19:07:31 +0000 (UTC)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.11.0 chill.innovation.ch E8A221B640F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1613588851;
        bh=qcHkDiWeuZJwaE8KC5P4fY1TNb7Og+nXRokLCY5UEZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fn87dt6iKXKD/mZFkNdDq702zSjtc8dJjGOULqt1mchETIXEIRPxLPqht9FhdJp0a
         vtQrCDZ+La77bSTBMsdK26hb3ymmblOPAEY32vmIZheYJXm93yDwTQAqCVnQCXTcFU
         A8HQUTOLsf2SC3rR0dZHV+P4OTs2NliMurUv1LuLA7H9DnK5nD7GjpHN27uuyCgQno
         QrJWfTFsnBruRUWHKEct+CTa+Gm0VeqqfsmeC1nUXJuJQA+vSBtdXwLK1mqti0da7F
         br0Zoo+9IuPdTVdAao0Sjnkg3cHaf37usfl8jp2xSlSuXJvOWrGgTORLxEth3KSfbQ
         /l0G6Vr7jvw7Q==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: applespi: Fix occasional crc errors under load.
Date:   Wed, 17 Feb 2021 11:07:17 -0800
Message-Id: <20210217190718.11035-2-ronald@innovation.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217190718.11035-1-ronald@innovation.ch>
References: <20210217190718.11035-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

For some reason, when the system is under heavy CPU load, the read
following the write sometimes occurs unusually quickly, resulting in
the read data not being quite ready and hence a bad packet getting read.
Adding another delay after reading the status message appears to fix
this.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 8494bf610fd70..f0a0067c48ff6 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -749,6 +749,8 @@ static void applespi_async_write_complete(void *context)
 					 applespi->tx_status,
 					 APPLESPI_STATUS_SIZE);
 
+	udelay(SPI_RW_CHG_DELAY_US);
+
 	if (!applespi_check_write_status(applespi, applespi->wr_m.status)) {
 		/*
 		 * If we got an error, we presumably won't get the expected
-- 
2.26.2

