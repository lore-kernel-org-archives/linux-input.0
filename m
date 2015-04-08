From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4.0 REGRESSION FIX] alps: Fix left touchpad button getting stuck when using it with trackpoint
Date: Wed, 8 Apr 2015 22:26:36 +0200
Message-ID: <201504082226.36289@pali>
References: <1428507532-25533-1-git-send-email-hdegoede@redhat.com> <1428507532-25533-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2119731.cfQhf5Vrx6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428507532-25533-2-git-send-email-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart2119731.cfQhf5Vrx6
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 April 2015 17:38:52 Hans de Goede wrote:
> When the left touchpad button gets pressed, and then the
> trackpoint is moved, and then the button is released, the
> following happens:
>=20
> 1) touchpad packet is received, touchpad evdev node reports
> BTN_LEFT 1 2) pointingstick packet is received, the hw will
> report a BTN_LEFT 1 in this packet because when the
> trackstick is active it communicates the combined touchpad +
> pointingstick buttons in the trackstick packet, since
> alps_report_bare_ps2_packet passes NULL (*) for the dev2
> parameter to alps_report_buttons the combining is not
> detected and the pointingstick evdev node will also report
> BTN_LEFT 1
> 3) on release of the button a pointingstick packet with
> BTN_LEFT 0 is received, and the pointingstick evdev node will
> report BTN_LEFT 0
>=20
> Note how because of the passing as NULL for dev2 the touchpad
> evdev node will never send BTN_LEFT 0 in this scenario
> leading to a stuck mouse button.
>=20
> This is a regression in 4.0 introduced by commit 04aae283ba6a8
> ("Input: ALPS - do not mix trackstick and external PS/2 mouse
> data")
>=20
> This commit fixes this by passing in the touchpad evdev as
> dev2 parameter when calling alps_report_buttons for the
> pointingstick on alps v2 devices, so that alps_report_buttons
> correctly detect that we're already reporting the button as
> pressed via the touchpad evdev node, and will also send the
> release event there.
>=20
> Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch looks good to me, so

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

As this is regression in 4.0 (which was not in 3.19), I'm also=20
for fixing it. But decision is of course on maintainers...

I think this is nice example how touchpad+trackstick protocol at=20
HW level should not looks like. It is complete mess what HW=20
engineers invented and how their devices pass input data to=20
operating system.

> ---
>  drivers/input/mouse/alps.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c
> b/drivers/input/mouse/alps.c index 80b6eca..6962c26 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1159,13 +1159,14 @@ static void
> alps_report_bare_ps2_packet(struct psmouse *psmouse, bool
> report_buttons)
>  {
>  	struct alps_data *priv =3D psmouse->private;
> -	struct input_dev *dev;
> +	struct input_dev *dev, *dev2 =3D NULL;
>=20
>  	/* Figure out which device to use to report the bare packet
> */ if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
>  	    (priv->flags & ALPS_DUALPOINT)) {
>  		/* On V2 devices the DualPoint Stick reports bare packets
> */ dev =3D priv->dev2;
> +		dev2 =3D psmouse->dev;
>  	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
>  		/* Register dev3 mouse if we received PS/2 packet first
> time */ if (!IS_ERR(priv->dev3))
> @@ -1177,7 +1178,7 @@ static void
> alps_report_bare_ps2_packet(struct psmouse *psmouse, }
>=20
>  	if (report_buttons)
> -		alps_report_buttons(dev, NULL,
> +		alps_report_buttons(dev, dev2,
>  				packet[0] & 1, packet[0] & 2, packet[0] & 4);
>=20
>  	input_report_rel(dev, REL_X,

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2119731.cfQhf5Vrx6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEUEABECAAYFAlUljvwACgkQi/DJPQPkQ1JB5gCYgLsQCS0E6aMDws5kv6+fl6Qr
QACgiBB7i98+VP9c1igTWvOb51+poMo=
=xlaY
-----END PGP SIGNATURE-----

--nextPart2119731.cfQhf5Vrx6--
