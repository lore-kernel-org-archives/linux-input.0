Return-Path: <SRS0=DsBK=45=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC94C10DCE
	for <linux-input@archiver.kernel.org>; Thu, 12 Mar 2020 14:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8620674
	for <linux-input@archiver.kernel.org>; Thu, 12 Mar 2020 14:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCLOwc (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:52:32 -0400
Received: from mail.astralinux.ru ([217.74.38.120]:44340 "EHLO astralinux.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbgCLOwc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 12 Mar 2020 10:52:32 -0400
Received: from [46.148.196.138] (HELO mastykin.cct.rbt)
  by astralinux.ru (CommuniGate Pro SMTP 6.2.7)
  with ESMTPS id 1757313; Thu, 12 Mar 2020 17:50:20 +0300
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org,
        Dmitry Mastykin <dmastykin@astralinux.ru>
Subject: [PATCH v2 2/2] Input: goodix - Ignore spurious interrupts
Date:   Thu, 12 Mar 2020 17:50:11 +0300
Message-Id: <20200312145009.27449-2-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312145009.27449-1-dmastykin@astralinux.ru>
References: <20200312145009.27449-1-dmastykin@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The goodix panel sends spurious interrupts after a 'finger up' event,
which always cause a timeout.
The timeout was reported as touch_num == 0 and caused reading of
not ready buffer and false key release event.
In this patch the timeout is reported as ENOMSG and not processed.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
---
Changes in v2:
- Improve commit message 
---
 drivers/input/touchscreen/goodix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index daf1781..0e14719 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -329,7 +329,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 	 * The Goodix panel will send spurious interrupts after a
 	 * 'finger up' event, which will always cause a timeout.
 	 */
-	return 0;
+	return -ENOMSG;
 }
 
 static void goodix_ts_report_touch_8b(struct goodix_ts_data *ts, u8 *coor_data)
-- 
2.23.0

