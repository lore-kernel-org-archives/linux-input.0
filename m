From: Jindrich Makovicka <makovick@gmail.com>
Subject: Re: [PATCH] HID: check for HID_QUIRK_IGNORE during probing
Date: Tue, 25 May 2010 22:53:23 +0200
Message-ID: <20100525225323.134b2c00@holly>
References: <20100523204725.6e9e8dad@holly>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51585 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756378Ab0EYUxe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 May 2010 16:53:34 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1OH17y-0000wp-QN
	for linux-input@vger.kernel.org; Tue, 25 May 2010 22:53:30 +0200
Received: from r11at174.net.upc.cz ([94.112.45.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 25 May 2010 22:53:30 +0200
Received: from makovick by r11at174.net.upc.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 25 May 2010 22:53:30 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Updated to current git:

--- hid-core.c.orig	2010-05-25 22:04:58.000000000 +0200
+++ hid-core.c	2010-05-25 22:08:53.791241376 +0200
@@ -1759,7 +1759,8 @@
 
 	/* we need to kill them here, otherwise they will stay
allocated to
 	 * wait for coming driver */
-	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE) && hid_ignore(hdev))
+	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE)
+            && (hid_ignore(hdev) || (hdev->quirks & HID_QUIRK_IGNORE)))
 		return -ENODEV;
 
 	/* XXX hack, any other cleaner solution after the driver core

-- 
Jindrich Makovicka


