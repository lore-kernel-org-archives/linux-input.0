Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ADDC4320A
	for <linux-input@archiver.kernel.org>; Thu, 19 Aug 2021 15:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC4160F14
	for <linux-input@archiver.kernel.org>; Thu, 19 Aug 2021 15:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbhHSP1D (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:27:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49059 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S238702AbhHSP1D (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Aug 2021 11:27:03 -0400
Received: (qmail 230180 invoked by uid 1000); 19 Aug 2021 11:26:26 -0400
Date:   Thu, 19 Aug 2021 11:26:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mkubecek@suse.cz,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
Message-ID: <20210819152626.GD228422@rowland.harvard.edu>
References: <20210818184927.GD197200@rowland.harvard.edu>
 <000000000000f7ab1005c9db0f8e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f7ab1005c9db0f8e@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Aug 18, 2021 at 01:13:06PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in hid_submit_ctrl/usb_submit_urb
> 
> ------------[ cut here ]------------
> usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType a1
> WARNING: CPU: 1 PID: 10180 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410

Looks like I was wrong.  Let's see what's really happening.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 794c7931a242

--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -397,6 +397,8 @@ static int hid_submit_ctrl(struct hid_de
 		} else
 			padlen = 0;
 		usbhid->urbctrl->transfer_buffer_length = padlen;
+		hid_err(hid, "submit_ctrl: maxpacket %d len %d padlen %d\n",
+				maxpacket, len, padlen);
 	}
 	usbhid->urbctrl->dev = hid_to_usb_dev(hid);
 
