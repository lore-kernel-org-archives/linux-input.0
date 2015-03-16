From: Timo Teras <timo.teras@iki.fi>
Subject: Re: hidraw with exclusive access ?
Date: Mon, 16 Mar 2015 20:39:12 +0200
Message-ID: <20150316203912.75b32686@vostro>
References: <20150313083758.076c8dfb@vostro>
	<CAN+gG=GdNpqDTazZD6_4r8AmWqbZg-_w8M2-6PDdvKjwdFfFWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35185 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934075AbbCPSj7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 14:39:59 -0400
Received: by lbcgn8 with SMTP id gn8so26484685lbc.2
        for <linux-input@vger.kernel.org>; Mon, 16 Mar 2015 11:39:58 -0700 (PDT)
In-Reply-To: <CAN+gG=GdNpqDTazZD6_4r8AmWqbZg-_w8M2-6PDdvKjwdFfFWw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, 16 Mar 2015 11:29:10 -0400
Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:

> On Fri, Mar 13, 2015 at 2:37 AM, Timo Teras <timo.teras@iki.fi> wrote:
> > Hi,
> >
> > I'm trying to write userland driver for an input controller -
> > basically a macrokeyboard: some keys act like regular keys, and some
> > are not really described in the descriptor so it needs custom
> > parser. It has also extra commands to set/blink LEDs, etc.
> >
> > I'd need exclusive access to it. Mainly because some of the keys
> > emit normal looking presses and I would not like them to be fed
> > into the input system when my application is running. As side
> > effect I get also in dmesg errors like "input input16: event field
> > not found" due to this.
> >
> > Now this is of course doable with libusb, not using kernel hid
> > subsystem, and reimplementing the relevant hid bits (or using some
> > of the existing hid libraries doing this). But this sounds a bit
> > overkill and hidraw seems to be exactly for this kind of use case.
> >
> > The only problem is that I was not able to find a 'grab device'
> > type of functionality in hidraw. Basically equivalent of EVIOCGRAB
> > in input subsystem. Something that would make sure the reports come
> > only to hidraw device.
> >
> > Would it make sense to implement something like this for hidraw?
> 
> I am not a big fan of this idea. Simply because sensitive information
> like key press should not be handled in user space.
> Really, we already have keyboards macro support in the kernel (see
> drivers/hid/hid-roccat*) and I think you should consider doing your
> driver in the kernel.

I thought this was the exact idea of hidraw - to allow hardware access
without requiring kernel driver.

> > As an alternative I think we could have hid-rawonly driver, that
> > would by default bind to nothing. And when bound, would connect to
> > the hid device with HID_CONNECT_HIDRAW flag only. I could then in
> > userland rebind the device from hid-generic to hid-rawonly.
> 
> That could work (make a special driver and use HID_CONNECT_HIDRAW),
> but that's a terrible idea and will be refused I guess.
> Users expects their keyboard to be working everywhere, even at boot
> and in the console. By doing so, you will just break existing
> keyboards.

No. The whole point was to have driver that is not automatically
bound to anything. So we would not break anything existing. You'd get
that driver only by manual rebinding via sysfs.

> > Or finally, to implement a full kernel side driver it. But I'd
> > rather not go there. Especially since the device has multiple leds,
> > and the input system allows only limited leds. (The leds could be
> > exported as led devices, but then I'd need more userland logic to
> > figure out which led devices map to which input device.)
> 
> No, that's not true. If you have LEDs, then use the LED class and then
> user space deal with the LEDs. If the LEDs are not standard, then you
> will need userspace tools to access them so I don't think it is a
> problem. Standard LEDs will be handled properly through the input node
> (CAPS Lock, Ver Num, etc...).

There's individial LEDs per each key. Namely I'm looking at the devices
at: http://xkeys.com/XkeysKeyboards/index.php

The protocol they run is published at:
http://xkeys.com/PISupport/DeveloperHIDDataReports.php

And as mentioned - it'd be lot of work to combine which LED is for which
key.

> The good side of having your driver in the kernel is also less
> maintenance, and less pain for the users. Once it hits mainline, users
> will have a functional keyboard without having to rely on anything
> else. For you, if some interface change, you will have less head
> aches.
>
> If you *really* don't want to work in the kernel, you should simply
> ignore the generic keys in your driver and work only on the special
> keys macros that you want to support.

It's not possible. Few of the generic keys default to mouse buttons.
Those I'd like to ignore.

In fact, there's already some code out there that use hidraw and feed
the application from it. The code also opens the corresponding input
device with grab to make sure the events do not leak out to x11. So I'm
not the only one wanting to do this.

/Timo
