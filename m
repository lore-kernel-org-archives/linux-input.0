From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 2/4] ir-core: centralize sysfs raw decoder
 enabling/disabling
Date: Mon, 7 Jun 2010 20:48:36 +0200
Message-ID: <20100607184836.GB19390@hardeman.nu>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
 <20100424211406.11570.96241.stgit@localhost.localdomain>
 <4BDF28C0.4060102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BDF28C0.4060102@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, May 03, 2010 at 04:49:20PM -0300, Mauro Carvalho Chehab wrote:
> Hi David,

Hi, sorry for dropping off the radar...life has been hetic...daughter i=
n=20
hospital (she's fine now).

> David H=E4rdeman wrote:
> > With the current logic, each raw decoder needs to add a copy of the=
 exact
> > same sysfs code. This is both unnecessary and also means that (re)l=
oading
> > an IR driver after raw decoder modules have been loaded won't work =
as
> > expected.
> >=20
> > This patch moves that logic into ir-raw-event and adds a single sys=
fs
> > file per device.
> >=20
> > Reading that file returns something like:
> >=20
> > 	"rc5 [rc6] nec jvc [sony]"
> >=20
> > (with enabled protocols in [] brackets)
> >=20
> > Writing either "+protocol" or "-protocol" to that file will
> > enable or disable the according protocol decoder.
> >=20
> > An additional benefit is that the disabling of a decoder will be
> > remembered across module removal/insertion so a previously
> > disabled decoder won't suddenly be activated again. The default
> > setting is to enable all decoders.
> >=20
> > This is also necessary for the next patch which moves even more dec=
oder
> > state into the central raw decoding structs.
>=20
> I liked the idea of your redesign, but I didn't like the removal of
> a per-decoder sysfs entry. As already discussed, there are cases wher=
e
> we'll need a per-decoder sysfs entry (lirc_dev is probably one of tho=
se
> cases - also Jarod's imon driver is currently implementing a modprobe
> parameter that needs to be moved to the driver).

per-decoder or per-decoder-per-receiver sysfs entries? If you want the=20
latter, you'll need much more code than what is currently there to not=20
break random module load order (which doesn't work with the current=20
code).  Additionally, *if* imon and lirc_dev really need something like=
=20
that, those modules should carry the burden.
=20
> So, while we can implement some core support at the raw event core, w=
e should
> keep the decoder attributes internally inside the driver.

Why?

> So, each decoder
> may have his own code like:
>=20
> static struct attribute *decoder_attributes[] =3D {
>        &dev_attr_enabled.attr,
>        &dev_attr_bar1.attr,
>        &dev_attr_bar2.attr,
>        &dev_attr_bar3.attr,
>        NULL
> };
>=20
> static struct attribute_group decoder_attribute_group =3D {
>        .name   =3D "foo_decoder",
>        .attrs  =3D decoder_attributes,
> };
>=20
> As the attr_enabled is common to all, maybe we can have a default ena=
ble
> code at the .h or inside the core.

Smells like lots of duplicated code with no gain for the current set of=
=20
decoders.


--=20
David H=E4rdeman
