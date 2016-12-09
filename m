From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Fri, 9 Dec 2016 09:01:18 -0600
Message-ID: <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161201143434.GD1280@mail.corp.redhat.com> <20161201172448.GA46688@google.com>
 <20161205235908.rmiyd7io4kddple6@rob-hp-laptop> <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
 <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com> <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com> <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
 <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933534AbcLIPBn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 10:01:43 -0500
In-Reply-To: <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Fri, Dec 9, 2016 at 8:36 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Thu, 8 Dec 2016, Rob Herring wrote:
>
>> > And if tomorrow there is Elan device that is drop-in compatible (same
>> > connector, etc) with Wacom i2c-hid, will you ask for Elan-specific
>> > binding? Atmel? Weida? They all need to be powered up ultimately.
>>
>> Yes, I will.
>
> What advantage does that bring?
>
>> That in no way means the OS driver has to know about each and every one.
>> If they can all claim compatibility with Wacom (including power
>> control), then they can have a Wacom compatible string too. Or you can
>> just never tell me that there's a different manufacturer and I won't
>> care as long you don't need different control. But soon as a device
>> needs another power rail, GPIO or different timing, then you'd better
>> have a new compatible string.
>
> Again, I simply don't understand what advantage does the aproach you are
> trying to use bring.

This is simply how DT works. HID-over-I2C devices are no different
than any other I2C device or any other component. You are not special.

> HID over I2C is a generic protocol.

DT describes h/w, not protocols.

> Sure, we need to have quirks for
> device-specific bugs, and in such cases enumerate particular devices. But
> we don't need DT for that at all.

When it is related to powering on the device you may need to know the
specific device in DT. Compatibles are like VID/PID for devices, a
unique identifier for the specific device. Having that does not to
prevent generic/common drivers. The same rules apply. You wouldn't
want different devices having the same VID/PID (surely that has never
happened) or only change a VID/PID when you find a bug. The same rules
apply for compatible strings. You should be able to apply quirks
without changing/adding compatible strings (or more generally, without
changing the dtb). Just like you wouldn't change a VID/PID for a
device only when you find a bug, you can't add/change a DT compatible.

BTW, As you do have a VID/PID, you could define a compatible string
syntax using VID/PID like is done for PCI and USB.

Rob
