From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty-rXV5z7KbLFk@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification  implementation
Date: Sun, 7 Oct 2012 18:20:54 +0200
Message-ID: <91E2364F-9A56-4222-A876-BEC6D474EC75@enac.fr>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com>< 20121006220421.47f5fd56@endymion.delvare><6F756B9E-DC87-4EF6-BB09-8A69A5F8C 999@enac.fr><20121006231111.6350c014@endymion.delvare><alpine.LNX.2.00.1210 062314110.27782@pobox.suse.cz><alpine.LNX.2.00.1210062326150.27782@pobox.su se.cz><914C6C58-5A3B-4F7D-94BE-EF6868ED5D9D@enac.fr> <CAN+gG=FOnFDn4BdEQUt0dbQRj-6PrhRzSOqM620xSM3DeTXt_Q@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN+gG=FOnFDn4BdEQUt0dbQRj-6PrhRzSOqM620xSM3DeTXt_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Fabien_Andr=E9?= <fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Le 7 oct. 2012 =E0 18:07, Benjamin Tissoires a =E9crit :
>>>=20
>>> Basically, to me this all boils down to the question -- what is mor=
e
>>> important: low-level transport being used, or the general function =
of the
>>> device?
>>>=20
>>> To me, it's the latter, and as such, everything would belong under
>>> drivers/hid.
>>=20
>> Then shouldn't is be drivers/input, rather?
>=20
> Ouch, it will introduce more and more complexity.

Purely rhetorical question, I agree. But still.

>=20
> It seems that hid transport layers should go in drivers/hid.
> However, I don't like mixing the transport layer and the final
> drivers. Maybe this is the time to rework a little bit the tree.
> To minimize the moves, we could introduce:
> drivers/hid/busses/usb
> drivers/hid/busses/i2c
> drivers/hid/busses/bluetooth

What about creating drivers/hid/core and move all generic stuff there? =
That is:
drivers/hid/core
drivers/hid/usb
drivers/hid/i2c
drivers/hid/bluetooth

Cheers,

St.
