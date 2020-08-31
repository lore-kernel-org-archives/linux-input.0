Return-Path: <SRS0=K583=CJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E805C433E6
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC82064B
	for <linux-input@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888180;
	bh=jMmDAQcvu1Iifj6PtLRo7v3/YownEqEklSjrnF+GTIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KASzD/f6OFVNrIqAkIw1zcQiTJsIoTXzTOnA037XQ3oEtma173PZczfncMhvci4Aa
	 t9HOzAk3dYK+f9O6uQZw7VeZFzZejE2DMwsDi15m08WqkQjGIoFhY7R4OR1FDU+Dtd
	 1K4FjDiXyVYJuSdFc3CHFctQOkoooANlz8l+khY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgHaPgP (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgHaPao (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB727215A4;
        Mon, 31 Aug 2020 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887844;
        bh=jMmDAQcvu1Iifj6PtLRo7v3/YownEqEklSjrnF+GTIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctNoRzqEydDc8d31VUtj9Bn8M/tlv+hp61wJKew2DSVfqrWTm/BL6YO3H+7qNBUdV
         Z+SaAbZmSr569r3R3o3uteiy46sx9ApDooFPUHGup+jgIYLlRT7iMltBDZ5QKivGLB
         xNwfm3CbYXq8VrqJErSDXyS07MkZw7xzs1vqUzsE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot+34ee1b45d88571c2fa8b@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/23] HID: hiddev: Fix slab-out-of-bounds write in hiddev_ioctl_usage()
Date:   Mon, 31 Aug 2020 11:30:18 -0400
Message-Id: <20200831153039.1024302-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153039.1024302-1-sashal@kernel.org>
References: <20200831153039.1024302-1-sashal@kernel.org>
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
index 35b1fa6d962ec..4711fb191a072 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -519,12 +519,16 @@ static noinline int hiddev_ioctl_usage(struct hiddev *hiddev, unsigned int cmd,
 
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

