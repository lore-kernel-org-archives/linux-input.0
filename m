From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Thu, 14 Sep 2017 13:49:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709141242040.9284-100000@netrider.rowland.org>
References: <CAAeHK+yCz++ShQW5qgVOxo7Cam4M7tAefHn+ZLySZeDiObJpYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:49519 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751509AbdINRte (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Sep 2017 13:49:34 -0400
In-Reply-To: <CAAeHK+yCz++ShQW5qgVOxo7Cam4M7tAefHn+ZLySZeDiObJpYw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>

On Thu, 14 Sep 2017, Andrey Konovalov wrote:

> Looked at this a little more.
> 
> dummy_timer() stucks in an infinite loop. It calls
> usb_hcd_giveback_urb(), which in turn calls usbtouch_irq(), which
> calls usb_submit_urb(), which calls dummy_urb_enqueue() and puts urb
> back into dummy urb queue. dummy_timer() then does goto restart, finds
> the urb and calls usb_hcd_giveback_urb() again. And this process goes
> on again and again. It seems that something should either process the
> urb and set urb->status or it should just expire.

There is some throttling code, but it applies only to bulk transfers.  
Probably because the bandwidth limits for other types are slightly 
different.  However, I don't think we need to worry about this level of 
detail, since the driver makes a number of other approximations anyway.

Try the patch below; it should fix the problem.

Alan Stern



Index: usb-4.x/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-4.x.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-4.x/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1781,7 +1781,6 @@ restart:
 		struct dummy_request	*req;
 		u8			address;
 		struct dummy_ep		*ep = NULL;
-		int			type;
 		int			status = -EINPROGRESS;
 
 		urb = urbp->urb;
@@ -1789,14 +1788,10 @@ restart:
 			goto return_urb;
 		else if (dum_hcd->rh_state != DUMMY_RH_RUNNING)
 			continue;
-		type = usb_pipetype(urb->pipe);
 
-		/* used up this frame's non-periodic bandwidth?
-		 * FIXME there's infinite bandwidth for control and
-		 * periodic transfers ... unrealistic.
-		 */
-		if (total <= 0 && type == PIPE_BULK)
-			continue;
+		/* Used up this frame's bandwidth? */
+		if (total <= 0)
+			break;
 
 		/* find the gadget's ep for this request (if configured) */
 		address = usb_pipeendpoint (urb->pipe);

