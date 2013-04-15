From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom: Correct reported resolution for Intuos4
 Wireless
Date: Mon, 15 Apr 2013 09:20:42 -0700
Message-ID: <20130415162042.GA27693@core.coreip.homeip.net>
References: <1365780680.4605.9.camel@localhost>
 <1365784982-10721-1-git-send-email-killertofu@gmail.com>
 <1365796838.12600.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35341 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab3DOQUq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Apr 2013 12:20:46 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so2598364pde.37
        for <linux-input@vger.kernel.org>; Mon, 15 Apr 2013 09:20:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365796838.12600.0.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net, pinglinux@gmail.com

On Fri, Apr 12, 2013 at 09:00:38PM +0100, Przemo Firszt wrote:
> Dnia 2013-04-12, pi=C4=85 o godzinie 09:43 -0700, Jason Gerecke pisze=
:
> > Reported-by: Przemo Firszt <przemo@firszt.eu>
> > Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> > ---
> >  drivers/input/tablet/wacom_wac.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/table=
t/wacom_wac.c
> > index 1daa979..1e0031d 100644
> > --- a/drivers/input/tablet/wacom_wac.c
> > +++ b/drivers/input/tablet/wacom_wac.c
> > @@ -1912,7 +1912,7 @@ static const struct wacom_features wacom_feat=
ures_0xBB =3D
> >  	{ "Wacom Intuos4 12x19",  WACOM_PKGLEN_INTUOS,    97536, 60960, 2=
047,
> >  	  63, INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
> >  static const struct wacom_features wacom_features_0xBC =3D
> > -	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40840, 25400, 2=
047,
> > +	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40640, 25400, 2=
047,
> >  	  63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
> >  static const struct wacom_features wacom_features_0x26 =3D
> >  	{ "Wacom Intuos5 touch S", WACOM_PKGLEN_INTUOS,  31496, 19685, 20=
47,
>=20
> Tested-by: Przemo Firszt <przemo@firszt.eu>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
