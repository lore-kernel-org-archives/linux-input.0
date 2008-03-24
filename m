From: "M G" <lists.mg@googlemail.com>
Subject: xpad - led/rumble completely disables controller
Date: Mon, 24 Mar 2008 14:46:09 +0100
Message-ID: <74d457500803240646m686d3395pe23cd7a7f5349b8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:7779 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758295AbYCXNqL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Mar 2008 09:46:11 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1708497wra.1
        for <linux-input@vger.kernel.org>; Mon, 24 Mar 2008 06:46:10 -0700 (PDT)
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
to the exact value, 3 for the led and 8 for rumble, like so:

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
