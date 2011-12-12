From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: bcm5974 - Fix USB autosuspend
Date: Mon, 12 Dec 2011 11:26:30 +0100
Message-ID: <20111212102630.GA2479@polaris.bitmath.org>
References: <1323680764-2155-1-git-send-email-rydberg@euromail.se>
 <201112121002.53004.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:53305 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab1LLKML (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Dec 2011 05:12:11 -0500
Content-Disposition: inline
In-Reply-To: <201112121002.53004.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

On Mon, Dec 12, 2011 at 10:02:52AM +0100, Oliver Neukum wrote:
> Am Montag, 12. Dezember 2011, 10:06:04 schrieb Henrik Rydberg:
> > @@ -895,6 +857,10 @@ static int bcm5974_probe(struct usb_interface *iface,
> >         /* save our data pointer in this interface device */
> >         usb_set_intfdata(iface, dev);
> >  
> > +       error = bcm5974_start_traffic(dev);
> > +       if (error)
> > +               goto err_free_buffer;
> > +
> >         return 0;
> >  
> >  err_free_buffer:
> > -- 
> 
> Why do you want to start traffic before open() in probe() ?
> It doesn't make sense to ask a device to deliver data nobody
> wants.

Seems I was a bit trigger happy here, will send another one.

Thanks,
Henrik
