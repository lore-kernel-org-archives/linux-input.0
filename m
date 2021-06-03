Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FCCC47096
	for <linux-input@archiver.kernel.org>; Thu,  3 Jun 2021 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93EE613FF
	for <linux-input@archiver.kernel.org>; Thu,  3 Jun 2021 22:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFCWJ4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:09:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52678 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFCWJ4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Jun 2021 18:09:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lovVZ-0000zv-DN; Thu, 03 Jun 2021 22:08:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] Input: resistive-adc-touch: Fix uninitialized variable 'press'
Date:   Thu,  3 Jun 2021 23:08:09 +0100
Message-Id: <20210603220809.155118-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where st->ch_map[GRTS_CH_PRESSURE] < GRTS_MAX_CHANNELS is false
and also st->ch_map[GRTS_CH_Z1] < GRTS_MAX_CHANNELS is false the variable
press is not initialized and contains garbage. This affects a later
comparison of press < st->pressure_min.  Fix this by initializing press
to 0 and allows us to also remove an else clause that sets press to 0.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 60b7db914ddd ("Input: resistive-adc-touch - rework mapping of channels")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/touchscreen/resistive-adc-touch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
index ea7dd9d2b2ac..744544a723b7 100644
--- a/drivers/input/touchscreen/resistive-adc-touch.c
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -59,7 +59,7 @@ static int grts_cb(const void *data, void *private)
 {
 	const u16 *touch_info = data;
 	struct grts_state *st = private;
-	unsigned int x, y, press;
+	unsigned int x, y, press = 0;
 
 	x = touch_info[st->ch_map[GRTS_CH_X]];
 	y = touch_info[st->ch_map[GRTS_CH_Y]];
@@ -84,8 +84,6 @@ static int grts_cb(const void *data, void *private)
 		 */
 		if (Rt < GRTS_DEFAULT_PRESSURE_MAX)
 			press = GRTS_DEFAULT_PRESSURE_MAX - Rt;
-		else
-			press = 0;
 	}
 
 	if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
-- 
2.31.1

