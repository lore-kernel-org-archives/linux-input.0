From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH v2 0/4] Add ff-memless-next and make hid-lg4ff use it
Date: Mon, 24 Feb 2014 23:11:20 +0100
Message-ID: <1687636.joOxxSug6B@geidi-prime>
References: <1516865.M993BQAYe4@geidi-prime> <CADbOyBQ0U_TiovwMJJO1zQpr5PcwmB1O155P4nC6CmwhZjA=UQ@mail.gmail.com> <20140224214818.GA4156@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:43463 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbaBXWL2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Feb 2014 17:11:28 -0500
In-Reply-To: <20140224214818.GA4156@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Elias Vanderstuyft <elias.vds@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Simon Wood <simon@mungewell.org>

On Monday 24 of February 2014 13:48:18 Dmitry Torokhov wrote:
> On Mon, Feb 24, 2014 at 10:17:25PM +0100, Elias Vanderstuyft wrote:
> > On Mon, Feb 24, 2014 at 1:58 AM, Michal Mal=FD <madcatxster@prifuk.=
cz>=20
wrote:
> > > On Monday 24 of February 2014 02:32:27 Anssi Hannula wrote:
> > >> I think we should extend the current ff-memless instead of dupli=
cating
> > >> its functionality (even on a "for now" basis).
> > >>=20
> > >> Having looked at ff-memless-next briefly, it seems very similar =
to
> > >> ff-memless on its basic working principle, and therefore I don't=
 really
> > >> see why extending ff-memless would be too cumbersome. Unless I'm
> > >> missing
> > >> something - in that case, feel free to point it out to me :)
> > >=20
> > > Deciding whether to patch ff-memless or write a new driver from s=
cratch
> > > was a perfect example of being caught between the rock and a hard
> > > place. I am not particularly fond of the fact that we would have =
two
> > > modules doing pretty much the same thing. My reasons for writing =
a
> > > separate module were:
> > > - Periodic effects. ff-memless doesn't do "real" periodic effects=
, it
> > > simply emulates them through rumble effect. Devices without rumbl=
e
> > > effect support require emulation through constant force effect. J=
ust
> > > this was not something one could write in one afternoon:)
> > > - Conditional effects. These effects cannot be by nature combined=
 into
> > > one
> > > overall force (at least not easily) so they have to be handled on=
e by
> > > one -
> > > this is a concept ff-memless does not seem to consider. FFB devic=
es have
> > > limits as to how many conditional (referred to as "uncombinable" =
in
> > > MLNX)
> > > effects can be active simultaneously, etc.
> > > All in all it seemed less error prone to write a new driver based=
 on the
> > > ff- memless logic, test and deploy it on devices I have access to=
 and
> > > once we are sure there are no nasty regressions port the rest of =
the
> > > drivers to the new API. Given the scope of the changes I am afrai=
d that
> > > a "patch" to ff-memless would be pretty close to a rewrite anyway=
=2E
> >=20
> > And add the fact that we already heavily tested the ff-memless-next
> > driver.
> > Unless you do a diff between the original ff-memless.c and the curr=
ent
> > ff-memless-next.c (which will result in a rather unintuitive patch)=
,
> > it would be a huge waste of time to retest the modified (when doing
> > efforts to create an intuitive patch) ff-memless-next.c, considered=
 my
> > total time spend on testing (and not to speak of the time that Mich=
al
> > spent to fix the corresponding bugs.)
> > I know that might not be much of an argument, but on the other side=
,
> > my motivation to test again from scratch will be much lower (I can'=
t
> > change much on that, I'm afraid), which would eventually lead to lo=
wer
> > reliability of the final product.
>=20
> On the other hand having 2 drivers implementing very similar
> functionality would lead to general confusion as to which one should =
be
> used; they will also have to be maintained.
>=20
> I would rather see them merged into one driver providing necessary
> services to all memoryless FF devices.
>=20
> Thanks.

Very well. It that case I guess the most sensible thing to do would be =
to add=20
=46F_RUMBLE to ff-memless-next and replace ff-memless completely. As An=
ssi=20
pointed out a lot of the drivers that currently use ff-memless are very=
 simple=20
so any risk of breakage will hopefully be minimal.

As I don't have any device with rumble effect support I'll appreciate h=
elp on=20
this front

Michal M.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
