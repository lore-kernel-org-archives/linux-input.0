From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Simple approach to write PS3/PS4 usermode driver?
Date: Mon, 15 Feb 2016 22:34:36 +0100
Message-ID: <20160215223436.fc5a3f66f82ee49b161099ea@ao2.it>
References: <56C2270E.9080603@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:54610 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbcBOVem (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Feb 2016 16:34:42 -0500
In-Reply-To: <56C2270E.9080603@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input@vger.kernel.org

On Mon, 15 Feb 2016 20:29:18 +0100
Manuel Reimer <mail+linux-input@m-reimer.de> wrote:

> Hello,
> 
> now I've been trying several things, but maybe I missed something.
> 
> - If I just blacklist "hid-sony", then everything is dead. No bluetooth 
> binding, no "/dev/hidrawX".
> - After some searching, I found out that the core reason for this is a 
> "hid_have_special_driver" list in hid-core.c which contains the PS3/PS4 
> controller.
> - So I thought: Maybe I can keep "hid-sony" to keep "/dev/hidrawX" and 
> somehow detach the generated eventX and jsX devices. I've been searching 
> /sys for about half an hour but I didn't find any way to do this. Maybe 
> impossible?
>

Have you tried loading hid.ko with the ignore_special_drivers=1
parameter? I guess that will ignore _all_ special drivers tho, even
mouse and keyboard ones.

> I know that libusb may be an option, but this way I also give up easy 
> bluetooth binding. Especially the PS4 gamepad is easy to bind. If the 
> resulting bluetooth device wouldn't be blacklisted in hid-core.c.
>

Alan Ott's hidapi[1] is a better alternative to libusb for hid
devices.

[1] http://www.signal11.us/oss/hidapi/

> Maybe someone can give me a hint. Is there any easy way to get the HID 
> to input device translation process ported into usermode without giving 
> up all the things that work automatically if hid-sony is active?
> 
> Thank you very much for any information.
> 

I reckon a patched kernel is not an option, is it?

If I may, why a userspace driver? Can't you improve the kernel driver
to match your needs? You'd also avoid code duplication this way.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
