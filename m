Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12B0C001B0
	for <linux-input@archiver.kernel.org>; Sun, 23 Jul 2023 12:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjGWMYe (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 23 Jul 2023 08:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWMYe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 23 Jul 2023 08:24:34 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830710DE;
        Sun, 23 Jul 2023 05:24:32 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7580D1C0A92; Sun, 23 Jul 2023 14:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1690115070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=T+7CgaHN4AZNnlQhKld0Sw5Ige0x36Br5M/VqqphhMM=;
        b=NhpFpRrwFEAQ6VR5ve5SWQyYtX9T09THtW3mJb1sh1i+FAWLQg1CQmEEclvRl2g9EioX1O
        Xpqy5SXweeX59h1lSarYIw833HvkTlX02hxRIX3lV4JipfDVNzQ887QrGuMR0mebBMEzTi
        FchKtl/w8gNjlpD4HPMYBddxudLoIj4=
Date:   Sun, 23 Jul 2023 14:24:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: 6.5-rc2: keys autorepeating when they should not
Message-ID: <ZL0b/odKy/GlEzJV@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+VFFbTk9YlWrWmzm"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--+VFFbTk9YlWrWmzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I updated to 6.5-rc2, and now I see keyboard problems (in X). ~ once
in two days I get keyboard "stuck", autorepeating. It is USB keyboard,
hitting another key cancels the autorepeat.

Any ideas?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+VFFbTk9YlWrWmzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZL0b/gAKCRAw5/Bqldv6
8rl/AJ9Xu8SRX9H+z5mSQU729V9mJ7FKHgCgjlv5OQeoQxiKBRK9PtluP+bZZWk=
=xKHk
-----END PGP SIGNATURE-----

--+VFFbTk9YlWrWmzm--
