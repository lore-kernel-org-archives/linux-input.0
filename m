From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input driver
	forbutton/scrollwhell/slider/touchpad
Date: Tue, 1 Sep 2009 23:09:21 -0400
Message-ID: <8bd0f97a0909012009k2f5bb41btca6de961c8cfa99@mail.gmail.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<1251777330-16994-2-git-send-email-21cnbao@gmail.com> <1251777330-16994-3-git-send-email-21cnbao@gmail.com>
	<8bd0f97a0909011230r50cb532ep46db64d65cbb49e5@mail.gmail.com>
	<0F1B54C89D5F954D8535DB252AF412FA04A5CADA@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f188.google.com ([209.85.211.188]:45625 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbZIBDJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2009 23:09:40 -0400
Received: by ywh26 with SMTP id 26so832789ywh.5
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2009 20:09:42 -0700 (PDT)
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04A5CADA@chinexm1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Song, Barry" <Barry.Song@analog.com>
Cc: Barry Song <21cnbao@gmail.com>, dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Tue, Sep 1, 2009 at 22:46, Song, Barry wrote:
>>From: Mike Frysinger
>>> +struct ad714x_chip {
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short h_state;
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short l_state;
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short c_state;
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short adc_reg[STAGE_NUM];
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short amb_reg[STAGE_NUM];
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short sensor_val[STAGE_NUM];
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 struct ad714x_platform_data *hw;
>>> + =C2=A0 =C2=A0 =C2=A0 struct ad714x_driver_data *sw;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 bus_device *bus;
>>> + =C2=A0 =C2=A0 =C2=A0 int (*read) (bus_device *, unsigned short, u=
nsigned short *);
>>> + =C2=A0 =C2=A0 =C2=A0 int (*write) (bus_device *, unsigned short, =
unsigned short);
>>
>>using function pointers is pure overhead in your current
>>implementation. =C2=A0create a ad714x_read macro that expands to eith=
er the
>>spi or the i2c version depending on which is enabled.
>
> Using macro can be a choice. But I don't think it can save much overh=
ead here.
> Function pointers encapsulates the object better.

did you look at the generated code ?  function pointers requires
pointer loads and indirect calls.  telling gcc that the function is
completely static allows for direct calls (and thus less register
pressure) and if gcc gets clever enough, avoid call overhead.

>>> +static int stage_cal_abs_pos(struct ad714x_chip *ad714x,
>>>>int start_stage, int end_stage, int highest_stage, int max_coord)
>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 int a_param, b_param;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 if (highest_stage =3D=3D start_stage) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_param =3D ad71=
4x->sensor_val[start_stage + 1];
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b_param =3D ad71=
4x->sensor_val[start_stage] +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ad714x->sensor_val[start_stage + 1];
>>> + =C2=A0 =C2=A0 =C2=A0 } else if (highest_stage =3D=3D end_stage) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_param =3D ad71=
4x->sensor_val[end_stage] *
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (end_stage - start_stage) +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ad714x->sensor_val[end_stage - 1] *
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (end_stage - start_stage - 1);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b_param =3D ad71=
4x->sensor_val[end_stage] +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ad714x->sensor_val[end_stage - 1];
>>> + =C2=A0 =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_param =3D ad71=
4x->sensor_val[highest_stage] *
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (highest_stage - start_stage) +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ad714x->sensor_val[highest_stage - 1] *
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (highest_stage - start_stage - 1) +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ad714x->sensor_val[highest_stage + 1] *
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (highest_stage - start_stage + 1);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b_param =3D ad71=
4x->sensor_val[highest_stage] +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ad714x->sensor_val[highest_stage - 1] +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ad714x->sensor_val[highest_stage + 1];
>>> + =C2=A0 =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 return (max_coord / (end_stage - start_stage=
)) *
>>a_param / b_param;
>>> +}
>>
>>do the local vars really need "_stage" suffix ? =C2=A0if you trimmed =
that,
>>i imagine it'd make the code a bit easier to digest.
>
> Yes. It need the _stage suffix. Otherwise, nobody know what's started=
, what's ended.

that doesnt make sense.  if it's labeled "start" and "end" in the
local function, it's pretty obvious.

>>> + input[alloc_idx-1]->id.bustype =3D BUS_I2C;
>>
>>you set bustype to I2C in common code even though this will be
>>executed for both SPI and I2C interfaces
>
> There is a BUS_I2C, but no BUS_SPI. So people may use other serial ty=
pe to imply.
> Do you think we should add a macro in input.h? I am really suprised w=
hy the macro hasn't been added until now.

yes, a new BUS_SPI should be added

>>> +{
>>> + =C2=A0 =C2=A0 =C2=A0 int ret;
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short tx[2];
>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short rx[2];
>>> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer t =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .tx_buf =3D tx,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rx_buf =3D rx,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
>>> + =C2=A0 =C2=A0 =C2=A0 };
>>> + =C2=A0 =C2=A0 =C2=A0 struct spi_message m;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 tx[0] =3D (AD714x_SPI_ADDR << AD714x_SPI_ADD=
R_SHFT) |
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (AD714x_SPI_READ=
 << AD714x_SPI_READ_SHFT) | reg;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&m);
>>> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&t, &m);
>>> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_sync(spi, &m);
>>
>>cant you use spi_write_then_read() ? =C2=A0dont let the u8* prototype=
 scare
>>you, it should work with writing 16bits and then reading 16bits.
>
> I have never been scared by any u8* or something else. I only prefer =
to use raw spi API, which can show the bottom level timing and SPI bus =
feature better.
> In fact, I prefer to use raw i2c API too.

that doesnt make sense.  the entire purpose of writing these helper
write/read functions is because people often do just that -- write a
few then read a few.  your concerns are purely superficial.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
