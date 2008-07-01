From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 08:56:30 -0400
Message-ID: <20080701085504.ZZRA012@mailhub.coreip.homeip.net>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net> <200807010046.34219.oliver@neukum.org> <alpine.LNX.1.10.0807010957320.6375@jikos.suse.cz> <200807011108.48556.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:65444 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684AbYGAM4g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 08:56:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so398898and.103
        for <linux-input@vger.kernel.org>; Tue, 01 Jul 2008 05:56:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807011108.48556.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Alan Stern <stern@rowland.harvard.edu>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Jul 01, 2008 at 11:08:47AM +0200, Oliver Neukum wrote:
> Am Dienstag 01 Juli 2008 09:59:01 schrieb Jiri Kosina:
> > On Tue, 1 Jul 2008, Oliver Neukum wrote:
> > 
> > >> Ok, I see... So what does a device do when it is suspended and a 
> > >> request comes in? Does it automatically resume and service the request 
> > >> (and potentially goes back to sleep)? Does it queue the request for 
> > >> later? Ignore it? Is it a system-wide policy or up to the device 
> > >> [class]?
> > > Return an error. If you queue, how much would you queue?
> > > There's no sane answer, so you better fail right away.
> > 
> > I guess that Dmitry's question was about the behavior of the driver, 
> > right? For example in situation when the LED state changes on PS/2 
> > keyboard, what should the USB keyboard driver do for a suspended USB 
> > keyboard.
> 
> I understood it that way.
> 
> > I really don't think we want to return error in such cases. Either resume 
> > the device, or queue some requests (maybe depending on the type of 
> > requests), right?
> 
> We are talking about forcibly suspended devices, so they cannot be
> resumed. We could queue, but where would we end queuing? And we
> have to decide to stop it at some point, or we create a DoS problem.
> 
> The user has decided to put the device in a state in which the driver
> cannot properly function. If the user wanted the driver to work, he should
> select autosuspend.
>

That is the thing with the forced suspend - it leaves device out of
sync with the rest of the system. If user really does not want to use
the device it should probably be completely disconnected?

-- 
Dmitry
