From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: keyboard doesn't work with acpi on lenovo s10-3c
Date: Sun, 28 Nov 2010 01:02:41 -0800
Message-ID: <20101128090241.GG14499@core.coreip.homeip.net>
References: <AANLkTimZxNOuuK2+uEUF_RbHus1dgFRA6usMuYzrGjoD@mail.gmail.com>
 <20101128000648.GC29981@core.coreip.homeip.net>
 <AANLkTikagjOqgTSZjKPvgyR-73PJqgi2YiE5HmWKPP9+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikagjOqgTSZjKPvgyR-73PJqgi2YiE5HmWKPP9+@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Boris Savelev <boris.savelev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Nov 28, 2010 at 11:30:58AM +0300, Boris Savelev wrote:
> Thanks for reply Dmitry!
>=20
> 2010/11/28 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > Hi Boris,
> >
> > On Sat, Nov 27, 2010 at 08:28:51PM +0300, Boris Savelev wrote:
> >> Hello!
> >>
> >> When I run linux on my netbook lenovo s10-3c -- keyboard doesn't w=
ork!
> >> keyboard works perfectly in bios, in grub (or lilo), in windows, b=
ut
> >> not in linux.
> >> I try linux kernel 2.6.35, 2.6.36, 2.6.37-rc2 -- no way. keyboard =
doesn't work
> >> I upgrade BIOS up to 3CCN13WW. keyboard doesn't work
> >> All keys are disabled, numlock, capslock... It's seems like keyboa=
rd
> >> haven't power.
> >> with Google I find topic [1] where solution is add to kernel opts
> >> 'noapic acpi=3Doff' -- Viola! keyboard work. But battery state,
> >> powersaving, powerbutton and other usefull things doesn't work.
> >> So this is not a workaround...
> >
> > The keyboard seems to get detected but is silent afterwards... =A0D=
oes the
> > touchpad work by default?
>=20
> Touchpad always work.
>=20
> >
> > Could you try a few kernel options: acpi=3Dnoirq, pci=3Dnoacpi, i80=
42.reset
> > and i8042.nomux please?
>=20
> acpi=3Dnoirq -- kernel panic
> pci=3Dnoacpi -- kernel panic
> i8042.reset=3D1 -- kbd doesn't work
> i8042.nomux=3D1 -- kbd doesn't work
>=20
> combination of these options also doesn't help.
>=20
> Need screenshots of kernel panic?

Might be interesting but not much.

If you plug an external USB keyboard and do:

	echo -n "reconnect" > /sys/bus/serio/devices/serio0/drvctl

or

	echo -n "rescan" > /sys/bus/serio/devices/serio0/drvctl

after booting does it revive the keyboard? Also, what does
/proc/interrupts look like?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
