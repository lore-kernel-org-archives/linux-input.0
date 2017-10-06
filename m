From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: Convert timers to use timer_setup()
Date: Fri, 6 Oct 2017 18:03:03 +0200
Message-ID: <201710061803.03551@pali>
References: <20171005005329.GA23768@beast>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2046169.ZYX7lzC1IZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:47676 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbdJFQDH (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Oct 2017 12:03:07 -0400
In-Reply-To: <20171005005329.GA23768@beast>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Gamari <ben@smart-cactus.org>, Paul Donohue <linux-kernel@paulsd.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

--nextPart2046169.ZYX7lzC1IZ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 05 October 2017 02:53:29 Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list
> pointer to all timer callbacks, switch to using the new
> timer_setup() and from_timer() to pass the timer pointer explicitly.
> Adds a pointer back to input device in byd driver.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: "Pali Roh=C3=A1r" <pali.rohar@gmail.com>
> Cc: Ben Gamari <ben@smart-cactus.org>
> Cc: Paul Donohue <linux-kernel@PaulSD.com>
> Cc: Masaki Ota <masaki.ota@jp.alps.com>
> Cc: linux-input@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This requires commit 686fef928bba ("timer: Prepare to change timer
> callback argument type") in v4.14-rc3, but should be otherwise
> stand-alone.
> ---
>  drivers/input/ff-memless.c |  8 ++++----
>  drivers/input/mouse/alps.c |  8 ++++----
>  drivers/input/mouse/byd.c  | 10 ++++++----
>  3 files changed, 14 insertions(+), 12 deletions(-)

Looks good,
Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2046169.ZYX7lzC1IZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlnXqTcACgkQi/DJPQPkQ1Jn6QCfb02YGLTtLzX+ESW4PdG1ZIlx
KF4AoJvy+7WlVbcurqtqKHBZBDjnEvLr
=lvIc
-----END PGP SIGNATURE-----

--nextPart2046169.ZYX7lzC1IZ--
