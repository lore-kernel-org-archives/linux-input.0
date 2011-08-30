From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH trivial] input: apanel: remove a redundant MODULE_ALIAS
Date: Tue, 30 Aug 2011 19:14:26 +0200
Message-ID: <20110830171426.GA1732@debian.debian>
References: <1314653189-31020-1-git-send-email-j.neuschaefer@gmx.net>
 <201108291507.14497.dmitry.torokhov@gmail.com>
 <20110829161015.323c20a3@nehalam.ftrdhcpuser.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110829161015.323c20a3@nehalam.ftrdhcpuser.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 29, 2011 at 04:10:15PM -0700, Stephen Hemminger wrote:
> On Mon, 29 Aug 2011 15:07:14 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>=20
> > On Monday, August 29, 2011 02:26:29 PM Jonathan Neusch=C3=A4fer wro=
te:
> > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > ---
> > >  drivers/input/misc/apanel.c |    1 -
> > >  1 files changed, 0 insertions(+), 1 deletions(-)
> > >=20
> > > diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apa=
nel.c
> > > index a8d2b8d..1dd1bd3 100644
> > > --- a/drivers/input/misc/apanel.c
> > > +++ b/drivers/input/misc/apanel.c
> > > @@ -346,5 +346,4 @@ MODULE_DESCRIPTION(APANEL_NAME " driver");
> > >  MODULE_LICENSE("GPL");
> > >  MODULE_VERSION(APANEL_VERSION);
> > >=20
> > > -MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
> > >  MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
> >                                         ^
> >=20
> > Not necessarily redundant, if you notice the register is different.
> >=20
>=20
> At one point I found machines with both values, that is why there
> are two entries.

Okay, I didn't see the difference, sorry.
