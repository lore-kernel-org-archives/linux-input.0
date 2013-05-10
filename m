From: "Tibor Billes" <tbilles@gmx.com>
Subject: Re: Possible regression 3.8.7 -> 3.9 with Dell touchpad
Date: Fri, 10 May 2013 21:39:57 +0200
Message-ID: <20130510193957.89870@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:52626 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab3EJTkE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 May 2013 15:40:04 -0400
Received: from mailout-eu.gmx.com ([10.1.101.216]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MfTEr-1Uuu5p3ZBz-00P6Wc for
 <linux-input@vger.kernel.org>; Fri, 10 May 2013 21:40:02 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Dave Turvene <dturvene@dahetral.com>, Kevin Cernekee <cernekee@gmail.com>

=46rom: Dmitry Torokhov Sent: 05/10/13 12:54 AM
>=20
> On Thu, May 09, 2013 at 10:59:58PM +0200, Tibor Billes wrote:
> > Hi,
> >=20
> > I found that after upgrading my kernel from 3.8.7 to 3.9 my touchpa=
d only
> > works partly. By that I mean I can use the touchpad to move the cur=
sor
> > around, but I cannot click with it by tapping.
>=20
> Is the touchpad recognized as ALPS or PS/2 mouse in 3.8.7? Also, can =
you
> check that touchpad tapping is enabled in your desktop environment?

In 3.8.7 it is recognized as PS/2 mouse and the desktop environment doe=
sn't even offer any touchpad settings. In 3.9.1 the touchpad is recogni=
zed as 'AlpsPS/2 ALPS DualPoint TouchPad' and yes, the touchpad setting=
s appeared, and yes, clicking was disabled. Enabled it, works like a ch=
arm :)

So what happened is that the 3.8.7 kernel did not recognize my touchpad=
, so it fell back to PS/2 which worked well for me. The 3.9 kernel reco=
ngizes my touchpad correctly because Kevin updated the driver, and my s=
ystem started using a different configuration as it knew it was a touch=
pad and not some PS/2 device. Am I right? I recall looking for touchpad=
 settings in one of the 3.8.x kernels and I didn't find any so I didn't=
 bother looking for it again in 3.9...

In this case I'm sorry for the false report, and thank you guys for the=
 driver update :)

> Thanks.
>=20
> > My machine is a Dell
> > Latitude E5530. Since it is 100% reproducible on my machine, I bise=
cted it,
> > and found this commit:
> >=20
> > commit 1302bac33d9e88cd43e482191a806998f3ed43cc
> > Author: Kevin Cernekee <cernekee@gmail.com>
> > Date: =C2=A0 Wed Feb 13 22:27:08 2013 -0800
> >=20
> > =C2=A0 =C2=A0Input: ALPS - add support for "Rushmore" touchpads
> > =C2=A0 =C2=A0
> > =C2=A0 =C2=A0Rushmore touchpads are found on Dell E6230/E6430/E6530=
=2E =C2=A0They use the V3
> > =C2=A0 =C2=A0protocol with slightly tweaked init sequences and repo=
rt formats.
> > =C2=A0 =C2=A0
> > =C2=A0 =C2=A0The E7 report is 73 03 0a, and the EC report is 88 08 =
1d
> > =C2=A0 =C2=A0
> > =C2=A0 =C2=A0Credits: Emmanuel Thome reported the MT bitmap changes=
=2E
> > =C2=A0 =C2=A0
> > =C2=A0 =C2=A0Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > =C2=A0 =C2=A0Tested-by: Dave Turvene <dturvene@dahetral.com>
> > =C2=A0 =C2=A0Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.=
com>
> >=20
> > I did the bisection between 3.8.7 and 3.9, but also tried 3.9.1, it=
 is bad
> > too. I also tried reverting that commit to make sure that it really=
 is
> > what made my touchpad not working. The revert did fix my problem.
> >=20
> > That's all I gathered so far, but I'd be happy to help further in a=
ny way
> > I can, just let me know.
> >=20
> > Thanks,
> > Tibor
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
> --=20
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
