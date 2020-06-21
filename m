Return-Path: <SRS0=oUY2=AC=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF932C433E0
	for <linux-input@archiver.kernel.org>; Sun, 21 Jun 2020 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4D20767
	for <linux-input@archiver.kernel.org>; Sun, 21 Jun 2020 21:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFUVVI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 21 Jun 2020 17:21:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41604 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgFUVVH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jun 2020 17:21:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CBF071C0C0A; Sun, 21 Jun 2020 23:21:06 +0200 (CEST)
Date:   Sun, 21 Jun 2020 23:21:06 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Slaby <jslaby@suse.com>, kernel@collabora.com
Subject: Re: [PATCH] tty/sysrq: Add alternative SysRq key
Message-ID: <20200621212106.GB22512@amd>
References: <20200511180145.GU89269@dtor-ws>
 <20200619162819.715-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20200619162819.715-1-andrzej.p@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There exist machines which don't have SysRq key at all, e.g. chromebooks.
>=20
> This patch allows configuring an alternative key to act as SysRq. Devices
> which declare KEY_SYSRQ in their 'keybit' bitmap continue using KEY_SYSRQ,
> but other devices use the alternative SysRq key instead, by default F10.
> Which key is actually used can be modified with sysrq's module parameter.
>=20
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

So... SysRq was selected because you are not going to press
Alt-Printscreen-X by default.

I'm not sure if F10 is similar level of "impossible to press by
mistake", altrough holding up F10-B is likely not too common. Maybe it
should be some combination for chromebooks?
Leftshift-rightshift-F10-key? Ctrl-alt-del-key? :-).

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7vz0IACgkQMOfwapXb+vLDiQCgmuKgWbgUn3chU8mSHTfvok8D
PMcAoJ8OU2jiEO7vy2a4Tptysrp8WwSs
=SZqh
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
