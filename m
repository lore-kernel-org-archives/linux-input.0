From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 5 May 2010 11:09:11 -0700
Message-ID: <201005051109.11531.dmitry.torokhov@gmail.com>
References: <4BE16121.8040000@tudelft.nl> <20100505171350.GE7337@core.coreip.homeip.net> <20100505180048.GH6075@perldition.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:65200 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab0EESJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 14:09:22 -0400
Received: by wwb34 with SMTP id 34so65827wwb.19
        for <linux-input@vger.kernel.org>; Wed, 05 May 2010 11:09:20 -0700 (PDT)
In-Reply-To: <20100505180048.GH6075@perldition.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Ragwitz <rafl@debian.org>
Cc: =?iso-8859-15?q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wednesday 05 May 2010 11:00:48 am Florian Ragwitz wrote:
> On Wed, May 05, 2010 at 10:13:50AM -0700, Dmitry Torokhov wrote:
> > On Wed, May 05, 2010 at 06:58:18PM +0200, =C9ric Piel wrote:
> > > Op 05-05-10 18:39, Dmitry Torokhov schreef:
> > > > I think we shoudl have threshold for the firmware version when =
we
> > > > start reporting the width.
> > >=20
> > > What do you mean? That the width might not be reported correctly =
by all
> > > the firmwares? I have no idea if that is the case. For info, IIRC=
 my
> > > firmware report 2.1 with middle byte 8.
> >=20
> > My understanding was that older firmwares would report 0. I might b=
e
> > mistaken.
>=20
> Some firmwares always set the upper bits to 0. Others don't.
>=20
> As far as I can see, we only know about firmware version 2.1 and 4.1
> using those high bits for width reports.
>=20
> However, there's firmware versions inbetween, like 2.48, which don't
> report width information. And there's even other firmware versions
> inbetween, like 2.36, which actually implment what the driver calls
> hardware version 1. Those have a quite different packet format, and a=
lso
> no width information.

What we need to figure out if 2.48 and 2.36 are in fact something like
2.0.48 and 2.0.36.. And 2.1 is actually 2.x.1. Then it would all make
better sense.

>=20
> Currently it seems to be unknown how to detect hw ver 1 vs. 2 based o=
n
> the firmware version. Guesses tend towards the middle bit being
> signifficant, somehow.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
