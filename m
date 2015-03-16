From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hidraw with exclusive access ?
Date: Mon, 16 Mar 2015 15:15:33 -0400
Message-ID: <CAN+gG=FXY9m8ygQ+e_JCt=7m3+mRHCYiDLmwggpHQbSDD6etvA@mail.gmail.com>
References: <20150313083758.076c8dfb@vostro>
	<CAN+gG=GdNpqDTazZD6_4r8AmWqbZg-_w8M2-6PDdvKjwdFfFWw@mail.gmail.com>
	<20150316203912.75b32686@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35474 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965533AbbCPTPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 15:15:34 -0400
Received: by qgez64 with SMTP id z64so49455750qge.2
        for <linux-input@vger.kernel.org>; Mon, 16 Mar 2015 12:15:33 -0700 (PDT)
In-Reply-To: <20150316203912.75b32686@vostro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo Teras <timo.teras@iki.fi>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 16, 2015 at 2:39 PM, Timo Teras <timo.teras@iki.fi> wrote:
> On Mon, 16 Mar 2015 11:29:10 -0400
> Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>
>> On Fri, Mar 13, 2015 at 2:37 AM, Timo Teras <timo.teras@iki.fi> wrote:
>> > Hi,
>> >
>> > I'm trying to write userland driver for an input controller -
>> > basically a macrokeyboard: some keys act like regular keys, and some
>> > are not really described in the descriptor so it needs custom
>> > parser. It has also extra commands to set/blink LEDs, etc.
>> >
>> > I'd need exclusive access to it. Mainly because some of the keys
>> > emit normal looking presses and I would not like them to be fed
>> > into the input system when my application is running. As side
>> > effect I get also in dmesg errors like "input input16: event field
>> > not found" due to this.
>> >
>> > Now this is of course doable with libusb, not using kernel hid
>> > subsystem, and reimplementing the relevant hid bits (or using some
>> > of the existing hid libraries doing this). But this sounds a bit
>> > overkill and hidraw seems to be exactly for this kind of use case.
>> >
>> > The only problem is that I was not able to find a 'grab device'
>> > type of functionality in hidraw. Basically equivalent of EVIOCGRAB
>> > in input subsystem. Something that would make sure the reports come
>> > only to hidraw device.
>> >
>> > Would it make sense to implement something like this for hidraw?
>>
>> I am not a big fan of this idea. Simply because sensitive information
>> like key press should not be handled in user space.
>> Really, we already have keyboards macro support in the kernel (see
>> drivers/hid/hid-roccat*) and I think you should consider doing your
>> driver in the kernel.
>
> I thought this was the exact idea of hidraw - to allow hardware access
> without requiring kernel driver.

Yes it is, but I did not understand which type of device you were
trying to fix. I thought you were dealing with regular keyboards with
some macro keys and with few LEDs. In that case, a user space driver
is not very welcomed IMO.
But the X-keys devices you are fixing are quite different. I don't
think anybody expects them to be able to type his password at prompt
with it, and the purpose is somewhat different from the regular
keyboards.

>
>> > As an alternative I think we could have hid-rawonly driver, that
>> > would by default bind to nothing. And when bound, would connect to
>> > the hid device with HID_CONNECT_HIDRAW flag only. I could then in
>> > userland rebind the device from hid-generic to hid-rawonly.
>>
>> That could work (make a special driver and use HID_CONNECT_HIDRAW),
>> but that's a terrible idea and will be refused I guess.
>> Users expects their keyboard to be working everywhere, even at boot
>> and in the console. By doing so, you will just break existing
>> keyboards.
>
> No. The whole point was to have driver that is not automatically
> bound to anything. So we would not break anything existing. You'd get
> that driver only by manual rebinding via sysfs.

Hmm, still not convinced by the manual re-binding through sysfs. If
the keyboard does not work directly with the generic hid protocol or
send garbage that users can not deal with, then why not simply bind it
to the hidraw driver only?

>
>> > Or finally, to implement a full kernel side driver it. But I'd
>> > rather not go there. Especially since the device has multiple leds,
>> > and the input system allows only limited leds. (The leds could be
>> > exported as led devices, but then I'd need more userland logic to
>> > figure out which led devices map to which input device.)
>>
>> No, that's not true. If you have LEDs, then use the LED class and then
>> user space deal with the LEDs. If the LEDs are not standard, then you
>> will need userspace tools to access them so I don't think it is a
>> problem. Standard LEDs will be handled properly through the input node
>> (CAPS Lock, Ver Num, etc...).
>
> There's individial LEDs per each key. Namely I'm looking at the devices
> at: http://xkeys.com/XkeysKeyboards/index.php
>
> The protocol they run is published at:
> http://xkeys.com/PISupport/DeveloperHIDDataReports.php
>
> And as mentioned - it'd be lot of work to combine which LED is for which
> key.

Then in that case, why not exporting your own sysfs interface to
illuminate the LEDs and set the macro?

We do that for the OLED of the wacom device, and that's fine (I guess).

>
>> The good side of having your driver in the kernel is also less
>> maintenance, and less pain for the users. Once it hits mainline, users
>> will have a functional keyboard without having to rely on anything
>> else. For you, if some interface change, you will have less head
>> aches.
>>
>> If you *really* don't want to work in the kernel, you should simply
>> ignore the generic keys in your driver and work only on the special
>> keys macros that you want to support.
>
> It's not possible. Few of the generic keys default to mouse buttons.
> Those I'd like to ignore.
>
> In fact, there's already some code out there that use hidraw and feed
> the application from it. The code also opens the corresponding input
> device with grab to make sure the events do not leak out to x11. So I'm
> not the only one wanting to do this.
>

So, IMO you can approach the problem through 2 ways:
- make a short out-of-the-tree driver for the X-keys that bind only to
hidraw, when you launch the user-space driver, unbind hid-generic and
bind the device to your small driver and then deal with the keyboard
in userspace.
- keep the kernel input node, reimplement the .raw_event() in the
kernel driver, and provide a control API through sysfs.

The second way allows you to have a UI/config tool which is not a
daemon and which just controls what the kernel does.

BTW, I guessed that the macros are not stored in the keyboard but
rather in your user-space program. If the macros are actually stored
and generated by the device itself, then I think fixing the kernel to
handle them would be a better path, and you need hidraw only to
configure the device.

Cheers,
Benjamin
