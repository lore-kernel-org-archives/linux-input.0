From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 3/4] ir-core: move decoding state to ir_raw_event_ctrl
Date: Mon, 7 Jun 2010 16:15:30 -0400
Message-ID: <20100607201530.GG16638@redhat.com>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
 <20100424211411.11570.2189.stgit@localhost.localdomain>
 <4BDF2B45.9060806@redhat.com>
 <20100607190003.GC19390@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100607190003.GC19390@hardeman.nu>
Sender: linux-media-owner@vger.kernel.org
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 07, 2010 at 09:00:03PM +0200, David H=E4rdeman wrote:
> On Mon, May 03, 2010 at 05:00:05PM -0300, Mauro Carvalho Chehab wrote=
:
> > David H=E4rdeman wrote:
> > > This patch moves the state from each raw decoder into the
> > > ir_raw_event_ctrl struct.
> > >=20
> > > This allows the removal of code like this:
> > >=20
> > >         spin_lock(&decoder_lock);
> > >         list_for_each_entry(data, &decoder_list, list) {
> > >                 if (data->ir_dev =3D=3D ir_dev)
> > >                         break;
> > >         }
> > >         spin_unlock(&decoder_lock);
> > >         return data;
> > >=20
> > > which is currently run for each decoder on each event in order
> > > to get the client-specific decoding state data.
> > >=20
> > > In addition, ir decoding modules and ir driver module load
> > > order is now independent. Centralizing the data also allows
> > > for a nice code reduction of about 30% per raw decoder as
> > > client lists and client registration callbacks are no longer
> > > necessary.
> >=20
> > The registration callbacks will likely still be needed by lirc,
> > as you need to create/delete lirc_dev interfaces, when the module
> > is registered, but I might be wrong. It would be interesting to
> > add lirc_dev first, in order to be sure about the better interfaces
> > for it.
>=20
> Or the lirc_dev patch can add whatever interfaces it needs. Anyway, t=
he=20
> current interfaces are not good enough since it'll break if lirc_dev =
is=20
> loaded after the hardware modules.

This is something I've been meaning to mention myself. On system boot, =
if
an mceusb device is connected, it pretty regularly only has the NEC
decoder available to use. I have to reload mceusb, or make sure ir-core=
 is
explicitly loaded, wait a bit, then load mceusb, if I want to have all =
of
the protocol handlers available -- which includes the needed-by-default
rc6 one. I've only briefly tinkered with trying to fix it, sounds like =
you
may already have fixage within this patchset.

=2E..
> In addition, random module load order is currently broken (try loadin=
g=20
> decoders first and hardware later and you'll see).  With this patch, =
it=20
> works again.

Want.

> Anyway, I'll post a new patch series this evening and then we can go=20
> back to our regular arguing :)

Hey, at least we're making progress too! :)

--=20
Jarod Wilson
jarod@redhat.com
