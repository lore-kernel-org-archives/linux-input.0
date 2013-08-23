From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] Input: wacom - fix error return code in wacom_probe()
Date: Fri, 23 Aug 2013 10:53:00 +0800
Message-ID: <CAPgLHd99Hc=EvmNSv6D4X=HYhDsypwHDGjN9eNJktmGZ_qOABQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:61779 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab3HWCxC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Aug 2013 22:53:02 -0400
Received: by mail-bk0-f45.google.com with SMTP id mx11so28907bkb.18
        for <linux-input@vger.kernel.org>; Thu, 22 Aug 2013 19:53:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, killertofu@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com, fengguang.wu@intel.com
Cc: yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the urb submit error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/tablet/wacom_sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index aaf23ae..7eeac61 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1366,7 +1366,8 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	usb_set_intfdata(intf, wacom);
 
 	if (features->quirks & WACOM_QUIRK_MONITOR) {
-		if (usb_submit_urb(wacom->irq, GFP_KERNEL))
+		error = usb_submit_urb(wacom->irq, GFP_KERNEL);
+		if (error)
 			goto fail5;
 	}
 

