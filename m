From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 3/4] ir-core: move decoding state to ir_raw_event_ctrl
Date: Wed, 9 Jun 2010 09:29:08 -0400
Message-ID: <20100609132908.GM16638@redhat.com>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
 <20100424211411.11570.2189.stgit@localhost.localdomain>
 <4BDF2B45.9060806@redhat.com>
 <20100607190003.GC19390@hardeman.nu>
 <20100607201530.GG16638@redhat.com>
 <20100608175017.GC5181@hardeman.nu>
 <AANLkTimuYkKzDPvtnrWKoT8sh1H9paPBQQNmYWOT7-R2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimuYkKzDPvtnrWKoT8sh1H9paPBQQNmYWOT7-R2@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 08, 2010 at 11:46:36PM -0400, Jarod Wilson wrote:
> On Tue, Jun 8, 2010 at 1:50 PM, David H=E4rdeman <david@hardeman.nu> =
wrote:
> > On Mon, Jun 07, 2010 at 04:15:30PM -0400, Jarod Wilson wrote:
> >> On Mon, Jun 07, 2010 at 09:00:03PM +0200, David H=E4rdeman wrote:
> >> > On Mon, May 03, 2010 at 05:00:05PM -0300, Mauro Carvalho Chehab =
wrote:
> >> > > David H=E4rdeman wrote:
> >> > > > This patch moves the state from each raw decoder into the
> >> > > > ir_raw_event_ctrl struct.
> >> > > >
> >> > > > This allows the removal of code like this:
> >> > > >
> >> > > > =A0 =A0 =A0 =A0 spin_lock(&decoder_lock);
> >> > > > =A0 =A0 =A0 =A0 list_for_each_entry(data, &decoder_list, lis=
t) {
> >> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->ir_dev =3D=3D ir_d=
ev)
> >> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> > > > =A0 =A0 =A0 =A0 }
> >> > > > =A0 =A0 =A0 =A0 spin_unlock(&decoder_lock);
> >> > > > =A0 =A0 =A0 =A0 return data;
> >> > > >
> >> > > > which is currently run for each decoder on each event in ord=
er
> >> > > > to get the client-specific decoding state data.
> >> > > >
> >> > > > In addition, ir decoding modules and ir driver module load
> >> > > > order is now independent. Centralizing the data also allows
> >> > > > for a nice code reduction of about 30% per raw decoder as
> >> > > > client lists and client registration callbacks are no longer
> >> > > > necessary.
> >> > >
> >> > > The registration callbacks will likely still be needed by lirc=
,
> >> > > as you need to create/delete lirc_dev interfaces, when the mod=
ule
> >> > > is registered, but I might be wrong. It would be interesting t=
o
> >> > > add lirc_dev first, in order to be sure about the better inter=
faces
> >> > > for it.
> >> >
> >> > Or the lirc_dev patch can add whatever interfaces it needs. Anyw=
ay, the
> >> > current interfaces are not good enough since it'll break if lirc=
_dev is
> >> > loaded after the hardware modules.
> >>
> >> This is something I've been meaning to mention myself. On system b=
oot, if
> >> an mceusb device is connected, it pretty regularly only has the NE=
C
> >> decoder available to use. I have to reload mceusb, or make sure ir=
-core is
> >> explicitly loaded, wait a bit, then load mceusb, if I want to have=
 all of
> >> the protocol handlers available -- which includes the needed-by-de=
fault
> >> rc6 one. I've only briefly tinkered with trying to fix it, sounds =
like you
> >> may already have fixage within this patchset.
> >
> > The problem is that without the patchset, each decoder is expected =
to
> > carry it's own list of datastructures for each hardware receiver.
> > Hardware receiver addition/removal is signalled through a callback =
to
> > the decoder, but the callback will (naturally) not be invoked if th=
e
> > hardware driver is already loaded when the decoder is. So loading a
> > decoder "late" or reloading a decoder will mean that it doesn't kno=
w
> > about pre-existing hardware.
> >
> >> > In addition, random module load order is currently broken (try l=
oading
> >> > decoders first and hardware later and you'll see). =A0With this =
patch, it
> >> > works again.
> >>
> >> Want.
> >
> > Then please help me with two things:
> >
> > a) Test the patches I just sent (especially 6/8 and 7/8, they shoul=
d
> > =A0 be independent from the rest)
>=20
> Working on merging them into a tree here locally. There's been a bit
> of churn, so the last few didn't apply cleanly, but I'm almost there.
>=20
> > b) Mauro mentioned in <4BDF28C0.4060102@redhat.com> that:
> >
> > =A0 =A0 =A0 =A0I liked the idea of your redesign, but I didn't like=
 the removal
> > =A0 =A0 =A0 =A0of a per-decoder sysfs entry. As already discussed, =
there are
> > =A0 =A0 =A0 =A0cases where we'll need a per-decoder sysfs entry (li=
rc_dev is
> > =A0 =A0 =A0 =A0probably one of those cases - also Jarod's imon driv=
er is
> > =A0 =A0 =A0 =A0currently implementing a modprobe parameter that nee=
ds to be
> > =A0 =A0 =A0 =A0moved to the driver).
> >
> > =A0 could you please confirm if your lirc and/or imon drivers would=
 be
> > =A0 negatively affected by the proposed patches?
>=20
> Will do so once I get them wedged in on top.

Got it all merged and compiling, but not yet runtime tested. Compiling
alone sheds some light on things though...

So this definitely negatively impacts my ir-core-to-lirc_dev
(ir-lirc-codec.c) bridge driver, as it was doing the lirc_dev device
registration work in its register function. However, if (after your
patchset) we add a new pair of callbacks replacing raw_register and
raw_unregister, which are optional, that work could be done there inste=
ad,
so I don't think this is an insurmountable obstacle for the lirc bits.

As for the imon driver, the modprobe parameter in question (iirc) was
already removed from the driver, as its functionality is replaced by
implementing a change_protocol callback. However, there's a request to
add it (or something like it) back to the driver to allow disabling the
IR part altogether, and there are a few other modparams that might be
better suited as sysfs entries. However, its actually not relevant to t=
he
case of registering raw protocol handlers, as the imon devices do their
decoding in hardware. I can see the possibility for protocol-specific
knobs in sysfs though. But I think the same optional callbacks I'd use =
to
keep the lirc bits working could also be used for this. Can't think of =
a
good name for these yet, probably need more coffee first... ;)

--=20
Jarod Wilson
jarod@redhat.com
