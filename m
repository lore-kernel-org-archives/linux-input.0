Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF68BC433ED
	for <linux-input@archiver.kernel.org>; Fri,  2 Apr 2021 10:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DFD610D0
	for <linux-input@archiver.kernel.org>; Fri,  2 Apr 2021 10:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhDBKGc (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 2 Apr 2021 06:06:32 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:43196 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhDBKGc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 2 Apr 2021 06:06:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UUEJ78d_1617357989;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UUEJ78d_1617357989)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Apr 2021 18:06:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     srinivas.pandruvada@linux.intel.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] HID: intel-ish-hid: Remove an unused variable 'ret'
Date:   Fri,  2 Apr 2021 18:06:28 +0800
Message-Id: <1617357988-108792-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

drivers/hid/intel-ish-hid/ipc/pci-ish.c:264:6: warning: variable ‘ret’
set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 06081cf..61efc30 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -261,7 +261,6 @@ static void __maybe_unused ish_resume_handler(struct work_struct *work)
 	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
 	uint32_t fwsts = dev->ops->get_fw_status(dev);
-	int ret;
 
 	if (ish_should_leave_d0i3(pdev) && !dev->suspend_flag
 			&& IPC_IS_ISH_ILUP(fwsts)) {
@@ -273,7 +272,7 @@ static void __maybe_unused ish_resume_handler(struct work_struct *work)
 
 		/* Waiting to get resume response */
 		if (dev->resume_flag)
-			ret = wait_event_interruptible_timeout(dev->resume_wait,
+			wait_event_interruptible_timeout(dev->resume_wait,
 				!dev->resume_flag,
 				msecs_to_jiffies(WAIT_FOR_RESUME_ACK_MS));
 
-- 
1.8.3.1

