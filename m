From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv4 5/6] Input: add CMR3000 gyrsocope driver
Date: Tue, 25 Oct 2011 09:26:10 +0200
Message-ID: <CAPybu_2vRWV6RiPtHvj17oTaDa-18FsFa_JhOhWv2k55B0ZaEg@mail.gmail.com>
References: <1319487676-27181-1-git-send-email-ricardo.ribalda@gmail.com>
 <1319487676-27181-6-git-send-email-ricardo.ribalda@gmail.com> <20111024214020.GC4394@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64153 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1JYH0v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Oct 2011 03:26:51 -0400
In-Reply-To: <20111024214020.GC4394@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, jic23@cam.ac.uk, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Grant

 It is similar to the crm, because they came from the same
manufacturer and they share some commands, but that is all.

the crm is a gyroscope and the cma is an accelerometer. I tried to put
both drivers together and the result was a bit too messy, I think it
is easier to understand as two separate drivers, but if you believe
they have to live together and help me making it more understandable,
I have to problem in coding it.

   Regards!

On Mon, Oct 24, 2011 at 23:40, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
> On Mon, Oct 24, 2011 at 10:21:15PM +0200, Ricardo Ribalda Delgado wro=
te:
>> Add support for CMR3000 Tri-axis accelerometer. CMR3000 supports bot=
h
>> I2C/SPI bus communication, currently the driver supports SPI
>> communication, since I have no hardware to test the I2C communicatio=
n.
>
> How different is this driver from the cma3000? =A0Is it a cut and pas=
te job?
>
> g.
>
>>
>> ---
>>
>> v4: Fixes suggested by Dmitry Torokhov
>> =A0 =A0 =A0 -Do not release the input device until the irq has been =
released
>>
>> v3: Fixes suggested by Jonathan Cameron
>> =A0 =A0 =A0 -Support DT
>> =A0 =A0 =A0 -Cleaner spi read/write
>>
>> v2: Fixes suggested by Jonathan Cameron
>> =A0 =A0 =A0 -Code Stype
>> =A0 =A0 =A0 -Check pdata!=3DNULL
>> =A0 =A0 =A0 -SPI align Cacheline
>> =A0 =A0 =A0 -More clear based on
>> =A0 =A0 =A0 -%s/set/write/
>> =A0 =A0 =A0 -%s/accl/gyro/
>> =A0 =A0 =A0 -remove READ/SET macros
>>
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> ---
>> =A0drivers/input/misc/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 24 ++
>> =A0drivers/input/misc/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
>> =A0drivers/input/misc/cmr3000_d0x.c =A0 =A0 | =A0426 +++++++++++++++=
+++++++++++++++++++
>> =A0drivers/input/misc/cmr3000_d0x.h =A0 =A0 | =A0 45 ++++
>> =A0drivers/input/misc/cmr3000_d0x_spi.c | =A0144 ++++++++++++
>> =A0include/linux/input/cmr3000.h =A0 =A0 =A0 =A0| =A0 54 +++++
>> =A06 files changed, 695 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/input/misc/cmr3000_d0x.c
>> =A0create mode 100644 drivers/input/misc/cmr3000_d0x.h
>> =A0create mode 100644 drivers/input/misc/cmr3000_d0x_spi.c
>> =A0create mode 100644 include/linux/input/cmr3000.h
>>
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index b9f2e93..7c56f94 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -524,6 +524,30 @@ config INPUT_CMA3000_SPI
>> =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: t=
he
>> =A0 =A0 =A0 =A0 module will be called cma3000_d0x_spi.
>>
>> +config INPUT_CMR3000
>> + =A0 =A0 tristate "VTI CMR3000 Tri-axis gyroscope"
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Say Y here if you want to use VTI CMR3000_D0x Gyroscop=
e
>> + =A0 =A0 =A0 driver
>> +
>> + =A0 =A0 =A0 This driver currently only supports SPI interface to t=
he
>> + =A0 =A0 =A0 controller. Also select the SPI method.
>> +
>> + =A0 =A0 =A0 If unsure, say N
>> +
>> + =A0 =A0 =A0 To compile this driver as a module, choose M here: the
>> + =A0 =A0 =A0 module will be called cmr3000_d0x.
>> +
>> +config INPUT_CMR3000_SPI
>> + =A0 =A0 tristate "Support SPI bus connection"
>> + =A0 =A0 depends on INPUT_CMR3000 && SPI
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Say Y here if you want to use VTI CMR3000_D0x Gyroscop=
e
>> + =A0 =A0 =A0 through SPI interface.
>> +
>> + =A0 =A0 =A0 To compile this driver as a module, choose M here: the
>> + =A0 =A0 =A0 module will be called cmr3000_d0x_spi.
>> +
>> =A0config INPUT_XEN_KBDDEV_FRONTEND
>> =A0 =A0 =A0 tristate "Xen virtual keyboard and mouse support"
>> =A0 =A0 =A0 depends on XEN_FBDEV_FRONTEND
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefi=
le
>> index 7305f6f..c7fe09a 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -21,6 +21,8 @@ obj-$(CONFIG_INPUT_CM109) =A0 =A0 =A0 =A0 =A0 +=3D=
 cm109.o
>> =A0obj-$(CONFIG_INPUT_CMA3000) =A0 =A0 =A0 =A0 =A0+=3D cma3000_d0x.o
>> =A0obj-$(CONFIG_INPUT_CMA3000_I2C) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D c=
ma3000_d0x_i2c.o
>> =A0obj-$(CONFIG_INPUT_CMA3000_SPI) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D c=
ma3000_d0x_spi.o
>> +obj-$(CONFIG_INPUT_CMR3000) =A0 =A0 =A0 =A0 =A0+=3D cmr3000_d0x.o
>> +obj-$(CONFIG_INPUT_CMR3000_SPI) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D cmr=
3000_d0x_spi.o
>> =A0obj-$(CONFIG_INPUT_COBALT_BTNS) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D c=
obalt_btns.o
>> =A0obj-$(CONFIG_INPUT_DM355EVM) =A0 =A0 =A0 =A0 +=3D dm355evm_keys.o
>> =A0obj-$(CONFIG_HP_SDC_RTC) =A0 =A0 =A0 =A0 =A0 =A0 +=3D hp_sdc_rtc.=
o
>> diff --git a/drivers/input/misc/cmr3000_d0x.c b/drivers/input/misc/c=
mr3000_d0x.c
>> new file mode 100644
>> index 0000000..d046149
>> --- /dev/null
>> +++ b/drivers/input/misc/cmr3000_d0x.c
>> @@ -0,0 +1,426 @@
>> +/*
>> + * VTI CMR3000_D0x Gyroscope driver
>> + *
>> + * Copyright (C) 2011 Qtechnology
>> + * Author: Ricardo Ribalda <ricardo.ribalda@gmail.com>
>> + *
>> + * Based on:
>> + * =A0 drivers/input/misc/cma3000_d0x.c by: Hemanth V
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/slab.h>
>> +#include <linux/input.h>
>> +#include <linux/input/cmr3000.h>
>> +#include <linux/of.h>
>> +
>> +#include "cmr3000_d0x.h"
>> +
>> +#define CMR3000_REV =A0 =A0 =A0 =A0 0x21
>> +
>> +#define CMR3000_WHOAMI =A0 =A0 =A00x00
>> +#define CMR3000_REVID =A0 =A0 =A0 0x01
>> +#define CMR3000_CTRL =A0 =A0 =A0 =A00x02
>> +#define CMR3000_STATUS =A0 =A0 =A00x03
>> +#define CMR3000_X_LSB =A0 =A0 =A0 0x0C
>> +#define CMR3000_X_MSB =A0 =A0 =A0 0x0D
>> +#define CMR3000_Y_LSB =A0 =A0 =A0 0x0E
>> +#define CMR3000_Y_MSB =A0 =A0 =A0 0x0F
>> +#define CMR3000_Z_LSB =A0 =A0 =A0 0x10
>> +#define CMR3000_Z_MSB =A0 =A0 =A0 0x11
>> +#define CMR3000_I2C_ADDR =A0 =A00x22
>> +#define CMR3000_PDR =A0 =A0 =A0 =A0 0x26
>> +
>> +#define CMR3000_IRQDIS =A0 =A0 (1 << 0)
>> +#define CMR3000_MODEMASK =A0 (3 << 1)
>> +#define CMR3000_BUSI2C =A0 =A0 (0 << 4)
>> +#define CMR3000_BUSSPI =A0 =A0 (1 << 4)
>> +#define CMR3000_INTLOW =A0 =A0 (1 << 6)
>> +#define CMR3000_INTHIGH =A0 =A0(0 << 6)
>> +#define CMR3000_RST =A0 =A0 =A0 =A0(1 << 7)
>> +
>> +#define CMRMODE_SHIFT =A0 =A0 =A01
>> +#define CMRIRQLEVEL_SHIFT =A06
>> +
>> +#define CMR3000_STATUS_PERR =A0 =A0(1 << 0)
>> +#define CMR3000_STATUS_PORST =A0 (1 << 3)
>> +
>> +/* Settling time delay in ms */
>> +#define CMR3000_SETDELAY =A0 =A030
>> +
>> +/*
>> + * Bit weights mult/div in dps for bit 0, other bits need
>> + * multipy factor 2^n. 11th bit is the sign bit.
>> + */
>> +#define BIT_TO_DPS_MUL =A03
>> +#define BIT_TO_DPS_DIV 32
>> +
>> +static struct cmr3000_platform_data cmr3000_default_pdata =3D {
>> + =A0 =A0 .irq_level =3D CMR3000_INTHIGH,
>> + =A0 =A0 .mode =3D CMRMODE_MEAS80,
>> + =A0 =A0 .fuzz_x =3D 1,
>> + =A0 =A0 .fuzz_y =3D 1,
>> + =A0 =A0 .fuzz_z =3D 1,
>> + =A0 =A0 .irqflags =3D 0,
>> +};
>> +
>> +struct cmr3000_gyro_data {
>> + =A0 =A0 const struct cmr3000_bus_ops *bus_ops;
>> + =A0 =A0 struct cmr3000_platform_data pdata;
>> +
>> + =A0 =A0 struct device *dev;
>> + =A0 =A0 struct input_dev *input_dev;
>> +
>> + =A0 =A0 int irq_level;
>> + =A0 =A0 u8 mode;
>> +
>> + =A0 =A0 int bit_to_mg;
>> + =A0 =A0 int irq;
>> +
>> + =A0 =A0 struct mutex mutex;
>> + =A0 =A0 bool opened;
>> + =A0 =A0 bool suspended;
>> +};
>> +
>> +static void decode_dps(struct cmr3000_gyro_data *data, int *datax,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *datay, int *dataz)
>> +{
>> + =A0 =A0 /* Data in 2's complement, convert to dps */
>> + =A0 =A0 *datax =3D (((s16) ((*datax) << 2)) * BIT_TO_DPS_MUL) / BI=
T_TO_DPS_DIV;
>> + =A0 =A0 *datay =3D (((s16) ((*datay) << 2)) * BIT_TO_DPS_MUL) / BI=
T_TO_DPS_DIV;
>> + =A0 =A0 *dataz =3D (((s16) ((*dataz) << 2)) * BIT_TO_DPS_MUL) / BI=
T_TO_DPS_DIV;
>> +}
>> +
>> +static irqreturn_t cmr3000_thread_irq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct cmr3000_gyro_data *data =3D dev_id;
>> + =A0 =A0 int datax, datay, dataz;
>> + =A0 =A0 u8 mode, intr_status;
>> +
>> + =A0 =A0 intr_status =3D data->bus_ops->read(data->dev, CMR3000_STA=
TUS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "irq status");
>> + =A0 =A0 intr_status =3D data->bus_ops->read(data->dev, CMR3000_CTR=
L,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "control mode");
>> + =A0 =A0 if (intr_status < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> +
>> + =A0 =A0 /* Interrupt not for this device */
>> + =A0 =A0 if (intr_status & CMR3000_IRQDIS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> +
>> + =A0 =A0 mode =3D (intr_status & CMR3000_MODEMASK) >> CMRMODE_SHIFT=
;
>> + =A0 =A0 if ((mode !=3D CMRMODE_MEAS80)
>> + =A0 =A0 =A0 =A0 && (mode !=3D CMRMODE_MEAS20))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> +
>> + =A0 =A0 datax =3D (data->bus_ops->read(data->dev, CMR3000_X_MSB, "=
X_MSB")) << 8;
>> + =A0 =A0 datax |=3D data->bus_ops->read(data->dev, CMR3000_X_LSB, "=
X_LSB");
>> + =A0 =A0 datay =3D (data->bus_ops->read(data->dev, CMR3000_Y_MSB, "=
Y_MSB")) << 8;
>> + =A0 =A0 datay |=3D data->bus_ops->read(data->dev, CMR3000_Y_LSB, "=
Y_LSB");
>> + =A0 =A0 dataz =3D (data->bus_ops->read(data->dev, CMR3000_Z_MSB, "=
Z_MSB")) << 8;
>> + =A0 =A0 dataz |=3D data->bus_ops->read(data->dev, CMR3000_Z_LSB, "=
Z_LSB");
>> +
>> + =A0 =A0 /* Device closed */
>> + =A0 =A0 if ((data->mode !=3D CMRMODE_MEAS80)
>> + =A0 =A0 =A0 =A0 && (data->mode !=3D CMRMODE_MEAS20))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
>> +
>> + =A0 =A0 /* Decode register values to dps */
>> + =A0 =A0 decode_dps(data, &datax, &datay, &dataz);
>> +
>> + =A0 =A0 input_report_abs(data->input_dev, ABS_X, datax);
>> + =A0 =A0 input_report_abs(data->input_dev, ABS_Y, datay);
>> + =A0 =A0 input_report_abs(data->input_dev, ABS_Z, dataz);
>> + =A0 =A0 input_sync(data->input_dev);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int cmr3000_poweron(struct cmr3000_gyro_data *data)
>> +{
>> + =A0 =A0 const struct cmr3000_platform_data *pdata =3D &data->pdata=
;
>> + =A0 =A0 u8 ctrl;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ctrl =3D pdata->irq_level << CMRIRQLEVEL_SHIFT;
>> + =A0 =A0 ctrl |=3D data->mode << CMRMODE_SHIFT;
>> + =A0 =A0 ctrl |=3D data->bus_ops->ctrl_mod;
>> + =A0 =A0 ret =3D data->bus_ops->write(data->dev, CMR3000_CTRL, ctrl=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Mode setting");
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> +
>> + =A0 =A0 msleep(CMR3000_SETDELAY);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int cmr3000_poweroff(struct cmr3000_gyro_data *data)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 u8 ctrl =3D CMRMODE_POFF;
>> +
>> + =A0 =A0 ctrl |=3D data->bus_ops->ctrl_mod;
>> + =A0 =A0 ctrl |=3D CMR3000_IRQDIS;
>> +
>> + =A0 =A0 ret =3D data->bus_ops->write(data->dev, CMR3000_CTRL, ctrl=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Mode setting");
>> + =A0 =A0 msleep(CMR3000_SETDELAY);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int cmr3000_reset(struct cmr3000_gyro_data *data)
>> +{
>> + =A0 =A0 int val;
>> +
>> + =A0 =A0 /* Reset chip */
>> + =A0 =A0 data->bus_ops->write(data->dev, CMR3000_CTRL, CMR3000_RST,=
 "Reset");
>> + =A0 =A0 mdelay(2);
>> +
>> + =A0 =A0 /* Settling time delay */
>> + =A0 =A0 val =3D data->bus_ops->read(data->dev, CMR3000_STATUS, "St=
atus");
>> + =A0 =A0 if (val < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data->dev, "Reset failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return val;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (val & CMR3000_STATUS_PERR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data->dev, "Parity Error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return cmr3000_poweroff(data);
>> +}
>> +
>> +static int cmr3000_open(struct input_dev *input_dev)
>> +{
>> + =A0 =A0 struct cmr3000_gyro_data *data =3D input_get_drvdata(input=
_dev);
>> +
>> + =A0 =A0 mutex_lock(&data->mutex);
>> +
>> + =A0 =A0 if (!data->suspended)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweron(data);
>> +
>> + =A0 =A0 data->opened =3D true;
>> +
>> + =A0 =A0 mutex_unlock(&data->mutex);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void cmr3000_close(struct input_dev *input_dev)
>> +{
>> + =A0 =A0 struct cmr3000_gyro_data *data =3D input_get_drvdata(input=
_dev);
>> +
>> + =A0 =A0 mutex_lock(&data->mutex);
>> +
>> + =A0 =A0 if (!data->suspended)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweroff(data);
>> +
>> + =A0 =A0 data->opened =3D false;
>> +
>> + =A0 =A0 mutex_unlock(&data->mutex);
>> +}
>> +
>> +void cmr3000_suspend(struct cmr3000_gyro_data *data)
>> +{
>> + =A0 =A0 mutex_lock(&data->mutex);
>> +
>> + =A0 =A0 if (!data->suspended && data->opened)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweroff(data);
>> +
>> + =A0 =A0 data->suspended =3D true;
>> +
>> + =A0 =A0 mutex_unlock(&data->mutex);
>> +}
>> +EXPORT_SYMBOL(cmr3000_suspend);
>> +
>> +void cmr3000_resume(struct cmr3000_gyro_data *data)
>> +{
>> + =A0 =A0 mutex_lock(&data->mutex);
>> +
>> + =A0 =A0 if (data->suspended && data->opened)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_poweron(data);
>> +
>> + =A0 =A0 data->suspended =3D false;
>> +
>> + =A0 =A0 mutex_unlock(&data->mutex);
>> +}
>> +EXPORT_SYMBOL(cmr3000_resume);
>> +
>> +#ifdef CONFIG_OF
>> +void cmr3000_get_pdata_of(struct device *dev, struct cmr3000_gyro_d=
ata *data)
>> +{
>> + =A0 =A0 const __be32 *property;
>> + =A0 =A0 int len;
>> +
>> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,irq_level"=
, &len);
>> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.irq_level =3D be32_to_cpup(pro=
perty);
>> +
>> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,mode", &le=
n);
>> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.mode =3D be32_to_cpup(property=
);
>> +
>> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,fuzz_x", &=
len);
>> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.fuzz_x =3D be32_to_cpup(proper=
ty);
>> +
>> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,fuzz_y", &=
len);
>> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.fuzz_y =3D be32_to_cpup(proper=
ty);
>> +
>> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,fuzz_z", &=
len);
>> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.fuzz_z =3D be32_to_cpup(proper=
ty);
>> +
>> + =A0 =A0 property =3D of_get_property(dev->of_node, "vti,irqflags",=
 &len);
>> + =A0 =A0 if (property && len =3D=3D sizeof(int))
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->pdata.irqflags =3D be32_to_cpup(prop=
erty);
>> +
>> + =A0 =A0 return;
>> +}
>> +#endif
>> +
>> +struct cmr3000_gyro_data *cmr3000_init(struct device *dev, int irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const struct cmr3000_bus_ops *bops)
>> +{
>> + =A0 =A0 struct cmr3000_platform_data *pdata;
>> + =A0 =A0 struct cmr3000_gyro_data *data;
>> + =A0 =A0 struct input_dev *input_dev;
>> + =A0 =A0 int rev;
>> + =A0 =A0 int error;
>> +
>> + =A0 =A0 /* if no IRQ return error */
>> + =A0 =A0 if (irq =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 data =3D kzalloc(sizeof(struct cmr3000_gyro_data), GFP_KER=
NEL);
>> + =A0 =A0 input_dev =3D input_allocate_device();
>> + =A0 =A0 if (!data || !input_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*Init platform data*/
>> + =A0 =A0 if (dev->platform_data !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&data->pdata, dev->platform_data, s=
izeof(data->pdata));
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&data->pdata, &cmr3000_default_pdat=
a,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(dat=
a->pdata));
>> + =A0 =A0 =A0 =A0 =A0 =A0 #ifdef CONFIG_OF
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dev->of_node !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmr3000_get_pdata_of(dev, =
data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> + =A0 =A0 =A0 =A0 =A0 =A0 #endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(dev, "platform data not found, us=
ing default\n");
>> + =A0 =A0 }
>> + =A0 =A0 pdata =3D &data->pdata;
>> +
>> + =A0 =A0 data->dev =3D dev;
>> + =A0 =A0 data->input_dev =3D input_dev;
>> + =A0 =A0 data->bus_ops =3D bops;
>> + =A0 =A0 data->irq =3D irq;
>> + =A0 =A0 mutex_init(&data->mutex);
>> +
>> + =A0 =A0 data->mode =3D pdata->mode;
>> + =A0 =A0 if ((data->mode !=3D CMRMODE_MEAS80)
>> + =A0 =A0 =A0 =A0 && (data->mode !=3D CMRMODE_MEAS20)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->mode =3D CMRMODE_MEAS80;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "Invalid mode specified, ass=
uming 80Hz\n");
>> + =A0 =A0 }
>> +
>> + =A0 =A0 data->irq_level =3D pdata->irq_level;
>> + =A0 =A0 if ((data->irq_level !=3D CMR3000_INTLOW)
>> + =A0 =A0 =A0 =A0 && (data->irq_level !=3D CMR3000_INTHIGH)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->irq_level =3D CMR3000_INTHIGH;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(data->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Invalid int level spec=
ified, assuming high\n");
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_dev->name =3D "cmr3000-gyroscope";
>> + =A0 =A0 input_dev->id.bustype =3D bops->bustype;
>> + =A0 =A0 input_dev->open =3D cmr3000_open;
>> + =A0 =A0 input_dev->close =3D cmr3000_close;
>> +
>> + =A0 =A0 __set_bit(EV_ABS, input_dev->evbit);
>> +
>> + =A0 =A0 input_set_abs_params(input_dev, ABS_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-CMRRANGE, CMRR=
ANGE, pdata->fuzz_x, 0);
>> + =A0 =A0 input_set_abs_params(input_dev, ABS_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-CMRRANGE, CMRR=
ANGE, pdata->fuzz_y, 0);
>> + =A0 =A0 input_set_abs_params(input_dev, ABS_Z,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-CMRRANGE, CMRR=
ANGE, pdata->fuzz_z, 0);
>> +
>> + =A0 =A0 input_set_drvdata(input_dev, data);
>> +
>> + =A0 =A0 error =3D cmr3000_reset(data);
>> + =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> +
>> + =A0 =A0 rev =3D data->bus_ops->read(data->dev, CMR3000_REVID, "Rev=
id");
>> + =A0 =A0 if (rev < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D rev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> + =A0 =A0 if (rev !=3D CMR3000_REV) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("CMR3000 Gyroscope: Unknown Revisio=
n %x\n", rev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> + =A0 =A0 pr_info("CMR3000 Gyroscope: Revision %x\n", rev);
>> +
>> + =A0 =A0 error =3D request_threaded_irq(irq, NULL, cmr3000_thread_i=
rq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pdata->irqflags | IRQF_ONESHOT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"cmr3000_d0x", data);
>> + =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "request_threaded_irq failed\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 error =3D input_register_device(data->input_dev);
>> + =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to register input dev=
ice\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return data;
>> +
>> +err_free_irq:
>> + =A0 =A0 free_irq(irq, data);
>> +err_free_mem:
>> + =A0 =A0 input_free_device(input_dev);
>> + =A0 =A0 kfree(data);
>> +err_out:
>> + =A0 =A0 return ERR_PTR(error);
>> +}
>> +EXPORT_SYMBOL(cmr3000_init);
>> +
>> +void cmr3000_exit(struct cmr3000_gyro_data *data)
>> +{
>> + =A0 =A0 free_irq(data->irq, data);
>> + =A0 =A0 input_unregister_device(data->input_dev);
>> + =A0 =A0 kfree(data);
>> +}
>> +EXPORT_SYMBOL(cmr3000_exit);
>> +
>> +MODULE_DESCRIPTION("CMR3000-D0x Gyroscope Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
>> diff --git a/drivers/input/misc/cmr3000_d0x.h b/drivers/input/misc/c=
mr3000_d0x.h
>> new file mode 100644
>> index 0000000..3d0984a
>> --- /dev/null
>> +++ b/drivers/input/misc/cmr3000_d0x.h
>> @@ -0,0 +1,45 @@
>> +/*
>> + * VTI CMR3000_D0x Gyroscpe driver
>> + *
>> + * Copyright (C) 2011 Qtechnology
>> + * Author: Ricardo Ribalda <ricardo.ribalda@gmail.com>
>> + *
>> + * Based on:
>> + * =A0 drivers/input/misc/cma3000_d0x.h by Hemanth V
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef _INPUT_CMR3000_H
>> +#define _INPUT_CMR3000_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/input.h>
>> +
>> +struct device;
>> +struct cmr3000_gyro_data;
>> +
>> +struct cmr3000_bus_ops {
>> + =A0 =A0 u16 bustype;
>> + =A0 =A0 u8 ctrl_mod;
>> + =A0 =A0 int (*read) (struct device *, u8, char *);
>> + =A0 =A0 int (*write) (struct device *, u8, u8, char *);
>> +};
>> +
>> +struct cmr3000_gyro_data *cmr3000_init(struct device *dev, int irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const struct cmr3000_bus_ops *bops);
>> +void cmr3000_exit(struct cmr3000_gyro_data *);
>> +void cmr3000_suspend(struct cmr3000_gyro_data *);
>> +void cmr3000_resume(struct cmr3000_gyro_data *);
>> +
>> +#endif
>> diff --git a/drivers/input/misc/cmr3000_d0x_spi.c b/drivers/input/mi=
sc/cmr3000_d0x_spi.c
>> new file mode 100644
>> index 0000000..7f27fa3
>> --- /dev/null
>> +++ b/drivers/input/misc/cmr3000_d0x_spi.c
>> @@ -0,0 +1,144 @@
>> +/*
>> + * Implements SPI interface for VTI CMR300_D0x Accelerometer driver
>> + *
>> + * Copyright (C) 2011 Qtechnology
>> + * Author: Ricardo Ribalda <ricardo.ribalda@gmail.com.com>
>> + * Based on:
>> + * =A0 drivers/input/misc/cma3000_d0x_i2c.c by Hemanth V
>> + * =A0 drivers/input/mis/adxl34x-spi.c by Michael Hennerich
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/input/cmr3000.h>
>> +#include "cmr3000_d0x.h"
>> +
>> +static int cmr3000_spi_write(struct device *dev, u8 reg, u8 val, ch=
ar *msg)
>> +{
>> + =A0 =A0 struct spi_device *spi =3D to_spi_device(dev);
>> + =A0 =A0 int ret;
>> + =A0 =A0 u8 tmp[2];
>> +
>> + =A0 =A0 tmp[0] =3D (reg << 2) | 2;
>> + =A0 =A0 tmp[1] =3D val;
>> +
>> + =A0 =A0 ret =3D spi_write_then_read(spi, tmp, sizeof(tmp), NULL, 0=
);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s failed (%s, %d)\n", __fun=
c__, msg, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int cmr3000_spi_read(struct device *dev, u8 reg, char *msg)
>> +{
>> + =A0 =A0 struct spi_device *spi =3D to_spi_device(dev);
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D spi_w8r8(spi, reg << 2);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s failed (%s, %d)\n", __fun=
c__, msg, ret);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static const struct cmr3000_bus_ops cmr3000_spi_bops =3D {
>> + =A0 =A0 .bustype =3D BUS_SPI,
>> +#define CMR3000_BUSSPI =A0 =A0 (1 << 4)
>> + =A0 =A0 .ctrl_mod =3D CMR3000_BUSSPI,
>> + =A0 =A0 .read =3D cmr3000_spi_read,
>> + =A0 =A0 .write =3D cmr3000_spi_write,
>> +};
>> +
>> +static int __devinit cmr3000_spi_probe(struct spi_device *spi)
>> +{
>> + =A0 =A0 struct cmr3000_gyro_data *data;
>> +
>> + =A0 =A0 data =3D cmr3000_init(&spi->dev, spi->irq, &cmr3000_spi_bo=
ps);
>> + =A0 =A0 if (IS_ERR(data))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(data);
>> +
>> + =A0 =A0 spi_set_drvdata(spi, data);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int __devexit cmr3000_spi_remove(struct spi_device *spi)
>> +{
>> + =A0 =A0 struct cmr3000_gyro_data *data =3D dev_get_drvdata(&spi->d=
ev);
>> +
>> + =A0 =A0 cmr3000_exit(data);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int cmr3000_spi_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct spi_device *spi =3D to_spi_device(dev);
>> + =A0 =A0 struct cmr3000_gyro_data *data =3D dev_get_drvdata(&spi->d=
ev);
>> +
>> + =A0 =A0 cmr3000_suspend(data);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int cmr3000_spi_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct spi_device *spi =3D to_spi_device(dev);
>> + =A0 =A0 struct cmr3000_gyro_data *data =3D dev_get_drvdata(&spi->d=
ev);
>> +
>> + =A0 =A0 cmr3000_resume(data);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static const struct dev_pm_ops cmr3000_spi_pm_ops =3D {
>> + =A0 =A0 .suspend =3D cmr3000_spi_suspend,
>> + =A0 =A0 .resume =3D cmr3000_spi_resume,
>> +};
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(cmr3000_spi_pm, cmr3000_spi_suspend,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmr3000_spi_resume);
>> +
>> +static struct spi_driver cmr3000_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "cmr3000_d01",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.bus =3D &spi_bus_type,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =3D &cmr3000_spi_pm,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> + =A0 =A0 .probe =3D cmr3000_spi_probe,
>> + =A0 =A0 .remove =3D __devexit_p(cmr3000_spi_remove),
>> +};
>> +
>> +static int __init cmr3000_spi_init(void)
>> +{
>> + =A0 =A0 return spi_register_driver(&cmr3000_driver);
>> +}
>> +
>> +static void __exit cmr3000_spi_exit(void)
>> +{
>> + =A0 =A0 spi_unregister_driver(&cmr3000_driver);
>> +}
>> +
>> +module_init(cmr3000_spi_init);
>> +module_exit(cmr3000_spi_exit);
>> +
>> +MODULE_DESCRIPTION("CMR3000-D0x Gyroscope SPI Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
>> diff --git a/include/linux/input/cmr3000.h b/include/linux/input/cmr=
3000.h
>> new file mode 100644
>> index 0000000..dfcf9e3
>> --- /dev/null
>> +++ b/include/linux/input/cmr3000.h
>> @@ -0,0 +1,54 @@
>> +/*
>> + * VTI CMR3000_Dxx Gyroscope driver
>> + *
>> + * Copyright (C) 2011 Qtechnology
>> + * Author: Ricardo Ribalda <ricardo.ribalda@gmail.com>
>> + *
>> + * Based on:
>> + * =A0 include/linux/input/cma3000.h by Hemanth V
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify it
>> + * under the terms of the GNU General Public License version 2 as p=
ublished by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILI=
TY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public =
License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e along with
>> + * this program. =A0If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef _LINUX_CMR3000_H
>> +#define _LINUX_CMR3000_H
>> +
>> +#define CMRMODE_DEFAULT =A0 =A00
>> +#define CMRMODE_STANDBY =A0 =A01
>> +#define CMRMODE_MEAS20 =A0 =A0 2
>> +#define CMRMODE_MEAS80 =A0 =A0 3
>> +#define CMRMODE_POFF =A0 =A0 =A0 0
>> +
>> +#define CMRIRQLEVEL_LOW =A0 =A01
>> +#define CMRIRQLEVEL_HIGH =A0 0
>> +
>> +#define CMRRANGE =A0 3072
>> +
>> +/**
>> + * struct cmr3000_platform_data - CMR3000 Platform data
>> + * @fuzz_x: Noise on X Axis
>> + * @fuzz_y: Noise on Y Axis
>> + * @fuzz_z: Noise on Z Axis
>> + * @mode: Operating mode
>> + * @irq_level: Irq level
>> + */
>> +struct cmr3000_platform_data {
>> + =A0 =A0 int fuzz_x;
>> + =A0 =A0 int fuzz_y;
>> + =A0 =A0 int fuzz_z;
>> + =A0 =A0 uint8_t irq_level;
>> + =A0 =A0 uint8_t mode;
>> + =A0 =A0 unsigned long irqflags;
>> +};
>> +
>> +#endif
>> --
>> 1.7.7
>>
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
