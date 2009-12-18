From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Fri, 18 Dec 2009 11:52:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48527 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358AbZLRKwe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2009 05:52:34 -0500
In-Reply-To: <4B2ABC62.2030600@physik.uni-muenchen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, 18 Dec 2009, Johannes Ebke wrote:

> I have looked into the problems some more, and have found that the cause 
> of the crash was a change I made because I misunderstood the code 
> (LO(cmd) is the number of bytes in in the message, and is not 
> transferred on USB - i had removed it from the message...)

Ah, good, thanks.

> First, the changes in the normal input, the joystick axis+buttons message:
> * Prefix is 0x06 instead of 0x01 (joystick) or 0x03 (gamepad)
> * Throttle is not inverted (data[4] instead of 255-data[4])
> * Rudder is present and unsigned (not signed, as in iforce)
> 
> I have attached a patch that I think fixes this (it works for me :) 
> Since saitek uses a different protocol byte, this can be done without 
> adding per-device flags to the driver.
> 
> It also adds a button map btn_saitek_cyborg that switches button 1&2 to
> make the button number the same as printed on the device, and
> abs_saitek_cyborg for a joystick with rudder but only one hat.
> 
> The fftest effects seem to work, but some are feeble and feel strange -
> I suspect there are some subtle changes, for example I am quite sure
> that the Saitek uses signed (twos complement) numbers for effect
> strength (this could perhaps explain the 'strange' behavior for 0x80
> byte values in the current code)...

The changes look really minimal to me, so I'd propose just to add a few 
special cases to the iforce driver itself (probably by setting/checking 
some per-device flag where needed), rather than copy/pasting the whole 
iforce driver.

But the ultimate decision is on Dmitry (CCed) here.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
