From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Sun, 14 Aug 2011 11:31:58 +0100 (BST)
Message-ID: <1313317918.74933.YahooMailClassic@web29014.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm10.bullet.mail.ird.yahoo.com ([77.238.189.39]:47724 "HELO
	nm10.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753055Ab1HNKcB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Aug 2011 06:32:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-arm-kernel@lists.infradead.org, koen@dominion.thruhere.net, eric.y.miao@gmail.com, philipp.zabel@gmail.com, mad_soft@inbox.ru, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Igor,

Thanks for reviewing the driver. Specific responses below.

=A0 =A0 This patch should be 1/n as the other patches depend on it,
=A0 =A0 should not include the mfp stuff and should be sent also to
=A0 =A0 linux-input list
=A0 =A0 and the input subsystem maintainer (both added to CC).

OK, will do.

+/* Touchpad Controller */
+#define GPIO102_NAVPOINT_PWR=A0=A0=A0 MFP_CFG_OUT(GPIO102, AF0, DRIVE_=
LOW)
+

=A0 =A0 The name is not generic, so IMO can't be placed in the generic =
file.
=A0 =A0 Can't you use the already existing GPIO102_GPIO macro
=A0 =A0 and then change the direction in the board or driver file?

MFP_CFG_OUT(GPIO102, ...) had already moved from the patch v1 platform =
file to patch v2 mfp-pxa27x.h because it was suggested that MFP macros =
should not be used directly.
Changing the direction in the platform file would surely require using =
the MFP macros again, so how to keep everyone happy? Maybe I should jus=
t define a more generic name such as GPIO102_GPIO_OUT?
=A0 =A0=20
+config MOUSE_NAVPOINT_PXA27x
+=A0=A0=A0 bool "Synaptics NavPoint (PXA27x SSP/SPI)"
+=A0=A0=A0 depends on PXA27x && PXA_SSP
+=A0=A0=A0 help
+=A0=A0=A0 =A0 This option enables support for the Synaptics NavPoint c=
onnected to
+=A0=A0=A0 =A0 a PXA27x SSP port in SPI slave mode. The driver implemen=
ts a simple
+=A0=A0=A0 =A0 navigation pad. The four raised dots are mapped to UP/DO=
WN/LEFT/RIGHT
+=A0=A0=A0 =A0 buttons and the centre of the touchpad is mapped to the =
ENTER button.
+=A0=A0=A0 =A0 Say Y to enable the Synaptics NavPoint on the HP iPAQ hx=
4700.

=A0 =A0 There is no direct dependency for HP iPAQ hx4700,
=A0 =A0 so in theory each board that want to use it can use it.
=A0 =A0 I'd remove the "on the HP iPAQ ..." from the above sentence.

I copied that wording from my earlier ASIC3 LED driver. I suppose my fe=
eling was that it seemed unlikely that any other platform would ever us=
e this driver (otherwise I wouldn't be the first to write it). I'm happ=
y to remove it.
=A0 =A0=20
+obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)=A0=A0=A0 +=3D navpoint.o
=20
=A0 =A0 This does not look like mouse device... Why place it in the mou=
se
=A0 =A0 directory?
=A0 =A0 I think the most reasonable place would be drivers/input/keyboa=
rd

Because the underlying hardware is a touchpad controller and most of th=
e touchpad drivers live in the mouse directory. I could have added a mo=
use interface to this driver but chose not to (at least for now) becaus=
e the hx4700 platform already has a working touchscreen controller; a s=
econd mouse device was not needed. If future platforms require a mouse =
interface then one could be added relatively easily; surely this would =
be preferable to replicating the whole driver.

+struct driver_data {
+=A0=A0=A0 struct ssp_device *ssp;
+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 gpio;
+=A0=A0=A0 struct input_dev *input;
+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 index;
+=A0=A0=A0 uint8_t=A0=A0=A0 =A0=A0=A0 data[8];
+=A0=A0=A0 int=A0=A0=A0 =A0=A0=A0 pressed;=A0=A0=A0 /* 1 =3D pressed, 0=
 =3D released */
+=A0=A0=A0 unsigned=A0=A0=A0 code;=A0=A0=A0 =A0=A0=A0 /* Key code of th=
e last key pressed */

=A0 =A0 Why do you need it?

The code field? To match a button release with a button press. See late=
r.
=A0 =A0=20
+#define WEST=A0=A0=A0 2416=A0=A0=A0 =A0=A0=A0 /* 1/3 width */
+#define EAST=A0=A0=A0 3904=A0=A0=A0 =A0=A0=A0 /* 2/3 width */
+#define SOUTH=A0=A0=A0 2480=A0=A0=A0 =A0=A0=A0 /* 1/3 height */
+#define NORTH=A0=A0=A0 3424=A0=A0=A0 =A0=A0=A0 /* 2/3 height */

=A0 =A0 May be supply those via the platform_data?

OK, will do.

+=A0=A0=A0 drv_data =3D dev;

=A0 =A0 Can be done in the declaration line.

OK.

+=A0=A0=A0 =A0=A0=A0 if (pressed)
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 drv_data->code =3D code;

=A0 =A0 Why do you need to store the code? You don't use it in any plac=
e...

I use it in the next line. The store is conditional whereas the read is=
 unconditional. That's why I need to store it.

+=A0=A0=A0 drv_data =3D dev;

=A0 =A0 This can be done in the declaration line.

OK.

+=A0=A0=A0 status =3D pxa_ssp_read_reg(ssp, SSSR);
+=A0=A0=A0 ret =3D (status & (sssr | SSSR_RFS)) ? IRQ_HANDLED : IRQ_NON=
E;
+
+=A0=A0=A0 if (status & sssr) {
+=A0=A0=A0 =A0=A0=A0 dev_warn(dev, "spurious interrupt: 0x%02x\n", stat=
us);
+=A0=A0=A0 =A0=A0=A0 pxa_ssp_write_reg(ssp, SSSR, (status & sssr));
+=A0=A0=A0 }
+
+=A0=A0=A0 while (status & SSSR_RNE) {
+=A0=A0=A0 =A0=A0=A0 u32 data;
+
+=A0=A0=A0 =A0=A0=A0 data =3D pxa_ssp_read_reg(ssp, SSDR);
+=A0=A0=A0 =A0=A0=A0 drv_data->data[drv_data->index + 0] =3D (data >> 8=
);
+=A0=A0=A0 =A0=A0=A0 drv_data->data[drv_data->index + 1] =3D data;
+=A0=A0=A0 =A0=A0=A0 drv_data->index +=3D 2;
+=A0=A0=A0 =A0=A0=A0 if ((drv_data->data[0] & 0x07) < drv_data->index)
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 navpoint_packet(dev);
+=A0=A0=A0 =A0=A0=A0 status =3D pxa_ssp_read_reg(ssp, SSSR);
+=A0=A0=A0 }

=A0 =A0 Should all this really be done in the interrupt context?

Yes. The FIFO controller triggers a CPU interrupt when the number of RX=
 FIFO entries >=3D SSCR1.RFT (RX FIFO threshold), which I have set to 1=
=2E If I don't drain the RX FIFO then the interrupt source will not be =
cleared and the interrupt handler will be re-entered immediately (I hav=
e verified this). In short, draining the RX FIFO clears the interrupt.

+=A0=A0=A0 drv_data =3D dev_get_drvdata(dev);
+=A0=A0=A0 ssp =3D drv_data->ssp;

=A0 =A0 The above two can be done in the declaration line...

OK.

+=A0=A0=A0 drv_data =3D dev_get_drvdata(dev);
+=A0=A0=A0 ssp =3D drv_data->ssp;

=A0 =A0 The above two can be done in the declaration line...

OK.

+=A0=A0=A0 drv_data->gpio =3D pdata->gpio;

=A0 =A0 I'd suggest checking if the supplied gpio is valid
=A0 =A0 and also may be configure it for output?

The suspend and resume functions check that the gpio is valid (which is=
 taken to be non-zero) before using it. The platform file has already c=
onfigured the gpio for output; it's the GPIO102 discussed earlier.

+=A0=A0=A0 (void) navpoint_resume(&pdev->dev);

=A0 =A0 Will this compile if !CONFIG_SUSPEND?

oops. OK.

+=A0=A0=A0 drv_data =3D platform_get_drvdata(pdev);
+=A0=A0=A0 ssp =3D drv_data->ssp;
+=A0=A0=A0 input =3D drv_data->input;

=A0 =A0 You need neither ssp nor input variables - you only use them on=
ce.
=A0 =A0 This will remove 4 lines...

Actually the ssp variable is used twice. Regardless, by declaring those=
 two variables I ensured that most of navpoint_remove() was identical t=
o the error return of navpoint_probe(). I suppose I value consistency m=
ore than saving lines. I'm happy to move those two assignments to the d=
eclaration line.

+=A0=A0=A0 (void) navpoint_suspend(&pdev->dev);

=A0 =A0 and will this compile if !CONFIG_SUSPEND?

oops again. OK.

Regards,
Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
