Return-Path: <SRS0=EvQP=CH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E24BC433E2
	for <linux-input@archiver.kernel.org>; Sat, 29 Aug 2020 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199D120838
	for <linux-input@archiver.kernel.org>; Sat, 29 Aug 2020 07:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgH2HsD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:48:03 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54852 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgH2HsC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 29 Aug 2020 03:48:02 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C36621C0B80; Sat, 29 Aug 2020 09:47:59 +0200 (CEST)
Date:   Sat, 29 Aug 2020 09:47:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        Shirish.S@amd.com, Andy Shevchenko <andy@infradead.org>,
        Dan Murphy <dmurphy@ti.com>,
        Darren Hart <dvhart@infradead.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Rajat Jain <rajatja@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: i8042 - Prevent intermixing i8042 commands
Message-ID: <20200829074758.GA16838@amd>
References: <20200827135205.1.I6981f9a9f0c12e60f8038f3b574184f8ffc1b9b5@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20200827135205.1.I6981f9a9f0c12e60f8038f3b574184f8ffc1b9b5@changeid>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-08-27 13:52:22, Raul E Rangel wrote:
> The i8042_mutex must be held by writers of the AUX and KBD ports, as
> well as users of i8042_command. There were a lot of users of
> i8042_command that were not calling i8042_lock_chip/i8042_unlock_chip.
> This resulted in i8042_commands being issues in between PS/2
> transactions.
>=20
> This change moves the mutex lock into i8042_command and removes the
> burden of locking the mutex from the callers.
>=20
> It is expected that the i8042_mutex is locked before calling
> i8042_aux_write or i8042_kbd_write. This is currently done by the PS/2
> layer via ps2_begin_command and ps2_end_command. Other modules
> (serio_raw) do not currently lock the mutex, so there is still a
> possibility for intermixed commands.


> @@ -343,10 +330,14 @@ int i8042_command(unsigned char *param, int command)
>  	unsigned long flags;
>  	int retval;
> =20
> +	mutex_lock(&i8042_mutex);
> +
>  	spin_lock_irqsave(&i8042_lock, flags);
>  	retval =3D __i8042_command(param, command);
>  	spin_unlock_irqrestore(&i8042_lock, flags);
> =20
> +	 mutex_unlock(&i8042_mutex);
> +
>  	return retval;

There's something wrong with whitespace here. Checkpatch?
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9KCC4ACgkQMOfwapXb+vLRLQCZAVRSNB7AWmLMpShfbIqQb9g7
e2kAn0k5vjeRzWluElrV5q2QcU+nhqJy
=TVRR
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
