From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]reliably killing urbs in yealink driver
Date: Fri, 27 Jun 2008 14:00:55 +0200
Message-ID: <200806271400.57257.oliver@neukum.org>
References: <200806261344.32326.oliver@neukum.org> <200806261632.18258.oliver@neukum.org> <20080626134141.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:59683 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbYF0MAa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2008 08:00:30 -0400
In-Reply-To: <20080626134141.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Henk.Vergonet@gmail.com

Am Donnerstag 26 Juni 2008 19:43:15 schrieb Dmitry Torokhov:
> On Thu, Jun 26, 2008 at 04:32:16PM +0200, Oliver Neukum wrote:
> > Am Donnerstag 26 Juni 2008 16:26:34 schrieb Dmitry Torokhov:
> > > Hi Oliver,
> > > 
> > > On Thu, Jun 26, 2008 at 01:44:30PM +0200, Oliver Neukum wrote:
> > > > @@ -809,8 +831,7 @@ static int usb_cleanup(struct yealink_de
> > > >  	if (yld == NULL)
> > > >  		return err;
> > > >  
> > > > -	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
> > > > -	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
> > > > +	stop_traffic(yld);
> > > 
> > > stop_traffic is unneeded here since input core guarantees that close is
> > > called when you unregister and opened device. Do you have the hardware
> > > to test? If not I will fold stop_traffic back into yealink_close
> > > locally.
> > > 
> > 
> > No, I don't have hardware to test.
> > 
> 
> OK, then I'll change it. I wonder whether we really need spinlock
> though or a simple wmb() is enough to make sure other CPUs notice
> the flag being set before we get to executing usb_kill_urb()...

I am unsure and wouldn't try anything so subtle without a clear need.

	Regards
		Oliver
