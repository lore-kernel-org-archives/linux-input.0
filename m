From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch input driver
Date: Wed, 9 Sep 2009 16:15:28 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04B4C4C3@chinexm1.ad.analog.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com> <200909081149.28942.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com> <200909081929.57935.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B118A5@chinexm1.ad.analog.com> <8bd0f97a0909082305q632a4b30y3be36ce54ce9d509@mail.gmail.com> <0F1B54C89D5F954D8535DB252AF412FA04B4C3BE@chinexm1.ad.analog.com> <8bd0f97a0909090047s3510b0c5mb52380108bde64a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:51116 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZIIIPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 04:15:32 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909090047s3510b0c5mb52380108bde64a5@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

=20

>-----Original Message-----
>From: Mike Frysinger [mailto:vapier.adi@gmail.com]=20
>Sent: Wednesday, September 09, 2009 3:48 PM
>To: Song, Barry
>Cc: David Brownell; dmitry.torokhov@gmail.com;=20
>uclinux-dist-devel@blackfin.uclinux.org; linux-input@vger.kernel.org
>Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices=20
>AD714Xcaptouch input driver
>
>On Wed, Sep 9, 2009 at 03:15, Song, Barry wrote:
>>From: Mike Frysinger [mailto:vapier.adi@gmail.com]
>>>On Tue, Sep 8, 2009 at 23:33, Song, Barry wrote:
>>>> +static inline int ad714x_spi_register_driver(struct
>>>> spi_driver *spi_drv)
>>>> +{
>>>> + =A0 =A0 =A0 return spi_register_driver(spi_drv);
>>>> +}
>>>> +
>>>> +static inline void ad714x_spi_unregister_driver(struct
>>>spi_driver *spi_drv)
>>>> +{
>>>> + =A0 =A0 =A0 spi_unregister_driver(spi_drv);
>>>> +}
>>>> +
>>>> +#else
>>>> +#define ad714x_spi_register_driver(p) 0
>>>> +#define ad714x_spi_unregister_driver(p)
>>>> =A0#endif
>>>
>>>i dont think you need the ifdef protection that far up. =A0what abou=
t
>>>using the ifdef in this one place:
>>>static inline int ad714x_spi_register_driver(struct spi_driver
>>>*spi_drv)
>>>{
>>>#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
>>> =A0 =A0return spi_register_driver(spi_drv);
>>>#else
>>> =A0 =A0return 0;
>>>#endif
>>>}
>>>
>>>then i imagine you can have all the other pieces always enabled. =A0=
gcc
>>>will see that everything is marked static and not used, so it'll cul=
l
>>>things.
>>
>> In fact, I have tried to do like this before changing like I=20
>sent in the last mail. In fact, it will get compiling error if=20
>I always enable all spi and i2c functions without a #ifdef protection.
>> So since there are far #ifdef, I think it shoud be better to=20
>place related codes to existed #ifdef.
>
>i really have no idea what you're trying to say or why it=20
>didnt work for you
I guess you want to change like this:
- #if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE))
static int ad714x_spi_read(struct device *dev, unsigned short reg,=20
                unsigned short *data)
{
=2E..

static struct spi_driver ad714x_spi_driver =3D {
=2E..

static inline int ad714x_spi_register_driver(struct spi_driver *spi_drv=
)
{
#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
        return spi_register_driver(spi_drv);
#else
        return 0;
#endif
}

static inline void ad714x_spi_unregister_driver(struct spi_driver *spi_=
drv)
{
#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
        spi_unregister_driver(spi_drv);
#endif =20
}

- #endif

- #if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
static int ad714x_i2c_write(struct device *dev, unsigned short reg,=20
                unsigned short data)
{
=2E..

static struct i2c_driver ad714x_i2c_driver =3D {
=2E..

static inline int ad714x_i2c_add_driver(struct i2c_driver *i2c_drv)
{
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
        return i2c_add_driver(i2c_drv);
#else
        return 0;
#endif
}

static inline void ad714x_i2c_del_driver(struct i2c_driver *i2c_drv)
{
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
        i2c_del_driver(i2c_drv);
#endif
}
- #endif

static int __init ad714x_init(void)
{

        int ret =3D 0;
        ret =3D ad714x_spi_register_driver(&ad714x_spi_driver);
        if (ret)
                goto err;
        ret =3D ad714x_i2c_add_driver(&ad714x_i2c_driver);
        if (ret)
                ad714x_spi_unregister_driver(&ad714x_spi_driver);
err:
        return ret;
}

static void __exit ad714x_exit(void)
{
        ad714x_spi_unregister_driver(&ad714x_spi_driver);
        ad714x_i2c_del_driver(&ad714x_i2c_driver);
}

In fact, it can still cause link errors due to lost i2c/spi symbols if =
only spi/i2c enabled. It makes simple things too complex. So I think ke=
eping the=20
#if (defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE))
#if (defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE))
is better.
Since I don't delete the two far #ifdefs, I'd like to split spi/i2c reg=
ister/unregister definition to those #ifdef to cover them.
If you consider ad714x_spi_driver and ad714x_i2c_driver, field function=
s in them include internal i2c/spi symbols, which can cause link errors=
 too if the two variants are not protected by far #ifdef.=20

>-mike
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
