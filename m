From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
Date: Mon, 15 Aug 2011 16:01:53 +0800
Message-ID: <CAMPhdO8WOsnbCvqGGYqnCMiw71esp-OqXryXAS4Xeb0id2DG2g@mail.gmail.com>
References: <1313317918.74933.YahooMailClassic@web29014.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec54866e247360604aa86ae72
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34595 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1HOICO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 04:02:14 -0400
Received: by vws1 with SMTP id 1so3736219vws.19
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2011 01:02:13 -0700 (PDT)
In-Reply-To: <1313317918.74933.YahooMailClassic@web29014.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org, koen@dominion.thruhere.net, philipp.zabel@gmail.com, mad_soft@inbox.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--bcaec54866e247360604aa86ae72
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 14, 2011 at 6:31 PM, Paul Parsons <lost.distance@yahoo.com> wro=
te:
> Hi Igor,
>
> Thanks for reviewing the driver. Specific responses below.
>
> =C2=A0 =C2=A0 This patch should be 1/n as the other patches depend on it,
> =C2=A0 =C2=A0 should not include the mfp stuff and should be sent also to
> =C2=A0 =C2=A0 linux-input list
> =C2=A0 =C2=A0 and the input subsystem maintainer (both added to CC).
>
> OK, will do.
>
> +/* Touchpad Controller */
> +#define GPIO102_NAVPOINT_PWR=C2=A0=C2=A0=C2=A0 MFP_CFG_OUT(GPIO102, AF0,=
 DRIVE_LOW)
> +
>
> =C2=A0 =C2=A0 The name is not generic, so IMO can't be placed in the gene=
ric file.
> =C2=A0 =C2=A0 Can't you use the already existing GPIO102_GPIO macro
> =C2=A0 =C2=A0 and then change the direction in the board or driver file?
>
> MFP_CFG_OUT(GPIO102, ...) had already moved from the patch v1 platform fi=
le to patch v2 mfp-pxa27x.h because it was suggested that MFP macros should=
 not be used directly.
> Changing the direction in the platform file would surely require using th=
e MFP macros again, so how to keep everyone happy? Maybe I should just defi=
ne a more generic name such as GPIO102_GPIO_OUT?

I guess we need a new definition for this config, looks like SCLK here
is different from a normal configuration because the pxa27x is used
as a SPI slave here?

And checked a bit with the pxa27x developer manual, there is no SCLK
for this GPIO102????

>
> +config MOUSE_NAVPOINT_PXA27x
> +=C2=A0=C2=A0=C2=A0 bool "Synaptics NavPoint (PXA27x SSP/SPI)"
> +=C2=A0=C2=A0=C2=A0 depends on PXA27x && PXA_SSP
> +=C2=A0=C2=A0=C2=A0 help
> +=C2=A0=C2=A0=C2=A0 =C2=A0 This option enables support for the Synaptics =
NavPoint connected to
> +=C2=A0=C2=A0=C2=A0 =C2=A0 a PXA27x SSP port in SPI slave mode. The drive=
r implements a simple
> +=C2=A0=C2=A0=C2=A0 =C2=A0 navigation pad. The four raised dots are mappe=
d to UP/DOWN/LEFT/RIGHT
> +=C2=A0=C2=A0=C2=A0 =C2=A0 buttons and the centre of the touchpad is mapp=
ed to the ENTER button.
> +=C2=A0=C2=A0=C2=A0 =C2=A0 Say Y to enable the Synaptics NavPoint on the =
HP iPAQ hx4700.
>
> =C2=A0 =C2=A0 There is no direct dependency for HP iPAQ hx4700,
> =C2=A0 =C2=A0 so in theory each board that want to use it can use it.
> =C2=A0 =C2=A0 I'd remove the "on the HP iPAQ ..." from the above sentence=
.
>
> I copied that wording from my earlier ASIC3 LED driver. I suppose my feel=
ing was that it seemed unlikely that any other platform would ever use this=
 driver (otherwise I wouldn't be the first to write it). I'm happy to remov=
e it.
>
> +obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)=C2=A0=C2=A0=C2=A0 +=3D navpoint.o
>
> =C2=A0 =C2=A0 This does not look like mouse device... Why place it in the=
 mouse
> =C2=A0 =C2=A0 directory?
> =C2=A0 =C2=A0 I think the most reasonable place would be drivers/input/ke=
yboard
>
> Because the underlying hardware is a touchpad controller and most of the =
touchpad drivers live in the mouse directory. I could have added a mouse in=
terface to this driver but chose not to (at least for now) because the hx47=
00 platform already has a working touchscreen controller; a second mouse de=
vice was not needed. If future platforms require a mouse interface then one=
 could be added relatively easily; surely this would be preferable to repli=
cating the whole driver.
>
> +struct driver_data {
> +=C2=A0=C2=A0=C2=A0 struct ssp_device *ssp;
> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 gpio;
> +=C2=A0=C2=A0=C2=A0 struct input_dev *input;
> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 index;
> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data[8];
> +=C2=A0=C2=A0=C2=A0 int=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pressed;=C2=
=A0=C2=A0=C2=A0 /* 1 =3D pressed, 0 =3D released */
> +=C2=A0=C2=A0=C2=A0 unsigned=C2=A0=C2=A0=C2=A0 code;=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 /* Key code of the last key pressed */
>
> =C2=A0 =C2=A0 Why do you need it?
>
> The code field? To match a button release with a button press. See later.
>
> +#define WEST=C2=A0=C2=A0=C2=A0 2416=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 /* 1/3 width */
> +#define EAST=C2=A0=C2=A0=C2=A0 3904=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 /* 2/3 width */
> +#define SOUTH=C2=A0=C2=A0=C2=A0 2480=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 /* 1/3 height */
> +#define NORTH=C2=A0=C2=A0=C2=A0 3424=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 /* 2/3 height */
>
> =C2=A0 =C2=A0 May be supply those via the platform_data?
>
> OK, will do.
>
> +=C2=A0=C2=A0=C2=A0 drv_data =3D dev;
>
> =C2=A0 =C2=A0 Can be done in the declaration line.
>
> OK.
>
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (pressed)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 drv_data->code =
=3D code;
>
> =C2=A0 =C2=A0 Why do you need to store the code? You don't use it in any =
place...
>
> I use it in the next line. The store is conditional whereas the read is u=
nconditional. That's why I need to store it.
>
> +=C2=A0=C2=A0=C2=A0 drv_data =3D dev;
>
> =C2=A0 =C2=A0 This can be done in the declaration line.
>
> OK.
>
> +=C2=A0=C2=A0=C2=A0 status =3D pxa_ssp_read_reg(ssp, SSSR);
> +=C2=A0=C2=A0=C2=A0 ret =3D (status & (sssr | SSSR_RFS)) ? IRQ_HANDLED : =
IRQ_NONE;
> +
> +=C2=A0=C2=A0=C2=A0 if (status & sssr) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_warn(dev, "spurious interrupt:=
 0x%02x\n", status);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pxa_ssp_write_reg(ssp, SSSR, (stat=
us & sssr));
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 while (status & SSSR_RNE) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u32 data;
> +
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data =3D pxa_ssp_read_reg(ssp, SSD=
R);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 drv_data->data[drv_data->index + 0=
] =3D (data >> 8);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 drv_data->data[drv_data->index + 1=
] =3D data;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 drv_data->index +=3D 2;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if ((drv_data->data[0] & 0x07) < d=
rv_data->index)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 navpoint_packet=
(dev);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 status =3D pxa_ssp_read_reg(ssp, S=
SSR);
> +=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0 =C2=A0 Should all this really be done in the interrupt context?
>
> Yes. The FIFO controller triggers a CPU interrupt when the number of RX F=
IFO entries >=3D SSCR1.RFT (RX FIFO threshold), which I have set to 1. If I=
 don't drain the RX FIFO then the interrupt source will not be cleared and =
the interrupt handler will be re-entered immediately (I have verified this)=
. In short, draining the RX FIFO clears the interrupt.
>
> +=C2=A0=C2=A0=C2=A0 drv_data =3D dev_get_drvdata(dev);
> +=C2=A0=C2=A0=C2=A0 ssp =3D drv_data->ssp;
>
> =C2=A0 =C2=A0 The above two can be done in the declaration line...
>
> OK.
>
> +=C2=A0=C2=A0=C2=A0 drv_data =3D dev_get_drvdata(dev);
> +=C2=A0=C2=A0=C2=A0 ssp =3D drv_data->ssp;
>
> =C2=A0 =C2=A0 The above two can be done in the declaration line...
>
> OK.
>
> +=C2=A0=C2=A0=C2=A0 drv_data->gpio =3D pdata->gpio;
>
> =C2=A0 =C2=A0 I'd suggest checking if the supplied gpio is valid
> =C2=A0 =C2=A0 and also may be configure it for output?
>
> The suspend and resume functions check that the gpio is valid (which is t=
aken to be non-zero) before using it. The platform file has already configu=
red the gpio for output; it's the GPIO102 discussed earlier.
>
> +=C2=A0=C2=A0=C2=A0 (void) navpoint_resume(&pdev->dev);
>
> =C2=A0 =C2=A0 Will this compile if !CONFIG_SUSPEND?
>
> oops. OK.
>
> +=C2=A0=C2=A0=C2=A0 drv_data =3D platform_get_drvdata(pdev);
> +=C2=A0=C2=A0=C2=A0 ssp =3D drv_data->ssp;
> +=C2=A0=C2=A0=C2=A0 input =3D drv_data->input;
>
> =C2=A0 =C2=A0 You need neither ssp nor input variables - you only use the=
m once.
> =C2=A0 =C2=A0 This will remove 4 lines...
>
> Actually the ssp variable is used twice. Regardless, by declaring those t=
wo variables I ensured that most of navpoint_remove() was identical to the =
error return of navpoint_probe(). I suppose I value consistency more than s=
aving lines. I'm happy to move those two assignments to the declaration lin=
e.
>
> +=C2=A0=C2=A0=C2=A0 (void) navpoint_suspend(&pdev->dev);
>
> =C2=A0 =C2=A0 and will this compile if !CONFIG_SUSPEND?
>
> oops again. OK.
>
> Regards,
> Paul
>

--bcaec54866e247360604aa86ae72
Content-Type: image/png; name="gpio-102.png"
Content-Disposition: attachment; filename="gpio-102.png"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grd5ncob0

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
0QAAAABJRU5ErkJggg==
--bcaec54866e247360604aa86ae72--
