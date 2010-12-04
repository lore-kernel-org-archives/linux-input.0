From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH 0/4] Add new wmi support to acer-wmi driver
Date: Sat, 4 Dec 2010 09:08:47 -0200
Message-ID: <20101204110847.GA30435@barata.holoscopio.com>
References: <1291424606-23383-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291424606-23383-1-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: mjg@redhat.com, carlos@strangeworlds.co.uk, corentin.chary@gmail.com, dmitry.torokhov@gmail.com, corentincj@iksaif.net, tiwai@novell.com, mjg59@srcf.ucam.org, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2010 at 09:03:22AM +0800, Lee, Chun-Yi wrote:
> Hi Matthew,=20
>=20
> These patches add new wmi support to acer-wmi driver, included the follow=
ing
> functions:
>=20
> - Acer wmi hotkey events:
>   Acer BIOS applied wmi hotkey events from 2010, this patch adds support.
>=20
> - Enabled Acer Launch Manager mode:
>   Directly enable it to avoid the raw EC behavior conflict with rfkill-in=
put or
>   userland solution.
>=20
> - Add 3G rfkill sysfs file:
>   Provide interface to userland for enable/disable 3G function by wmi met=
hod.
>=20
> - Detect the WiFi/Bluetooth/3G devices available:
>   Look for OEM type AAh in dmi to get the WiFi/BT/3G devices available.
>=20

Please, add a subsystem/driver prefix to the summary like:

acer-wmi: Add 3G rfkill sysfs file.

Otherwise, any person reading summaries will ask perself: adding such
file to what!?!

Regards,
Cascardo.

> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> Reviewed-by: Thomas Renninger <trenn@suse.de>
>=20
> Lee, Chun-Yi (4):
>   Add acer wmi hotkey events support
>   Enabled Acer Launch Manager mode
>   Add 3G rfkill sysfs file
>   Detect the WiFi/Bluetooth/3G devices available
>=20
>  drivers/platform/x86/Kconfig    |    2 +
>  drivers/platform/x86/acer-wmi.c |  400 +++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 394 insertions(+), 8 deletions(-)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe platform-driver=
-x86" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJM+iE8AAoJEEWxSg7udFZIVnsQAO4axVOXPaGQU2uKaAnwtrO3
ipb1Xc0XTrAAtan4LApJfTtWK+4MVhvOBiW07LzEeAwXka7w/ID69adOiQLTuJPF
SwzdVggcPrEAsxi934rY2o+Hesw8T54Lyy37cg7wn/WlxnQzfC6OM+zS1ERbRGJq
MOZLBKs2nkkOPoKCq37a1dSYUa3JOM7XGuTb+CfQx/99a/GDcVmVNM+obp+cK8Df
cibgHJR4OLFVT+3c/9eRzkTNDI4MDgjtG1a0QAXPmp5xBqGhukjb3e6TeCm/vPVP
cn17LR0jevUxel/UJoZcnAcz9A/HeMGZt61NJnwJkuSupXBthI7SVXeHMRbcIuQq
qd7IytrfZun+vA2UZCzHCpgQRFd8I1LlnblPrPHpjqD6PGgqKIgHuYSbBtQ2HF77
RQkBUAF/SIUgX4/iUJoRtimpfPBdf+sD13R9zH3nvr7vnDL4zprHX7/yHqPqQhMw
NNqMrXyk7zpxopI4KfEXdJP6Vp6O6d+oIz8cupCJ015x6oZwiH1ITbES5JTVSEvy
Gj2eCoh2cgJIcMcilSUci3zNS3mp7b8Bju+wCqrKKzzCPXxyfKbDBECtVnEN21K2
NtkCxNI6yKHNOYhFeZ1EkvM//BCjhMnm2zo3f7r47DgmH13rszS5wa7v3orKvMYK
hXFIjMySJvx0nOcsstYA
=y0aI
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
