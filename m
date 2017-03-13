From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/7] Input: hanwang - fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:35:37 +0100
Message-ID: <20170313123539.28103-6-johan@kernel.org>
References: <20170313123539.28103-1-johan@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32769 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbdCMMgU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 08:36:20 -0400
In-Reply-To: <20170313123539.28103-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Xing Wei <weixing@hanwang.com.cn>, Jiri Kosina <jkosina@suse.cz>

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer should a malicious device lack endpoints.

Fixes: bba5394ad3bd ("Input: add support for Hanwang tablets")
Cc: stable <stable@vger.kernel.org>	# 2.6.37
Cc: Xing Wei <weixing@hanwang.com.cn>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/tablet/hanwang.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
index cd852059b99e..df4bea96d7ed 100644
--- a/drivers/input/tablet/hanwang.c
+++ b/drivers/input/tablet/hanwang.c
@@ -340,6 +340,9 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
 	int error;
 	int i;
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	hanwang = kzalloc(sizeof(struct hanwang), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!hanwang || !input_dev) {
-- 
2.12.0

