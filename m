From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty-rXV5z7KbLFk@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification  implementation
Date: Sat, 6 Oct 2012 22:30:00 +0200
Message-ID: <6F756B9E-DC87-4EF6-BB09-8A69A5F8C999@enac.fr>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com> <20121006220421.47f5fd56@endymion.delvare>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121006220421.47f5fd56-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "benjamin.tissoires" <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, =?iso-8859-1?Q?Fabien_Andr=E9?= <fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Jean

(I cc Marcel Holtmann because BT is involved too)

Le 6 oct. 2012 =E0 22:04, Jean Delvare a =E9crit :

> Hi Benjamin,
>=20
> On Fri, 14 Sep 2012 15:41:43 +0200, benjamin.tissoires wrote:
>> From: Benjamin Tissoires <benjamin.tissoires-rXV5z7KbLFk@public.gmane.org>
>>=20
>> Microsoft published the protocol specification of HID over i2c:
>> http://msdn.microsoft.com/en-us/library/windows/hardware/hh852380.as=
px
>>=20
>> This patch introduces an implementation of this protocol.
>>=20
>> This implementation does not includes the ACPI part of the specifica=
tion.
>> This will come when ACPI 5.0 devices will be available.
>>=20
>> Once the ACPI part will be done, OEM will not have to declare HID ov=
er I2C
>> devices in their platform specific driver.
>>=20
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-rXV5z7KbLFk@public.gmane.org>
>> ---
>>=20
>> Hi,
>>=20
>> this is finally my first implementation of HID over I2C.
>>=20
>> This has been tested on an Elan Microelectronics HID over I2C device=
, with
>> a Samsung Exynos 4412 board.
>>=20
>> Any comments are welcome.
>>=20
>> Cheers,
>> Benjamin
>>=20
>> drivers/i2c/Kconfig         |    8 +
>> drivers/i2c/Makefile        |    1 +
>> drivers/i2c/i2c-hid.c       | 1027 +++++++++++++++++++++++++++++++++=
++++++++++
>> include/linux/i2c/i2c-hid.h |   35 ++
>> 4 files changed, 1071 insertions(+)
>> create mode 100644 drivers/i2c/i2c-hid.c
>> create mode 100644 include/linux/i2c/i2c-hid.h
>=20
> Looks like the wrong place for this driver. HID-over-USB support live=
s
> under drivers/hid, so your driver should go there as well. Not only
> this will be more consistent, but it also makes more sense: your driv=
er
> is a user, not an implementer, of the I2C layer, so it doesn't belong
> to drivers/i2c.

This is a question I asked a few months back, but apparently not all po=
ints of views had been expressed at the time. Currently, HID-over-USB l=
ives in drivers/hid, but HID-over-BT lives in drivers/bluetooth. When I=
 asked, Jiri explained that he maintained HID-over-USB and Marcel maint=
ained HID-over-BT, which explained the choices made. Let's try to summa=
rize what we know now:

The question is what drives the choice of where to put HID-over-XXX, am=
ong the following
 1- who the maintainer is. Here, Benjamin will probably maintain this s=
o it does not help.
 2- dependencies. HID-over-XXX depends on HID as much as it depends on =
XXX, so it does not help.
 3- data flow. Indeed, HID is a client of HID-over-XXX which is a clien=
t of XXX. Are there other parts of the kernel where this drives the cho=
ice of where YYY-over-XXX lives?

Jiri, Marcel, Greg, others, any opinions?

>=20
> Also, you need to sort out dependencies. Your causes a link failure h=
ere:
>=20
> ERROR: "hiddev_report_event" [drivers/i2c/i2c-hid.ko] undefined!
> ERROR: "hiddev_disconnect" [drivers/i2c/i2c-hid.ko] undefined!
> ERROR: "hiddev_connect" [drivers/i2c/i2c-hid.ko] undefined!
> ERROR: "hid_pidff_init" [drivers/i2c/i2c-hid.ko] undefined!
> make[1]: *** [__modpost] Erreur 1
> make: *** [modules] Erreur 2
>=20
> This is because these functions aren't exported and I tried to build
> i2c-hid as a module.BTW I see that these functions are part of the
> usbhid driver, which looks seriously wrong. If these functions are
> transport layer-independent, they should be moved to the hid-code or
> some sub-module. One should be able to enable HID-over-I2C without
> HID-over-USB.
>=20
> --=20
> Jean Delvare

Cheers,

St.

PS: Benjamin is leaving ENAC. He'll probably keep maintaining HID-over-=
I2C, and we'll probably share the maintenance of hid-multitouch as well=
 as other input-related projects we have not published yet.
