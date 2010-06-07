From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 3/4] ir-core: move decoding state to ir_raw_event_ctrl
Date: Mon, 7 Jun 2010 21:00:03 +0200
Message-ID: <20100607190003.GC19390@hardeman.nu>
References: <20100424210843.11570.82007.stgit@localhost.localdomain>
 <20100424211411.11570.2189.stgit@localhost.localdomain>
 <4BDF2B45.9060806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BDF2B45.9060806@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, May 03, 2010 at 05:00:05PM -0300, Mauro Carvalho Chehab wrote:
> David H=E4rdeman wrote:
> > This patch moves the state from each raw decoder into the
> > ir_raw_event_ctrl struct.
> >=20
> > This allows the removal of code like this:
> >=20
> >         spin_lock(&decoder_lock);
> >         list_for_each_entry(data, &decoder_list, list) {
> >                 if (data->ir_dev =3D=3D ir_dev)
> >                         break;
> >         }
> >         spin_unlock(&decoder_lock);
> >         return data;
> >=20
> > which is currently run for each decoder on each event in order
> > to get the client-specific decoding state data.
> >=20
> > In addition, ir decoding modules and ir driver module load
> > order is now independent. Centralizing the data also allows
> > for a nice code reduction of about 30% per raw decoder as
> > client lists and client registration callbacks are no longer
> > necessary.
>=20
> The registration callbacks will likely still be needed by lirc,
> as you need to create/delete lirc_dev interfaces, when the module
> is registered, but I might be wrong. It would be interesting to
> add lirc_dev first, in order to be sure about the better interfaces
> for it.

Or the lirc_dev patch can add whatever interfaces it needs. Anyway, the=
=20
current interfaces are not good enough since it'll break if lirc_dev is=
=20
loaded after the hardware modules.

> Also, from one side, you reduced the code size, but, on the other han=
d,
> you've increased the memory usage, as now the protocol data will be
> stored even for protocols that weren't compiled/loaded.=20

In <4BBF3309.6020909@infradead.org>, Mauro Carvalho Chehab wrote:
>> Andy Walls wrote:
>>> Encoding pulse vs space with a negative sign, even if now hidden=20
>>> with macros, is still just using a sign instead of a boolean. =20
>>> Memory in modern computers (and now microcontrollers) is cheap and=20
>>> only getting cheaper.  Don't give up readability, flexibility, or=20
>>> mainatainability, for the sake of saving memory.
>
> That was my point since the beginning: the amount of saved memory=20
> doesn't justify the lack of readability.

Are you worried about memory usage now?

> Probably, the code size savings are big enough to justify the runtime=
=20
> memory footprint, at least with the current decoders. Not sure how bi=
g=20
> this will become when we add lirc_dev and other decoders that might b=
e=20
> missing.

Right now, the "reasonable default" is a user machine with one hardware=
=20
decoder and with all of the rc-core decoders loaded (cause that's how=20
his/her distro will set it up).  For that machine, the patch will save =
a=20
lot of memory, not waste it (~380 lines less code...I'll assure you it'=
s=20
a net gain).

In addition, random module load order is currently broken (try loading=20
decoders first and hardware later and you'll see).  With this patch, it=
=20
works again.

Anyway, I'll post a new patch series this evening and then we can go=20
back to our regular arguing :)

--=20
David H=E4rdeman
