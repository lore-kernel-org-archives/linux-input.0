From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: new modular hid?
Date: Wed, 14 Jan 2009 14:39:00 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901141435150.5377@jikos.suse.cz>
References: <496BA275.1080504@msgid.tls.msk.ru> <alpine.LRH.1.10.0901130052180.24105@twin.jikos.cz> <20090112213924.ZZRA012@mailhub.coreip.homeip.net> <alpine.LNX.1.10.0901130939290.5377@jikos.suse.cz> <alpine.LNX.1.10.0901130958230.5377@jikos.suse.cz>
 <496DE7FD.8080406@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:44542 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751007AbZANNjD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 08:39:03 -0500
In-Reply-To: <496DE7FD.8080406@msgid.tls.msk.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Wed, 14 Jan 2009, Michael Tokarev wrote:

> Let's take a look at my example, hid_bright.  Without this module, my 
> keyboard does not work, even if usbhid&Co is loaded.  But this module 
> does exactly two things:
> 
>   hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>   usbhid_set_leds(hdev);
> Maybe, just maybe, it's possible to init stuff by default, and get 
> additional features or quirks later, when actually loading the 
> sub-driver?  But any way, this "doing nothing" driver thing seems to be 
> wrong...

Yes. And actually hid-bright and hid-dell drivers have been already 
removed in current Linus' tree, and the leds are handled in the generic 
code again. So in this particular case, things are exactly the same as 
they used to be before for your hardware.

Still, there are drivers that are more complicated and having the code in 
the generic code is not bearable, so we have to think about this and solve 
it anyway, even though this is not going to be a problem particularly for 
your system in 2.6.29.

-- 
Jiri Kosina
