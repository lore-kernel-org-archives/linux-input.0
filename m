Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797CC432BE
	for <linux-input@archiver.kernel.org>; Wed,  1 Sep 2021 16:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA156102A
	for <linux-input@archiver.kernel.org>; Wed,  1 Sep 2021 16:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbhIAQhH (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 1 Sep 2021 12:37:07 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43407 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S245407AbhIAQhE (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2021 12:37:04 -0400
Received: (qmail 405992 invoked by uid 1000); 1 Sep 2021 12:36:06 -0400
Date:   Wed, 1 Sep 2021 12:36:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-input@vger.kernel.org,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [PATCH 3/3] HID: usbhid: Simplify code in hid_submit_ctrl()
Message-ID: <20210901163606.GC404634@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This patch makes a small simplification to the code in
hid_submit_ctrl().  The test for maxpacket being > 0 is unnecessary,
because endpoint 0 always has a maxpacket value which is >= 8.

Furthermore, endpoint 0's maxpacket value is always a power of 2, so
instead of open-coding the round-to-next-multiple computation we can
call the optimized round_up() routine.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/hid/usbhid/hid-core.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -388,14 +388,10 @@ static int hid_submit_ctrl(struct hid_de
 		usbhid->urbctrl->pipe = usb_rcvctrlpipe(hid_to_usb_dev(hid), 0);
 		maxpacket = usb_maxpacket(hid_to_usb_dev(hid),
 					  usbhid->urbctrl->pipe, 0);
-		if (maxpacket > 0) {
-			len += (len == 0);    /* Don't allow 0-length reports */
-			len = DIV_ROUND_UP(len, maxpacket);
-			len *= maxpacket;
-			if (len > usbhid->bufsize)
-				len = usbhid->bufsize;
-		} else
-			len = 0;
+		len += (len == 0);	/* Don't allow 0-length reports */
+		len = round_up(len, maxpacket);
+		if (len > usbhid->bufsize)
+			len = usbhid->bufsize;
 	}
 	usbhid->urbctrl->transfer_buffer_length = len;
 	usbhid->urbctrl->dev = hid_to_usb_dev(hid);
