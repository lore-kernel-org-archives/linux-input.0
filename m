From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: touchscreen: edt-ft5x06: Prevent DMA driver from mapping an area
 on stack
Date: Sat, 12 Dec 2015 18:13:55 +0100
Message-ID: <20151212171355.GA7362@katana>
References: <e0311a5e79a315814e8678c9ef4a32563c01d1e0.1449913392.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0311a5e79a315814e8678c9ef4a32563c01d1e0.1449913392.git.maitysanchayan@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, maxime.ripard@free-electrons.com, stefan@agner.ch
List-Id: linux-input@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Frankly speaking I do not know where the fix should actually be. I2C IMX
> driver somehow taking care of this or the users of I2C, touchscreen drivers
> in this case. In my opinion, the fix should be with the touchscreen driver
> however I did like to have feedback or hear opinions on what is the accepted
> solution to this.

There is no accepted solution to this yet :( DMA is/was still too rare for
a serious discussion about this. There is also [1] and probably more...

[1]  http://patchwork.ozlabs.org/patch/220137/

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbFXTAAoJEBQN5MwUoCm2JCcP/jyAd6I4vbr4U52qIUYv+VRM
4Qx7hd9oVfWCnUpiVHkJDmKIdD8vanwPsWhpOBAPhzftIHGAxUzFL6bcb2t5+CEk
w+vTMeO7HDad2r/1134do7/sr896U3iyqaXrar4hHxh+nvo7lmXnnebw7R5o2DJ9
7uz0IorL/6NTEhzGF+Gsco7DvmKwnEbuZQTQnF1gkCdN9nZE7Nxiih8g35Sz92E5
sGVPA6ZOeW0vv4iP+RdfG0XDv6OnPWnGP4rxZKsUIGPMlbm21Ba4SiT0v/y+fbc4
n/R7A+nvUBholzvvkhxUS8f23wIZ+hhSsD7eeS4l3bfTnJcXszoZR9HXvS644Lmu
3m6tOKV43SW7IQXWH5+EH4ii+wqWVswT7vMp1g9LyTN76fQYypTcbqIA3XXELXOe
nQlrK/yHVbSR5xw/+6YaLKpP+tfzF0MhXvXnG2hIRxqFNKVToq3gFRV5iPcDkgd8
mMo0ZELnQMcJuNzNR4ENDS+1gIBlpssb9cxNdwpnaFlwnWXs5DSaj8NOlQ9fIcpv
MIEJ/YCCirSWuDz4eZwPNgX8mgaHHQ31/fp4n/KWcauQ8ezdBxkdW0uSxZtmOiYd
9kHsGrX70T2mFMHa+VhdfHZADYvOWU5oy0IR0C9qNNFVw0m3UpThy0FmUlMmjaGa
viFaqunGmWvbmEBWLE1H
=ca9L
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
