From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/7] Input: sur40 - fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:35:39 +0100
Message-ID: <20170313123539.28103-8-johan@kernel.org>
References: <20170313123539.28103-1-johan@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32771 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbdCMMgV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 08:36:21 -0400
In-Reply-To: <20170313123539.28103-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Florian Echtler <floe@butterbrot.org>, David Herrmann <dh.herrmann@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer or accessing memory that lie beyond the end of the endpoint
array should a malicious device lack the expected endpoints.

Fixes: bdb5c57f209c ("Input: add sur40 driver for Samsung SUR40 (aka MS
Surface 2.0/Pixelsense)")
Cc: stable <stable@vger.kernel.org>	# 3.13
Cc: Florian Echtler <floe@butterbrot.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/touchscreen/sur40.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index aefb6e11f88a..4c0eecae065c 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -527,6 +527,9 @@ static int sur40_probe(struct usb_interface *interface,
 	if (iface_desc->desc.bInterfaceClass != 0xFF)
 		return -ENODEV;
 
+	if (iface_desc->desc.bNumEndpoints < 5)
+		return -ENODEV;
+
 	/* Use endpoint #4 (0x86). */
 	endpoint = &iface_desc->endpoint[4].desc;
 	if (endpoint->bEndpointAddress != TOUCH_ENDPOINT)
-- 
2.12.0

