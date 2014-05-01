From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
Date: Thu, 1 May 2014 02:16:27 +0000
Message-ID: <08914164-8CE6-4170-BC21-9E2840FFA05E@cirrus.com>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>,
 <20140501013103.GK3245@sirena.org.uk>
 <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0457325830235571781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <13D36045-EE68-418B-983B-2704C52391E3@cirrus.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, "arnd@arndb.de" <arnd@arndb.de>, Sangbeom Kim <sbkim73@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Timur Tabi <timur@tabi.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Xia Kaixu <kaixu.xia@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org

--===============0457325830235571781==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_8BADDBDF-DC81-44DD-AFC5-FABB77EAC2F0";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_8BADDBDF-DC81-44DD-AFC5-FABB77EAC2F0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On Apr 30, 2014, at 8:54 PM, Austin, Brian <Brian.Austin@cirrus.com> =
wrote:

>=20
>=20
>> On Apr 30, 2014, at 20:31, "Mark Brown" <broonie@kernel.org> wrote:
>>=20
>>> On Tue, Apr 29, 2014 at 09:31:30PM -0500, Brian Austin wrote:
>>>=20
>>> I assume you mean the CS42L52 instead of the L51. INPUT is used for =
a BEEP
>>> Generator but when I disable CONFIG_INPUT I do not get an error. Is =
there
>>> any information available on what the error is?
>>=20
>> I suspect it's ASoC built in and INPUT build as a module.
> Ok, I'll try that next.
> Doesn't IS_ENABLED cover that?
Apparently not.
I would like to come up with a better solution than making INPUT a =
requirement. I just need some time.
In the meantime I suppose it=92s OK to apply it?=20

--Apple-Mail=_8BADDBDF-DC81-44DD-AFC5-FABB77EAC2F0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTYa56AAoJEHdXZdGWfiO75eUH/2wC5eynvf3HIrcEfjHgrXS/
bZgi2r31Mp9wlvgmdLXj4gPgYs6kNIiHM/xMkcP9jnvCallm14WhdZMqy23gEult
40nwiLrJOp5VGTTQl5l5s0XWhG9J1WR1AI1g2mPKw0+6b1Sw1dOf0mOLzppGy8/6
jWRnGb6KULv1aXZJPkDUtl+z8h9E1s6F5TN10eFcONOxBLrFtyEl++obURdBgb/R
YW7QMDmf1cXl7ubuqG6Il2nbZQ6CPzJCcIInrWiHLYTjUDwstdijhvSfJcGoTwjO
7ppEyPmildJbE5mKBZyyq7BwhxDFLc4A33EN6Sk14NBWTb5LlGvhjHyJs6vmq7E=
=wNJa
-----END PGP SIGNATURE-----

--Apple-Mail=_8BADDBDF-DC81-44DD-AFC5-FABB77EAC2F0--

--===============0457325830235571781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0457325830235571781==--
