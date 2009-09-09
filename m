From: David Brownell <david-b@pacbell.net>
Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch input driver
Date: Tue, 8 Sep 2009 19:29:57 -0700
Message-ID: <200909081929.57935.david-b@pacbell.net>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com> <200909081149.28942.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp103.sbc.mail.gq1.yahoo.com ([67.195.15.62]:25784 "HELO
	smtp103.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751420AbZIIC34 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Sep 2009 22:29:56 -0400
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Song, Barry" <Barry.Song@analog.com>
Cc: Barry Song <21cnbao@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Tuesday 08 September 2009, Song, Barry wrote:
> I don't know what the exact meaning of "inlined NOP stubs", do you me=
an things like the following?
> #if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
> ...
> static struct i2c_driver ad714x_i2c_driver =3D {
> =A0 =A0 =A0 =A0 ..
> };

You _should_ be able to always declare that and let GCC
optimize it away ...


> static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
> {
> =A0 =A0 =A0 =A0 return i2c_add_driver(i2c_drv);
> }
> #else
> static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
> {
> =A0 =A0 =A0 =A0 return 0;
> }

That'd be OK as a quick fix; ideally i2c_add_driver() itself
would be what the #ifdef covers (in <linux/i2c.h> and likewise
in <linux/spi/spi.h>).  And you'd need to cover driver remove
paths too.


> #define ad714x_i2c_driver NULL

Ditto: shouldn't need to #define that


> #endif
>=20
> static int __init ad714x_init(void)
> {
> =A0=A0=A0=A0=A0=A0=A0=A0...
> =A0=A0=A0=A0=A0=A0=A0=A0ad714x_i2c_add_driver(&ad714x_i2c_driver);

Yes; but do check the value!

> =A0=A0=A0=A0=A0=A0=A0=A0...
> }
>=20
> Then ad714x_init can use a unified ad714x_i2c_add_driver,
> ad714x_spi_register_driver to avoid #ifdeffery used?=20
> It seems that doesn't make the codes more pretty?

Way less #ifdeffery and *ONE* non-#ifdeffed chunk of
code in driver init/exit code.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
