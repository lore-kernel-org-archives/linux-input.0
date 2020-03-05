Return-Path: <SRS0=Ma1V=4W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C252C3F2D1
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5BD20848
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583429060;
	bh=zgVtazVFwI+Yfj0ahILa+kVWFdUeQ9jA7UBi5RO0ug4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9+xsExi37MWBNg86cMF2Qm8770S4Nc2uaqzpvO5AGgfTs6K8RJoyBc3fd/Wvnw29
	 HAzaLyFnNWCMSdZgUcCPLe07kfv5g2wrrRYvjyLDQiQDRo4SQ7/ixBxNtOLW2TOCP5
	 ZPU+qND5N7qVfcNZlWKPIpZoGgMtdIG8UaTLb9Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgCERYU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgCERNR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Mar 2020 12:13:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB4321556;
        Thu,  5 Mar 2020 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428396;
        bh=zgVtazVFwI+Yfj0ahILa+kVWFdUeQ9jA7UBi5RO0ug4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHlex3ej1XWF8CIn0/aH8VNMlaAWCKK16s9I4YWNUfQ07F0kkHGLsZghcjQ9b2VKu
         A1E5P5011ynAPZYyt/wOZ+kIFQauXC2gltnLQAXIY1d2Br1/PritkDnUXa/0Ooudos
         RXfTVsLjcR5nG+tCK2+AWfEsIJeoDyidxvNQ3oug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        syzbot+784ccb935f9900cc7c9e@syzkaller.appspotmail.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 05/67] HID: hiddev: Fix race in in hiddev_disconnect()
Date:   Thu,  5 Mar 2020 12:12:06 -0500
Message-Id: <20200305171309.29118-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>

[ Upstream commit 5c02c447eaeda29d3da121a2e17b97ccaf579b51 ]

Syzbot reports that "hiddev" is used after it's free in hiddev_disconnect().
The hiddev_disconnect() function sets "hiddev->exist = 0;" so
hiddev_release() can free it as soon as we drop the "existancelock"
lock.  This patch moves the mutex_unlock(&hiddev->existancelock) until
after we have finished using it.

Reported-by: syzbot+784ccb935f9900cc7c9e@syzkaller.appspotmail.com
Fixes: 7f77897ef2b6 ("HID: hiddev: fix potential use-after-free")
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hiddev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index a970b809d778c..4140dea693e90 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -932,9 +932,9 @@ void hiddev_disconnect(struct hid_device *hid)
 	hiddev->exist = 0;
 
 	if (hiddev->open) {
-		mutex_unlock(&hiddev->existancelock);
 		hid_hw_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
+		mutex_unlock(&hiddev->existancelock);
 	} else {
 		mutex_unlock(&hiddev->existancelock);
 		kfree(hiddev);
-- 
2.20.1

