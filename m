From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification implementation
Date: Sun, 7 Oct 2012 18:07:50 +0200
Message-ID: <CAN+gG=FOnFDn4BdEQUt0dbQRj-6PrhRzSOqM620xSM3DeTXt_Q@mail.gmail.com>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com>
	<20121006220421.47f5fd56@endymion.delvare>
	<6F756B9E-DC87-4EF6-BB09-8A69A5F8C999@enac.fr>
	<20121006231111.6350c014@endymion.delvare>
	<alpine.LNX.2.00.1210062314110.27782@pobox.suse.cz>
	<alpine.LNX.2.00.1210062326150.27782@pobox.suse.cz>
	<914C6C58-5A3B-4F7D-94BE-EF6868ED5D9D@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <914C6C58-5A3B-4F7D-94BE-EF6868ED5D9D-rXV5z7KbLFk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty-rXV5z7KbLFk@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Fabien_Andr=E9?= <fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?Big5?B?vEK5xcJA?= <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 6, 2012 at 11:39 PM, St=E9phane Chatty <chatty-rXV5z7KbLFk@public.gmane.org> wro=
te:
>
> Le 6 oct. 2012 =E0 23:28, Jiri Kosina a =E9crit :
>
>> On Sat, 6 Oct 2012, Jiri Kosina wrote:
>>
>>>> My vote is a clear 3. It took me a few years to kick all users (as
>>>> opposed to implementers) of i2c from drivers/i2c and finding them =
a
>>>> proper home, I'm not going to accept new intruders. Grouping drive=
rs
>>>> according to what they implement makes it a lot easier to share co=
de
>>>> and ideas between related drivers. If you want to convince yoursel=
f,
>>>> just imagine the mess it would be if all drivers for PCI devices l=
ived
>>>> under drivers/pci.
>>>
>>> This is more or less consistent with my original opinion when I was
>>> refactoring the HID layer out of the individual drivers a few years=
 ago.
>>>
>>> But Marcel objected that he wants to keep all the bluetooth-related
>>> drivers under net/bluetooth, and I didn't really want to push hard =
against
>>> this, because I don't have really super-strong personal preference =
either
>>> way.
>>>
>>> But we definitely can use this oportunity to bring this up for disc=
ussion
>>> again.
>>
>> Basically, to me this all boils down to the question -- what is more
>> important: low-level transport being used, or the general function o=
f the
>> device?
>>
>> To me, it's the latter, and as such, everything would belong under
>> drivers/hid.
>
> Then shouldn't is be drivers/input, rather?

Ouch, it will introduce more and more complexity.

It seems that hid transport layers should go in drivers/hid.
However, I don't like mixing the transport layer and the final
drivers. Maybe this is the time to rework a little bit the tree.
To minimize the moves, we could introduce:
drivers/hid/busses/usb
drivers/hid/busses/i2c
drivers/hid/busses/bluetooth

Cheers,
Benjamin

>
> St.
>
>
