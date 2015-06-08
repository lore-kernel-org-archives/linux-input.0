From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Mon, 8 Jun 2015 16:16:18 -0700
Message-ID: <20150608231618.GA420@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433804291.12204.15.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33376 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbbFHXQX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 19:16:23 -0400
Content-Disposition: inline
In-Reply-To: <1433804291.12204.15.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Jun 09, 2015 at 12:58:11AM +0200, Bastien Nocera wrote:
> On Mon, 2015-06-08 at 14:43 -0700, Dmitry Torokhov wrote:
> > Hi,
> > 
> > I finally was able to spend some time looking over Samuel's patch set
> > switching input LEDs from custom implementation over to standard LED 
> > class
> > devices and I think this is the shape I am reasonably happy with. The
> > changes:
> > 
> <snip>
> > 2. There are no per-input device triggers. Input devices only carry 
> > LEDs
> > and those LEDs use one of the system-wide triggers. Which ones is to 
> > user
> > to decide. The default triggers are the one defines by keyboard 
> > handler for
> > it's standard LED states.
> > 
> <snip>
> > Please take a look and see if you see any holes.
> 
> What would the quirk for a keyboard not having LEDs look like?
> 
> In GNOME, we want to pop up a on-screen display when pressing, say, the
> Caps Lock key on a keyboard that doesn't have any such keys (such as my
> Lenovo X1 Carbon and the Logitech K750 that's plugged into it in my
> case).

This is not really related to this patch set, but LED bitmap for input
devices is sent in their uevents so you can check it in udev. This will
assumes that input driver knows whether LED is present on device or not
(and for PS/2 keyboards it does not and assumes they are there so your
X1's keyboard tell you that it has 3 standard LEDs).

Thanks.

-- 
Dmitry
