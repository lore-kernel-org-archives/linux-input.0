From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] amba_kmi_write() timeleft reaches -1 rather than 0
Date: Sat, 31 Jan 2009 14:33:58 +0100
Message-ID: <49845346.2050006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:36260 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbZAaNd7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2009 08:33:59 -0500
Received: by ey-out-2122.google.com with SMTP id 25so207423eya.37
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2009 05:33:58 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru
Cc: linux-input@vger.kernel.org

With a postfix decrement timeleft reaches -1 rather than 0,
but after the loop it is tested to have become 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index b10ffae..ab3299c 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -57,7 +57,7 @@ static int amba_kmi_write(struct serio *io, unsigned char val)
 	struct amba_kmi_port *kmi = io->port_data;
 	unsigned int timeleft = 10000; /* timeout in 100ms */
 
-	while ((readb(KMISTAT) & KMISTAT_TXEMPTY) == 0 && timeleft--)
+	while ((readb(KMISTAT) & KMISTAT_TXEMPTY) == 0 && --timeleft)
 		udelay(10);
 
 	if (timeleft)
