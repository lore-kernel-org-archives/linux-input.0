From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Sun, 21 Feb 2010 11:05:26 +0200
Message-ID: <201002211105.30079.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002191202.16384.anarsoul@gmail.com>
	<20100221073512.GA18298@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2046870835=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100221073512.GA18298@core.coreip.homeip.net>
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
Cc: ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--===============2046870835==
Content-Type: multipart/signed;
  boundary="nextPart3862446.zAETh1Vzbs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3862446.zAETh1Vzbs
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
21 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 09:35:13 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> Applied, thank you Vasily.
>=20
> One more thing though - why do we need that timer to report input events
> and reschedule ADC conversions? It looks like it is not really needed.
> Could you please give a try to the patch below?
>=20
> Thanks!

Timer is used to avoid reporting input events in interrupt context (select=
=20
callback is called from s3c_adc_try and from s3c_adc_irq), Is it safe to ca=
ll=20
input_report_abs/input_report_key from interrupt context? Anyway, driver=20
doesn't work for me with this patch (it works as mouse, but it doesn't as=20
touchscreen through tslib)

Regards,
Vasily

--nextPart3862446.zAETh1Vzbs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuA91oACgkQRM6pQpltKE5NbwCeL8ZiaJnlEPBIsKOhJyD9lru2
M94An1T+kKUHltC4Xi23MyXrmCshWMV6
=7c/W
-----END PGP SIGNATURE-----

--nextPart3862446.zAETh1Vzbs--


--===============2046870835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2046870835==--
