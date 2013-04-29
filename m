From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Convert to
 devm_input_allocate_device()
Date: Mon, 29 Apr 2013 21:01:28 +0100
Message-ID: <20130429200128.GC3270@sirena.org.uk>
References: <CALq1K=+sJUZ++_sMkU1Sg9+aE-HpF1tnfPHGCEJ789hj19Yp9A@mail.gmail.com>
 <20130425125234.GV5019@opensource.wolfsonmicro.com>
 <CALq1K=+ViDvsCZDR5KndX-T1Dt6tghPjiP7F6wm+npYOw2DE1A@mail.gmail.com>
 <20130428094745.GA5877@sirena.org.uk>
 <CALq1K=+=J9oPGvbrXuhS=Bgqj+viC5EAkTHKkNuHxBadExpXdA@mail.gmail.com>
 <20130429101959.GE5019@opensource.wolfsonmicro.com>
 <CALq1K=KGrDJZa_w_ZVdriptpiKsWvwYDcx3aV3oVXMyTxMjcqg@mail.gmail.com>
 <20130429180727.GA3915@core.coreip.homeip.net>
 <20130429181903.GB3915@core.coreip.homeip.net>
 <CALq1K=+4bz0RtuxK=sOEr_k1y2e5x67oUFbo8T7cs0t2vX+54Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8538318026085710564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CALq1K=+4bz0RtuxK=sOEr_k1y2e5x67oUFbo8T7cs0t2vX+54Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches <patches@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--===============8538318026085710564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2013 at 09:52:34PM +0300, Leon Romanovsky wrote:

> Mark, please take my apologies, I was mislead by the following comment
> on the code:

No problem, thanks for taking the time to check into this.

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRftGVAAoJELSic+t+oim955gP/2jmeKUH3IDywdkr8NKYGVUb
2NpH0pNGiO1j9fO2W7BjncdUt83YkwbXZXtf9GWCNlnZIwuDc+NWhCSlI6JbRFLm
Dp2254q1xhre1tq7QPYbDYmLx1Ujg55vms3w7orhoKFy5Hizunb4k0U5kMD19UoU
KdmQarL7BSw9wjU9OxLikIa6blkS5t+5WgQapW52O2fxpnqq5ojJD3yI5b6nK/ZK
Ku3ZLKzrTWsmQ+YEZ2GgPXb7c/rWdN+ZJ792Cev7sMAScMJmVipBkGep9sGnaKsE
fzkWdRH3s8zoj+GU3xuyYWnnDKWTET75OEnc/bkdX1ZMtTPFcZGTX3Q1ccvDa+XM
myUgSXsqtx+uusUXMlIARIoy4/4i3zbzB90Yn4Ij9TOoG8Qm4RgWC2Cu6L56Y/f7
IBbAR/AyPmjUXXDGJvgdc2YZ8FrHRGIgiFdKnpP8hRxKA6KTx2HnchUmQz46lxbW
BgOBTXPAlY8T/HuwK3CuvqYC1VTTczuqxJt56DWClqiJCgrNgSiSa8Rlk8dQKxXQ
XRCSoowmlbV+KZk+OvXAcWY5vEshSv+XkzFJHP8ZfqWLXUfSDLUBGLk8Q/qqGTrj
lFjSx9FvAJMBUzN1pTQIrXaZvTrm6z49KjllVSVjepWLn3YhK7xXEdc/rDytc/YB
90ll9OFWW3+y28aXupMf
=9N/0
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--

--===============8538318026085710564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8538318026085710564==--
