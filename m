From: Sergey Senozhatsky <sergey.senozhatsky@mail.by>
Subject: [PATCH] HID: Avoid double spin_lock_init on usbhid->lock (resend)
Date: Tue, 23 Jun 2009 12:33:25 +0300
Message-ID: <20090623093324.GB3805@localdomain.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [212.98.175.89] ([212.98.175.89]:39464 "EHLO localdomain.by"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751136AbZFWJbx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 05:31:53 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Trivial: Avoid double spin_lock_init on usbhid->lock.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@mail.by>
---
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 76c4bbe..c654b89 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -987,7 +987,6 @@ static int usbhid_start(struct hid_device *hid)
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
 
 	spin_lock_init(&usbhid->lock);
-	spin_lock_init(&usbhid->lock);
 
 	usbhid->intf = intf;
 	usbhid->ifnum = interface->desc.bInterfaceNumber;
