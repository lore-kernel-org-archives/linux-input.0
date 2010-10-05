From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Mon, 4 Oct 2010 23:08:22 -0700
Message-ID: <20101005060822.GD15355@core.coreip.homeip.net>
References: <1285844276.26405.26.camel@cookie.hadess.net>
 <201010042117.41786.oliver@neukum.org>
 <20101005044520.GA14707@core.coreip.homeip.net>
 <201010050802.14271.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33655 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab0JEGI2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 02:08:28 -0400
Content-Disposition: inline
In-Reply-To: <201010050802.14271.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Oct 05, 2010 at 08:02:14AM +0200, Oliver Neukum wrote:
> Am Dienstag, 5. Oktober 2010, 06:45:20 schrieb Dmitry Torokhov:
> > > > +{
> > > > +   struct appleir *appleir = input_get_drvdata(dev);
> > > > +
> > > > +   mutex_lock(&appleir_mutex);
> > > > +
> > > > +   if (!(appleir->flags & APPLEIR_SUSPENDED)) {
> > > > +           usb_kill_urb(appleir->urb);
> > > > +           del_timer_sync(&appleir->key_up_timer);
> > > 
> > > You can close with a key unreleased.
> > 
> > I think this is handled by input core. We forcibly send release events
> > when device is disconnected; this takes care of surprise disconnect case.
> > OTOH if input_dev->close() is called that means that there are no more
> > listeners for the events so the fact that a key is still pressed is not
> > interesting to anyone.
> 
> But what about the next opener? He'll get a completely spurious
> key release event, as the next key is pressed.

How does the opening of a device handle relate to a device state?
Userspace should expect to see releases without presses (in case they
weren't the first client that opened the device).

But I guess we should reset the "last key" here, just in case.

> 
> > > > +           usb_kill_urb(appleir->urb);
> > > 
> > > If the system goes to sleep you'd better report a pressed key
> > > as released here and kill the timer.
> > 
> > Input core sends "release" events upon resume so we should be OK.
> 
> I see. OK, this is covered.

Might be a good idea to reset "last key" here as well. No need to send
2nd release event later on.

-- 
Dmitry
