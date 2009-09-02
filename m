From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input driverforbutton/scrollwhell/slider/touchpad
Date: Wed, 2 Sep 2009 05:50:01 -0400
Message-ID: <200909020550.01729.rgetz@blackfin.uclinux.org>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <8bd0f97a0909012009k2f5bb41btca6de961c8cfa99@mail.gmail.com> <0F1B54C89D5F954D8535DB252AF412FA04A5CB70@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:53638 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZIBJp4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Sep 2009 05:45:56 -0400
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04A5CB70@chinexm1.ad.analog.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: uclinux-dist-devel@blackfin.uclinux.org
Cc: "Song, Barry" <Barry.Song@analog.com>, Mike Frysinger <vapier.adi@gmail.com>, dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Tue 1 Sep 2009 23:17, Song, Barry pondered:
> No. I can't agree other coding style issues you said. I will keep my
> original codes for these issues except adding a BUS_SPI. =20

style is different than performance....

Did you think about Mike's comment - I think it was a performance issue=
 he was=20
talking about.

On Tue 1 Sep 2009 23:09, Mike Frysinger pondered:
>=20
> did you look at the generated code?  function pointers requires
> pointer loads and indirect calls.  telling gcc that the function is
> completely static allows for direct calls (and thus less register
> pressure) and if gcc gets clever enough, avoid call overhead.



> >-----Original Message-----
> >From: Mike Frysinger [mailto:vapier.adi@gmail.com]=20
> >Sent: Wednesday, September 02, 2009 11:09 AM
> >To: Song, Barry
> >Cc: Barry Song; dbrownell@users.sourceforge.net; dtor@mail.ru;=20
> >dmitry.torokhov@gmail.com;=20
> >spi-devel-general@lists.sourceforge.net;=20
> >linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
> >Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input=20
> >driver forbutton/scrollwhell/slider/touchpad
> >
> >On Tue, Sep 1, 2009 at 22:46, Song, Barry wrote:
> >>>From: Mike Frysinger
> >>>> +struct ad714x_chip {
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short h_state;
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short l_state;
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short c_state;
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short adc_reg[STAGE_NUM];
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short amb_reg[STAGE_NUM];
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short sensor_val[STAGE_NUM];
> >>>> +
> >>>> + =C2=A0 =C2=A0 =C2=A0 struct ad714x_platform_data *hw;
> >>>> + =C2=A0 =C2=A0 =C2=A0 struct ad714x_driver_data *sw;
> >>>> +
> >>>> + =C2=A0 =C2=A0 =C2=A0 bus_device *bus;
> >>>> + =C2=A0 =C2=A0 =C2=A0 int (*read) (bus_device *, unsigned short=
,=20
> >unsigned short *);
> >>>> + =C2=A0 =C2=A0 =C2=A0 int (*write) (bus_device *, unsigned shor=
t,=20
> >unsigned short);
> >>>
> >>>using function pointers is pure overhead in your current
> >>>implementation. =C2=A0create a ad714x_read macro that expands to=20
> >either the
> >>>spi or the i2c version depending on which is enabled.
> >>
> >> Using macro can be a choice. But I don't think it can save=20
> >much overhead here.
> >> Function pointers encapsulates the object better.
> >
> >did you look at the generated code ?  function pointers requires
> >pointer loads and indirect calls.  telling gcc that the function is
> >completely static allows for direct calls (and thus less register
> >pressure) and if gcc gets clever enough, avoid call overhead.
> >
> >>>> +static int stage_cal_abs_pos(struct ad714x_chip *ad714x,
> >>>>>int start_stage, int end_stage, int highest_stage, int max_coord=
)
> >>>> +{
> >>>> + =C2=A0 =C2=A0 =C2=A0 int a_param, b_param;
> >>>> +
> >>>> + =C2=A0 =C2=A0 =C2=A0 if (highest_stage =3D=3D start_stage) {
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_param =3D a=
d714x->sensor_val[start_stage + 1];
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b_param =3D a=
d714x->sensor_val[start_stage] +
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ad714x->sensor_val[start_stage + 1];
> >>>> + =C2=A0 =C2=A0 =C2=A0 } else if (highest_stage =3D=3D end_stage=
) {
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_param =3D a=
d714x->sensor_val[end_stage] *
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (end_stage - start_stage) +
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ad714x->sensor_val[end_stage - 1] *
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (end_stage - start_stage - 1);
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b_param =3D a=
d714x->sensor_val[end_stage] +
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ad714x->sensor_val[end_stage - 1];
> >>>> + =C2=A0 =C2=A0 =C2=A0 } else {
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_param =3D a=
d714x->sensor_val[highest_stage] *
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (highest_stage - start_stage) +
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ad714x->sensor_val[highest_stage - 1] *
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (highest_stage - start_stage - 1) +
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ad714x->sensor_val[highest_stage + 1] *
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (highest_stage - start_stage + 1);
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b_param =3D a=
d714x->sensor_val[highest_stage] +
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ad714x->sensor_val[highest_stage - 1] +
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ad714x->sensor_val[highest_stage + 1];
> >>>> + =C2=A0 =C2=A0 =C2=A0 }
> >>>> +
> >>>> + =C2=A0 =C2=A0 =C2=A0 return (max_coord / (end_stage - start_st=
age)) *
> >>>a_param / b_param;
> >>>> +}
> >>>
> >>>do the local vars really need "_stage" suffix ? =C2=A0if you trimm=
ed that,
> >>>i imagine it'd make the code a bit easier to digest.
> >>
> >> Yes. It need the _stage suffix. Otherwise, nobody know=20
> >what's started, what's ended.
> >
> >that doesnt make sense.  if it's labeled "start" and "end" in the
> >local function, it's pretty obvious.
> >
> >>>> + input[alloc_idx-1]->id.bustype =3D BUS_I2C;
> >>>
> >>>you set bustype to I2C in common code even though this will be
> >>>executed for both SPI and I2C interfaces
> >>
> >> There is a BUS_I2C, but no BUS_SPI. So people may use other=20
> >serial type to imply.
> >> Do you think we should add a macro in input.h? I am really=20
> >suprised why the macro hasn't been added until now.
> >
> >yes, a new BUS_SPI should be added
> >
> >>>> +{
> >>>> + =C2=A0 =C2=A0 =C2=A0 int ret;
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short tx[2];
> >>>> + =C2=A0 =C2=A0 =C2=A0 unsigned short rx[2];
> >>>> + =C2=A0 =C2=A0 =C2=A0 struct spi_transfer t =3D {
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .tx_buf =3D t=
x,
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .rx_buf =3D r=
x,
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .len =3D 4,
> >>>> + =C2=A0 =C2=A0 =C2=A0 };
> >>>> + =C2=A0 =C2=A0 =C2=A0 struct spi_message m;
> >>>> +
> >>>> + =C2=A0 =C2=A0 =C2=A0 tx[0] =3D (AD714x_SPI_ADDR << AD714x_SPI_=
ADDR_SHFT) |
> >>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (AD714x_SPI_R=
EAD << AD714x_SPI_READ_SHFT) | reg;
> >>>> +
> >>>> + =C2=A0 =C2=A0 =C2=A0 spi_message_init(&m);
> >>>> + =C2=A0 =C2=A0 =C2=A0 spi_message_add_tail(&t, &m);
> >>>> + =C2=A0 =C2=A0 =C2=A0 ret =3D spi_sync(spi, &m);
> >>>
> >>>cant you use spi_write_then_read() ? =C2=A0dont let the u8*=20
> >prototype scare
> >>>you, it should work with writing 16bits and then reading 16bits.
> >>
> >> I have never been scared by any u8* or something else. I=20
> >only prefer to use raw spi API, which can show the bottom=20
> >level timing and SPI bus feature better.
> >> In fact, I prefer to use raw i2c API too.
> >
> >that doesnt make sense.  the entire purpose of writing these helper
> >write/read functions is because people often do just that -- write a
> >few then read a few.  your concerns are purely superficial.
> >-mike
> >
> _______________________________________________
> Uclinux-dist-devel mailing list
> Uclinux-dist-devel@blackfin.uclinux.org
> https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
