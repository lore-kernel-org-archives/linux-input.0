From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 2/4] ir-core: centralize sysfs raw decoder enabling/disabling
Date: Mon, 03 May 2010 16:49:20 -0300
Message-ID: <4BDF28C0.4060102@redhat.com>
References: <20100424210843.11570.82007.stgit@localhost.localdomain> <20100424211406.11570.96241.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42389 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286Ab0ECTt3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 May 2010 15:49:29 -0400
In-Reply-To: <20100424211406.11570.96241.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgSMOkcmRlbWFu?= <david@hardeman.nu>
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org

Hi David,

David H=C3=A4rdeman wrote:
> With the current logic, each raw decoder needs to add a copy of the e=
xact
> same sysfs code. This is both unnecessary and also means that (re)loa=
ding
> an IR driver after raw decoder modules have been loaded won't work as
> expected.
>=20
> This patch moves that logic into ir-raw-event and adds a single sysfs
> file per device.
>=20
> Reading that file returns something like:
>=20
> 	"rc5 [rc6] nec jvc [sony]"
>=20
> (with enabled protocols in [] brackets)
>=20
> Writing either "+protocol" or "-protocol" to that file will
> enable or disable the according protocol decoder.
>=20
> An additional benefit is that the disabling of a decoder will be
> remembered across module removal/insertion so a previously
> disabled decoder won't suddenly be activated again. The default
> setting is to enable all decoders.
>=20
> This is also necessary for the next patch which moves even more decod=
er
> state into the central raw decoding structs.

I liked the idea of your redesign, but I didn't like the removal of
a per-decoder sysfs entry. As already discussed, there are cases where
we'll need a per-decoder sysfs entry (lirc_dev is probably one of those
cases - also Jarod's imon driver is currently implementing a modprobe
parameter that needs to be moved to the driver).

So, while we can implement some core support at the raw event core, we =
should
keep the decoder attributes internally inside the driver. So, each deco=
der
may have his own code like:

static struct attribute *decoder_attributes[] =3D {
       &dev_attr_enabled.attr,
       &dev_attr_bar1.attr,
       &dev_attr_bar2.attr,
       &dev_attr_bar3.attr,
       NULL
};

static struct attribute_group decoder_attribute_group =3D {
       .name   =3D "foo_decoder",
       .attrs  =3D decoder_attributes,
};

As the attr_enabled is common to all, maybe we can have a default enabl=
e
code at the .h or inside the core.
=20
Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
