Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043EC433FE
	for <linux-input@archiver.kernel.org>; Fri, 11 Dec 2020 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFDD23E21
	for <linux-input@archiver.kernel.org>; Fri, 11 Dec 2020 13:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbgLKNho (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbgLKNhe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Dec 2020 08:37:34 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AA7C0613D3
        for <linux-input@vger.kernel.org>; Fri, 11 Dec 2020 05:36:53 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id 31cs2400K4C55Sk011csMz; Fri, 11 Dec 2020 14:36:52 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1knibM-009i8V-9G; Fri, 11 Dec 2020 14:36:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1knibL-00CSgv-HC; Fri, 11 Dec 2020 14:36:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Input: adc-keys - drop bogus __refdata annotation
Date:   Fri, 11 Dec 2020 14:36:50 +0100
Message-Id: <20201211133650.2970182-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

As the ADC ladder input driver does not have any code or data located in
initmem, there is no need to annotate the adc_keys_driver structure with
__refdata.  Drop the annotation, to avoid suppressing future section
warnings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/keyboard/adc-keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
index 6d5be48d1b3d7988..bf72ab8df817756f 100644
--- a/drivers/input/keyboard/adc-keys.c
+++ b/drivers/input/keyboard/adc-keys.c
@@ -193,7 +193,7 @@ static const struct of_device_id adc_keys_of_match[] = {
 MODULE_DEVICE_TABLE(of, adc_keys_of_match);
 #endif
 
-static struct platform_driver __refdata adc_keys_driver = {
+static struct platform_driver adc_keys_driver = {
 	.driver = {
 		.name = "adc_keys",
 		.of_match_table = of_match_ptr(adc_keys_of_match),
-- 
2.25.1

