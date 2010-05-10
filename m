From: Bastien Nocera <hadess@hadess.net>
Subject: Re: More info on the elantech touchpad
Date: Mon, 10 May 2010 21:34:02 +0100
Message-ID: <1273523642.2308.651.camel@localhost.localdomain>
References: <4BE86ABE.5040400@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:43981 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0EJUeL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 16:34:11 -0400
In-Reply-To: <4BE86ABE.5040400@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Florian Ragwitz <rafl@debian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2010-05-10 at 22:21 +0200, =C9ric Piel wrote:
> Hello,
>=20
> There is a version apparently developed for the Dell mini 10 of the
> elantech driver which brings some light on the versions and the proto=
col.
>=20
> It was hidden in some ubuntu git trees [1] (warning, the code hurts t=
he
> eyes):
> http://zinc.ubuntu.com/git?p=3Dmid-team/hardy-netbook.git;a=3Dblob;f=3D=
drivers/input/mouse/elantech.c;h=3Dd0e2cafed162428f72e3654f4dda85e08ea4=
86b3;hb=3Drefs/heads/abi-22
>=20
> In particular the elantech_init() function is very instructive about =
the
> various available versions.
>=20
> Hopefully someone can merge this code with the current kernel version=
,
> so we get something that detects automatically most hardware...

Arjen already has the code, as well as some custom Elantech user-space
drivers and code on top of it. But he didn't have any hardware.

I noticed that Peter was working on the Dell mini 10 Elantech touchpad
and passed the code up to him as well.

Cheers

> See you,
> Eric
>=20
> [1] kudos to Bastien Nocera for spotting it out:
> http://www.hadess.net/2009/05/dell-mini-10-gah.html


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
