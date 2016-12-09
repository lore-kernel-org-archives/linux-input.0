From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Fri, 9 Dec 2016 08:16:57 -0800
Message-ID: <CAD=FV=V2w+anV6d5KzwfRaOYT322a8wjj0ULryEkCV=Ta2-_og@mail.gmail.com>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161201143434.GD1280@mail.corp.redhat.com> <20161201172448.GA46688@google.com>
 <20161205235908.rmiyd7io4kddple6@rob-hp-laptop> <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
 <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com> <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com> <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
 <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm> <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38792 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933399AbcLIQRA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 11:17:00 -0500
Received: by mail-wm0-f53.google.com with SMTP id f82so31670545wmf.1
        for <linux-input@vger.kernel.org>; Fri, 09 Dec 2016 08:16:59 -0800 (PST)
In-Reply-To: <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Brian Norris <briannorris@chromium.org>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hi,

On Fri, Dec 9, 2016 at 7:01 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 9, 2016 at 8:36 AM, Jiri Kosina <jikos@kernel.org> wrote:
>> On Thu, 8 Dec 2016, Rob Herring wrote:
>>
>>> > And if tomorrow there is Elan device that is drop-in compatible (same
>>> > connector, etc) with Wacom i2c-hid, will you ask for Elan-specific
>>> > binding? Atmel? Weida? They all need to be powered up ultimately.
>>>
>>> Yes, I will.
>>
>> What advantage does that bring?
>>
>>> That in no way means the OS driver has to know about each and every one.
>>> If they can all claim compatibility with Wacom (including power
>>> control), then they can have a Wacom compatible string too. Or you can
>>> just never tell me that there's a different manufacturer and I won't
>>> care as long you don't need different control. But soon as a device
>>> needs another power rail, GPIO or different timing, then you'd better
>>> have a new compatible string.
>>
>> Again, I simply don't understand what advantage does the aproach you are
>> trying to use bring.
>
> This is simply how DT works. HID-over-I2C devices are no different
> than any other I2C device or any other component. You are not special.

...but once you say that it's HID over I2C then it becomes probe-able,
right?  Said another way: we need to specify just enough to power the
device up properly and then we can ask it what kind of device it is
and then we can make quirk decisions based on that.

So specifying what kind of device it is in the device tree is somewhat
redundant and it also means that you make it needlessly difficult to
build a system with dual-sourced components.

One of the major points of probe-able connections is that you could
put anything you want there and the kernel _doesn't_ need to describe
it.  ...and the whole point of device tree (I thought) was to
specifically handle connections that _aren't_ probe-able.

For instance, if a board has a USB bus on it but you need to assert a
special reset or turn on a special regulator (besides vbus) before you
can probe the USB bus, you wouldn't think that the board should
specify exactly what device was stuffed in the connection, would you?


>> HID over I2C is a generic protocol.
>
> DT describes h/w, not protocols.

Isn't it a little of each, though?  When you say that there's a USB
port or an SDIO port or a serial port on the board, you're saying more
than just that there are 2, 4, or 8 wires coming out of the board.
You're saying that you're expecting to talk a certain protocol over
those wires.

-Doug
