From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 11:08:47 +0200
Message-ID: <200807011108.48556.oliver@neukum.org>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net> <200807010046.34219.oliver@neukum.org> <alpine.LNX.1.10.0807010957320.6375@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:54223 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYGAJIS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 05:08:18 -0400
In-Reply-To: <alpine.LNX.1.10.0807010957320.6375@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Ville Syrj?l? <syrjala@sci.fi>, daniel.ritz@gmx.ch, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Dienstag 01 Juli 2008 09:59:01 schrieb Jiri Kosina:
> On Tue, 1 Jul 2008, Oliver Neukum wrote:
> 
> >> Ok, I see... So what does a device do when it is suspended and a 
> >> request comes in? Does it automatically resume and service the request 
> >> (and potentially goes back to sleep)? Does it queue the request for 
> >> later? Ignore it? Is it a system-wide policy or up to the device 
> >> [class]?
> > Return an error. If you queue, how much would you queue?
> > There's no sane answer, so you better fail right away.
> 
> I guess that Dmitry's question was about the behavior of the driver, 
> right? For example in situation when the LED state changes on PS/2 
> keyboard, what should the USB keyboard driver do for a suspended USB 
> keyboard.

I understood it that way.

> I really don't think we want to return error in such cases. Either resume 
> the device, or queue some requests (maybe depending on the type of 
> requests), right?

We are talking about forcibly suspended devices, so they cannot be
resumed. We could queue, but where would we end queuing? And we
have to decide to stop it at some point, or we create a DoS problem.

The user has decided to put the device in a state in which the driver
cannot properly function. If the user wanted the driver to work, he should
select autosuspend.

	Regards
		Oliver
