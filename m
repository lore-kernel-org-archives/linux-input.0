Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BCCC433EF
	for <linux-input@archiver.kernel.org>; Wed, 16 Feb 2022 01:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiBPBvR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:51:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343509AbiBPBu6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Feb 2022 20:50:58 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229D8FABC5;
        Tue, 15 Feb 2022 17:50:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4aiK1Z_1644976244;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V4aiK1Z_1644976244)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 09:50:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] HID: i2c-hid: remove unneeded semicolon
Date:   Wed, 16 Feb 2022 09:50:42 +0800
Message-Id: <20220216015042.113021-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/hid/i2c-hid/i2c-hid-core.c:357:56-57: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 91b2fa0d33c7..c078f09a2318 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -354,7 +354,7 @@ static int i2c_hid_set_or_send_report(struct i2c_hid *ihid,
 		 * With simple "send report" all data goes into the output
 		 * register.
 		 */
-		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wOutputRegister;;
+		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wOutputRegister;
 		length += sizeof(__le16);
 	}
 
-- 
2.20.1.7.g153144c

