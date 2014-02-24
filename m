From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/4] Add ff-memless-next and make hid-lg4ff use it
Date: Mon, 24 Feb 2014 13:48:18 -0800
Message-ID: <20140224214818.GA4156@core.coreip.homeip.net>
References: <1516865.M993BQAYe4@geidi-prime>
 <530A931B.3020606@iki.fi>
 <14991521.KzMVP7XS2h@geidi-prime>
 <CADbOyBQ0U_TiovwMJJO1zQpr5PcwmB1O155P4nC6CmwhZjA=UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADbOyBQ0U_TiovwMJJO1zQpr5PcwmB1O155P4nC6CmwhZjA=UQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, Michal =?iso-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 24, 2014 at 10:17:25PM +0100, Elias Vanderstuyft wrote:
> On Mon, Feb 24, 2014 at 1:58 AM, Michal Mal=FD <madcatxster@prifuk.cz=
> wrote:
> > On Monday 24 of February 2014 02:32:27 Anssi Hannula wrote:
> >>
> >> I think we should extend the current ff-memless instead of duplica=
ting
> >> its functionality (even on a "for now" basis).
> >>
> >> Having looked at ff-memless-next briefly, it seems very similar to
> >> ff-memless on its basic working principle, and therefore I don't r=
eally
> >> see why extending ff-memless would be too cumbersome. Unless I'm m=
issing
> >> something - in that case, feel free to point it out to me :)
> >
> > Deciding whether to patch ff-memless or write a new driver from scr=
atch was a
> > perfect example of being caught between the rock and a hard place. =
I am not
> > particularly fond of the fact that we would have two modules doing =
pretty much
> > the same thing. My reasons for writing a separate module were:
> > - Periodic effects. ff-memless doesn't do "real" periodic effects, =
it simply
> > emulates them through rumble effect. Devices without rumble effect =
support
> > require emulation through constant force effect. Just this was not =
something
> > one could write in one afternoon:)
> > - Conditional effects. These effects cannot be by nature combined i=
nto one
> > overall force (at least not easily) so they have to be handled one =
by one -
> > this is a concept ff-memless does not seem to consider. FFB devices=
 have
> > limits as to how many conditional (referred to as "uncombinable" in=
 MLNX)
> > effects can be active simultaneously, etc.
> > All in all it seemed less error prone to write a new driver based o=
n the ff-
> > memless logic, test and deploy it on devices I have access to and o=
nce we are
> > sure there are no nasty regressions port the rest of the drivers to=
 the new
> > API. Given the scope of the changes I am afraid that a "patch" to f=
f-memless
> > would be pretty close to a rewrite anyway.
>=20
> And add the fact that we already heavily tested the ff-memless-next d=
river.
> Unless you do a diff between the original ff-memless.c and the curren=
t
> ff-memless-next.c (which will result in a rather unintuitive patch),
> it would be a huge waste of time to retest the modified (when doing
> efforts to create an intuitive patch) ff-memless-next.c, considered m=
y
> total time spend on testing (and not to speak of the time that Michal
> spent to fix the corresponding bugs.)
> I know that might not be much of an argument, but on the other side,
> my motivation to test again from scratch will be much lower (I can't
> change much on that, I'm afraid), which would eventually lead to lowe=
r
> reliability of the final product.

On the other hand having 2 drivers implementing very similar
functionality would lead to general confusion as to which one should be
used; they will also have to be maintained.

I would rather see them merged into one driver providing necessary
services to all memoryless FF devices.

Thanks.

--=20
Dmitry
