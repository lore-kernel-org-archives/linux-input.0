From: Joao Paulo Rechi Vita <jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Subject: Re: HID Output and Feature Reports
Date: Tue, 29 May 2012 19:14:47 -0300
Message-ID: <CAAngNMa1EZN-U5MZ6kwMJbUs0F2v-3A3UyaSz8+v1Uy6+BMLrg@mail.gmail.com>
References: <CAAngNMZDfgcaf+pO+Lx=c+BLYCXKWP5k4bUKhmTyiiheiUH+3A@mail.gmail.com>
	<CANq1E4RhVzukWTTQLykSa9aMCNuUkOk6BBKYu5jhOTHtDX8EqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANq1E4RhVzukWTTQLykSa9aMCNuUkOk6BBKYu5jhOTHtDX8EqQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Claudio Takahasi <claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org>, Andre Guedes <andre.guedes-430g2QfJUUCGglJvpFV4uA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello David,

On Sat, May 26, 2012 at 7:44 AM, David Herrmann
<dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> Hi Joao
>
> I CC'ed Jiri as he is the HID maintainer.
>
> On Fri, May 25, 2012 at 10:51 PM, Joao Paulo Rechi Vita
> <jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org> wrote:
>> Hello all,
>>
>> I'm working to support HID over GATT (HoG), which is HID over
>> Bluetooth Low Energy links, both on kernel and userspace. Traffic
>> coming from the remote peripheral through a L2CAP socket will be
>> handled in usespace, where the HID input reports are decapsulated fr=
om
>> GATT and injected back into the kernel through the new uHID module
>> written by David Herrmann. This module works similar to uinput, but
>> dealing with HID traffic.
>>
>> The input part is working without problems and now I looking how to
>> support Output and Feature reports. Doing some basic testing it seem=
s
>> we don't support Output reports very well. A basic use-case for that
>> is synchronizing keyboard leds (CAPS, NUM, etc) when there is more
>> than one keyboard connected, and I couldn't get this to work on my
>> tests. I didn't try to test feature reports since it's still not ver=
y
>> clear to me when they're used. The HID spec says that they exist for
>> setting values/controls on the peripheral that are not visible to th=
e
>> user, but I haven't discovered any real-world use case for them. Wha=
t
>> is the current state for these reports, do we support them somehow?
>
> I think my last revision of uhid added support for feature-reports.
> However, they are not used by the generic hid-input driver. If there
> is currently no specialized bluetooth-LE HID driver, you also do not
> need to worry about it.
>

Yes, I've seen the new event types for them, what I'm looking for is
how to trigger them.

> I think the new generic HID battery-detection code uses the
> feature-reports. However, its disabled by default if I remember
> correctly.
>

I will check this out, thanks for the hint.

> About output-reports: Do you correctly receive the UHID_OUTPUT_EV
> request in user-space? Do you send the packet to the device? How do
> you format it?
>

I was correctly receiving it with the previous version of your patch.
With this new version I still receive an event coming from the host,
but with ev.type value out of the enum range (different values like
this: 2062073856).

What is the difference between UHID_OUTPUT_EV and UHID_OUTPUT events?
Should both of them be written to the device?

>> Also, I've found usbhid-dump by Greg K-H, but it doesn't seem to dum=
p
>> data coming from the host to the device. Is this on the plans for th=
is
>> tool? I can try to send a patch for it, if someone can guide me on h=
ow
>> this whole output/feature reports thing should work.
>
> Regards
> David

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
