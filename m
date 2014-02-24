From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH v2 0/4] Add ff-memless-next and make hid-lg4ff use it
Date: Mon, 24 Feb 2014 01:58:53 +0100
Message-ID: <14991521.KzMVP7XS2h@geidi-prime>
References: <1516865.M993BQAYe4@geidi-prime> <530A931B.3020606@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:41629 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbaBXA7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 19:59:00 -0500
In-Reply-To: <530A931B.3020606@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org

On Monday 24 of February 2014 02:32:27 Anssi Hannula wrote:
> 24.02.2014 01:24, Michal Mal=FD kirjoitti:
> > Hi everybody,
>=20
> Hi,
>=20
> > this patch series is a result of my work to improve FFB support for
> > memoryless devices. ff-memless-next is an improvement over the curr=
ently
> > available ff-memless which is well suited for joypads but cannot ha=
ndle
> > more advanced devices such as racing wheels properly. As I have exp=
lained
> > in one of RFCs regarding ff-memless-next, the extent of the changes=
 makes
> > implementing ff-memless-next as a patch to ff-memless unfeasible. A=
s of
> > now there is a total of 27 drivers using ff-memless (including lg4f=
f) - a
> > lot of them joypads. I do not have access to any FFB joypad at the =
moment
> > so I cannot
> > implement the functionality required to handle joypads properly - n=
amely
> > FF_RUMBLE and emulation of FF_PERIODIC through FF_RUMBLE.
> > The plan is to implement the missing functionality and replace ff-m=
emless
> > completely in the future.
>=20
> I think we should extend the current ff-memless instead of duplicatin=
g
> its functionality (even on a "for now" basis).
>=20
> Having looked at ff-memless-next briefly, it seems very similar to
> ff-memless on its basic working principle, and therefore I don't real=
ly
> see why extending ff-memless would be too cumbersome. Unless I'm miss=
ing
> something - in that case, feel free to point it out to me :)

Deciding whether to patch ff-memless or write a new driver from scratch=
 was a=20
perfect example of being caught between the rock and a hard place. I am=
 not
particularly fond of the fact that we would have two modules doing pret=
ty much
the same thing. My reasons for writing a separate module were:
- Periodic effects. ff-memless doesn't do "real" periodic effects, it s=
imply=20
emulates them through rumble effect. Devices without rumble effect supp=
ort=20
require emulation through constant force effect. Just this was not some=
thing=20
one could write in one afternoon:)
- Conditional effects. These effects cannot be by nature combined into =
one=20
overall force (at least not easily) so they have to be handled one by o=
ne -=20
this is a concept ff-memless does not seem to consider. FFB devices hav=
e=20
limits as to how many conditional (referred to as "uncombinable" in MLN=
X)=20
effects can be active simultaneously, etc.
All in all it seemed less error prone to write a new driver based on th=
e ff-
memless logic, test and deploy it on devices I have access to and once =
we are=20
sure there are no nasty regressions port the rest of the drivers to the=
 new=20
API. Given the scope of the changes I am afraid that a "patch" to ff-me=
mless=20
would be pretty close to a rewrite anyway.

> Duplicating the module makes reviewing it somewhat difficult since th=
e
> changes are not clearly visible.
>=20
> As for the amount of drivers using ff-memless, those are ~all very
> simple (single function call registering a single callback) so it sho=
uld
> be easy to apply any API conversion if needed.
> And I don't see a real need for you to have access to a rumble joypad=
 -
> that support is already implemented in ff-memless, and other people c=
an
> test that it isn't broken by your changes.
It has been my intention to add handling of rumble effects in a followu=
p=20
patch. I wanted to limit the extent of changes I dump in a one massive =
patch,=20
especially when I cannot test the rumble effect on a real hardware.

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
