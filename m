From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 08:32:13 +0200
Message-ID: <201204250832.13252.oneukum@suse.de>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com> <CACVXFVOuSamcBrPT=K9Q3fAXULjz57e-1W9pi9AW1gAKxyCT7g@mail.gmail.com> <201204250819.32642.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56162 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab2DYGgO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 02:36:14 -0400
In-Reply-To: <201204250819.32642.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Mittwoch, 25. April 2012, 08:19:32 schrieb Oliver Neukum:
> Am Mittwoch, 25. April 2012, 03:27:19 schrieb Ming Lei:

> > @@ -546,8 +557,13 @@ static void __usbhid_submit_report(struct
> > hid_device *hid, struct hid_report *re
> >  			 * no race because this is called under
> >  			 * spinlock
> >  			 */
> > -			if (time_after(jiffies, usbhid->last_out + HZ * 5))
> > +
> > +			if (time_after(jiffies, usbhid->last_out + HZ * 5) &&
> > +					!usbhid->urbout->unlinked) {
> > +				spin_unlock(&usbhid->lock);
> >  				usb_unlink_urb(usbhid->urbout);
> > +				spin_lock(&usbhid->lock);
> > +			}
> >  		}
> >  		return;
> >  	}
> 
> Same objection. You are just making the race unlikelier. The flag
> needs to be set under a lock you hold while checking time_after().
> We'd be back at the original proposal.

In fact, now that I think about it, we could solve this with splitting
up usb_poison_urb(). We need to increase urb->reject under the
lock and then drop the lock. The only problem is double timeout.

	Regards
		Oliver
 
