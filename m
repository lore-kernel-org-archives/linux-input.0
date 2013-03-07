From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v2 2/7] USB: serial: handle suspend failure path correctly
Date: Fri,  8 Mar 2013 00:07:47 +0800
Message-ID: <1362672472-22680-3-git-send-email-ming.lei@canonical.com>
References: <1362672472-22680-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:49126 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493Ab3CGQLt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Mar 2013 11:11:49 -0500
In-Reply-To: <1362672472-22680-1-git-send-email-ming.lei@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Ming Lei <ming.lei@canonical.com>, Johan Hovold <jhovold@gmail.com>

This patch kills traffic even though type->suspend returns
failure inside usb_serial_suspend from system sleep context
because USB core ignores the failiure and lets system sleep
go ahread, so the serial URB traffic need to be killed
in this case.

Cc: Johan Hovold <jhovold@gmail.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/usb/serial/usb-serial.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index a19ed74..9d0b9c8 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1142,10 +1142,11 @@ int usb_serial_suspend(struct usb_interface *intf, pm_message_t message)
 
 	if (serial->type->suspend) {
 		r = serial->type->suspend(serial, message);
-		if (r < 0) {
+		if (r < 0 && PMSG_IS_AUTO(message)) {
 			serial->suspending = 0;
 			goto err_out;
 		}
+		/* TODO: resume() might need to handle suspend failure */
 	}
 
 	for (i = 0; i < serial->num_ports; ++i) {
-- 
1.7.9.5

