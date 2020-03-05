Return-Path: <SRS0=Ma1V=4W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E1C3F2D1
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 06:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6C92166E
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 06:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8Z7wwYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEGo1 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:44:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43343 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCEGo1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Mar 2020 01:44:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id c144so2275444pfb.10;
        Wed, 04 Mar 2020 22:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=iHCLUX4LlZEuEw2wjTqn+Kf9HUrwO3gyzSzh9eS6vB8=;
        b=i8Z7wwYJp4A559I+KmDI1uIIDf4ALcKodvGO5dAfEp8Pbp7WGuoD2aDGeQYZXcGTnh
         DxJMSLMKx6+dWWK0vx+xrr6VWqM2SeCHrDslGkN1w7SIhXeb+OW9jKBpwu/4wuR4R0fo
         qcKtYtsGBAV3ozx6TlKvkzo+j6Sqxv7hyngUOOP94we/DANDqxX2X3jjRzZiecp6fw3N
         +wA/UWriRtmXxNZ7WyLcxnRR7/eM2Au+eB1wJgOrrQ0DPsNFvwBxyiBZvwU8HgVwP93e
         QfEk7+AAWRL01NFi7tMxF2SuelaHgdOZU/DZUGqXRYbkwx41U5TQJUWYI2nm1zf7O6eB
         /75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=iHCLUX4LlZEuEw2wjTqn+Kf9HUrwO3gyzSzh9eS6vB8=;
        b=e5FXFKZY8Sbma/zOqeUN/8zUzDytnqJmkfqTvJm2XOY9rBjZZIGKyMfuz0ouAoaEjT
         vgf9lD1YpgSFE+Thtu3s4bmy4dLEw1WmP2be/5tgZIVXMWtD2JxlMM5NQBtRzGLE+1jX
         eL+IrY5F8q186NiW4+M8oxG1eFLW3oHap5bmXLc4i29AvV3pQ7pfNtvQI98Jm/p0bWJh
         eVCrfe86hGryOj1mk+cj+9d5LSY0POIGjPOLcdBk8LgAnX+KmR5J1yVE7lbBKmV4d/03
         +Y1zdlNbp9Wqh17hKaWr2mq8UIzsODr69TEAiD6Fbv+n8jUjntIACT1BCyfiSAdiEjbq
         nYqQ==
X-Gm-Message-State: ANhLgQ2pYlz71ljUhTiMqnG7uWSIOEA6pX1WnBKmeyZeVTAmH3Mbl5nh
        Zil0woQjwKdNbXbKW5Yt6uI=
X-Google-Smtp-Source: ADFU+vsZdz4mOQHRYedWXA90jUzMBhPRBEjV3ILIMadz2Ii8pDZqacczIffSpWyMTQqroUq7ZZ/lcQ==
X-Received: by 2002:a62:d10b:: with SMTP id z11mr7164103pfg.38.1583390665965;
        Wed, 04 Mar 2020 22:44:25 -0800 (PST)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id e1sm30964891pff.188.2020.03.04.22.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 22:44:25 -0800 (PST)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: i8042 - Fix the selftest retry logic
Date:   Thu,  5 Mar 2020 14:44:23 +0800
Message-Id: <20200305064423.16196-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

It returns -NODEV at the first selftest timeout, so the retry logic
doesn't work. Move the return outside of the while loop to make it real
retry 5 times before returns -ENODEV.

BTW, the origin loop will retry 6 times, also fix this.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/input/serio/i8042.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 20ff2bed3917..3f6433a5c8e6 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -944,10 +944,9 @@ static int i8042_controller_selftest(void)
 	 */
 	do {
 
-		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
-			pr_err("i8042 controller selftest timeout\n");
-			return -ENODEV;
-		}
+		if (i8042_command(&param, I8042_CMD_CTL_TEST))
+			pr_err("i8042 controller selftest timeout (%d/5)\n",
+			       i+1);
 
 		if (param == I8042_RET_CTL_TEST)
 			return 0;
@@ -955,7 +954,9 @@ static int i8042_controller_selftest(void)
 		dbg("i8042 controller selftest: %#x != %#x\n",
 		    param, I8042_RET_CTL_TEST);
 		msleep(50);
-	} while (i++ < 5);
+	} while (++i < 5);
+	if (i == 5)
+		return -ENODEV;
 
 #ifdef CONFIG_X86
 	/*
-- 
2.17.1

