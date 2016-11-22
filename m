From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/9] AC97 device/driver model revamp
Date: Tue, 22 Nov 2016 18:13:17 +0000
Message-ID: <20161122181317.jcyhcyorxgpp6w3m@sirena.org.uk>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0576043004976886590=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org


--===============0576043004976886590==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xaxrk4mep5322mmb"
Content-Disposition: inline


--xaxrk4mep5322mmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2016 at 09:41:38PM +0200, Robert Jarzmik wrote:

> The driving ideas are still the same, and I put them in [1] for memory. This is
> the first post RFC submission. In order to make a full demonstration of the
> framework, wm97xx was converted to an MFD, see [2] for the "why".

This all looks nice to me, I did spot a few things but I don't think I
had anything that wasn't already raised by someone else so didn't repeat
them.  Thanks for stepping up and doing this work!

--xaxrk4mep5322mmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNIq8AAoJECTWi3JdVIfQMjgH/je+KeOstLfSW2OjUoKyRn7y
CYdl68cdRkRygHfPUIZio/QXlpxbqKDl9VYmGXAvDWpad5MyRDVZjDlPm3JtflgP
2ug3nn01Jw0NeE1kD3pgJBQi7ghg3XExXwMlCv7qawo4kQQIhUUgQFY8lQD6Bwal
Hku9hddeFQCpuNwlx3Rekd5VXm6X7x8NkPgSrHJVOJRogmmwbzBPVu4ONhR24oCK
RSx2p/7cedwlkCKVEisd6zRKIcQJgmJHhQQjzc3A+n6foEM7GWnM6h5oP9S1nxVk
kD9RxstanRPNTg06bIWlgXq1iAAaavhZJQG3wWoSyWr1dtNvWiMST/az9j3HcAo=
=lGWW
-----END PGP SIGNATURE-----

--xaxrk4mep5322mmb--


--===============0576043004976886590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0576043004976886590==--
