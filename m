Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED59C433DB
	for <linux-input@archiver.kernel.org>; Sun, 14 Feb 2021 18:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E0961494
	for <linux-input@archiver.kernel.org>; Sun, 14 Feb 2021 18:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBNSWQ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 14 Feb 2021 13:22:16 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52520 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhBNSWP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 14 Feb 2021 13:22:15 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B15DF1C0B9F; Sun, 14 Feb 2021 19:21:17 +0100 (CET)
Date:   Sun, 14 Feb 2021 19:21:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     linux-leds@vger.kernel.org, marek.behun@nic.cz,
        roderick.colenbrander@sony.com, pobrn@protonmail.com,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        jikos@kernel.org, linux-input@vger.kernel.org
Subject: HID: playstation: add DualSense lightbar support
Message-ID: <20210214182117.GA16744@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I noticed that there are LED patches in the -next that were not
reviewed on the lists, such as "HID: playstation: add DualSense
lightbar support".

Could you get them posted on LED mailing lists for review, please?

Thanks,
							Pavel

--=20
http://www.livejournal.com/~pavelmachek

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYClqHQAKCRAw5/Bqldv6
8mrbAJ98OIoecJ6FvWMSgl81gWgFX3MSsQCeKqi7B3WZOOsjlt90fYC5uNOsucE=
=r4V/
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
