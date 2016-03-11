From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add devicetree bindings to Input Drivers
 section
Date: Thu, 10 Mar 2016 17:20:24 -0800
Message-ID: <20160311012024.GB485@dtor-ws>
References: <1457374694-4764-1-git-send-email-afaerber@suse.de>
 <2964268.geAV7fb7cP@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34855 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961AbcCKBU2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 20:20:28 -0500
Content-Disposition: inline
In-Reply-To: <2964268.geAV7fb7cP@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Mon, Mar 07, 2016 at 07:54:16PM +0100, Heiko St=FCbner wrote:
> Am Montag, 7. M=E4rz 2016, 19:18:13 schrieb Andreas F=E4rber:
> > To avoid changes to input bindings not reaching linux-input reviewe=
rs
> > add an appropriate file pattern to the MAINTAINERS entry.
> >=20
> > Reported-by: Heiko St=FCbner <heiko@sntech.de>
> > Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
>=20
> not sure if it is needed, but looks good to me, so

Should not hurt...

>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied, thank you.

>=20
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8e9d47e10f59..b01a56dd7fb2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5633,6 +5633,7 @@ F:	drivers/input/
> >  F:	include/linux/input.h
> >  F:	include/uapi/linux/input.h
> >  F:	include/linux/input/
> > +F:	Documentation/devicetree/bindings/input/
> >=20
> >  INPUT MULTITOUCH (MT) PROTOCOL
> >  M:	Henrik Rydberg <rydberg@bitmath.org>
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
