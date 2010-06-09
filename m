From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 3/4] ir-core: move decoding state to ir_raw_event_ctrl
Date: Wed, 9 Jun 2010 14:15:06 -0400
Message-ID: <20100609181506.GO16638@redhat.com>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
 <20100424211411.11570.2189.stgit@localhost.localdomain>
 <4BDF2B45.9060806@redhat.com>
 <20100607190003.GC19390@hardeman.nu>
 <20100607201530.GG16638@redhat.com>
 <20100608175017.GC5181@hardeman.nu>
 <AANLkTimuYkKzDPvtnrWKoT8sh1H9paPBQQNmYWOT7-R2@mail.gmail.com>
 <20100609132908.GM16638@redhat.com>
 <20100609175621.GA19620@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100609175621.GA19620@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 09, 2010 at 07:56:21PM +0200, David H=E4rdeman wrote:
> On Wed, Jun 09, 2010 at 09:29:08AM -0400, Jarod Wilson wrote:
> > On Tue, Jun 08, 2010 at 11:46:36PM -0400, Jarod Wilson wrote:
> > > On Tue, Jun 8, 2010 at 1:50 PM, David H=E4rdeman <david@hardeman.=
nu> wrote:
> > > > b) Mauro mentioned in <4BDF28C0.4060102@redhat.com> that:
> > > >
> > > > =A0 =A0 =A0 =A0I liked the idea of your redesign, but I didn't =
like the removal
> > > > =A0 =A0 =A0 =A0of a per-decoder sysfs entry. As already discuss=
ed, there are
> > > > =A0 =A0 =A0 =A0cases where we'll need a per-decoder sysfs entry=
 (lirc_dev is
> > > > =A0 =A0 =A0 =A0probably one of those cases - also Jarod's imon =
driver is
> > > > =A0 =A0 =A0 =A0currently implementing a modprobe parameter that=
 needs to be
> > > > =A0 =A0 =A0 =A0moved to the driver).
> > > >
> > > > =A0 could you please confirm if your lirc and/or imon drivers w=
ould be
> > > > =A0 negatively affected by the proposed patches?
> > >=20
> > > Will do so once I get them wedged in on top.
> >=20
> > Got it all merged and compiling, but not yet runtime tested. Compil=
ing
> > alone sheds some light on things though...
> >=20
> > So this definitely negatively impacts my ir-core-to-lirc_dev
> > (ir-lirc-codec.c) bridge driver, as it was doing the lirc_dev devic=
e
> > registration work in its register function. However, if (after your
> > patchset) we add a new pair of callbacks replacing raw_register and
> > raw_unregister, which are optional, that work could be done there i=
nstead,
> > so I don't think this is an insurmountable obstacle for the lirc bi=
ts.
>=20
> While I'm not sure exactly what callbacks you're suggesting,

Essentially:

=2Esetup_other_crap
=2Etear_down_other_crap

=2E..which in the ir-lirc-codec case, register ir-lirc-codec for a spec=
ific
hardware receiver as an lirc_dev client, and conversely, tear it down.

> it still=20
> sounds like the callbacks would have the exact same problems that the=
=20
> current code has (i.e. the decoder will be blissfully unaware of=20
> hardware which exists before the decoder is loaded). Right?

In my head, this was going to work out, but you're correct, I still hav=
e
the exact same problem -- its not in ir_raw_handler_list yet when
ir_raw_event_register runs, and thus the callback never fires, so lirc_=
dev
never actually gets wired up to ir-lirc-codec. It now knows about the l=
irc
decoder, but its completely useless. Narf.

> > As for the imon driver, the modprobe parameter in question (iirc) w=
as
> > already removed from the driver, as its functionality is replaced b=
y
> > implementing a change_protocol callback. However, there's a request=
 to
> > add it (or something like it) back to the driver to allow disabling=
 the
> > IR part altogether, and there are a few other modparams that might =
be
> > better suited as sysfs entries. However, its actually not relevant =
to the
> > case of registering raw protocol handlers, as the imon devices do t=
heir
> > decoding in hardware. I can see the possibility for protocol-specif=
ic
> > knobs in sysfs though. But I think the same optional callbacks I'd =
use to
> > keep the lirc bits working could also be used for this. Can't think=
 of a
> > good name for these yet, probably need more coffee first... ;)
>=20
> But those sysfs entries wouldn't be=20
> per-decoder-per-hardware-device....they'd just be=20
> per-hardware-device...right?

Most likely. But I think its possible someone would want to want to twe=
ak
some parameter that is both protocol and hardware device specific. Just
sheer speculation at the moment though, I don't have a concrete example=
=2E

--=20
Jarod Wilson
jarod@redhat.com
