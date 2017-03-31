From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: ABS_MT_MAJOR clarification needed
Date: Fri, 31 Mar 2017 14:40:25 -0700
Message-ID: <c843df76-b84c-525b-4aeb-25a3aad6afb5@synaptics.com>
References: <20170331004849.GA18897@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:18545 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdCaVk0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 17:40:26 -0400
In-Reply-To: <20170331004849.GA18897@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, Henrik Rydberg <rydberg@euromail.se>, HungNien Chen <hn.chen@weidahitech.com>, Jonathan Clarke <jonathan.a.clarke@gmail.com>
Cc: linux-input@vger.kernel.org

On 03/30/2017 05:48 PM, Peter Hutterer wrote:
> Hi guys,
>
> I finally started implementing code for ABS_MT_TOUCH_MAJOR to try to work
> with better touch shapes (in libinput). The result is... discouraging.
> libinput use physical dimensions everywhere possible, e.g. touchpad software
> features are X mm large, etc. but for ABS_MT_TOUCH_MAJOR it's almost
> impossible (ABS_MT_TOUCH_MINOR has the same issues, but is omitted for
> brevity).
>
> ABS_MT_MAJOR is documented as, paraphrased, the longer axis of the ellipsis,
> in applicable surface units at the current rotation. So at a rotation of 0
> (== vertical), ABS_MT_MAJOR corresponds to y units. This is... suboptimal,
> to get to the physical lengths we have to do sin/cos on every event. That
> gets more entertaining on devices with uneven x/y resolutions. AFAICT no
> driver sets a specific resolution for major.
>
> What we have in the kernel is a mix of touch_major min-max ranges
> (largely independent of the x/y axes) with some orientation value that may
> or may not help.
>
> bcm5974 driver:
>    ABS_MT_TOUCH_MAJOR max is hardcoded as 2048, the actual value is sent is
>    double whatever the hardware gives us. There is no resolution for x/y but
>    libinput has a hwdb entry for those touchpads to get at the physical
>    dimensions. Without that, conversion would be impossible.
>
>    Either way, I wonder what data the device provides and whether sin/cos
>    gets us to the real values, esp. as this device has uneven x/y
>    resolutions.
>
>    Orientation is -16384..16384, forwarded as-is from the hardware but with a
>    large fuzz of ~3200.
>
> magic trackpad:
>    driver just sends four times whatever the hardware gives us.
>    ABS_MT_TOUCH_MAJOR max is hardcoded to 1020 but we have x/y resolution
>    (hardcoded in the driver). Doing the conversion means the largest
>    detectable touch is 22mm.  But the values are generally below what is
>    actually in contact [1].
>   
>    Orientation is hardcoded to -31..32, forwarded as is, seems to be largely
>    accurate.
>
> hid-mt:
>    maps HID_DG_WIDTH to ABS_MT_TOUCH_MAJOR. The x/y resolution is set
>    depending on whether the HID field has the unit attribute set.
>
>    The HID spec for HID_DG_WIDTH says "Unit are assumed to match x's units",
>    but hid-mt takes whatever the larger axis is as major. So alternatively it
>    may send width as major, or height. At least orientation is only 0 or 1,
>    so this could be reversed in userspace. That matches the kernel
>    documentation:
>       ABS_MT_TOUCH_MAJOR := max(X, Y)
>       ABS_MT_TOUCH_MINOR := min(X, Y)
>       ABS_MT_ORIENTATION := bool(X > Y)
>
>    This cannot reliably work for uneven x/y resolutions though because the
>    max() takes device units.
>
> wacom:
>    ABS_MT_TOUCH_MAJOR max matches x max, otherwise see hid-mt logic
>
> hid-ntrig:
>    looks like the same as wacom
>
> rmi4:
>    ABS_MT_TOUCH_MAJOR max is hardcoded to 0xf. x/y has resolution of 12 or 20
>    in the devices I've seen so far. orientation is only 0 or 1, uses same
>    logic as hid-mt. Orientation is 0/1.
>
>    Based on a recording in [2], the highest value is 25, but firmware palm
>    detection kicks in at 13 already. Even at the lower resolution of 12,
>    the touch major max value of 25 would be a 2mm touch. That's a very small
>    palm.

I updated the bug [2] with additional detail. But, my understanding is 
that the values we report via ABS_MT_TOUCH_MAJOR / MINOR do not 
correspond with the physical dimensions of the device. Instead they are 
relative values which attempt to convey the width of the contact. These 
values are reported by the firmware as W/X and W/Y. We report the larger 
value as ABS_MT_TOUCH_MAJOR and the smaller as MINOR.

Andrew

> cyapa:
>    ABS_MT_TOUCH_MAJOR max is hardcoded to 255, orientation is -127..127, data
>    is forwarded as-is from the hardware. The max is 255 because it only gets
>    one byte in the protocol.
>
>    I don't have a device to read the x/y ranges, so I can't verify
>    what a 255 would correspond to. The ones I've seen are 1280x960 with
>    uneven x/y resolutions, so 255 would correspond to ca 1/4 of the touchpad.
>    That seems sensible.
>
> elantech:
>    ABS_MT_TOUCH_MAJOR max is set up as 15 ("finger width") times something
>    called max_width. In one recording I have it ends up at 2445 (x/y max
>    are 3260/2282 [3]) but it may swap x and y during initialization already,
>    so we have nothing to go on. It doesn't report orientation and
>    reports major as max of (x, y), so we can't guess how to get back to
>    physical coordinates.
>
> atmel:
>    missing ABS_MT_TOUCH_MAJOR, forwards the 'area' as major (that's
>    protocol-correct). ABS_MT_TOUCH_MAJOR max is 0xff, but x/y have a
>    resolution of 20. So that would leave us with a maximum touch size of ~12
>    mm. That doesn't seem correct either.
>
> There are a few other drivers I didn't check but it comes down to: for the
> purpose of actually determining touch size, ABS_MT_TOUCH_MAJOR is largely
> useless. I'll need per-device flags and hwdb entries to make this even
> remotely useful and even then I'll have to rely on specific driver
> behaviour. So the question is, is there anything we can do about this?
>
> Cheers,
>     Peter
>
> [1] ok, I don't have a 'normalized' finger but guesstimating the contact
> surface and comparing the data - the major is smaller by a few mm than the
> physical contact.
> [2] https://bugs.freedesktop.org/show_bug.cgi?id=100243, the highest
> [3] https://github.com/whot/evemu-devices/blob/master/touchpads/ETPS2%20Elantech%20Touchpad.Samsung-700Z3A.events
>

