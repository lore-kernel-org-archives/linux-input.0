From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty-rXV5z7KbLFk@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification   implementation
Date: Sat, 6 Oct 2012 23:39:08 +0200
Message-ID: <914C6C58-5A3B-4F7D-94BE-EF6868ED5D9D@enac.fr>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com>  <20121006220421.47f5fd56@endymion.delvare>  <6F756B9E-DC87-4EF6-BB09-8A69A5F8C999@enac.fr>  <20121006231111.6350c014@endymion.delvare>  <alpine.LNX.2.00.1210062314110.27782@pobox.suse.cz> <alpine.LNX.2.00.1210062326150.27782@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1210062326150.27782-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "benjamin.tissoires" <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Fabien_Andr=E9?= <fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Le 6 oct. 2012 =E0 23:28, Jiri Kosina a =E9crit :

> On Sat, 6 Oct 2012, Jiri Kosina wrote:
>=20
>>> My vote is a clear 3. It took me a few years to kick all users (as
>>> opposed to implementers) of i2c from drivers/i2c and finding them a
>>> proper home, I'm not going to accept new intruders. Grouping driver=
s
>>> according to what they implement makes it a lot easier to share cod=
e
>>> and ideas between related drivers. If you want to convince yourself=
,
>>> just imagine the mess it would be if all drivers for PCI devices li=
ved
>>> under drivers/pci.
>>=20
>> This is more or less consistent with my original opinion when I was=20
>> refactoring the HID layer out of the individual drivers a few years =
ago.
>>=20
>> But Marcel objected that he wants to keep all the bluetooth-related=20
>> drivers under net/bluetooth, and I didn't really want to push hard a=
gainst=20
>> this, because I don't have really super-strong personal preference e=
ither=20
>> way.
>>=20
>> But we definitely can use this oportunity to bring this up for discu=
ssion=20
>> again.
>=20
> Basically, to me this all boils down to the question -- what is more=20
> important: low-level transport being used, or the general function of=
 the=20
> device?
>=20
> To me, it's the latter, and as such, everything would belong under=20
> drivers/hid.

Then shouldn't is be drivers/input, rather?

St.
