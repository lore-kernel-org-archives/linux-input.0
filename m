Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D7DC432BE
	for <linux-input@archiver.kernel.org>; Wed,  1 Sep 2021 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519416102A
	for <linux-input@archiver.kernel.org>; Wed,  1 Sep 2021 16:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245259AbhIAQg7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:36:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35701 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236453AbhIAQg7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2021 12:36:59 -0400
Received: (qmail 405969 invoked by uid 1000); 1 Sep 2021 12:36:00 -0400
Date:   Wed, 1 Sep 2021 12:36:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        syzkaller-bugs@googlegroups.com, linux-input@vger.kernel.org,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [PATCH 2/3] HID: usbhid: Fix warning caused by 0-length input reports
Message-ID: <20210901163600.GB404634@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Syzbot found a warning caused by hid_submit_ctrl() submitting a
control request to transfer a 0-length input report:

	usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType a1

(The warning message is a little difficult to understand.  It means
that the control request claims to be for an IN transfer but this
contradicts the USB spec, which requires 0-length control transfers
always to be in the OUT direction.)

Now, a zero-length report isn't good for anything and there's no
reason for a device to have one, but the fuzzer likes to pick out
these weird edge cases.  In the future, perhaps we will decide to
reject 0-length reports at probe time.  For now, the simplest approach
for avoiding these warnings is to pretend that the report actually has
length 1.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: stable@vger.kernel.org

---

 drivers/hid/usbhid/hid-core.c |    1 +
 1 file changed, 1 insertion(+)

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -389,6 +389,7 @@ static int hid_submit_ctrl(struct hid_de
 		maxpacket = usb_maxpacket(hid_to_usb_dev(hid),
 					  usbhid->urbctrl->pipe, 0);
 		if (maxpacket > 0) {
+			len += (len == 0);    /* Don't allow 0-length reports */
 			len = DIV_ROUND_UP(len, maxpacket);
 			len *= maxpacket;
 			if (len > usbhid->bufsize)
