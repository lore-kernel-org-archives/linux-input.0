From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: export LEDs as class devices in sysfs
Date: Wed, 22 Jul 2015 14:49:48 -0700
Message-ID: <20150722214948.GF14875@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609174211.GH6338@dtor-ws>
 <55AE299F.3010002@suse.cz>
 <20150721170133.GA39076@dtor-ws>
 <55AFAB9B.2090101@suse.cz>
 <alpine.LNX.2.00.1507222145030.1141@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34723 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbGVVtx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2015 17:49:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1507222145030.1141@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, Jul 22, 2015 at 09:49:06PM +0200, Jiri Kosina wrote:
> On Wed, 22 Jul 2015, Vlastimil Babka wrote:
> 
> > [  101.805120] usb 3-4: new low-speed USB device number 3 using xhci_hcd
> > [  101.979584] usb 3-4: New USB device found, idVendor=046d, idProduct=c50e
> > [  101.979589] usb 3-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > [  101.979592] usb 3-4: Product: USB Receiver
> > [  101.979594] usb 3-4: Manufacturer: Logitech
> > [  101.979805] usb 3-4: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
> > [  101.989010] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989014] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989017] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989019] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989021] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989023] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989025] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989027] hid-generic 0003:046D:C50E.0003: Mapped LED usage 4b as LED 8
> > [  101.989091] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb3/3-4/3-4:1.0/0003:046D:C50E.0003/input/input14
> > [  102.039320] ------------[ cut here ]------------
> > [  102.039329] WARNING: CPU: 6 PID: 168 at ../drivers/input/input-leds.c:115 input_leds_connect+0x22b/0x260()
> > 
> > (5 WARNINGs as before)
> > 
> > [  102.040729] hid-generic 0003:046D:C50E.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-4/input0
> 
> Alright, I think it's pretty obvious what's happening. Vlastimil, am I 
> right that the patch below fixes the issue?
> 
> I am however not sure whether input_leds_connect() is not too unkind to 
> unnamed LEDs and shouldn't be more tolerant to those in the long term.

Yes, I'll change how we count the leds to skip unnamed, then the patch
below won't be needed.

BTW, maybe we should be using hid_map_usage_clear() in map_led() as it
does not make much sense to convert CAPS LOCK into SCROLL LOCK in case
keyboard happens to have 2 usages for caps...

Thanks.

-- 
Dmitry
