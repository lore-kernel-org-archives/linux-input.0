From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v2 0/4] Add ff-memless-next and make hid-lg4ff use it
Date: Mon, 24 Feb 2014 02:32:27 +0200
Message-ID: <530A931B.3020606@iki.fi>
References: <1516865.M993BQAYe4@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sinikuusama.dnainternet.net ([83.102.40.134]:54088 "EHLO
	sinikuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422AbaBXAcj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 19:32:39 -0500
In-Reply-To: <1516865.M993BQAYe4@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org

24.02.2014 01:24, Michal Mal=FD kirjoitti:
> Hi everybody,

Hi,

> this patch series is a result of my work to improve FFB support for m=
emoryless
> devices. ff-memless-next is an improvement over the currently availab=
le
> ff-memless which is well suited for joypads but cannot handle more ad=
vanced
> devices such as racing wheels properly. As I have explained in one of=
 RFCs
> regarding ff-memless-next, the extent of the changes makes implementi=
ng
> ff-memless-next as a patch to ff-memless unfeasible. As of now there =
is a total
> of 27 drivers using ff-memless (including lg4ff) - a lot of them joyp=
ads.
> I do not have access to any FFB joypad at the moment so I cannot
> implement the functionality required to handle joypads properly - nam=
ely FF_RUMBLE
> and emulation of FF_PERIODIC through FF_RUMBLE.
> The plan is to implement the missing functionality and replace ff-mem=
less completely
> in the future.=20

I think we should extend the current ff-memless instead of duplicating
its functionality (even on a "for now" basis).

Having looked at ff-memless-next briefly, it seems very similar to
ff-memless on its basic working principle, and therefore I don't really
see why extending ff-memless would be too cumbersome. Unless I'm missin=
g
something - in that case, feel free to point it out to me :)

Duplicating the module makes reviewing it somewhat difficult since the
changes are not clearly visible.

As for the amount of drivers using ff-memless, those are ~all very
simple (single function call registering a single callback) so it shoul=
d
be easy to apply any API conversion if needed.
And I don't see a real need for you to have access to a rumble joypad -
that support is already implemented in ff-memless, and other people can
test that it isn't broken by your changes.

Regardless, thanks for looking into this.

>=20
> Second part of this series ports lg4ff driver over to ff-memless-next=
=2E
> The immediate benefit of this is support of all periodic effects and =
ramp effect.
>=20
> v2 addresses a few issues that have not been noticed at the time v1 w=
as
> submitted. Specific fixes are mentioned in the respective patches.
>=20
> Michal M.
>=20
>  Michal Mal=FD (4):
>   INPUT: Add ff-memless-next module
>   HID: Port hid-lg4ff to ff-memless-next
>   HID: Add support for periodic effects in hid-lg4ff
>   HID: Add support for ramp effect in hid-lg4ff
>=20
>  Documentation/input/ff-memless-next.txt | 141 ++++++
>  drivers/hid/Kconfig                     |   2 +-
>  drivers/hid/hid-lg4ff.c                 |  93 ++--
>  drivers/input/Kconfig                   |  11 +
>  drivers/input/Makefile                  |   1 +
>  drivers/input/ff-memless-next.c         | 789 ++++++++++++++++++++++=
++++++++++
>  include/linux/input/ff-memless-next.h   |  32 ++
>  7 files changed, 1033 insertions(+), 36 deletions(-)
> --
>  1.9.0
>=20
> --
>=20


--=20
Anssi Hannula
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
