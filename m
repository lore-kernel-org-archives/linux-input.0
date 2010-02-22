From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Mon, 22 Feb 2010 11:03:00 +0200
Message-ID: <201002221103.13677.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002220058.52583.anarsoul@gmail.com>
	<20100222071403.GD2095@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1611219375=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100222071403.GD2095@core.coreip.homeip.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: arhuaco@freaks-unidos.net, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--===============1611219375==
Content-Type: multipart/signed;
  boundary="nextPart2325899.hoH3MnAiSK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2325899.hoH3MnAiSK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
22 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 09:14:03 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> +               /* Reset WAIT4INT state */
> +               writel(0, ts.io + S3C2410_ADCTSC);

That's wrong, should be writel(S3C2410_ADCTSC_PULL_UP_DISABLE | AUTOPST, ts=
=2Eio=20
+ S3C2410_ADCTSC), anyway it doesn't work even with this fix

> -               if (pen_is_down)
> +               if (pen_is_down) {
> +                       /* Reset WAIT4INT state */
> +                       writel(0, ts.io + S3C2410_ADCTSC);

Same note.

Regards
Vasily

--nextPart2325899.hoH3MnAiSK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuCSFEACgkQRM6pQpltKE4pvwCggHmCJ+Rq41iE1qlwf2PYNOeB
4pgAmwWwtWxeC73PTh4Dhaee6ZAmOXkq
=dtsi
-----END PGP SIGNATURE-----

--nextPart2325899.hoH3MnAiSK--


--===============1611219375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1611219375==--
