From: Claudio Takahasi <claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
Date: Thu, 26 Apr 2012 14:22:09 -0300
Message-ID: <CAKT1EBesnson8JR+rTFtQyjATUj09QhR99Lg=ouN4aCeJJbviQ@mail.gmail.com>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
	<CAAngNMa0npQwBv+y_giRTOeLUMYiEnwWw4-cA+xMiRRsK732Mw@mail.gmail.com>
	<CAAngNMaOHRRfTy5yT9ys0Cv5yB5t-zEVxwcZWuK64BEA4oRy2g@mail.gmail.com>
	<alpine.LNX.2.00.1204031513070.9041@pobox.suse.cz>
	<CAAngNMYx4YcC8kEuZkEgojbFLf7BtchTCEDs927P+oqfr_oKnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAngNMYx4YcC8kEuZkEgojbFLf7BtchTCEDs927P+oqfr_oKnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Joao Paulo Rechi Vita <jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi David/Jiri,

On Wed, Apr 4, 2012 at 7:59 PM, Joao Paulo Rechi Vita
<jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org> wrote:
> On Tue, Apr 3, 2012 at 7:14 PM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
>> On Tue, 3 Apr 2012, Joao Paulo Rechi Vita wrote:
>>
>>> >> This is the second revision of the UHID driver. It basically all=
ows to register
>>> >> hid_ll_drivers in user-space. This is needed to implement Blueto=
oth HoG (HID
>>> >> over GATT) as discussed earlier.
>>> >>
>>> >
>>> > We have a first prototype implementation of the HoG plugin workin=
g
>>> > with the uhid driver \o/
>>> >
>>>
>>> I'm having problems with modifiers keys (they don't work). The USB-=
HID
>>> spec says that for each modifier key pressed a bit have to be set o=
n
>>> the modifiers byte (byte 2) of the report array. Dumping the data b=
oth
>>> on the HoG plugin on bluetoothd and through hidraw for the created =
HID
>>> device shows that these bits are being set correctly.
>>>
>>> Any idea of what could be wrong or additional checks that can be pe=
rformed?
>>
>> So hidraw shows the respective bits set properly, but they are not c=
oming
>> out of /dev/input/eventX, right?
>>
>
> Exactly.
>
>> How about /syse/kernel/debug/hid/<device>/events, does it show the e=
vents?
>>
>
> Thanks for the help, but it wasn't needed. The problem was actually o=
n
> the userspace HoG->HID parsing, we're adding an additional 0x00 byte
> to the beginning of the array. Now modifiers works!
>
> --
> Jo=C3=A3o Paulo Rechi Vita
> Openbossa Labs - INdT


The basic features are now working, we have tested HoG keyboard and
mouse. The major features missing related to HID are output/feature
reports, and suspend.

My HID knowledge is quite limited but it seems that output reports are
not working on uhid, at least I didn't see events from the host. Even
for USB keyboard it doesn't work, do you have any pointers?

BR,
Claudio
