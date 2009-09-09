From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch input driver
Date: Wed, 9 Sep 2009 10:59:55 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04B11818@chinexm1.ad.analog.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com> <200909081149.28942.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com> <200909081929.57935.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:61640 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbZIIC76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 22:59:58 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <200909081929.57935.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com
Cc: Barry Song <21cnbao@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

=20

>-----Original Message-----
>From: David Brownell [mailto:david-b@pacbell.net]=20
>Sent: Wednesday, September 09, 2009 10:30 AM
>To: Song, Barry
>Cc: Barry Song; uclinux-dist-devel@blackfin.uclinux.org;=20
>linux-input@vger.kernel.org
>Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices=20
>AD714Xcaptouch input driver
>
>On Tuesday 08 September 2009, Song, Barry wrote:
>> I don't know what the exact meaning of "inlined NOP stubs",=20
>do you mean things like the following?
>> #if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
>> ...
>> static struct i2c_driver ad714x_i2c_driver =3D {
>> =A0 =A0 =A0 =A0 ..
>> };
>
>You _should_ be able to always declare that and let GCC
>optimize it away ...
>
>
>> static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
>> {
>> =A0 =A0 =A0 =A0 return i2c_add_driver(i2c_drv);
>> }
>> #else
>> static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
>> {
>> =A0 =A0 =A0 =A0 return 0;
>> }
>
>That'd be OK as a quick fix; ideally i2c_add_driver() itself
>would be what the #ifdef covers (in <linux/i2c.h> and likewise
>in <linux/spi/spi.h>).  And you'd need to cover driver remove
>paths too.
>
>
>> #define ad714x_i2c_driver NULL
>
>Ditto: shouldn't need to #define that
>
>
>> #endif
>>=20
>> static int __init ad714x_init(void)
>> {
>> =A0=A0=A0=A0=A0=A0=A0=A0...
>> =A0=A0=A0=A0=A0=A0=A0=A0ad714x_i2c_add_driver(&ad714x_i2c_driver);
>
>Yes; but do check the value!
>
>> =A0=A0=A0=A0=A0=A0=A0=A0...
>> }
>>=20
>> Then ad714x_init can use a unified ad714x_i2c_add_driver,
>> ad714x_spi_register_driver to avoid #ifdeffery used?=20
>> It seems that doesn't make the codes more pretty?
>
>Way less #ifdeffery and *ONE* non-#ifdeffed chunk of
>code in driver init/exit code.
=46ixed
>
>- Dave
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
