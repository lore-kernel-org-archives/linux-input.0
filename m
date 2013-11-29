From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 26/31] Input: tegra-kbc - use reset framework
Date: Fri, 29 Nov 2013 15:50:54 +0100
Message-ID: <20131129145053.GF9712@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-27-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384548866-13141-27-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 01:54:21PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
>=20
> Cc: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Cc: pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
> Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/input/keyboard/tegra-kbc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmKnNAAoJEN0jrNd/PrOhR5IQAKeFVfIHkOQj+VpN+e9W6gdO
wa5f+i8VoIDy05Q85wWYBmuLSg6CpLhDdZ0h0ItorKNqfp/m8P+/NamlPZClhpRw
bf8GyHVDY8B0IntLh2s9Zc4rMcNa7DAeccH9DYjspbV0IoXT/QQn2igB7IOHzHST
IqrMwQ/0hSCuuzfMuyCCGzy/X1J9DvcF1GSkoQIADdYctxSeU8QYsqMnXH7E/den
fcN7HdnuGQAsd6nPntqI0vmYdA6lJoARITZv/xJgBGzi46CKHUu+LIK6O3NAwYTI
OqIBXyF7ZDDYoV84sZ6bRrs/UDLretW485+jVIUo8ws2NSWWczjvXIpYibnu3JKj
XmF+vQa4E9CODxDuIFpFYNy1GiZaWYNe09AgzK7iOJwIkQKLGJx7qj71MPjimuAQ
JawK/8D7UAR1M5CwSMSi8uncm2D45sazXOLtT/K9M3Lh4glFQ0zeQTR5yFjkWDhD
dNBt4KdcpcscLZAA5NcupFWNLEJ5lWtDAggSOXvv6qVn2zW6mDtJO0jAnM3LYMPU
bCOec+zImC36xkrcONXBrP8msXH8SUek90ampWeCooP6s1DUrWYW7NSQjVMWKvNS
LUbj3hb6V4xKXThjpKpYoTLp7OVYrjpXfmZrFcieLFxPZU8D4VRqJcZyEvbLgLHF
s1lQJkj+x50ih6JqVQxJ
=iaDY
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
