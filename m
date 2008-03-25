From: "M G" <lists.mg@googlemail.com>
Subject: xpad - led or rumble disables controller
Date: Tue, 25 Mar 2008 20:15:32 +0100
Message-ID: <74d457500803251215h5e7ae88erf58e2fb1f141745a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:25481 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759415AbYCYTPd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Mar 2008 15:15:33 -0400
Received: by py-out-1112.google.com with SMTP id u52so5123015pyb.10
        for <linux-input@vger.kernel.org>; Tue, 25 Mar 2008 12:15:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, I'm trying to use my Xbox360 Controller with the xpad driver. But
as soon as the led status is set (i.e. right after pluging it in) it
becomes unresponsive. If I comment out the led-setting code in xpad.c
the controller works but only until a rumble effect is played, then it
will become unresponsive again.

I have found that this does not occur if transfer_buffer_length is set
to the exact value, 3 for the led and 8 for rumble.


--- a/xpad.c	2008-03-21 16:39:58.000000000 +0100
+++ b/xpad.c	2008-03-21 16:38:41.000000000 +0100
@@ -469,6 +469,7 @@
 		xpad->odata[5] = 0x00;
 		xpad->odata[6] = 0x00;
 		xpad->odata[7] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 8;
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 	}

@@ -502,6 +503,7 @@
 		xpad->odata[0] = 0x01;
 		xpad->odata[1] = 0x03;
 		xpad->odata[2] = command;
+		xpad->irq_out->transfer_buffer_length = 3;
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 		mutex_unlock(&xpad->odata_mutex);
 	}


Does that seem right?
