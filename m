From: Taneli =?iso-8859-1?Q?V=E4h=E4kangas?=
	<taneli.vahakangas@welho.com>
Subject: Re: support for Logitech Wave
Date: Wed, 16 Jan 2008 23:58:24 +0200
Message-ID: <20080116215824.GA3797@localhost>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi> <20080116110244.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:51229 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbYAPV6f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2008 16:58:35 -0500
Content-Disposition: inline
In-Reply-To: <20080116110244.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Timo Aaltonen <tjaalton@cc.hut.fi>, linux-input@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>


Hi! Chiming in, as I have a similar issue ...

On Wed, Jan 16, 2008 at 11:07:17AM -0500, Dmitry Torokhov wrote:
> Hi Timo,
> 
> On Tue, Jan 15, 2008 at 03:49:14PM +0200, Timo Aaltonen wrote:
> >
> > 	Hi
> >
> >   I've got a Logitech Wave keyboard, that has a number of extra keys on it, 
> > and most of them fail to work with evdev. I get no output with xev or while 
> > trying to cat the input device. I've been told that it's a kernel issue if 
> > the device shows no events, hence this email.
> >
> > What should I do to get full support for all the keys on it? It's a nice 
> > keyboard, so I'd like to get the most of it :)
> >
> 
> Please try booting with the latest -rc kernel (currently 2.6.26-rc8) and run
> evtest utility. You should see it report MSC_SCAN events when you press keys
> on your keyboard. Compose list of keys and corresponding codes and send it to
> Jiri Kosina so he can add proper mappings to the HID driver.

I tried the same on a Creative Prodikeys keyboard, but can't see any
events for some keys (most notably none of the "piano" keys work).

Is there anything that can be done to make it work?

Cheers,

	Taneli

