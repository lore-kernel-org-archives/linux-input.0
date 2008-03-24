From: Helge Deller <deller@gmx.de>
Subject: [PATCH] apm-power.c: Fix crash when unloading modules
Date: Mon, 24 Mar 2008 14:43:18 +0100
Message-ID: <200803241443.19164.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754668AbYCXNnV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Mar 2008 09:43:21 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Richard Purdie <rpurdie@rpsys.net>

This patch fixes a crash in the apm-power driver when a input-device
(e.g. a keyboard driver module) is unloaded.
Fix is the same as it's used in the evbug driver.
I assume this patch went unnoticed, since most keyboard drivers
in PDAs are not compiled as modules.

Signed-off-by: Helge Deller <deller@gmx.de>
CC: Richard Purdie <rpurdie@rpsys.net>

--
 apm-power.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
--

diff --git a/drivers/input/apm-power.c b/drivers/input/apm-power.c
index c36d110..7d61a96 100644
--- a/drivers/input/apm-power.c
+++ b/drivers/input/apm-power.c
@@ -63,8 +63,6 @@ static int apmpower_connect(struct input_handler *handler,
 	handle->handler = handler;
 	handle->name = "apm-power";
 
-	handler->private = handle;
-
 	error = input_register_handle(handle);
 	if (error) {
 		printk(KERN_ERR
@@ -87,11 +85,10 @@ static int apmpower_connect(struct input_handler *handler,
 	return 0;
 }
 
-static void apmpower_disconnect(struct input_handle *handler)
+static void apmpower_disconnect(struct input_handle *handle)
 {
-	struct input_handle *handle = handler->private;
-
 	input_close_device(handle);
+	input_unregister_handle(handle);
 	kfree(handle);
 }
 
