From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2 v2] elantech: Additional info reporting with version2
Date: Thu, 20 May 2010 10:52:37 -0700
Message-ID: <201005201052.38099.dmitry.torokhov@gmail.com>
References: <4BE592AB.7040801@tudelft.nl> <4BF575A8.4040401@tudelft.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57746 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab0ETRwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 13:52:45 -0400
Received: by pwi5 with SMTP id 5so39676pwi.19
        for <linux-input@vger.kernel.org>; Thu, 20 May 2010 10:52:44 -0700 (PDT)
In-Reply-To: <4BF575A8.4040401@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thursday 20 May 2010 10:47:20 am =C3=89ric Piel wrote:
> Op 08-05-10 18:34, =C3=89ric Piel schreef:
> > Hello,
> >=20
> > Will follow a second version of my patches to support more informat=
ion
> > in the hardware version 2 of elantech. The main changes is that I'v=
e
> >=20
> > done much further reverse engineering on the protocol, and found ou=
t that:
> >  * the width is acutally reported on 6 bits (not just 4)
> >  * the coordinates of the three finger touch are rerported as a one
> >=20
> > finger touch
> >=20
> >  * it's possible to differentiate between 3 and 4 fingers touch
> >=20
> > The second patch to add MT support has only be adapted to work bett=
er
> > with mousedev, as suggested by Dmitry.
> >=20
> > Patches are against git input-linux for-linus.
>=20
> Hi Dmitry,
> These two patches were not in your queue for 2.6.35-rc0. Is there any
> additional changes that you'd like to have on them before merging?
>=20

Eric,

It is still unclear to me what is the cutoff version of the firmware
that starts reporting teh width and multiple fingers. I think that
we should not advertise these capabilities on touchpads that do not
support them.

So basically more testing/data is needed at this point.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
