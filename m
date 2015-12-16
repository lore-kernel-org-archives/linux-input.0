From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add eGalaxTouch serial touchscreen driver v3
Date: Wed, 16 Dec 2015 11:28:30 -0800
Message-ID: <20151216192830.GA10962@dtor-ws>
References: <1450269798-13928-1-git-send-email-zboszor@pr.hu>
 <56715EE9.9080303@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34146 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966407AbbLPT2e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 14:28:34 -0500
Received: by mail-pa0-f52.google.com with SMTP id wq6so28379652pac.1
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 11:28:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56715EE9.9080303@pr.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: linux-input@vger.kernel.org, =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszormenyi@sicom.com>

On Wed, Dec 16, 2015 at 01:54:01PM +0100, Boszormenyi Zoltan wrote:
> 2015-12-16 13:43 keltez=C3=A9ssel, Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9=
nyi =C3=ADrta:
> > Signed-off-by: B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=BDnyi Zolt=EF=BF=BDn <=
zboszor@pr.hu>
>=20
> this
>=20
> > + * Copyright (c) 2015 Zolt=EF=BF=BDn B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=
=BDnyi <zboszor@pr.hu>
>=20
> this
>=20
> > +MODULE_AUTHOR("Zolt=EF=BF=BDn B=EF=BF=BDsz=EF=BF=BDrm=EF=BF=BDnyi =
<zboszor@pr.hu>");
>=20
> and this were in Latin-2 after you sent the patch back to me, my patc=
h
> was UTF-8 in the beginning.

Hmm, not sure what happened...

>=20
> Can you run the code through "recode latin2..utf-8" before committing=
 or
> should I resend to fix this?

No, I recoded it and I also added back SERIO_EGALAX definition to
serio.h that you somehow dropped from the patch. The driver is queued
for 4.5 now.

Thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
