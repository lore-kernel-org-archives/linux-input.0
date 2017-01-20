From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 4/7] Input: pwm-beeper - fix race when suspending
Date: Fri, 20 Jan 2017 11:14:21 +0100
Message-ID: <20170120101421.GD3824@ulmo.ba.sec>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34945 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdATKO3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 05:14:29 -0500
Content-Disposition: inline
In-Reply-To: <20170119224057.9995-4-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:40:54PM -0800, Dmitry Torokhov wrote:
> Usually userspace sends SND_BELL and SND_TONE events, and by the time
> pwm_beeper_suspend() runs userpsace is already frozen, but theoretically
> in-kernel users may send these events too, and that may cause
> pwm_beeper_event() scheduling another work after we canceled it.
>=20
> Let's introduce a "suspended" flag and check it in pwm_beeper_event() to
> avoid this race.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB4vwACgkQ3SOs138+
s6EI5BAAgJtyvz77TYBN47QZNfWF+eT0ya8WSRYBnAP6AhWsGisXnsYd5hSE46kf
3bs92GVpOKP11doGWu3UxOtljR74+4fx7yxk5xy8rmKIc1yQewYYCdPUoznMq9mP
m1O48c2Ipa48yYuQd3cKznE7+9lp0nhJl2w2De+Is4ROxc7RLOXyhHe0ePBnhT8s
9cdao95lHRmyqyJl4o4KFEcwj9N6qi8mdSUaVKcdxeMRetjlRVnM+s1Qia+axOQl
4nrD/eKsimwWL3xRxyng5ZZbZxkeFPqz128mn9K/QJq11nvFJoM/q8BEsErqu9WL
erVUi0G5Uj+OHI/jcJoYlG5hwnT9rr70tyru6dAtJfW5zUWKqAOEMNMPRKbFggtr
6MC4s41Fr77ilpAEGXstctmv7GenzL2j/BxF2rKgZXsfdG38j2OdZF5prJJD5MO4
ZAEzKALXvsKBU5gEhv6jlnzH9f4rdtUg+q7MQtmhz2W9y6Acmvga0k8oFvNM4Tvr
W0+62FERqOehUPcmp7rvCH2tLZtuyKjj+O6tp9XZu/qJgqtjOgUbPbcGCtsVzkSp
S6LmzIXYyrLD1jkNYGWqgKASkZ560CZmWebwQ8UK++Pa16ItlgHiCyzLOuIQ+Z0D
ds0skstssY3JNRvJr0hVzy2YFkOZkbnzQv6RJJysB91zpJijnvQ=
=G9pF
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
