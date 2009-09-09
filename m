From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch input driver
Date: Wed, 9 Sep 2009 10:11:06 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com> <200909081149.28942.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:41609 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZIICLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 22:11:10 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <200909081149.28942.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

=20

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org=20
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On=20
>Behalf Of David Brownell
>Sent: Wednesday, September 09, 2009 2:49 AM
>To: Barry Song
>Cc: uclinux-dist-devel@blackfin.uclinux.org;=20
>linux-input@vger.kernel.org
>Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices=20
>AD714Xcaptouch input driver
>
>On Tuesday 08 September 2009, Barry Song wrote:
>> +static int __init ad714x_init(void)
>> +{
>> +#if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)) && \
>> +=A0=A0=A0=A0=A0=A0=A0!(defined(CONFIG_I2C) || defined(CONFIG_I2C_MO=
DULE))
>> +=A0=A0=A0=A0=A0=A0=A0return spi_register_driver(&ad714x_spi_driver)=
;
>> +#endif
>> +
>> +#if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)) =A0&& \
>> +=A0=A0=A0=A0=A0=A0=A0!(defined(CONFIG_SPI) || defined(CONFIG_SPI_MO=
DULE))
>> +=A0=A0=A0=A0=A0=A0=A0return i2c_add_driver(&ad714x_i2c_driver);
>> +#endif
>> +
>> +#if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)) && \
>> +=A0=A0=A0=A0=A0=A0=A0(defined(CONFIG_I2C) || defined(CONFIG_I2C_MOD=
ULE))
>> +=A0=A0=A0=A0=A0=A0=A0int ret =3D 0;
>> +=A0=A0=A0=A0=A0=A0=A0ret =3D spi_register_driver(&ad714x_spi_driver=
);
>> +=A0=A0=A0=A0=A0=A0=A0if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err;
>> +=A0=A0=A0=A0=A0=A0=A0ret =3D i2c_add_driver(&ad714x_i2c_driver);
>> +=A0=A0=A0=A0=A0=A0=A0if (ret)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spi_unregister_driver(=
&ad714x_spi_driver);
>> +err:
>> +=A0=A0=A0=A0=A0=A0=A0return ret;
>> +#endif
>> +}
>
>Ugly and error prone.
>You should have only one block of code not four ...
>
>Absolutely the cleanest solution adds inlined NOP stubs
>for I2C and SPI driver register/unregister calls, and
>gets rid of all that #ifdeffery; there are other solutions.
>
The aim is that the module can work at:
1. only spi bus enabled (probe spi devices)
2. only i2c bus enabled (probe i2c devices)
3. both spi and i2c bus enabled. (probe both i2c/spi devices)
So the module depends on SPI || I2C not SPI && I2C. I used the  #ifdeff=
ery to avoid compiling error due to symbols losing of I2C or SPI while =
kernel configuration doesn't enable both SPI and I2C. If kernel only en=
ables one of the two buses, the driver only probes the enabled bus.

I don't know what the exact meaning of "inlined NOP stubs", do you mean=
 things like the following?
#if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
=2E..
static struct i2c_driver ad714x_i2c_driver =3D {
        .driver =3D {
                .name =3D "ad714x_captouch",
        },  =20
        .probe    =3D ad714x_i2c_probe,
        .remove   =3D __devexit_p(ad714x_i2c_remove),
        .suspend  =3D ad714x_i2c_suspend,
        .resume   =3D ad714x_i2c_resume,
        .id_table =3D ad714x_id,
};

static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
{
        return i2c_add_driver(i2c_drv);
}
#else
static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
{
        return 0;
}
#define ad714x_i2c_driver NULL
#endif

static int __init ad714x_init(void)
{
	...
	ad714x_i2c_add_driver(&ad714x_i2c_driver);
	...
}

Then ad714x_init can use a unified ad714x_i2c_add_driver, ad714x_spi_re=
gister_driver to avoid #ifdeffery used?
It seems that doesn't make the codes more pretty?

>
>
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
