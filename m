From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Handling special keys in platform drivers
Date: Mon, 9 Jan 2012 08:34:26 +0100
Message-ID: <CAHR064juCt90x_4bqSE2FqRxO+4759Sh4_L54eKopP_UJpap9Q@mail.gmail.com>
References: <CAHR064jAJkQCd_Tsrx7NHe_RbaBbNcX4sMwy=zkZCZNUNo=fAw@mail.gmail.com>
	<1326092955.24116.131.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1326092955.24116.131.camel@linux-s257.site>
Sender: platform-driver-x86-owner@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, linux-input@vger.kernel.org, GLin@suse.com
List-Id: linux-input@vger.kernel.org

On Mon, Jan 9, 2012 at 8:09 AM, joeyli <jlee@suse.com> wrote:
> Hi Corentin,
>
> =E6=96=BC =E4=B8=80=EF=BC=8C2012-01-09 =E6=96=BC 07:24 +0100=EF=BC=8C=
Corentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
>> Hi,
>>
>> Some of the platform drivers in platform/x86/ (and probably other) a=
re
>> relaying keys to userspace and are also controlling the device
>> associated to these key. A simple example is screen brightness,
>> keyboard backlight or rfkill.
>>
>> In this case the driver send a key to userspace, userspace has to
>> handle this key and control the right device.
>>
>> Most of the time, this job is done by:
>> - ACPI scripts (legacy)
>> - DE (gnome-power-manager, kde's solid)
>>
>> The real problem is that for keyboard backlight to work, it needs DE
>> cooperation, and only gnome as implemented that right now, and other
>> (except KDE) will probably neither have the resources to handle all
>> the possible keys correctly. And of course, who should handle the ke=
ys
>> when there is no DE running at all ?
>>
>> So I was wondering if we could introduce an "auto" mode for this
>> drivers. For example, with this mode enabled, asus-wmi would filter
>> the keys and control keyboard backlight directly (and rfkill/screen
>> brightness ?).
>>
>> What do you think about it ?
>>
>> Thanks,
>>
>
> For backlight,
> I think control backlight in platform driver is generally no problem,
> but need careful don't keep/change brightness level if BIOS also keep=
 a
> variable reflect to brightness level.

Hum, for screen brightness, try to start without any desktop
environment on a laptop where the keys don't control the BIOS and only
send input events, and you won't be able to change the screen
brightness.

This is actually worse for keyboard backlight since only gnome support =
it.

> Another question is when the "auto" mode disable? Does it possible
> disable it from user space?

Probably only a module parameter. And disabled by default.

> Currently, like rfkill-input can disabled by ioctl from user space, e=
=2Eg.
> urfkill daemon will disable rfkill-input by ioctl when it launched.
>
>
> For rfkill,
> I am not prefer allow platform driver direct control rfkill.

Yeah rfkill was just an example, of such interaction, but your right
rfkill support is currently pretty good.

> that might more complex because already have the follow components
> involve to it when function key pressed:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0BIOS/EC (ODM backup behavior)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rfkill-input
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wireless/bluetooth drivers
> =C2=A0 =C2=A0 =C2=A0 =C2=A0user space daemon/applications (e.g. Netwo=
rkManager, urfkill...)
>
> Then, will platform driver also involve to rfkill control?
>
> We already have rfkill-input in kernel to control rfkill state, if ne=
ed
> more flexible policy control on rfkill key, put policy logic in user
> space will be better.
> e.g. User can setup rfkill policy by account.



--=20
Corentin Chary
http://xf.iksaif.net
