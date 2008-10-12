From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] Input: appletouch - driver refactoring
Date: Sun, 12 Oct 2008 18:00:57 +0200
Message-ID: <1223827257.11389.1.camel@galileo>
References: <1223542147.6130.14.camel@galileo>
	 <20081011032120.GB22499@anvil.corenet.prv>
	 <1223822468.9733.1.camel@galileo>  <1223822674.9733.5.camel@galileo>
	 <1223823289.10176.9.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sd-11162.dedibox.fr ([88.191.70.230]:34014 "EHLO
	sd-11162.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbYJLQBJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Oct 2008 12:01:09 -0400
In-Reply-To: <1223823289.10176.9.camel@johannes.berg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Le dimanche 12 octobre 2008 =C3=A0 16:54 +0200, Johannes Berg a =C3=A9c=
rit :

> Looks nice, will give it a test later, just a small comment.
[...]

> > +static struct atp_info fountain_info =3D {
[...]
> > +static struct atp_info geyser1_info =3D {
[...]

> And there are only three uses. Do we expect to add new uses of the
> types, especially different structs that share the type? Otherwise I'=
d
> suggest to use
>=20
> if (dev->info =3D=3D &geyser2_info) and &fountain_info respectively a=
nd just
> remove the type thing completely.

I agree. Updated patch is coming.

--=20
Stelian Pop <stelian@popies.net>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
