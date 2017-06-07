From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Improve generic name generation
Date: Wed, 7 Jun 2017 11:39:04 -0700
Message-ID: <CANRwn3StvJec0qx0=fgxdK0C-oc7E9OEjpsDNBU8bXGSHZQSjg@mail.gmail.com>
References: <20170517175208.14233-1-killertofu@gmail.com> <20170518072026.GB18288@mail.corp.redhat.com>
 <9eaeb638-c7a9-2288-0786-b4732f67d857@gmail.com> <20170519125616.GD1098@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34317 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdFGSjG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 14:39:06 -0400
Received: by mail-ua0-f170.google.com with SMTP id m31so9988710uam.1
        for <linux-input@vger.kernel.org>; Wed, 07 Jun 2017 11:39:05 -0700 (PDT)
In-Reply-To: <20170519125616.GD1098@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, May 19, 2017 at 5:56 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On May 18 2017 or thereabouts, Jason Gerecke wrote:
>> On 05/18/2017 12:20 AM, Benjamin Tissoires wrote:
>> > On May 17 2017 or thereabouts, Jason Gerecke wrote:
>> >> The 'wacom_update_name' function is responsible for producing names f=
or
>> >> the input device nodes based on the hardware device name. Commit f220=
9d4
>> >> added the ability to strip off prefixes like "Wacom Co.,Ltd." where t=
he
>> >> prefix was immediately (and redundantly) followed by "Wacom". The
>> >> 2nd-generation Intuos Pro 2 has such a prefix, but with a small error
>> >> (the period and comma are swapped) that prevents the existing code fr=
om
>> >> matching it. We're loath to extend the number of cases out endlessly =
and
>> >> so instead try to be smarter about name generation.
>> >>
>> >> We observe that the cause of the redundant prefixes is HID combining =
the
>> >> manufacturer and product strings of USB devices together. By using th=
e
>> >> original product name (with "Wacom" prefixed, if it does not already
>> >> exist in the string) we can bypass the gyrations to find and remove
>> >> redundant prefixes. Other devices either don't have a manufacturer st=
ring
>> >> that needs to be removed (Bluetooth, uhid) or should have their name
>> >> generated from scratch (I2C).
>> >>
>> >> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> >> ---
>> >
>> > Thanks Jason.
>> >
>> > I am not a big fan of the "real USB" check (I would believe enhancing
>> > struct hid_device would make something more generic), but it seems to =
be
>> > doing the job OK.
>> >
>> > Just giving out 2 ideas to achieve the same, so you could decide keepi=
ng
>> > this or not:
>> >
>> > - adding .product_name to struct hid_device directly
>> > - exporting usb_hid_driver in usbhid/usbhid.h and comparing hdev->ll_d=
river
>> >   with it (this can be achieved in an inlined function in usbhid.h).
>> >
>> > I would believe having the second option above would provide several
>> > benefits:
>> > - the wacom module will not have to check against all usb devices
>> > - other drivers would be able to quickly tell if they are using a low
>> >   level USB device, and not a uhid one. This way, we can remove some
>> >   errors when we emulate a HID device on a HID driver that expects USB
>> >   to be the actual transport layer
>> >
>> > Your function works too, but I would believe this will be faster and
>> > better (I also get the concern of having something self consistent for
>> > easier backporting).
>> >
>>
>> Ah, I think I misunderstood your earlier reply. I avoided a generic
>> approach since it seemed this naming issue was unique to the USB bus and
>> our driver. Backporting concerns also entered the picture, though we can
>> always conditionally compile this "real USB" function as fallback code
>> like we do in other cases where we have to work with older kernels.
>>
>> I would be tempted to take the second option as well (I was quite
>> disappointed when I realized such a check wasn't already possible), but
>> using definitions from usbhid.h or other non-system headers isn't ideal.
>> We'd have to require users to have a full source tree instead of just a
>> "kernel-devel" package in order to build an input-wacom backport (or
>> have the "real USB" function used even when compiled with upstream
>> kernels :().
>
> You can also define locally the function with this implementation if you
> do not want to change usbhid.h
>
>>
>> A modification of the second option that might be a bit better is to
>> have hid.h expose a function that does the comparison on behalf of the
>> caller. I presume that someone else could someday want to know if their
>> e.g. I2C device is really from uhid, so I'd probably also change the
>> logic to be "return hid->ll_driver =3D=3D uhid_hid_driver". That way we
>> don't have to export and compare against every transport driver...
>
> I'd rather ask: "are you of such type?" than "are you not on such
> type?".
>
> The problem with the negation is that as soon as you want to target only
> Bluetooth for instance, then you'll need to ask for "bluetooth and not
> uhid".
>
> OK, that is not clear. An other way of saying it is that you are
> interesting in casting a pointer into a pointer type from the low level
> transport driver. So if you are not absolutely sure about it, then you
> should not cast it.
>
>>
>> A different option I'd considered and am rather fond of would be to
>> define something like "HID_QUIRK_UHID" (or "HID_QUIRK_VIRTUAL"?) which
>> the uhid driver could set on devices that it creates. It'd be trivial to
>> implement and check and seems like it'd fit right in with the other
>> device quirks. Thoughts?
>
> I locally have a patch that achieves that by changing the hdev->type. But
> I am not so sure it is good because we would change HID_TYPE_OTHER,
> HID_TYPE_USBMOUSE, or HID_TYPE_USBNONE into HID_TYPE_UHID... Also I do
> not like much the fact that the transport layer has to change something
> in hdev if only one does such a change.
>
> So I would believe it's better to ask usbhid if it handles the device
> currently than asking uhid if it is not handling it.
>
> Cheers,
> Benjamin
>

Been busy with other tasks and finally getting back to this...

I hadn't considered using export/extern -- I suppose that does work. I
think exposing the `usb_hid_driver` structure (and friends) is a
little weird, but its ultimately Jiri's call. *nudges Jiri for
comment*

If I make a patch implementing this (with the check implemented in our
driver due to usbhid.h concerns), I'd also like to check if only the
bus-related hid_ll_driver structures should be exported, or if it
makes sense to also export more driver-specific ones (specifically
those within "hid-hyperv.c" and "hid-logitech-dj.c").

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
