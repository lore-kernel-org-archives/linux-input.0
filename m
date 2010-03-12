From: Oliver Neukum <oliver@neukum.org>
Subject: [RFT 2/2] USB: acecad: Implement reset_resume()
Date: Fri, 12 Mar 2010 11:40:32 +0100
Message-ID: <201003121140.32229.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:55976 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757541Ab0CLKo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Mar 2010 05:44:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: edouard.tisserant@wanadoo.fr
Cc: svoltz@numericable.fr, linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

>From 2a264b56c60daecf6cd3cebc47699b4eafdcb041 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Fri, 12 Mar 2010 11:36:03 +0100
Subject: [PATCH 2/2] USB: acecad: Implement reset_resume()

resume() can do double duty.

Signed-off-by: Oliver Neukum <neukum@b1-systems.de>
---
 drivers/input/tablet/acecad.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index bf5bffb..25bfdb2 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -297,6 +297,7 @@ static struct usb_driver usb_acecad_driver = {
 	.disconnect =	usb_acecad_disconnect,
 	.suspend =	usb_acecad_suspend,
 	.resume =	usb_acecad_resume,
+	.reset_resume =	usb_acecad_resume,
 	.id_table =	usb_acecad_id_table,
 };
 
-- 
1.6.4.2

