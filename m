From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch
	input driver
Date: Wed, 9 Sep 2009 03:47:58 -0400
Message-ID: <8bd0f97a0909090047s3510b0c5mb52380108bde64a5@mail.gmail.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com>
	<200909081149.28942.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B11725@chinexm1.ad.analog.com>
	<200909081929.57935.david-b@pacbell.net> <0F1B54C89D5F954D8535DB252AF412FA04B118A5@chinexm1.ad.analog.com>
	<8bd0f97a0909082305q632a4b30y3be36ce54ce9d509@mail.gmail.com>
	<0F1B54C89D5F954D8535DB252AF412FA04B4C3BE@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:64195 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZIIHsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 03:48:16 -0400
Received: by yxe1 with SMTP id 1so20394yxe.21
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2009 00:48:18 -0700 (PDT)
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04B4C3BE@chinexm1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Song, Barry" <Barry.Song@analog.com>
Cc: David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Wed, Sep 9, 2009 at 03:15, Song, Barry wrote:
>From: Mike Frysinger [mailto:vapier.adi@gmail.com]
>>On Tue, Sep 8, 2009 at 23:33, Song, Barry wrote:
>>> +static inline int ad714x_spi_register_driver(struct
>>> spi_driver *spi_drv)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 return spi_register_driver(spi_drv);
>>> +}
>>> +
>>> +static inline void ad714x_spi_unregister_driver(struct
>>spi_driver *spi_drv)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 spi_unregister_driver(spi_drv);
>>> +}
>>> +
>>> +#else
>>> +#define ad714x_spi_register_driver(p) 0
>>> +#define ad714x_spi_unregister_driver(p)
>>> =C2=A0#endif
>>
>>i dont think you need the ifdef protection that far up. =C2=A0what ab=
out
>>using the ifdef in this one place:
>>static inline int ad714x_spi_register_driver(struct spi_driver
>>*spi_drv)
>>{
>>#if defined(CONFIG_SPI) || defined(CONFIG_SPI_MODULE)
>> =C2=A0 =C2=A0return spi_register_driver(spi_drv);
>>#else
>> =C2=A0 =C2=A0return 0;
>>#endif
>>}
>>
>>then i imagine you can have all the other pieces always enabled. =C2=A0=
gcc
>>will see that everything is marked static and not used, so it'll cull
>>things.
>
> In fact, I have tried to do like this before changing like I sent in =
the last mail. In fact, it will get compiling error if I always enable =
all spi and i2c functions without a #ifdef protection.
> So since there are far #ifdef, I think it shoud be better to place re=
lated codes to existed #ifdef.

i really have no idea what you're trying to say or why it didnt work fo=
r you
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
