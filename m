From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: ucb1400_gpio driver Kconfig entry
Date: Tue, 1 Feb 2011 18:38:52 +0100
Message-ID: <201102011838.52571.marek.vasut@gmail.com>
References: <87bp2vsy5y.fsf@tac.ki.iif.hu> <201102011816.24029.marek.vasut@gmail.com> <87ipx3r7i7.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39840 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1BARf5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Feb 2011 12:35:57 -0500
In-Reply-To: <87ipx3r7i7.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tuesday 01 February 2011 18:26:24 Ferenc Wagner wrote:
> Marek Vasut <marek.vasut@gmail.com> writes:
> > On Tuesday 01 February 2011 14:05:13 Ferenc Wagner wrote:
> >> drivers/gpio/Kconfig says:
> >> 
> >> config GPIO_UCB1400
> >> 
> >>         bool "Philips UCB1400 GPIO"
> >>         depends on UCB1400_CORE
> >>         help
> >>         
> >>           This enables support for the Philips UCB1400 GPIO pins.
> >>           The UCB1400 is an AC97 audio codec.
> >>           
> >>           To compile this driver as a module, choose M here: the
> >>           module will be called ucb1400_gpio.
> >> 
> >> But you use bool above, so choosing M isn't actually an option.
> >> Maybe you want to resolve this inconsistency.
> > 
> > I don't really have any device with ucb1400 available now. I will have
> > some probably sometimes soon though. On the other hand, if you know
> > it's a correct fix, you can send a patch.
> 
> This note hasn't got much to do with the driver code itself.  Either you
> want to enable compiling the driver as a module, then use tristate
> instead of bool; or it isn't an option and then remove the corresponding
> paragraph from the documentation.  The latter is improbable, and a
> quick look at the code seems to confirm that the driver was actually
> intended to be used as a module.  So I suggest replacing bool with
> tristate.  But I don't know anything at all about this driver or device.

I know what this thing is -- it's a MFD chip with audio/touchscreen/gpio on it. 
I'll get to a device with such thing soon, so don't worry. I'll keep this in 
ToDo. I think it should be possible to compile this as a module btw.

Cheers
