Return-Path: <SRS0=kFWr=IF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E4C433E9
	for <linux-input@archiver.kernel.org>; Sun,  7 Mar 2021 22:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7AE465151
	for <linux-input@archiver.kernel.org>; Sun,  7 Mar 2021 22:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCGWX0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 7 Mar 2021 17:23:26 -0500
Received: from aposti.net ([89.234.176.197]:34036 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhCGWWv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 7 Mar 2021 17:22:51 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     od@zcrc.me, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/3] input: gpio-keys: Remove extra call to input_sync
Date:   Sun,  7 Mar 2021 22:22:38 +0000
Message-Id: <20210307222240.380583-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The input_sync() function is already called after the loop in
gpio_keys_report_state(), so it does not need to be called after each
iteration within gpio_keys_gpio_report_event().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Keep the input_sync() within gpio_keys_report_state() so that it's
        not called at every iteration of the loop.
    
    v3: No change

 drivers/input/keyboard/gpio_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 77bac4ddf324..7fcb2c35c5cc 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -373,7 +373,6 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 	} else {
 		input_event(input, type, *bdata->code, state);
 	}
-	input_sync(input);
 }
 
 static void gpio_keys_gpio_work_func(struct work_struct *work)
@@ -382,6 +381,7 @@ static void gpio_keys_gpio_work_func(struct work_struct *work)
 		container_of(work, struct gpio_button_data, work.work);
 
 	gpio_keys_gpio_report_event(bdata);
+	input_sync(bdata->input);
 
 	if (bdata->button->wakeup)
 		pm_relax(bdata->input->dev.parent);
-- 
2.30.1

