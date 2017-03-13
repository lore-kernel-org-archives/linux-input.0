From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/7] Input: kbtab - fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:35:38 +0100
Message-ID: <20170313123539.28103-7-johan@kernel.org>
References: <20170313123539.28103-1-johan@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36250 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbdCMMgV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 08:36:21 -0400
In-Reply-To: <20170313123539.28103-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer should a malicious device lack endpoints.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/tablet/kbtab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index e850d7e8afbc..4d9d64908b59 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -122,6 +122,9 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
 	struct input_dev *input_dev;
 	int error = -ENOMEM;
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	kbtab = kzalloc(sizeof(struct kbtab), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!kbtab || !input_dev)
-- 
2.12.0

