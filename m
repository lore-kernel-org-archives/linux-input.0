From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 3/4] ir-core: move decoding state to ir_raw_event_ctrl
Date: Tue, 8 Jun 2010 19:50:17 +0200
Message-ID: <20100608175017.GC5181@hardeman.nu>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
 <20100424211411.11570.2189.stgit@localhost.localdomain>
 <4BDF2B45.9060806@redhat.com>
 <20100607190003.GC19390@hardeman.nu>
 <20100607201530.GG16638@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:52837 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab0FHRuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jun 2010 13:50:22 -0400
Content-Disposition: inline
In-Reply-To: <20100607201530.GG16638@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-media@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jun 07, 2010 at 04:15:30PM -0400, Jarod Wilson wrote:
> On Mon, Jun 07, 2010 at 09:00:03PM +0200, David H=E4rdeman wrote:
> > On Mon, May 03, 2010 at 05:00:05PM -0300, Mauro Carvalho Chehab wro=
te:
> > > David H=E4rdeman wrote:
> > > > This patch moves the state from each raw decoder into the
> > > > ir_raw_event_ctrl struct.
> > > >=20
> > > > This allows the removal of code like this:
> > > >=20
> > > >         spin_lock(&decoder_lock);
> > > >         list_for_each_entry(data, &decoder_list, list) {
> > > >                 if (data->ir_dev =3D=3D ir_dev)
> > > >                         break;
> > > >         }
> > > >         spin_unlock(&decoder_lock);
> > > >         return data;
> > > >=20
> > > > which is currently run for each decoder on each event in order
> > > > to get the client-specific decoding state data.
> > > >=20
> > > > In addition, ir decoding modules and ir driver module load
> > > > order is now independent. Centralizing the data also allows
> > > > for a nice code reduction of about 30% per raw decoder as
> > > > client lists and client registration callbacks are no longer
> > > > necessary.
> > >=20
> > > The registration callbacks will likely still be needed by lirc,
> > > as you need to create/delete lirc_dev interfaces, when the module
> > > is registered, but I might be wrong. It would be interesting to
> > > add lirc_dev first, in order to be sure about the better interfac=
es
> > > for it.
> >=20
> > Or the lirc_dev patch can add whatever interfaces it needs. Anyway,=
 the=20
> > current interfaces are not good enough since it'll break if lirc_de=
v is=20
> > loaded after the hardware modules.
>=20
> This is something I've been meaning to mention myself. On system boot=
, if
> an mceusb device is connected, it pretty regularly only has the NEC
> decoder available to use. I have to reload mceusb, or make sure ir-co=
re is
> explicitly loaded, wait a bit, then load mceusb, if I want to have al=
l of
> the protocol handlers available -- which includes the needed-by-defau=
lt
> rc6 one. I've only briefly tinkered with trying to fix it, sounds lik=
e you
> may already have fixage within this patchset.

The problem is that without the patchset, each decoder is expected to=20
carry it's own list of datastructures for each hardware receiver. =20
Hardware receiver addition/removal is signalled through a callback to=20
the decoder, but the callback will (naturally) not be invoked if the=20
hardware driver is already loaded when the decoder is. So loading a=20
decoder "late" or reloading a decoder will mean that it doesn't know=20
about pre-existing hardware.

> > In addition, random module load order is currently broken (try load=
ing=20
> > decoders first and hardware later and you'll see).  With this patch=
, it=20
> > works again.
>=20
> Want.

Then please help me with two things:

a) Test the patches I just sent (especially 6/8 and 7/8, they should
   be independent from the rest)

b) Mauro mentioned in <4BDF28C0.4060102@redhat.com> that:

	I liked the idea of your redesign, but I didn't like the removal
	of a per-decoder sysfs entry. As already discussed, there are
	cases where we'll need a per-decoder sysfs entry (lirc_dev is
	probably one of those cases - also Jarod's imon driver is
	currently implementing a modprobe parameter that needs to be
	moved to the driver).

   could you please confirm if your lirc and/or imon drivers would be
   negatively affected by the proposed patches?


--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
