From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 408/493] input: remove use of __devexit
Date: Tue, 20 Nov 2012 15:49:22 +0900
Message-ID: <20121120064920.GQ10560@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-408-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="glwmnIOgU1tcuP7N"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353349642-3677-408-git-send-email-wfp5p@virginia.edu>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, device-drivers-devel@blackfin.uclinux.org, Wan ZongShun <mcuos.com@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, Miloslav Trmac <mitr@volny.cz>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--glwmnIOgU1tcuP7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:25:57PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--glwmnIOgU1tcuP7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqyfqAAoJELSic+t+oim9sLMQAI46bZMkpSRacdpHfcoEQLxe
aVOkus0nYCr4GygsorxRKciw0iYA/3Q44NQn8X8EFF7e8b1LhXOM0mRnHcEHBf8h
4i5wQ49Nh5xMNcqVbHj6flPulYmMxRwWLx+heKs9YaxEbOr7NNF2l9GtEGnpCDDt
Zk5d/2fCC/uCv1gNfDzGLSBUXD6KeToTTLADTVxYDISYuHRlf8huAncFIhCh/jAC
1AKjk4nLx5WQ6IwvliRjgEppShbk/tFMyBd1hFJ2cgXHXTzcElS27rt2dDoBJINY
dtKOW4Tr3r1Mq5TcWxo83PLYDBu4dXXGbsKW+EOu66vxEMcrKuFgGj/AkZaXs+ZY
gBNPGQtWbS3ZQOakS19O4jUc9QmtBGOek+oPAAszjvbfgVSYrrfgZ69E1Bwbuo7T
icTKp22LBPm1a9HFiN/ofcbUBE1NRDcdGQTicXlY40ROSpQtE9n+6NBtznKRLi36
3GZn2kKOZSb+zd8eDHkVDTwSVYMWUSpjWnSSR+g6EgPbzHFip6v4NDGrWdrxYNgJ
NQRHizDRL1pKWVrR5a520KEOaGtg1eRd+5q5lIUuO6xZA1mOICD1t+Li3dX2+n98
zqBnzvTcRFlr7E5cJvSYkFYEou4kwvZSmpXXV3+8N4oWuNh4o7Jo99bYLk8KFhEF
8ZWii9Vz9PT3QFum2N3M
=TTSn
-----END PGP SIGNATURE-----

--glwmnIOgU1tcuP7N--
