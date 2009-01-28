From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]reversed logic in disconnect testing of hiddev
Date: Wed, 28 Jan 2009 09:30:15 +0100
Message-ID: <200901280930.16072.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:45667 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbZA1I3m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 03:29:42 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

The logic for testing for disconnection is reversed in an ioctl leading
to false reports of disconnection.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
Tested-by: Folkert van Heusden <folkert@vanheusden.com>

Hi,

this should go into the next rc of 2.6.29

	Regards
		Oliver

---

--- linux-2.6/drivers/hid/usbhid/hiddev.c.alt	2009-01-26 20:03:10.000000000 +0100
+++ linux-2.6/drivers/hid/usbhid/hiddev.c	2009-01-26 20:03:17.000000000 +0100
@@ -656,7 +656,7 @@ static long hiddev_ioctl(struct file *fi
 
 	case HIDIOCGSTRING:
 		mutex_lock(&hiddev->existancelock);
-		if (!hiddev->exist)
+		if (hiddev->exist)
 			r = hiddev_ioctl_string(hiddev, cmd, user_arg);
 		else
 			r = -ENODEV;
