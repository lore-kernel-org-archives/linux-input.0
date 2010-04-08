From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC3] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Thu, 08 Apr 2010 09:21:17 -0300
Message-ID: <4BBDCA3D.3000106@infradead.org>
References: <20100408113910.GA17104@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:53319 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874Ab0DHMVV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 08:21:21 -0400
In-Reply-To: <20100408113910.GA17104@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

David H=E4rdeman wrote:
> drivers/media/IR/ir-raw-event.c is currently written with the assumpt=
ion=20
> that all "raw" hardware will generate events only on state change (i.=
e. =20
> when a pulse or space starts).
>=20
> However, some hardware (like mceusb, probably the most popular IR rec=
eiver
> out there) only generates duration data (and that data is buffered so=
 using
> any kind of timing on the data is futile).
>=20
> Furthermore, using signed int's to represent pulse/space durations in=
 ms
> is a well-known approach to anyone with experience in writing ir deco=
ders.
>=20
> This patch (which has been tested this time) is still a RFC on my pro=
posed
> interface changes.
>=20
> Changes since last version:
>=20
> o s64's are used to represent pulse/space durations in ns.
>=20
> o Lots of #defines are used in the decoders
>=20
> o Refreshed to apply cleanly on top of Mauro's current git tree
>=20
> o Jon's comments wrt. interrupt-context safe functions have been adde=
d
>=20

Ok, tested it with a variety of NEC/NEC extended/RC-5 IR's I have, with=
 the
saa7134 hardware. All worked.

There's just a few checkpatch.pl complains, and the most important thin=
g:

It lacks your SOB ;)

Please fix the checkpatch.pl errors, add a kfifo size comment and your =
SOB
and resend it to me (or, if you prefer, just send your SOB. I can take =
care
of the rest, as they're just trivial things).

--=20

Cheers,
Mauro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
