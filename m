From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv4 5/6] Input: add CMR3000 gyrsocope driver
Date: Wed, 2 Nov 2011 15:28:36 +0100
Message-ID: <CAPybu_1yX85JkH-wVk3c76_-Q7miF_A01ZUEs_CMuta1OjdRsA@mail.gmail.com>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
 <1319487676-27181-6-git-send-email-ricardo.ribalda@gmail.com>
 <20111024214020.GC4394@ponder.secretlab.ca> <CAPybu_2vRWV6RiPtHvj17oTaDa-18FsFa_JhOhWv2k55B0ZaEg@mail.gmail.com>
 <20111025082815.GB4605@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37266 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab1KBO3R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 10:29:17 -0400
In-Reply-To: <20111025082815.GB4605@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, jic23@cam.ac.uk, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Grant

 Thanks for your feedback.  I think I will remove this patch from the
patchset, I am already in the 5th iteration :S... When the cma
supports devicetree and spi I will try to re-engineer this driver.

 Thanks again

On Tue, Oct 25, 2011 at 10:28, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
> On Tue, Oct 25, 2011 at 09:26:10AM +0200, Ricardo Ribalda Delgado wro=
te:
>> Hello Grant
>>
>> =A0It is similar to the crm, because they came from the same
>> manufacturer and they share some commands, but that is all.
>>
>> the crm is a gyroscope and the cma is an accelerometer. I tried to p=
ut
>> both drivers together and the result was a bit too messy, I think it
>> is easier to understand as two separate drivers, but if you believe
>> they have to live together and help me making it more understandable=
,
>> I have to problem in coding it.
>
> Alternately, are there any parts of the cma driver that can be
> generalized and used by both? =A0A lot of the driver looks like
> boilerplate to me, which I'd rather not see duplicated.
>
> And I've filled in a few more comments below.
>
> g.
>
>>
>> =A0 =A0Regards!
>>
>> On Mon, Oct 24, 2011 at 23:40, Grant Likely <grant.likely@secretlab.=
ca> wrote:
>> > On Mon, Oct 24, 2011 at 10:21:15PM +0200, Ricardo Ribalda Delgado =
wrote:
>> >> Add support for CMR3000 Tri-axis accelerometer. CMR3000 supports =
both
>> >> I2C/SPI bus communication, currently the driver supports SPI
>> >> communication, since I have no hardware to test the I2C communica=
tion.
>> >
>> > How different is this driver from the cma3000? =A0Is it a cut and =
paste job?
>> >
>> > g.
>> >
>> >>
>> >> ---
>> >>
>> >> v4: Fixes suggested by Dmitry Torokhov
>> >> =A0 =A0 =A0 -Do not release the input device until the irq has be=
en released
>> >>
>> >> v3: Fixes suggested by Jonathan Cameron
>> >> =A0 =A0 =A0 -Support DT
>> >> =A0 =A0 =A0 -Cleaner spi read/write
>> >>
>> >> v2: Fixes suggested by Jonathan Cameron
>> >> =A0 =A0 =A0 -Code Stype
>> >> =A0 =A0 =A0 -Check pdata!=3DNULL
>> >> =A0 =A0 =A0 -SPI align Cacheline
>> >> =A0 =A0 =A0 -More clear based on
>> >> =A0 =A0 =A0 -%s/set/write/
>> >> =A0 =A0 =A0 -%s/accl/gyro/
>> >> =A0 =A0 =A0 -remove READ/SET macros
>> >>
>> >> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com=
>
>> >> ---
>> >> =A0drivers/input/misc/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 24 ++
>> >> =A0drivers/input/misc/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
>> >> =A0drivers/input/misc/cmr3000_d0x.c =A0 =A0 | =A0426 ++++++++++++=
++++++++++++++++++++++
>> >> =A0drivers/input/misc/cmr3000_d0x.h =A0 =A0 | =A0 45 ++++
>> >> =A0drivers/input/misc/cmr3000_d0x_spi.c | =A0144 ++++++++++++
>> >> =A0include/linux/input/cmr3000.h =A0 =A0 =A0 =A0| =A0 54 +++++
>> >> =A06 files changed, 695 insertions(+), 0 deletions(-)
>> >> =A0create mode 100644 drivers/input/misc/cmr3000_d0x.c
>> >> =A0create mode 100644 drivers/input/misc/cmr3000_d0x.h
>> >> =A0create mode 100644 drivers/input/misc/cmr3000_d0x_spi.c
>> >> =A0create mode 100644 include/linux/input/cmr3000.h
>> >>
>> >> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kcon=
fig
>> >> index b9f2e93..7c56f94 100644
>> >> --- a/drivers/input/misc/Kconfig
>> >> +++ b/drivers/input/misc/Kconfig
>> >> @@ -524,6 +524,30 @@ config INPUT_CMA3000_SPI
>> >> =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here=
: the
>> >> =A0 =A0 =A0 =A0 module will be called cma3000_d0x_spi.
>> >>
>> >> +config INPUT_CMR3000
>> >> + =A0 =A0 tristate "VTI CMR3000 Tri-axis gyroscope"
>> >> + =A0 =A0 help
>> >> + =A0 =A0 =A0 Say Y here if you want to use VTI CMR3000_D0x Gyros=
cope
>> >> + =A0 =A0 =A0 driver
>> >> +
>> >> + =A0 =A0 =A0 This driver currently only supports SPI interface t=
o the
>> >> + =A0 =A0 =A0 controller. Also select the SPI method.
>> >> +
>> >> + =A0 =A0 =A0 If unsure, say N
>> >> +
>> >> + =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
>> >> + =A0 =A0 =A0 module will be called cmr3000_d0x.
>> >> +
>> >> +config INPUT_CMR3000_SPI
>> >> + =A0 =A0 tristate "Support SPI bus connection"
>> >> + =A0 =A0 depends on INPUT_CMR3000 && SPI
>> >> + =A0 =A0 help
>> >> + =A0 =A0 =A0 Say Y here if you want to use VTI CMR3000_D0x Gyros=
cope
>> >> + =A0 =A0 =A0 through SPI interface.
>> >> +
>> >> + =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
>> >> + =A0 =A0 =A0 module will be called cmr3000_d0x_spi.
>> >> +
>> >> =A0config INPUT_XEN_KBDDEV_FRONTEND
>> >> =A0 =A0 =A0 tristate "Xen virtual keyboard and mouse support"
>> >> =A0 =A0 =A0 depends on XEN_FBDEV_FRONTEND
>> >> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Mak=
efile
>> >> index 7305f6f..c7fe09a 100644
>> >> --- a/drivers/input/misc/Makefile
>> >> +++ b/drivers/input/misc/Makefile
>> >> @@ -21,6 +21,8 @@ obj-$(CONFIG_INPUT_CM109) =A0 =A0 =A0 =A0 =A0 +=
=3D cm109.o
>> >> =A0obj-$(CONFIG_INPUT_CMA3000) =A0 =A0 =A0 =A0 =A0+=3D cma3000_d0=
x.o
>> >> =A0obj-$(CONFIG_INPUT_CMA3000_I2C) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 cma3000_d0x_i2c.o
>> >> =A0obj-$(CONFIG_INPUT_CMA3000_SPI) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 cma3000_d0x_spi.o
>> >> +obj-$(CONFIG_INPUT_CMR3000) =A0 =A0 =A0 =A0 =A0+=3D cmr3000_d0x.=
o
>> >> +obj-$(CONFIG_INPUT_CMR3000_SPI) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D =
cmr3000_d0x_spi.o
>> >> =A0obj-$(CONFIG_INPUT_COBALT_BTNS) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 cobalt_btns.o
>> >> =A0obj-$(CONFIG_INPUT_DM355EVM) =A0 =A0 =A0 =A0 +=3D dm355evm_key=
s.o
>> >> =A0obj-$(CONFIG_HP_SDC_RTC) =A0 =A0 =A0 =A0 =A0 =A0 +=3D hp_sdc_r=
tc.o
>> >> diff --git a/drivers/input/misc/cmr3000_d0x.c b/drivers/input/mis=
c/cmr3000_d0x.c
>> >> new file mode 100644
>> >> index 0000000..d046149
>> >> --- /dev/null
>> >> +++ b/drivers/input/misc/cmr3000_d0x.c
>> >> @@ -0,0 +1,426 @@
>> >> +/*
>> >> + * VTI CMR3000_D0x Gyroscope driver
>> >> + *
>> >> + * Copyright (C) 2011 Qtechnology
>> >> + * Author: Ricardo Ribalda <ricardo.ribalda@gmail.com>
>> >> + *
>> >> + * Based on:
>> >> + * =A0 drivers/input/misc/cma3000_d0x.c by: Hemanth V
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or=
 modify it
>> >> + * under the terms of the GNU General Public License version 2 a=
s published by
>> >> + * the Free Software Foundation.
>> >> + *
>> >> + * This program is distributed in the hope that it will be usefu=
l, but WITHOUT
>> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTAB=
ILITY or
>> >> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Publ=
ic License for
>> >> + * more details.
>> >> + *
>> >> + * You should have received a copy of the GNU General Public Lic=
ense along with
>> >> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> >> + */
>> >> +
>> >> +#include <linux/types.h>
>> >> +#include <linux/interrupt.h>
>> >> +#include <linux/delay.h>
>> >> +#include <linux/slab.h>
>> >> +#include <linux/input.h>
>> >> +#include <linux/input/cmr3000.h>
>> >> +#include <linux/of.h>
>> >> +
>> >> +#include "cmr3000_d0x.h"
>> >> +
>> >> +#define CMR3000_REV =A0 =A0 =A0 =A0 0x21
>> >> +
>> >> +#define CMR3000_WHOAMI =A0 =A0 =A00x00
>> >> +#define CMR3000_REVID =A0 =A0 =A0 0x01
>> >> +#define CMR3000_CTRL =A0 =A0 =A0 =A00x02
>> >> +#define CMR3000_STATUS =A0 =A0 =A00x03
>> >> +#define CMR3000_X_LSB =A0 =A0 =A0 0x0C
>> >> +#define CMR3000_X_MSB =A0 =A0 =A0 0x0D
>> >> +#define CMR3000_Y_LSB =A0 =A0 =A0 0x0E
>> >> +#define CMR3000_Y_MSB =A0 =A0 =A0 0x0F
>> >> +#define CMR3000_Z_LSB =A0 =A0 =A0 0x10
>> >> +#define CMR3000_Z_MSB =A0 =A0 =A0 0x11
>> >> +#define CMR3000_I2C_ADDR =A0 =A00x22
>> >> +#define CMR3000_PDR =A0 =A0 =A0 =A0 0x26
>> >> +
>> >> +#define CMR3000_IRQDIS =A0 =A0 (1 << 0)
>> >> +#define CMR3000_MODEMASK =A0 (3 << 1)
>> >> +#define CMR3000_BUSI2C =A0 =A0 (0 << 4)
>> >> +#define CMR3000_BUSSPI =A0 =A0 (1 << 4)
>> >> +#define CMR3000_INTLOW =A0 =A0 (1 << 6)
>> >> +#define CMR3000_INTHIGH =A0 =A0(0 << 6)
>> >> +#define CMR3000_RST =A0 =A0 =A0 =A0(1 << 7)
>> >> +
>> >> +#define CMRMODE_SHIFT =A0 =A0 =A01
>> >> +#define CMRIRQLEVEL_SHIFT =A06
>> >> +
>> >> +#define CMR3000_STATUS_PERR =A0 =A0(1 << 0)
>> >> +#define CMR3000_STATUS_PORST =A0 (1 << 3)
>> >> +
>> >> +/* Settling time delay in ms */
>> >> +#define CMR3000_SETDELAY =A0 =A030
>> >> +
>> >> +/*
>> >> + * Bit weights mult/div in dps for bit 0, other bits need
>> >> + * multipy factor 2^n. 11th bit is the sign bit.
>> >> + */
>> >> +#define BIT_TO_DPS_MUL =A03
>> >> +#define BIT_TO_DPS_DIV 32
>> >> +
>> >> +static struct cmr3000_platform_data cmr3000_default_pdata =3D {
>> >> + =A0 =A0 .irq_level =3D CMR3000_INTHIGH,
>> >> + =A0 =A0 .mode =3D CMRMODE_MEAS80,
>> >> + =A0 =A0 .fuzz_x =3D 1,
>> >> + =A0 =A0 .fuzz_y =3D 1,
>> >> + =A0 =A0 .fuzz_z =3D 1,
>> >> + =A0 =A0 .irqflags =3D 0,
>> >> +};
>> >> +
>> >> +struct cmr3000_gyro_data {
>> >> + =A0 =A0 const struct cmr3000_bus_ops *bus_ops;
>> >> + =A0 =A0 struct cmr3000_platform_data pdata;
>> >> +
>> >> + =A0 =A0 struct device *dev;
>> >> + =A0 =A0 struct input_dev *input_dev;
>> >> +
>> >> + =A0 =A0 int irq_level;
>> >> + =A0 =A0 u8 mode;
>> >> +
>> >> + =A0 =A0 int bit_to_mg;
>> >> + =A0 =A0 int irq;
>> >> +
>> >> + =A0 =A0 struct mutex mutex;
>> >> + =A0 =A0 bool opened;
>> >> + =A0 =A0 bool suspended;
>> >> +};
>> >> +
>> >> +static void decode_dps(struct cmr3000_gyro_data *data, int *data=
x,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *datay, int *dataz)
>> >> +{
>> >> + =A0 =A0 /* Data in 2's complement, convert to dps */
>> >> + =A0 =A0 *datax =3D (((s16) ((*datax) << 2)) * BIT_TO_DPS_MUL) /=
 BIT_TO_DPS_DIV;
>> >> + =A0 =A0 *datay =3D (((s16) ((*datay) << 2)) * BIT_TO_DPS_MUL) /=
 BIT_TO_DPS_DIV;
>> >> + =A0 =A0 *dataz =3D (((s16) ((*dataz) << 2)) * BIT_TO_DPS_MUL) /=
 BIT_TO_DPS_DIV;
>> >> +}
>> >> +
>> >> +static irqreturn_t cmr3000_thread_irq(int irq, void *dev_id)
>> >> +{
>> >> + =A0 =A0 struct cmr3000_gyro_data *data =3D dev_id;
>> >> + =A0 =A0 int datax, datay, dataz;
>> >> + =A0 =A0 u8 mode, intr_status;
>> >> +
>> >> + =A0 =A0 intr_status =3D data->bus_ops->read(data->dev, CMR3000_=
STATUS,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "irq status");
>> >> + =A0 =A0 intr_status =3D data->bus_ops->read(data->dev, CMR3000_=
CTRL,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "control mode");
>> >> + =A0 =A0 if (intr_status < 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> >> +
>> >> + =A0 =A0 /* Interrupt not for this device */
>> >> + =A0 =A0 if (intr_status & CMR3000_IRQDIS)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> >> +
>> >> + =A0 =A0 mode =3D (intr_status & CMR3000_MODEMASK) >> CMRMODE_SH=
IFT;
>> >> + =A0 =A0 if ((mode !=3D CMRMODE_MEAS80)
>> >> + =A0 =A0 =A0 =A0 && (mode !=3D CMRMODE_MEAS20))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> >> +
>> >> + =A0 =A0 datax =3D (data->bus_ops->read(data->dev, CMR3000_X_MSB=
, "X_MSB")) << 8;
>> >> + =A0 =A0 datax |=3D data->bus_ops->read(data->dev, CMR3000_X_LSB=
, "X_LSB");
>> >> + =A0 =A0 datay =3D (data->bus_ops->read(data->dev, CMR3000_Y_MSB=
, "Y_MSB")) << 8;
>> >> + =A0 =A0 datay |=3D data->bus_ops->read(data->dev, CMR3000_Y_LSB=
, "Y_LSB");
>> >> + =A0 =A0 dataz =3D (data->bus_ops->read(data->dev, CMR3000_Z_MSB=
, "Z_MSB")) << 8;
>> >> + =A0 =A0 dataz |=3D data->bus_ops->read(data->dev, CMR3000_Z_LSB=
, "Z_LSB");
>> >> +
>> >> + =A0 =A0 /* Device closed */
>> >> + =A0 =A0 if ((data->mode !=3D CMRMODE_MEAS80)
>> >> + =A0 =A0 =A0 =A0 && (data->mode !=3D CMRMODE_MEAS20))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> >> +
>> >> + =A0 =A0 /* Decode register values to dps */
>> >> + =A0 =A0 decode_dps(data, &datax, &datay, &dataz);
>> >> +
>> >> + =A0 =A0 input_report_abs(data->input_dev, ABS_X, datax);
>> >> + =A0 =A0 input_report_abs(data->input_dev, ABS_Y, datay);
>> >> + =A0 =A0 input_report_abs(data->input_dev, ABS_Z, dataz);
>> >> + =A0 =A0 input_sync(data->input_dev);
>> >> +
>> >> + =A0 =A0 return IRQ_HANDLED;
>> >> +}
>> >> +
>> >> +static int cmr3000_poweron(struct cmr3000_gyro_data *data)
>> >> +{
>> >> + =A0 =A0 const struct cmr3000_platform_data *pdata =3D &data->pd=
ata;
>> >> + =A0 =A0 u8 ctrl;
>> >> + =A0 =A0 int ret;
>> >> +
>> >> + =A0 =A0 ctrl =3D pdata->irq_level << CMRIRQLEVEL_SHIFT;
>> >> + =A0 =A0 ctrl |=3D data->mode << CMRMODE_SHIFT;
>> >> + =A0 =A0 ctrl |=3D data->bus_ops->ctrl_mod;
>> >> + =A0 =A0 ret =3D data->bus_ops->write(data->dev, CMR3000_CTRL, c=
trl,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Mode setting");
>> >> + =A0 =A0 if (ret < 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> >> +
>> >> + =A0 =A0 msleep(CMR3000_SETDELAY);
>> >> +
>> >> + =A0 =A0 return 0;
>> >> +}
>> >> +
>> >> +static int cmr3000_poweroff(struct cmr3000_gyro_data *data)
>> >> +{
>> >> + =A0 =A0 int ret;
>> >> + =A0 =A0 u8 ctrl =3D CMRMODE_POFF;
>> >> +
>> >> + =A0 =A0 ctrl |=3D data->bus_ops->ctrl_mod;
>> >> + =A0 =A0 ctrl |=3D CMR3000_IRQDIS;
>> >> +
>> >> + =A0 =A0 ret =3D data->bus_ops->write(data->dev, CMR3000_CTRL, c=
trl,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Mode setting");
>> >> + =A0 =A0 msleep(CMR3000_SETDELAY);
>> >> +
>> >> + =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static int cmr3000_reset(struct cmr3000_gyro_data *data)
>> >> +{
>> >> + =A0 =A0 int val;
>> >> +
>> >> + =A0 =A0 /* Reset chip */
>> >> + =A0 =A0 data->bus_ops->write(data->dev, CMR3000_CTRL, CMR3000_R=
ST, "Reset");
>> >> + =A0 =A0 mdelay(2);
>> >> +
>> >> + =A0 =A0 /* Settling time delay */
>> >> + =A0 =A0 val =3D data->bus_ops->read(data->dev, CMR3000_STATUS, =
"Status");
>> >> + =A0 =A0 if (val < 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data->dev, "Reset failed\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return val;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 if (val & CMR3000_STATUS_PERR) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data->dev, "Parity Error\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 return cmr3000_poweroff(data);
>> >> +}
>> >> +
>> >> +static int cmr3000_open(struct input_dev *input_dev)
>> >> +{
>> >> + =A0 =A0 struct cmr3000_gyro_data *data =3D input_get_drvdata(in=
put_dev);
>> >> +
>> >> + =A0 =A0 mutex_lock(&data->mutex);
>> >> +
>> >> + =A0 =A0 if (!data->suspended)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweron(data);
>> >> +
>> >> + =A0 =A0 data->opened =3D true;
>> >> +
>> >> + =A0 =A0 mutex_unlock(&data->mutex);
>> >> +
>> >> + =A0 =A0 return 0;
>> >> +}
>> >> +
>> >> +static void cmr3000_close(struct input_dev *input_dev)
>> >> +{
>> >> + =A0 =A0 struct cmr3000_gyro_data *data =3D input_get_drvdata(in=
put_dev);
>> >> +
>> >> + =A0 =A0 mutex_lock(&data->mutex);
>> >> +
>> >> + =A0 =A0 if (!data->suspended)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweroff(data);
>> >> +
>> >> + =A0 =A0 data->opened =3D false;
>> >> +
>> >> + =A0 =A0 mutex_unlock(&data->mutex);
>> >> +}
>> >> +
>> >> +void cmr3000_suspend(struct cmr3000_gyro_data *data)
>> >> +{
>> >> + =A0 =A0 mutex_lock(&data->mutex);
>> >> +
>> >> + =A0 =A0 if (!data->suspended && data->opened)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweroff(data);
>> >> +
>> >> + =A0 =A0 data->suspended =3D true;
>> >> +
>> >> + =A0 =A0 mutex_unlock(&data->mutex);
>> >> +}
>> >> +EXPORT_SYMBOL(cmr3000_suspend);
>> >> +
>> >> +void cmr3000_resume(struct cmr3000_gyro_data *data)
>> >> +{
>> >> + =A0 =A0 mutex_lock(&data->mutex);
>> >> +
>> >> + =A0 =A0 if (data->suspended && data->opened)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweron(data);
>> >> +
>> >> + =A0 =A0 data->suspended =3D false;
>> >> +
>> >> + =A0 =A0 mutex_unlock(&data->mutex);
>> >> +}
>> >> +EXPORT_SYMBOL(cmr3000_resume);
>
> These four functions bother me. =A0All they are doing is wrapping
> poweron/poweroff operation. =A0It makes me wonder what is missing fro=
m
> core code that makes this song-and-dance necessary (or is there
> something available in core code that this driver should be using).
>
>> >> +
>> >> +#ifdef CONFIG_OF
>> >> +void cmr3000_get_pdata_of(struct device *dev, struct cmr3000_gyr=
o_data *data)
>> >> +{
>> >> + =A0 =A0 const __be32 *property;
>> >> + =A0 =A0 int len;
>> >> +
>> >> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,irq_lev=
el", &len);
>> >> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.irq_level =3D be32_to_cpup(=
property);
>> >> +
>> >> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,mode", =
&len);
>> >> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.mode =3D be32_to_cpup(prope=
rty);
>> >> +
>> >> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,fuzz_x"=
, &len);
>> >> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.fuzz_x =3D be32_to_cpup(pro=
perty);
>> >> +
>> >> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,fuzz_y"=
, &len);
>> >> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.fuzz_y =3D be32_to_cpup(pro=
perty);
>> >> +
>> >> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,fuzz_z"=
, &len);
>> >> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.fuzz_z =3D be32_to_cpup(pro=
perty);
>> >> +
>> >> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,irqflag=
s", &len);
>> >> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.irqflags =3D be32_to_cpup(p=
roperty);
>> >> +
>> >> + =A0 =A0 return;
>> >> +}
>> >> +#endif
>> >> +
>> >> +struct cmr3000_gyro_data *cmr3000_init(struct device *dev, int i=
rq,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0const struct cmr3000_bus_ops *bops)
>> >> +{
>> >> + =A0 =A0 struct cmr3000_platform_data *pdata;
>> >> + =A0 =A0 struct cmr3000_gyro_data *data;
>> >> + =A0 =A0 struct input_dev *input_dev;
>> >> + =A0 =A0 int rev;
>> >> + =A0 =A0 int error;
>> >> +
>> >> + =A0 =A0 /* if no IRQ return error */
>> >> + =A0 =A0 if (irq =3D=3D 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 data =3D kzalloc(sizeof(struct cmr3000_gyro_data), GFP_=
KERNEL);
>
> Consider devm_kzalloc() so the driver doesn't need to worry about
> rewinding it.
>
> Also, use 'sizeof(*data)' it's safer.
>
> g.
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
