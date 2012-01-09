From: joeyli <jlee@suse.com>
Subject: Re: Handling special keys in platform drivers
Date: Mon, 09 Jan 2012 15:09:15 +0800
Message-ID: <1326092955.24116.131.camel@linux-s257.site>
References: <CAHR064jAJkQCd_Tsrx7NHe_RbaBbNcX4sMwy=zkZCZNUNo=fAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHR064jAJkQCd_Tsrx7NHe_RbaBbNcX4sMwy=zkZCZNUNo=fAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, linux-input@vger.kernel.org, GLin@suse.com
List-Id: linux-input@vger.kernel.org

Hi Corentin,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2012-01-09 =E6=96=BC 07:24 +0100=EF=BC=8CCo=
rentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi,
>=20
> Some of the platform drivers in platform/x86/ (and probably other) ar=
e
> relaying keys to userspace and are also controlling the device
> associated to these key. A simple example is screen brightness,
> keyboard backlight or rfkill.
>=20
> In this case the driver send a key to userspace, userspace has to
> handle this key and control the right device.
>=20
> Most of the time, this job is done by:
> - ACPI scripts (legacy)
> - DE (gnome-power-manager, kde's solid)
>=20
> The real problem is that for keyboard backlight to work, it needs DE
> cooperation, and only gnome as implemented that right now, and other
> (except KDE) will probably neither have the resources to handle all
> the possible keys correctly. And of course, who should handle the key=
s
> when there is no DE running at all ?
>=20
> So I was wondering if we could introduce an "auto" mode for this
> drivers. For example, with this mode enabled, asus-wmi would filter
> the keys and control keyboard backlight directly (and rfkill/screen
> brightness ?).
>=20
> What do you think about it ?
>=20
> Thanks,
>=20

=46or backlight,=20
I think control backlight in platform driver is generally no problem,
but need careful don't keep/change brightness level if BIOS also keep a
variable reflect to brightness level.

Another question is when the "auto" mode disable? Does it possible
disable it from user space?
Currently, like rfkill-input can disabled by ioctl from user space, e.g=
=2E
urfkill daemon will disable rfkill-input by ioctl when it launched.


=46or rfkill,
I am not prefer allow platform driver direct control rfkill.

that might more complex because already have the follow components
involve to it when function key pressed:
	BIOS/EC (ODM backup behavior)
	rfkill-input
	wireless/bluetooth drivers
	user space daemon/applications (e.g. NetworkManager, urfkill...)

Then, will platform driver also involve to rfkill control?

We already have rfkill-input in kernel to control rfkill state, if need
more flexible policy control on rfkill key, put policy logic in user
space will be better.
e.g. User can setup rfkill policy by account.


Thanks a lot!
Joey Lee
