From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch]reliably killing urbs in yealink driver
Date: Thu, 26 Jun 2008 13:43:15 -0400
Message-ID: <20080626134141.ZZRA012@mailhub.coreip.homeip.net>
References: <200806261344.32326.oliver@neukum.org> <20080626142633.GA16831@anvil.corenet.prv> <200806261632.18258.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:39547 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbYFZRnY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Jun 2008 13:43:24 -0400
Received: by yx-out-2324.google.com with SMTP id 31so72170yxl.1
        for <linux-input@vger.kernel.org>; Thu, 26 Jun 2008 10:43:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200806261632.18258.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Alfred E. Heggestad" <aeh@db.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Henk.Vergonet@gmail.com

On Thu, Jun 26, 2008 at 04:32:16PM +0200, Oliver Neukum wrote:
> Am Donnerstag 26 Juni 2008 16:26:34 schrieb Dmitry Torokhov:
> > Hi Oliver,
> > 
> > On Thu, Jun 26, 2008 at 01:44:30PM +0200, Oliver Neukum wrote:
> > > @@ -809,8 +831,7 @@ static int usb_cleanup(struct yealink_de
> > >  	if (yld == NULL)
> > >  		return err;
> > >  
> > > -	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
> > > -	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
> > > +	stop_traffic(yld);
> > 
> > stop_traffic is unneeded here since input core guarantees that close is
> > called when you unregister and opened device. Do you have the hardware
> > to test? If not I will fold stop_traffic back into yealink_close
> > locally.
> > 
> 
> No, I don't have hardware to test.
> 

OK, then I'll change it. I wonder whether we really need spinlock
though or a simple wmb() is enough to make sure other CPUs notice
the flag being set before we get to executing usb_kill_urb()...

-- 
Dmitry
