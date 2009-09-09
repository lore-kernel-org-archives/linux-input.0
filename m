From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch input driver
Date: Wed, 9 Sep 2009 11:33:44 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04B118A5@chinexm1.ad.analog.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com> <200909081149.28942.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com> <200909081929.57935.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:46074 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbZIIDeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 23:34:07 -0400
Content-Class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Song, Barry" <Barry.Song@analog.com>, David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com
Cc: Barry Song <21cnbao@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

=20

>-----Original Message-----
>From: Song, Barry=20
>Sent: Wednesday, September 09, 2009 11:00 AM
>To: 'David Brownell'; 'dmitry.torokhov@gmail.com'
>Cc: Barry Song; uclinux-dist-devel@blackfin.uclinux.org;=20
>linux-input@vger.kernel.org
>Subject: RE: [Uclinux-dist-devel] [PATCH v2]add analog devices=20
>AD714Xcaptouch input driver
>
>=20
>
>>-----Original Message-----
>>From: David Brownell [mailto:david-b@pacbell.net]=20
>>Sent: Wednesday, September 09, 2009 10:30 AM
>>To: Song, Barry
>>Cc: Barry Song; uclinux-dist-devel@blackfin.uclinux.org;=20
>>linux-input@vger.kernel.org
>>Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices=20
>>AD714Xcaptouch input driver
>>
>>On Tuesday 08 September 2009, Song, Barry wrote:
>>> I don't know what the exact meaning of "inlined NOP stubs",=20
>>do you mean things like the following?
>>> #if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
>>> ...
>>> static struct i2c_driver ad714x_i2c_driver =3D {
>>> =A0 =A0 =A0 =A0 ..
>>> };
>>
>>You _should_ be able to always declare that and let GCC
>>optimize it away ...
Even though I can always declare it, the functions in ad714x_i2c_driver=
 still access i2c symbols.
=46or that, I still need to use #ifdef to make the compiling pass.
>>
>>
>>> static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
>>> {
>>> =A0 =A0 =A0 =A0 return i2c_add_driver(i2c_drv);
>>> }
>>> #else
>>> static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
>>> {
>>> =A0 =A0 =A0 =A0 return 0;
>>> }
>>
>>That'd be OK as a quick fix; ideally i2c_add_driver() itself
>>would be what the #ifdef covers (in <linux/i2c.h> and likewise
>>in <linux/spi/spi.h>).  And you'd need to cover driver remove
>>paths too.
>>
>>
>>> #define ad714x_i2c_driver NULL
>>
>>Ditto: shouldn't need to #define that
Even though GCC can optimize unused variants/functions, there are still=
 compiling error since field functions of ad714x_i2c_driver/ad714x_spi_=
driver and other functions will access other spi/i2c symbols.
So maybe the best fix is:
Index: ad714x.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ad714x.c    (revision 7274)
+++ ad714x.c    (working copy)
@@ -1478,9 +1478,22 @@
        .suspend        =3D ad714x_spi_suspend,
        .resume         =3D ad714x_spi_resume,
 };
+
+static inline int ad714x_spi_register_driver(struct spi_driver *spi_dr=
v)
+{
+       return spi_register_driver(spi_drv);
+}
+
+static inline void ad714x_spi_unregister_driver(struct spi_driver *spi=
_drv)
+{
+       spi_unregister_driver(spi_drv);
+}
+
+#else
+#define ad714x_spi_register_driver(p) 0
+#define ad714x_spi_unregister_driver(p)
 #endif
=20
-
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int ad714x_i2c_write(struct device *dev, unsigned short reg,
                unsigned short data)
@@ -1595,43 +1608,40 @@
        .resume   =3D ad714x_i2c_resume,
        .id_table =3D ad714x_id,
 };
+
+static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
+{
+       return i2c_add_driver(i2c_drv);
+}
+
+static inline void ad714x_i2c_del_driver(struct i2c_driver *i2c_drv)
+{
+       i2c_del_driver(i2c_drv);
+}
+
+#else
+#define ad714x_i2c_add_driver(p) 0
+#define ad714x_i2c_del_driver(p)
 #endif

 static int __init ad714x_init(void)
 {
-#if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)) && \
-       !(defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
-       return spi_register_driver(&ad714x_spi_driver);
-#endif

-#if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))  && \
-       !(defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE))
-       return i2c_add_driver(&ad714x_i2c_driver);
-#endif
-
-#if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)) && \
-       (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
        int ret =3D 0;
-       ret =3D spi_register_driver(&ad714x_spi_driver);
+       ret =3D ad714x_spi_register_driver(&ad714x_spi_driver);
        if (ret)
                goto err;
-       ret =3D i2c_add_driver(&ad714x_i2c_driver);
+       ret =3D ad714x_i2c_add_driver(&ad714x_i2c_driver);
        if (ret)
-               spi_unregister_driver(&ad714x_spi_driver);
+               ad714x_spi_unregister_driver(&ad714x_spi_driver);
 err:
        return ret;
-#endif
 }

 static void __exit ad714x_exit(void)
 {
-#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
-       spi_unregister_driver(&ad714x_spi_driver);
-#endif
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-       i2c_del_driver(&ad714x_i2c_driver);
-#endif
+       ad714x_spi_unregister_driver(&ad714x_spi_driver);
+       ad714x_i2c_del_driver(&ad714x_i2c_driver);
 }

 module_init(ad714x_init);
>>
>>
>>> #endif
>>>=20
>>> static int __init ad714x_init(void)
>>> {
>>> =A0=A0=A0=A0=A0=A0=A0=A0...
>>> =A0=A0=A0=A0=A0=A0=A0=A0ad714x_i2c_add_driver(&ad714x_i2c_driver);
>>
>>Yes; but do check the value!
>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0...
>>> }
>>>=20
>>> Then ad714x_init can use a unified ad714x_i2c_add_driver,
>>> ad714x_spi_register_driver to avoid #ifdeffery used?=20
>>> It seems that doesn't make the codes more pretty?
>>
>>Way less #ifdeffery and *ONE* non-#ifdeffed chunk of
>>code in driver init/exit code.
>Fixed
>>
>>- Dave
>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
