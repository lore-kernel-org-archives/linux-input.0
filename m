From: Jake Merdich <jake@merdich.com>
Subject: [PATCH] HID: rmi: fix PDT table garbling on Dell 9Q33
Date: Sun, 23 Apr 2017 00:58:42 -0400
Message-ID: <20170423045842.8892-1-jake@merdich.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35930 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbdDWE65 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 23 Apr 2017 00:58:57 -0400
Received: by mail-qt0-f196.google.com with SMTP id t52so16649826qtb.3
        for <linux-input@vger.kernel.org>; Sat, 22 Apr 2017 21:58:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jake Merdich <jake@merdich.com>

Dell 9Q33's touchpad has been getting invalid function addresses
during the late stages of probing. This only occurs after the PDT
was scanned multiple times, so it only popped up now that PDT scanning
was unified in 0b2c7a89 (previously, hid-rmi.c scanned it only once).

This slows down probing enough to always get good data, at the cost of
~1ms of sleep per function probe (value determined empirically), or
about 20ms total when enumerating. If someone has a better idea of
handling this (maybe caching the PDT's?), I'd be happy to test.

Signed-off-by: Jake Merdich <jake@merdich.com>
---
 drivers/input/rmi4/rmi_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index d64fc92858f2..8724ee241ee5 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -545,6 +545,9 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 		retval = callback(rmi_dev, ctx, &pdt_entry);
 		if (retval != RMI_SCAN_CONTINUE)
 			return retval;
+
+		// Dell 9Q33 garbles data if scanned too quickly
+		usleep_range(500, 1000);
 	}
 
 	/*
-- 
2.12.2

