From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch input driver
Date: Wed, 9 Sep 2009 15:15:51 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04B4C3BE@chinexm1.ad.analog.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com> <200909081149.28942.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com> <200909081929.57935.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B118A5@chinexm1.ad.analog.com> <8bd0f97a0909082305q632a4b30y3be36ce54ce9d509@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:2601 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbZIIHQe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 03:16:34 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909082305q632a4b30y3be36ce54ce9d509@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

=20

>-----Original Message-----
>From: Mike Frysinger [mailto:vapier.adi@gmail.com]=20
>Sent: Wednesday, September 09, 2009 2:06 PM
>To: Song, Barry
>Cc: David Brownell; dmitry.torokhov@gmail.com;=20
>uclinux-dist-devel@blackfin.uclinux.org; linux-input@vger.kernel.org
>Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices=20
>AD714Xcaptouch input driver
>
>On Tue, Sep 8, 2009 at 23:33, Song, Barry wrote:
>> +static inline int ad714x_spi_register_driver(struct=20
>spi_driver *spi_drv)
>> +{
>> + =A0 =A0 =A0 return spi_register_driver(spi_drv);
>> +}
>> +
>> +static inline void ad714x_spi_unregister_driver(struct=20
>spi_driver *spi_drv)
>> +{
>> + =A0 =A0 =A0 spi_unregister_driver(spi_drv);
>> +}
>> +
>> +#else
>> +#define ad714x_spi_register_driver(p) 0
>> +#define ad714x_spi_unregister_driver(p)
>> =A0#endif
>
>i dont think you need the ifdef protection that far up.  what about
>using the ifdef in this one place:
>static inline int ad714x_spi_register_driver(struct spi_driver=20
>*spi_drv)
>{
>#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
>    return spi_register_driver(spi_drv);
>#else
>    return 0;
>#endif
>}
>
>then i imagine you can have all the other pieces always enabled.  gcc
>will see that everything is marked static and not used, so it'll cull
>things.
In fact, I have tried to do like this before changing like I sent in th=
e last mail. In fact, it will get compiling error if I always enable al=
l spi and i2c functions without a #ifdef protection.
So since there are far #ifdef, I think it shoud be better to place rela=
ted codes to existed #ifdef.
>-mike
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
