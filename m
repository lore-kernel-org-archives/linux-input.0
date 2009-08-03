From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [PATCH] hid: ignore all recent SoundGraph iMON devices
Date: Mon, 03 Aug 2009 16:05:28 +0300
Message-ID: <4A76E098.90705@gmail.com>
References: <200907311056.36729.jarod@redhat.com> <4A733AE2.5000508@gmail.com> <200907311500.28866.jarod@redhat.com> <200908022116.05450.jarod@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:34718 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808AbZHCNFt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Aug 2009 09:05:49 -0400
In-Reply-To: <200908022116.05450.jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Jarod Wilson wrote:
> On Friday 31 July 2009 15:00:28 Jarod Wilson wrote:
>> On Friday 31 July 2009 14:41:38 Anssi Hannula wrote:
>>> Jarod Wilson wrote:
>>>> After some inspection of the Windows iMON driver, several additional
>>>> device IDs were added to the lirc_imon driver. At least a few of these
>>>> have been seen in the wild, and require manual quirking to keep the
>>>> usbhid driver from binding to them. Rather than list out every single
>>>> device, ignore the entire device ID range, 0x0034 - 0x0046. Some of
>>>> these may not advertise themselves as HID devices, but no harm done to
>>>> such devices anyway. Does the right thing in brief testing w/my 0x0045
>>>> device.
>>> I'm not sure this is a good idea. I have a 0x0038 device and I'm
>>> developing a proper HID driver for it. If and when I'll submit it for
>>> kernel inclusion, this kind of ID range blacklisting may get ugly.
>> Erm, there's already a full driver for it though, and its already in
>> the ignore list...
> 
> Also, out of curiosity, what does a "proper HID driver for it" look
> like and/or do that the latest lirc_imon doesn't?

Well, I didn't want to use 3rdparty drivers with my device.

Anyways.. my driver implements a hid_driver (see /drivers/hid/hid-*.c),
and sets a raw_event callback for the non-standard-hid-input events of
the 2nd interface and emits input layer events for those. The device
uses standard HID input protocol in first interface, so my driver
doesn't touch that at all and lets the general hid code handle that
(some remote control buttons are passed by that). LCD write packets are
queued via usbhid_submit_report(). The driver also has code for
registering the LCD as standard framebuffer device and allowing led
subsystem access to the icons, though I'm not sure yet if those should
be there (1-bit framebuffers may not be supported by much userspace
code, haven't checked yet; having the icons registered for led subsystem
allows triggers and handling via /sys, but I'm not sure if that is
useful for these kind of icons).

> We're already doing
> input layer stuff with the mouse mode and mouse buttons, and looking to
> further extend that, potentially making the driver pure input layer,
> but still usable with the lirc devinput userspace driver.

Oh, this sounds to me like active work getting lirc into upstreamable
condition :)  Is it that?

More incentive for me to not submit my driver, then.

-- 
Anssi Hannula
