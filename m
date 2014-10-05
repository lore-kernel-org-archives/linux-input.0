From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Perixx reprogrammable mouse
Date: Sun, 5 Oct 2014 23:34:02 +0200
Message-ID: <20141005233402.7a9a437630c6c3796fc59a96@ao2.it>
References: <20141005105951.GA1935@vinc94-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:64858 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbaJEVj1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Oct 2014 17:39:27 -0400
In-Reply-To: <20141005105951.GA1935@vinc94-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vincenzo Scotti <vinc94@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, 5 Oct 2014 12:59:51 +0200
Vincenzo Scotti <vinc94@gmail.com> wrote:

> Hello.
> I just bought some new mouses from Perixx MX's series. They work out of the
> box with usbhid, even though they don't have an official driver under Linux to
> remap buttons, and online I couldn't find anything useful.
> So I was planning as a spare time project to write some sort of driver.
> I read that usbmon could be useful to understand the protocol, if using
> something like a Virtualbox VM with Windows running on it.

usbmon + tshark for capture, and wireshark for analysis is the best way
I found.

> Given that, would it be better to make the driver as a kernel module, or as a
> userspace application? I couldn't find any reprogrammable mouse driver in the
> kernel drivers directory.

What features do the devices offer? Something like auto-fire, latch
mode and so on?

I guess a userspace command line tool (maybe based on libusb) + udev
hooks to load a stored configuration would be enough for a prototype.

If later you want to load per-user configurations automatically you may
end up writing your own daemon/applet using libudev.

> I think that the more games will be ported to Linux, the more we'll need soon
> to have some support for this gamers-equipment.
> 
> I hope you'll give me some hints.
> 

Ciao ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
