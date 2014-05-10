From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] input: Add new sun4i-ts driver for
 Allwinner sunxi SoC's rtp controller
Date: Sat, 10 May 2014 07:24:39 -0500
Message-ID: <20140510122439.GJ7047@lukather>
References: <1399718826-16215-1-git-send-email-hdegoede@redhat.com>
 <1399718826-16215-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O2lvLMQR9k8T/RyB"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBIVVXCNQKGQEYNXNGXI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399718826-16215-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org


--O2lvLMQR9k8T/RyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

Thanks a lot for reposting this.

On Sat, May 10, 2014 at 12:47:05PM +0200, Hans de Goede wrote:
> Note the sun4i-ts controller is capable of detecting a second touch, but =
when
> a second touch is present then the accuracy becomes so bad the reported t=
ouch
> location is not useable.
>=20
> The original android driver contains some complicated heuristics using the
> aprox. distance between the 2 touches to see if the user is making a pinch
> open / close movement, and then reports emulated multi-touch events around
> the last touch coordinate (as the dual-touch coordinates are worthless).
>=20
> These kinds of heuristics are just asking for trouble (and don't belong
> in the kernel). So this driver offers straight forward, reliable single
> touch functionality only.
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/sun4i.txt           |  15 ++
>  drivers/input/touchscreen/Kconfig                  |  10 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/sun4i-ts.c               | 262 +++++++++++++++=
++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/s=
un4i.txt
>  create mode 100644 drivers/input/touchscreen/sun4i-ts.c
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sun4i.tx=
t b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> new file mode 100644
> index 0000000..e45927e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sun4i.txt
> @@ -0,0 +1,15 @@
> +sun4i resistive touchscreen controller
> +--------------------------------------
> +
> +Required properties:
> + - compatible: "allwinner,sun4i-ts"

In between, I changed the compatible of this driver to sun4i-a10-ts to
match the pattern used everywhere else. You should probably update it
in your driver as well :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--O2lvLMQR9k8T/RyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTbhqHAAoJEBx+YmzsjxAgPz8P/20g2XCIRnM+xB4BtocGWe+2
oHhxsKNYOeqv/9ZwfycBnBVGjK+BrZzMZmwG5guKbfhgzuZDYWixSADUGokZS2fk
lwuzTao3debGnHNkqHJJ1MztnEgOXU53CCrCI7/5zHtBjwr+E9zbHfz7UHJGkTWJ
P+hXeeTvSyNDiiMJdZn7vxNVyHdqymjVWe4FMF7vzSiTbtX5otqRwvzaCmgNmJkN
TZHI7a4al7qmS35pPcL6EMIYlUuvZxirlBdokNcmkNTC1JCeNUBlCnZv3HI8MntM
J+Lp2CC6fLmZaxB/+UaMKNewilUKLLPj6G+G1A8g5UljLkg350ZV/G5J4fP0vKiP
Py/s/A6Lh4mBqqz0MK70jpHKYBk+Jyx3EB7dlHTrfClBwt6pAABmND42oX5wXHBc
TWHVKEcMwXw9I1bjNAgYgApPkbTxSpyZwHsA0sDyy187z5KyBeYCP/EliVckKB8s
2faCcL/JHPBEcW30vUZSOih6/mViA3b8X4YhlL6zEd5Oiu2YzI24m8V4pfgoDlet
KiUA/yW0ycr0vo+lqi4iuP5mn5yMIrbaMsf8B/aBMaa+yNkwczRvcvl9seg9woef
ddQXnAP10FRaS4flqq149Rh2QNlLKwlWgCusoTAF6tvuo+O2C5Vs4UMAQW6SK8pH
g6iwMMu5uE3sEZCkqSgo
=zJL3
-----END PGP SIGNATURE-----

--O2lvLMQR9k8T/RyB--
