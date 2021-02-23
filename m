Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED72C433E0
	for <linux-input@archiver.kernel.org>; Tue, 23 Feb 2021 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A363564E21
	for <linux-input@archiver.kernel.org>; Tue, 23 Feb 2021 09:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBWJKv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 23 Feb 2021 04:10:51 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:52486 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBWJKI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Feb 2021 04:10:08 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 66BB61C0B82; Tue, 23 Feb 2021 10:09:24 +0100 (CET)
Date:   Tue, 23 Feb 2021 10:09:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] HID: elan: Remove elan_mute_led_get_brigtness()
Message-ID: <20210223090923.GH9750@amd>
References: <20210221113029.103703-1-hdegoede@redhat.com>
 <20210221113029.103703-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <20210221113029.103703-4-hdegoede@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -461,7 +452,6 @@ static int elan_init_mute_led(struct hid_device *hdev)
> =20
>  	mute_led->name =3D "elan:red:mute";

This probably should not have "elan" prefix.

Best regards,
							Pavel

--=20
http://www.livejournal.com/~pavelmachek

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmA0xkMACgkQMOfwapXb+vLLDQCgnvhE8J5fS8jikkY55qtXJkYw
zboAnRezbsT3WS58xznd5y82Z/QCZPs+
=cani
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
