Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57262C64EC4
	for <linux-input@archiver.kernel.org>; Thu,  9 Mar 2023 11:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCILgJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Mar 2023 06:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCILgJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2023 06:36:09 -0500
X-Greylist: delayed 362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 03:36:02 PST
Received: from acolombier.dev (acolombier.dev [146.59.197.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD276B32B
        for <linux-input@vger.kernel.org>; Thu,  9 Mar 2023 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=antoinecolombier.fr;
        s=default; t=1678361399;
        bh=ir29c73Wpma6N/wpSbWhHhR/h8g6xtpW9SdC3uQS7eQ=;
        h=Date:From:To:Subject:From;
        b=LPtvy8Nfz52gj2yZYIVFnFQmuOb6WHAuuwFTDwKuggfLX1IWuY5M9/+GkRxyd16Jl
         JU3yntcxwzvll5rbCnytKoXBMC/2olR45VBRiVmu+lidVccmbT5L83yqo5x7bqlU/y
         SZKUzADF7s6HI9LIH0laqyMdP7J/Vxr7sz3SSH0Y=
Received: from xps (05421d86.skybroadband.com [5.66.29.134])
        by acolombier.dev (Postfix) with ESMTPSA id 124F117A12C;
        Thu,  9 Mar 2023 11:29:59 +0000 (UTC)
Date:   Thu, 9 Mar 2023 11:29:58 +0000
From:   Antoine C <contact@antoinecolombier.fr>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "=?utf-8?Q?linux-input=40vger.kernel.org?=" 
        <linux-input@vger.kernel.org>
Message-ID: <38F34842-3087-43CB-B814-CDBC52FD2084@getmailspring.com>
Subject: [PATCH] HID: hidraw: Keep the report ID on buffer in get_report
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The ioctl syscall with arg HIDIOCGINPUT must not override
the report ID contained in the first byte of the buffer
and should offset the report data next to it.

Signed-off-by: Antoine Colombier <kernel@acolombier.dev>
---
Hello,

Apologies for the resend, I forgot to disable the HTML format on the
previous email. Please ignore the previous one.

This addresses the bug report in the hidapi: https://github.com/libusb/hidapi/issues/514
The patch was tested using the test snippets attached in the issue above
on 6.2.0-76060200-generic (PopOS 22.04)

 drivers/hid/hidraw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 197b1e7bf029..2c12f25817e6 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -231,9 +231,10 @@ static ssize_t hidraw_get_report(struct file *file,
char __user *buffer, size_t
  if (ret < 0)
  goto out_free;
 
+ count--;
  len = (ret < count) ? ret : count;
 
- if (copy_to_user(buffer, buf, len)) {
+ if (copy_to_user(buffer + 1, buf, len)) {
  ret = -EFAULT;
  goto out_free;
  }
