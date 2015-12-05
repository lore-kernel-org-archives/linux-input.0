From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH V2] goldfish: add goldfish match node for dt driver probe
Date: Sat, 5 Dec 2015 02:13:13 +0100
Message-ID: <20151205011313.GG22936@earth>
References: <1446793960-31946-1-git-send-email-yalin.wang2010@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0875441721841202840=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1446793960-31946-1-git-send-email-yalin.wang2010@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: yalin wang <yalin.wang2010@gmail.com>
Cc: somyaanand214@gmail.com, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, peter.senna@gmail.com, dbaryshkov@gmail.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, dmitry.torokhov@gmail.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, jslaby@suse.com, joe@perches.com, ricardo.ribalda@gmail.com, plagnioj@jcrosoft.com, dwmw2@infradead.org, dan.carpenter@oracle.com, alan@linux.intel.com
List-Id: linux-input@vger.kernel.org


--===============0875441721841202840==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Nov 06, 2015 at 03:12:40PM +0800, yalin wang wrote:
> qemu use device tree to bootup linux kernel,
> we need add device node match table to plaftorm driver,
> so that can probe the goldfish driver correctly.
> test by this qemu:
> git clone https://android.googlesource.com/platform/external/qemu

Your patch is missing the DT binding documentation part and should
be splitted into multiple patches, at least one per kernel
subsystem. Please read Documentation/SubmittingPatches and
Documentation/devicetree/bindings/submitting-patches.txt

-- Sebastian

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYjomAAoJENju1/PIO/qaHQsQAI/AIwC2MCMhFGGeq1m/pAdF
3Fds1Lo4ltPWWfrzr+0q2Mu2e4IgwFBtNXFr9vcDBx/6Cg/SrZhbJvT7Kb1Yd4JU
qfuoa1gk66/viuq42Nu/OxMUBrJvYzw2reUK6c97J//pJVBvlictEuU4g+idvJSB
s26XcFm0HAO8rsA1oHYV/H51GwfN2XloqPxy6FFYbxPzCyoV2q+SeDHTxD0AtgHY
S62tZkxBA9z7wuI2Hbfoy7mUIg/27ljG7ukov7s2c8tOtqK76/DiJLR4+T/KKBGn
JB1nef0JYhEuZHn4iFKY4b6A1Uc//fn7FQLmGg3dxGF8QhLJQTDKGhSfzmZih8Q4
df7u4pRnJ9gxDDmAxhJVAxqL0UO6zsNT4MeArKER7LJVAkN0Owi/IAGh4y+r2lpm
GRZMLQaiG+xsFH4MkiPPCKC6aeFXGkmZH0lWy1i2LBeW5VyaBeA2gGrm4pGseRHt
qCHRzVaab3qgRqGfX0GWR18kglxqi9ehqly0ql6OXHIWBWkBtiP7e68+4ec06kBK
S0h2158H5Y55JtE3wPoPnFXaI86t+/+dyNBadaFzOe6+0eoCprVJ3ZUO6NpKCmDC
LXwNcoi2MGEK+rUyXBWYx65w2RkD6sLyGsXPpiU1ETKsqofcQc8fNTkYbjXnfwee
fyDuL7Rgz0fWClJtap9T
=Cu8J
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--

--===============0875441721841202840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============0875441721841202840==--
