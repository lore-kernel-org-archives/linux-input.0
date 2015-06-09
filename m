From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 09:37:24 -0700
Message-ID: <20150609163724.GB6338@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f194.google.com ([209.85.223.194]:35801 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbFIQh3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 12:37:29 -0400
Content-Disposition: inline
In-Reply-To: <20150609105421.GA15814@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Jun 09, 2015 at 12:54:21PM +0200, Pavel Machek wrote:
> Hi!
> 
> > I finally was able to spend some time looking over Samuel's patch set
> > switching input LEDs from custom implementation over to standard LED class
> > devices and I think this is the shape I am reasonably happy with. The
> > changes:
> 
> Thanks!
> 
> > Please take a look and see if you see any holes.
> 
> Tested on thinkpad t40p. Started X, but then I went to text console
> for testing.
> 
> 1) input4::caps-lock -- default trigger was not set, so caps lock did
> not control the LED. That's bug, right?

Since you mention that after rebooting it assigned the right trigger
that is expected - the triigers are coming from keyboard.c which is
built-in, not a module.

> 
> I did echo kbd-capslock > trigger, but still no luck. (That might be
> bug in Debian, IIRC?)

On Debian and Ubunty the keycode emitted by CapsLock ke=y is CtrlL_Lock
for whatever reason, so CapsLock LED does not light up by default
(neither with these patcher nor without them). If you change setkeycodes
to assign CapsLock to keycode 58 it should work. Or set trigger for the
led to "kbd-ctrlllock".

Thanks.

-- 
Dmitry
