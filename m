Return-Path: <SRS0=iUnu=55=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84987C2BA2B
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 15:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEAF2072C
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 15:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgDMPYb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:24:31 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:39933 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgDMPYb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Apr 2020 11:24:31 -0400
Received: from localhost.localdomain ([93.22.151.169])
        by mwinf5d63 with ME
        id SFQS220023fYTYl03FQSGt; Mon, 13 Apr 2020 17:24:29 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Apr 2020 17:24:29 +0200
X-ME-IP: 93.22.151.169
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dmitry.torokhov@gmail.com, tglx@linutronix.de, info@metux.net,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Input: tca6416-keypad - Fix a typo in MODULE_DESCRIPTION
Date:   Mon, 13 Apr 2020 17:23:29 +0200
Message-Id: <20200413152329.4435-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This should be 'tca6416', not 'tca6146'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/keyboard/tca6416-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 21758767ccf0..9b0f9665dcb0 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -374,5 +374,5 @@ static void __exit tca6416_keypad_exit(void)
 module_exit(tca6416_keypad_exit);
 
 MODULE_AUTHOR("Sriramakrishnan <srk@ti.com>");
-MODULE_DESCRIPTION("Keypad driver over tca6146 IO expander");
+MODULE_DESCRIPTION("Keypad driver over tca6416 IO expander");
 MODULE_LICENSE("GPL");
-- 
2.20.1

