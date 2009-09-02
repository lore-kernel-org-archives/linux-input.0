From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input driver forbutton/scrollwhell/slider/touchpad
Date: Wed, 2 Sep 2009 11:17:15 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04A5CB70@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <1251777330-16994-2-git-send-email-21cnbao@gmail.com> <1251777330-16994-3-git-send-email-21cnbao@gmail.com> <8bd0f97a0909011230r50cb532ep46db64d65cbb49e5@mail.gmail.com> <0F1B54C89D5F954D8535DB252AF412FA04A5CADA@chinexm1.ad.analog.com> <8bd0f97a0909012009k2f5bb41btca6de961c8cfa99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:54582 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZIBDRS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2009 23:17:18 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909012009k2f5bb41btca6de961c8cfa99@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

No. I can't agree other coding style issues you said. I will keep my or=
iginal codes for these issues except adding a BUS_SPI.=20

>-----Original Message-----
>From: Mike Frysinger [mailto:vapier.adi@gmail.com]=20
>Sent: Wednesday, September 02, 2009 11:09 AM
>To: Song, Barry
>Cc: Barry Song; dbrownell@users.sourceforge.net; dtor@mail.ru;=20
>dmitry.torokhov@gmail.com;=20
>spi-devel-general@lists.sourceforge.net;=20
>linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input=20
>driver forbutton/scrollwhell/slider/touchpad
>
>On Tue, Sep 1, 2009 at 22:46, Song, Barry wrote:
>>>From: Mike Frysinger
>>>> +struct ad714x_chip {
>>>> + =A0 =A0 =A0 unsigned short h_state;
>>>> + =A0 =A0 =A0 unsigned short l_state;
>>>> + =A0 =A0 =A0 unsigned short c_state;
>>>> + =A0 =A0 =A0 unsigned short adc_reg[STAGE_NUM];
>>>> + =A0 =A0 =A0 unsigned short amb_reg[STAGE_NUM];
>>>> + =A0 =A0 =A0 unsigned short sensor_val[STAGE_NUM];
>>>> +
>>>> + =A0 =A0 =A0 struct ad714x_platform_data *hw;
>>>> + =A0 =A0 =A0 struct ad714x_driver_data *sw;
>>>> +
>>>> + =A0 =A0 =A0 bus_device *bus;
>>>> + =A0 =A0 =A0 int (*read) (bus_device *, unsigned short,=20
>unsigned short *);
>>>> + =A0 =A0 =A0 int (*write) (bus_device *, unsigned short,=20
>unsigned short);
>>>
>>>using function pointers is pure overhead in your current
>>>implementation. =A0create a ad714x_read macro that expands to=20
>either the
>>>spi or the i2c version depending on which is enabled.
>>
>> Using macro can be a choice. But I don't think it can save=20
>much overhead here.
>> Function pointers encapsulates the object better.
>
>did you look at the generated code ?  function pointers requires
>pointer loads and indirect calls.  telling gcc that the function is
>completely static allows for direct calls (and thus less register
>pressure) and if gcc gets clever enough, avoid call overhead.
>
>>>> +static int stage_cal_abs_pos(struct ad714x_chip *ad714x,
>>>>>int start_stage, int end_stage, int highest_stage, int max_coord)
>>>> +{
>>>> + =A0 =A0 =A0 int a_param, b_param;
>>>> +
>>>> + =A0 =A0 =A0 if (highest_stage =3D=3D start_stage) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a_param =3D ad714x->sensor_val[start=
_stage + 1];
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b_param =3D ad714x->sensor_val[start=
_stage] +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[s=
tart_stage + 1];
>>>> + =A0 =A0 =A0 } else if (highest_stage =3D=3D end_stage) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a_param =3D ad714x->sensor_val[end_s=
tage] *
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (end_stage - start_s=
tage) +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[e=
nd_stage - 1] *
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (end_stage - start_s=
tage - 1);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b_param =3D ad714x->sensor_val[end_s=
tage] +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[e=
nd_stage - 1];
>>>> + =A0 =A0 =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 a_param =3D ad714x->sensor_val[highe=
st_stage] *
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (highest_stage - sta=
rt_stage) +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[h=
ighest_stage - 1] *
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (highest_stage - sta=
rt_stage - 1) +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[h=
ighest_stage + 1] *
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (highest_stage - sta=
rt_stage + 1);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 b_param =3D ad714x->sensor_val[highe=
st_stage] +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[h=
ighest_stage - 1] +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x->sensor_val[h=
ighest_stage + 1];
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 return (max_coord / (end_stage - start_stage)) *
>>>a_param / b_param;
>>>> +}
>>>
>>>do the local vars really need "_stage" suffix ? =A0if you trimmed th=
at,
>>>i imagine it'd make the code a bit easier to digest.
>>
>> Yes. It need the _stage suffix. Otherwise, nobody know=20
>what's started, what's ended.
>
>that doesnt make sense.  if it's labeled "start" and "end" in the
>local function, it's pretty obvious.
>
>>>> + input[alloc_idx-1]->id.bustype =3D BUS_I2C;
>>>
>>>you set bustype to I2C in common code even though this will be
>>>executed for both SPI and I2C interfaces
>>
>> There is a BUS_I2C, but no BUS_SPI. So people may use other=20
>serial type to imply.
>> Do you think we should add a macro in input.h? I am really=20
>suprised why the macro hasn't been added until now.
>
>yes, a new BUS_SPI should be added
>
>>>> +{
>>>> + =A0 =A0 =A0 int ret;
>>>> + =A0 =A0 =A0 unsigned short tx[2];
>>>> + =A0 =A0 =A0 unsigned short rx[2];
>>>> + =A0 =A0 =A0 struct spi_transfer t =3D {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .tx_buf =3D tx,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rx_buf =3D rx,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 4,
>>>> + =A0 =A0 =A0 };
>>>> + =A0 =A0 =A0 struct spi_message m;
>>>> +
>>>> + =A0 =A0 =A0 tx[0] =3D (AD714x_SPI_ADDR << AD714x_SPI_ADDR_SHFT) =
|
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (AD714x_SPI_READ << AD714x_SPI_READ_=
SHFT) | reg;
>>>> +
>>>> + =A0 =A0 =A0 spi_message_init(&m);
>>>> + =A0 =A0 =A0 spi_message_add_tail(&t, &m);
>>>> + =A0 =A0 =A0 ret =3D spi_sync(spi, &m);
>>>
>>>cant you use spi_write_then_read() ? =A0dont let the u8*=20
>prototype scare
>>>you, it should work with writing 16bits and then reading 16bits.
>>
>> I have never been scared by any u8* or something else. I=20
>only prefer to use raw spi API, which can show the bottom=20
>level timing and SPI bus feature better.
>> In fact, I prefer to use raw i2c API too.
>
>that doesnt make sense.  the entire purpose of writing these helper
>write/read functions is because people often do just that -- write a
>few then read a few.  your concerns are purely superficial.
>-mike
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
