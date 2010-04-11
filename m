From: Michael Poole <mdpoole@troilus.org>
Subject: Re: Preferred way for a multitouch driver?
Date: Sun, 11 Apr 2010 12:54:40 -0400
Message-ID: <87633yhqun.fsf@troilus.org>
References: <Pine.LNX.4.64.1004111828030.29274@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51173 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751953Ab0DKQyo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 12:54:44 -0400
Received: by qyk30 with SMTP id 30so1266146qyk.16
        for <linux-input@vger.kernel.org>; Sun, 11 Apr 2010 09:54:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1004111828030.29274@butterbrot.org> (Florian
	Echtler's message of "Sun, 11 Apr 2010 18:41:04 +0200 (CEST)")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org

Florian Echtler writes:

> Hello everyone,
>
> I've just bought a Lenovo S10-3t convertible netbook, and now I'm
> experimenting with the "multitouch" screen (dual-touch, rather). It's
> being recognized as a HID device, and using hid-device-dump, I can
> nicely read the reports of both fingers. There's also some hacks
> floating around which use xf86-input-hidtouch, but AFAICT that doesn't
> do any kind of multitouch.
>
> From lurking here on the list, I've gathered that the evdev interface
> by now fully supports all kinds of multitouch events, so I guess the
> preferred way would be a hiddev-to-evdev bridge of some kind, right?

You don't need that -- HID drivers already generate evdev events.

> Can somebody point me into the right direction, e.g. to some other
> driver which also works that way?

You can find them by grepping for ABS_MT_ in the drivers/hid/ directory.
hid-3m-pct, hid-magicmouse, hid-mosart, hid-ntrig, hid-quanta and
hid-stratum all generate multitouch events.  Most of them use standard
HID report descriptors; however, hid-magicmouse has to translate input
reports that don't have published descriptors.  Depending on how the
screen behaves, you'll probably want to look more at the other drivers
than hid-magicmouse.

Michael Poole
