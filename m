From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: wacom - fix sparse warning
Date: Sun, 29 Apr 2012 21:08:08 -0700
Message-ID: <20120430040807.GA3013@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55595 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2D3EIO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 00:08:14 -0400
Received: by pbbrp8 with SMTP id rp8so2836699pbb.19
        for <linux-input@vger.kernel.org>; Sun, 29 Apr 2012 21:08:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Jason Gerecke <killertofu@gmail.com>

This fixes the following warning from sparse

	warning: Using plain integer as NULL pointer

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/tablet/wacom_sys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index be13223..e785fcd 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1015,13 +1015,13 @@ static void wacom_wireless_work(struct work_struct *work)
 	wacom = usb_get_intfdata(usbdev->config->interface[1]);
 	if (wacom->wacom_wac.input)
 		input_unregister_device(wacom->wacom_wac.input);
-	wacom->wacom_wac.input = 0;
+	wacom->wacom_wac.input = NULL;
 
 	/* Touch interface */
 	wacom = usb_get_intfdata(usbdev->config->interface[2]);
 	if (wacom->wacom_wac.input)
 		input_unregister_device(wacom->wacom_wac.input);
-	wacom->wacom_wac.input = 0;
+	wacom->wacom_wac.input = NULL;
 
 	if (wacom_wac->pid == 0) {
 		printk(KERN_INFO "wacom: wireless tablet disconnected\n");
-- 
1.7.7.6


-- 
Dmitry
