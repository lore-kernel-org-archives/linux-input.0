Return-Path: <SRS0=K583=CJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27215C433E6
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92F9207EA
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598887994;
	bh=r5LdmNC2g7FIRe6CwrmHuVuU4fXEV1nY9Ab8Ln9jqTU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VJ8ffWzUjC1JQ3Fb4jZDuUIYpVRibb78NWAWYSt6ryjRU9tV5Im5ttlm8PPRAk+tU
	 lsqPAeIHiSG5EA7aG0JAa2FbGQ/8gj2r+LAro4XV+nMCj/I1T0/9OTF1juYR+pXDWX
	 nqf9OocnS4NzCXriGdlgN6BSKUiWxkx38ZIBHHIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgHaPbz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbgHaPbx (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Aug 2020 11:31:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9217721556;
        Mon, 31 Aug 2020 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887913;
        bh=r5LdmNC2g7FIRe6CwrmHuVuU4fXEV1nY9Ab8Ln9jqTU=;
        h=From:To:Cc:Subject:Date:From;
        b=YzDN2y9VVlKHBL+T8cE6N+Sg/zXX7+5Mujc4hmC0uT2QDulYyWHWr4BUBC3jDnJYE
         gq7Kdenyf5thSEQl/Wc66Gd6yYPLVYnG4vvywJjIHb4xl2VrxjnrL2WjUN0+eg+yZM
         DEukMLFpVFMJjSrmw3e9VwWIkA0XQeWCA+bNaH4A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot+34ee1b45d88571c2fa8b@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 1/6] HID: hiddev: Fix slab-out-of-bounds write in hiddev_ioctl_usage()
Date:   Mon, 31 Aug 2020 11:31:44 -0400
Message-Id: <20200831153150.1024799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

[ Upstream commit 25a097f5204675550afb879ee18238ca917cba7a ]

`uref->usage_index` is not always being properly checked, causing
hiddev_ioctl_usage() to go out of bounds under some cases. Fix it.

Reported-by: syzbot+34ee1b45d88571c2fa8b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=f2aebe90b8c56806b050a20b36f51ed6acabe802
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hiddev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index dbdd265075daf..7bce23a43907e 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -554,12 +554,16 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 
 		switch (cmd) {
 		case HIDIOCGUSAGE:
+			if (uref->usage_index >= field->report_count)
+				goto inval;
 			uref->value = field->value[uref->usage_index];
 			if (copy_to_user(user_arg, uref, sizeof(*uref)))
 				goto fault;
 			goto goodreturn;
 
 		case HIDIOCSUSAGE:
+			if (uref->usage_index >= field->report_count)
+				goto inval;
 			field->value[uref->usage_index] = uref->value;
 			goto goodreturn;
 
-- 
2.25.1

