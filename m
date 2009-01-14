From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: new modular hid?
Date: Wed, 14 Jan 2009 16:26:21 +0300
Message-ID: <496DE7FD.8080406@msgid.tls.msk.ru>
References: <496BA275.1080504@msgid.tls.msk.ru> <alpine.LRH.1.10.0901130052180.24105@twin.jikos.cz> <20090112213924.ZZRA012@mailhub.coreip.homeip.net> <alpine.LNX.1.10.0901130939290.5377@jikos.suse.cz> <alpine.LNX.1.10.0901130958230.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.33.150]:22640 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762126AbZANN0X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 08:26:23 -0500
In-Reply-To: <alpine.LNX.1.10.0901130958230.5377@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

Jiri Kosina wrote:
> On Tue, 13 Jan 2009, Jiri Kosina wrote:
> 
>>> I would agree with Michael here, it looks like we went a bit overboard 
>>> with HID quirks. I think sensible solution would be to merge quirks into 
>>> 3-4 files (one per device type) and maybe even compile keyboard quirks 
>>> into hid core.
>> It might seem a too bit too much fine-grained right now, but my 
>> longer-term plan was to have more sophisticated drivers also register 
>> themselves to the HID bus, make use of the common parser, etc (Wacom comes 
>> to mind, for example). 
>> Having the quirks grouped together rather than nicely separate would then 
>> bring us close to the previous total mess, when unrelated quirks were 
>> glued together randomly in the spaghetti-code-way, which I really would 
>> like to avoid as much as possible, it started to become unmaintainable.
> 
> That being said, we of course need to think about the initrd issue brought 
> up by Michael.
> 
> Compiling everything into single driver back again in the end would of 
> course be a solution, but I am afraid that it'd be quite difficult with 
> the bus infrastructure in place.

I'm not sure I understand.

Let's take a look at my example, hid_bright.  Without this module, my
keyboard does not work, even if usbhid&Co is loaded.  But this module
does exactly two things:

  hid_hw_start(hdev, HID_CONNECT_DEFAULT);
  usbhid_set_leds(hdev);

(modulo error checking and the like).  The leds (caps, scroll and num
locks) on this keyboard works without the last call (I just checked).
hid_hw_start() gets called from all other drivers too.  So *to me*
it looks like this subdriver does exactly nothing useful.  Yet
w/o it the (perfectly working before 2.6.28) keyboard does not
work.

Maybe, just maybe, it's possible to init stuff by default, and
get additional features or quirks later, when actually loading
the sub-driver?  But any way, this "doing nothing" driver thing
seems to be wrong...

It's even more (to me): I don't understand the "hid bus" thing to
start with.  How the autoload (with udev) works?  I don't see any
modalias things in this module, `modinfo hid_bright' shows nothing
useful, and there are no useful modalias files in /sys/bus/hid/
either.

What mess was before the split?  How it's different from the current
many-small-doing-nothing things?

Thanks!

/mjt
