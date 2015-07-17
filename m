From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for SiS i2c touch driver
Date: Fri, 17 Jul 2015 16:21:35 -0700
Message-ID: <20150717232135.GG39282@dtor-ws>
References: <20150707035128.GA28112@sis.com>
 <8322374EB97AA24A95D0DDBFC8F1CA1DFD3BD6@SISMBEV01.sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35633 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbbGQXVk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 19:21:40 -0400
Received: by pdrg1 with SMTP id g1so68484130pdr.2
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2015 16:21:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8322374EB97AA24A95D0DDBFC8F1CA1DFD3BD6@SISMBEV01.sis.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5ri45pOx6LGqICh5dWdlcl95dSk=?= <yuger_yu@sis.com>
Cc: linux-input@vger.kernel.org, =?utf-8?B?5pu+5am36JGzICh0YW1teV90c2VuZyk=?= <tammy_tseng@sis.com>

Hi Yuger,

On Wed, Jul 15, 2015 at 06:03:52PM +0800, =E6=B8=B8=E6=93=B1=E8=B1=AA (=
yuger_yu) wrote:
> Hi, This patch is to add support for SiS i2c touch panel.
> Thanks a lot.

Thank you for your submission. See the comments below.

>=20
> Signed-off-by: Yuger <yuger_yu@sis.com>
> ---
>  drivers/input/touchscreen/Kconfig   |  11 +
>  drivers/input/touchscreen/Makefile  |   1 +
>  drivers/input/touchscreen/sis_i2c.c | 627 ++++++++++++++++++++++++++=
++++++++++
>  drivers/input/touchscreen/sis_i2c.h | 164 ++++++++++
>  4 files changed, 803 insertions(+)
>  create mode 100644 drivers/input/touchscreen/sis_i2c.c
>  create mode 100644 drivers/input/touchscreen/sis_i2c.h
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index d20fe1d..3d7a30d 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1027,4 +1027,15 @@ config TOUCHSCREEN_ZFORCE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zforce_ts.
> =20
> +config TOUCHSCREEN_SIS_I2C
> +	tristate "SiS 9200 family I2C touchscreen driver"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for I2C connected SiS touch panels.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called sis_i2c.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index 44deea7..02b466e 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -84,3 +84,4 @@ obj-$(CONFIG_TOUCHSCREEN_W90X900)	+=3D w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_SX8654)	+=3D sx8654.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+=3D tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+=3D zforce_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)   +=3D sis_i2c.o
> diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touc=
hscreen/sis_i2c.c
> new file mode 100644
> index 0000000..22dfc1f
> --- /dev/null
> +++ b/drivers/input/touchscreen/sis_i2c.c
> @@ -0,0 +1,627 @@
> +/*
> + * Touch Screen driver for SiS 9200 family I2C Touch panels
> + *
> + * Copyright (C) 2015 SiS, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Date: 2015/07/07

Date of what?

> + */
> +
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/hrtimer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include "sis_i2c.h"

No need to have separate header file; pull it into this file.

> +#include <linux/linkage.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/uaccess.h>
> +#include <linux/irq.h>
> +#include <asm/unaligned.h>
> +#include <linux/input/mt.h>	/*For Type-B Slot function*/
> +#include <linux/crc-itu-t.h>	/*For CRC Check*/
> +
> +/* Addresses to scan */
> +static const unsigned short normal_i2c[] =3D { SIS_SLAVE_ADDR,=20
> +I2C_CLIENT_END }; static struct workqueue_struct *sis_wq; struct=20
> +sis_ts_data *ts_bak; static void sis_tpinfo_clear(struct=20
> +sisTP_driver_data *TPInfo, int max);

It looks like your mailer warred patch somehow. Please try sending newx=
t
version via "git send-email".

> +
> +static int sis_command_for_read(struct i2c_client *client, int rleng=
th,
> +							unsigned char *rdata)
> +{
> +	int ret;
> +	struct i2c_msg msg;
> +
> +	msg.addr =3D client->addr;
> +	msg.flags =3D I2C_M_RD; /*Read*/
> +	msg.len =3D rlength;
> +	msg.buf =3D rdata;
> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +	return ret;

i2c_master_recv()?

> +}
> +
> +static int sis_cul_unit(uint8_t report_id) {

=46or functions open brace should be on a new line. Have you tried runn=
ing
=2E/scripts/checkpatch.pl over your code?

> +	int ret =3D NORMAL_LEN_PER_POINT;
> +
> +	if (report_id !=3D ALL_IN_ONE_PACKAGE) {
> +		if (IS_AREA(report_id))
> +			ret +=3D AREA_LEN_PER_POINT;
> +		if (IS_PRESSURE(report_id))
> +			ret +=3D PRESSURE_LEN_PER_POINT;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sis_ReadPacket(struct i2c_client *client, uint8_t cmd,=20
> +uint8_t *buf) {
> +	uint8_t tmpbuf[MAX_BYTE] =3D {0};	/*MAX_BYTE =3D 64;*/
> +	int ret;
> +	int touchnum =3D 0;
> +	int p_count =3D 0;
> +	int touc_formate_id =3D 0;
> +	int locate =3D 0;
> +	bool read_first =3D true;
> +	/*
> +	* New i2c format
> +	* buf[0] =3D Low 8 bits of byte count value
> +	* buf[1] =3D High 8 bits of byte counte value

                                       ^^^^^^ count

> +	* buf[2] =3D Report ID
> +	* buf[touch num * 6 + 2 ] =3D Touch information;
> +	* 1 touch point has 6 bytes, it could be none if no touch
> +	* buf[touch num * 6 + 3] =3D Touch numbers
> +	*
> +	* One touch point information include 6 bytes, the order is
> +	*
> +	* 1. status =3D touch down or touch up
> +	* 2. id =3D finger id
> +	* 3. x axis low 8 bits
> +	* 4. x axis high 8 bits
> +	* 5. y axis low 8 bits
> +	* 6. y axis high 8 bits
> +	* */
> +	do {
> +		if (locate >=3D PACKET_BUFFER_SIZE) {
> +			pr_err("sis_ReadPacket: Buf Overflow\n");
> +			return -EPERM;
> +		}
> +		ret =3D sis_command_for_read(client, MAX_BYTE, tmpbuf);
> +
> +		if (ret < 0) {
> +			pr_err("sis_ReadPacket: i2c transfer error\n");
> +			return ret;
> +		}
> +		/*error package length of receiving data*/
> +		else if (tmpbuf[P_BYTECOUNT] > MAX_BYTE) {
> +			pr_err("sis_ReadPacket: Error Bytecount\n");
> +			return -EPERM;
> +		}
> +		if (read_first) {
> +			/*access NO TOUCH event unless BUTTON NO TOUCH event*/
> +			if (tmpbuf[P_BYTECOUNT] =3D=3D 0/*NO_TOUCH_BYTECOUNT*/)
> +				return 0;	/*touchnum is 0*/
> +		}
> +		/*skip parsing data when two devices are registered
> +		 * at the same slave address*/

The format for multi-line comments is

		/*
		 * Multi
		 * line
		 * comment.
		 */

> +		/*parsing data when P_REPORT_ID && 0xf is TOUCH_FORMAT
> +		 * or P_REPORT_ID is ALL_IN_ONE_PACKAGE*/
> +		touc_formate_id =3D tmpbuf[P_REPORT_ID] & 0xf;

Replace touc with touch?

> +		if ((touc_formate_id !=3D TOUCH_FORMAT)
> +		&& (touc_formate_id !=3D HIDI2C_FORMAT)
> +		&& (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE)) {

Preference: logical operations at the end of line

		if (a &&
		    (b || c)) {
			...
		}

> +			pr_err("sis_ReadPacket: Error Report_ID\n");
> +			return -EPERM;
> +		}
> +		p_count =3D (int) tmpbuf[P_BYTECOUNT] - 1;	/*start from 0*/
> +		if (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) {
> +			if (IS_TOUCH(tmpbuf[P_REPORT_ID])) {
> +				p_count -=3D BYTE_CRC_I2C;/*delete 2 byte crc*/
> +			} else if (IS_HIDI2C(tmpbuf[P_REPORT_ID])) {
> +				p_count -=3D BYTE_CRC_HIDI2C;
> +			} else {	/*should not be happen*/
> +				pr_err("sis_ReadPacket: delete crc error\n");
> +				return -EPERM;
> +			}
> +			if (IS_SCANTIME(tmpbuf[P_REPORT_ID]))
> +				p_count -=3D BYTE_SCANTIME;
> +		}
> +		/*For ALL_IN_ONE_PACKAGE*/
> +		if (read_first) {
> +			touchnum =3D tmpbuf[p_count];
> +		} else {
> +			if (tmpbuf[p_count] !=3D 0) {
> +				pr_err("sis_ReadPacket: get error package\n");
> +				return -EPERM;
> +			}
> +		}
> +
> +#ifdef _CHECK_CRC

Why would we not want CRC? When do you expect it being compiled out?

> +		/* HID over I2C data foramt and no touch packet without CRC */
> +		if ((touc_formate_id !=3D HIDI2C_FORMAT) &&
> +			(tmpbuf[P_BYTECOUNT] > 3)) {
> +			int crc_end =3D p_count + (IS_SCANTIME(
> +				tmpbuf[P_REPORT_ID]) * 2);
> +			uint16_t buf_crc =3D crc_itu_t(
> +				0, tmpbuf + 2, crc_end - 1);
> +			int l_package_crc =3D (IS_SCANTIME(
> +				tmpbuf[P_REPORT_ID]) * 2) + p_count + 1;
> +			uint16_t package_crc =3D get_unaligned_le16(
> +				&tmpbuf[l_package_crc]);
> +
> +			if (buf_crc !=3D package_crc) {
> +				pr_err("sis_ReadPacket: CRC Error\n");
> +				return -EPERM;
> +			}
> +		}
> +#endif
> +		memcpy(&buf[locate], &tmpbuf[0], 64);
> +		/*Buf_Data [0~63] [64~128]*/
> +		locate +=3D 64;

A #define for constant 64 would be appreciated.

> +		read_first =3D false;
> +	} while (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE &&
> +			tmpbuf[p_count] > 5);
> +	return touchnum;
> +}
> +
> +static void sis_ts_work_func(struct work_struct *work) {
> +	struct sis_ts_data *ts =3D container_of(work, struct sis_ts_data, w=
ork);
> +	struct sisTP_driver_data *TPInfo =3D ts->TPInfo;
> +	int ret;
> +	int point_unit;
> +	uint8_t buf[PACKET_BUFFER_SIZE] =3D {0};
> +	uint8_t i =3D 0, fingers =3D 0;
> +	uint8_t px =3D 0, py =3D 0, pstatus =3D 0;
> +	uint8_t p_area =3D 0;
> +	uint8_t p_preasure =3D 0;

Kernel uses u8/u16/u32 instead of uintXX_t.

> +	int CheckID[MAX_FINGERS];
> +	static int Pre_CheckID[MAX_FINGERS];
> +	struct TypeB_Slot MM_Slot[MAX_FINGERS];

CamelCases are not for kernel code.

> +
> +	memset(CheckID, 0, sizeof(int)*MAX_FINGERS);
> +
> +	mutex_lock(&ts->mutex_wq);
> +	/*I2C or SMBUS block data read*/
> +	ret =3D sis_ReadPacket(ts->client, SIS_CMD_NORMAL, buf);
> +	/*Error Number*/
> +	if (ret < 0)
> +		goto err_free_allocate;

Allocate what?

> +	/*access NO TOUCH event unless BUTTON NO TOUCH event*/
> +	else if (ret =3D=3D 0) {
> +		fingers =3D 0;
> +		sis_tpinfo_clear(TPInfo, MAX_FINGERS);
> +
> +		goto Tye_B_report;

Hm, this sound like the code from here to Tye_B_report label shoudl be
factored out into one or more functions.

> +	}
> +	sis_tpinfo_clear(TPInfo, MAX_FINGERS);
> +
> +	/*Parser and Get the sis9200 data*/
> +	point_unit =3D sis_cul_unit(buf[P_REPORT_ID]);
> +	fingers =3D ret;
> +
> +	TPInfo->fingers =3D fingers =3D (fingers > MAX_FINGERS ? 0 : finger=
s);
> +
> +	/*fingers 10 =3D  0 ~ 9*/
> +	for (i =3D 0; i < fingers; i++) {
> +		if ((buf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) && (i >=3D 5)) {
> +			/*Calc point status*/
> +			pstatus =3D BYTE_BYTECOUNT + BYTE_ReportID
> +					+ ((i - 5) * point_unit);
> +			pstatus +=3D 64;
> +		} else {
> +			pstatus =3D BYTE_BYTECOUNT + BYTE_ReportID
> +					+ (i * point_unit);
> +					/*Calc point status*/
> +		}
> +	    px =3D pstatus + 2;	/*Calc point x_coord*/
> +	    py =3D px + 2;	/*Calc point y_coord*/
> +		if ((buf[pstatus]) =3D=3D TOUCHUP) {
> +			TPInfo->pt[i].Width =3D 0;
> +			TPInfo->pt[i].Height =3D 0;
> +			TPInfo->pt[i].Pressure =3D 0;
> +		} else if (buf[P_REPORT_ID] =3D=3D ALL_IN_ONE_PACKAGE
> +					&& (buf[pstatus]) =3D=3D TOUCHDOWN) {
> +			TPInfo->pt[i].Width =3D 1;
> +			TPInfo->pt[i].Height =3D 1;
> +			TPInfo->pt[i].Pressure =3D 1;
> +		} else if ((buf[pstatus]) =3D=3D TOUCHDOWN) {
> +			p_area =3D py + 2;
> +			p_preasure =3D py + 2 + (IS_AREA(buf[P_REPORT_ID]) * 2);
> +			/*area*/
> +			if (IS_AREA(buf[P_REPORT_ID])) {
> +				TPInfo->pt[i].Width =3D buf[p_area];
> +				TPInfo->pt[i].Height =3D buf[p_area + 1];
> +			} else {
> +				TPInfo->pt[i].Width =3D 1;
> +				TPInfo->pt[i].Height =3D 1;
> +			}
> +			/*pressure*/
> +			if (IS_PRESSURE(buf[P_REPORT_ID]))
> +				TPInfo->pt[i].Pressure =3D (buf[p_preasure]);
> +			else
> +				TPInfo->pt[i].Pressure =3D 1;
> +		} else {
> +			pr_err("sis_ts_work_func: Error Touch Status\n");
> +			goto err_free_allocate;
> +		}
> +		TPInfo->pt[i].id =3D (buf[pstatus + 1]);
> +		TPInfo->pt[i].x =3D get_unaligned_le16(&buf[px]);
> +		TPInfo->pt[i].y =3D get_unaligned_le16(&buf[py]);
> +
> +		CheckID[TPInfo->pt[i].id] =3D 1;
> +		MM_Slot[TPInfo->pt[i].id].id =3D TPInfo->pt[i].id;
> +		MM_Slot[TPInfo->pt[i].id].Pressure =3D TPInfo->pt[i].Pressure;
> +		MM_Slot[TPInfo->pt[i].id].x =3D TPInfo->pt[i].x;
> +		MM_Slot[TPInfo->pt[i].id].y =3D TPInfo->pt[i].y;
> +		MM_Slot[TPInfo->pt[i].id].Width =3D TPInfo->pt[i].Width
> +						* AREA_UNIT;
> +		MM_Slot[TPInfo->pt[i].id].Height =3D TPInfo->pt[i].Height
> +						* AREA_UNIT;
> +
> +	}
> +
> +Tye_B_report:
> +
> +	for (i =3D 0; i < MAX_FINGERS; i++) {
> +		if ((CheckID[i] !=3D Pre_CheckID[i]) && (CheckID[i] !=3D 1))
> +			CheckID[i] =3D -1;
> +	}
> +
> +	for (i =3D 0; i < MAX_FINGERS; i++) {
> +		if (CheckID[i] =3D=3D 1) {
> +			input_mt_slot(ts->input_dev, i+1);
> +			if (MM_Slot[i].Pressure > 0) {
> +				input_mt_report_slot_state(ts->input_dev,
> +						MT_TOOL_FINGER, true);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_PRESSURE, MM_Slot[i].Pressure);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_TOUCH_MAJOR, MM_Slot[i].Width);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_TOUCH_MINOR, MM_Slot[i].Height);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_POSITION_X, MM_Slot[i].x);
> +				input_report_abs(ts->input_dev,
> +					ABS_MT_POSITION_Y, MM_Slot[i].y);
> +			} else {
> +				input_mt_report_slot_state(ts->input_dev,
> +						MT_TOOL_FINGER, false);
> +				CheckID[i] =3D 0;
> +			}
> +		} else if (CheckID[i] =3D=3D -1) {
> +			input_mt_slot(ts->input_dev, i+1);
> +			input_mt_report_slot_state(ts->input_dev,
> +					MT_TOOL_FINGER, false);
> +			CheckID[i] =3D 0;
> +		}
> +		Pre_CheckID[i] =3D CheckID[i];
> +	}
> +
> +	input_sync(ts->input_dev);
> +
> +err_free_allocate:
> +
> +	if (ts->use_irq) {
> +#ifdef _INT_MODE_1	/*case 1 mode*/
> +		/*TODO: After interrupt status low,
> +		 * read i2c bus data by polling,
> +		 * until interrupt status is high*/
> +		ret =3D  gpio_get_value(GPIO_IRQ);
> +		/*interrupt pin is still LOW,
> +		 * read data until interrupt pin is released.*/
> +		if (!ret)
> +			hrtimer_start(&ts->timer, ktime_set(0, TIMER_NS),
> +						HRTIMER_MODE_REL);
> +		else {
> +			/*clear for interrupt*/
> +			if (irqd_irq_disabled(&ts->desc->irq_data))
> +				enable_irq(ts->client->irq);
> +		}
> +#else /*case 2 mode*/
> +		if (irqd_irq_disabled(&ts->desc->irq_data))
> +			enable_irq(ts->client->irq);
> +#endif

I do not quite understand the purpose of this block just remove it.

> +	}
> +
> +	mutex_unlock(&ts->mutex_wq);
> +}
> +
> +static void sis_tpinfo_clear(struct sisTP_driver_data *TPInfo, int m=
ax)=20
> +{
> +	int i =3D 0;
> +
> +	for (i =3D 0; i < max; i++) {
> +		TPInfo->pt[i].id =3D -1;
> +		TPInfo->pt[i].x =3D 0;
> +		TPInfo->pt[i].y =3D 0;
> +		TPInfo->pt[i].Pressure =3D 0;
> +		TPInfo->pt[i].Width =3D 0;
> +	}
> +	TPInfo->id =3D 0x0;
> +	TPInfo->fingers =3D 0;
> +}
> +
> +static enum hrtimer_restart sis_ts_timer_func(struct hrtimer *timer)=
 {
> +	struct sis_ts_data *ts =3D container_of(timer, struct sis_ts_data,=20
> +timer);
> +
> +	queue_work(sis_wq, &ts->work);
> +	if (!ts->use_irq)	/*For Polling mode*/
> +	    hrtimer_start(&ts->timer, ktime_set(0, TIMER_NS), HRTIMER_MODE_=
REL);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id) {
> +	struct sis_ts_data *ts =3D dev_id;
> +
> +	if (!irqd_irq_disabled(&ts->desc->irq_data))
> +		disable_irq_nosync(ts->client->irq);
> +	queue_work(sis_wq, &ts->work);

Use threaded IRQ handler instead.

> +	return IRQ_HANDLED;
> +}
> +
> +static int initial_irq(void)
> +{
> +	int ret =3D 0;
> +
> +	/* initialize gpio and interrupt pins */
> +	/*ex. GPIO_133 for interrupt mode*/
> +	ret =3D gpio_request(GPIO_IRQ, "GPIO_54");

This is definitely not valid in general. Please rely on the board
code/ACPI to set up interrupt line in i2c_client structure and use it
instead. I do not believe you need to treat it as GPIO at all.=20

> +	if (ret < 0) {
> +		/*Set Active Low.
> +		 * Please reference the file include/linux/interrupt.h*/
> +		pr_err("sis_ts_probe: Failed to gpio_request\n");
> +		pr_err("sis_ts_probe: Fail : gpio_request was called before this d=
river call\n");
> +	}
> +	/* setting gpio direction here OR boardinfo file*/
> +	return ret;
> +}
> +
> +static int sis_ts_probe(
> +	struct i2c_client *client, const struct i2c_device_id *id) {
> +	int ret =3D 0;

Preference: call this "error". Also do not gratuitously initialize
variables.

> +	struct sis_ts_data *ts =3D NULL;
> +	struct sis_i2c_rmi_platform_data *pdata =3D NULL;

RMI?

> +
> +	pr_info("sis_ts_probe\n");

This seems leftover from initial driver development effors; please drop=
=2E
Also use dev_dbg(), dev_err(), etc for messages.

> +	ts =3D kzalloc(sizeof(struct sis_ts_data), GFP_KERNEL);

Consider switching to devm_* API, it will simplify error paths and devi=
ce
removal code.

> +	if (ts =3D=3D NULL) {

	if (!ts) {
		...
	}

form is preferred.

> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +	ts->TPInfo =3D kzalloc(sizeof(struct sisTP_driver_data), GFP_KERNEL=
);
> +	if (ts->TPInfo =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +	ts_bak =3D ts;
> +
> +	mutex_init(&ts->mutex_wq);
> +	/*1. Init Work queue and necessary buffers*/
> +	INIT_WORK(&ts->work, sis_ts_work_func);
> +	ts->client =3D client;
> +	i2c_set_clientdata(client, ts);
> +	pdata =3D client->dev.platform_data;
> +	if (pdata)
> +		ts->power =3D pdata->power;

Please wire up power using standard regulator/gpiod framework and not
require platform function. It will not work well for ACPI or devicetree
systems.

> +	if (ts->power) {
> +		ret =3D ts->power(1);
> +		if (ret < 0) {
> +			pr_err("sis_ts_probe power on failed\n");
> +			goto err_power_failed;
> +		}
> +	}
> +	/*2. Allocate input device*/
> +	ts->input_dev =3D input_allocate_device();
> +	if (ts->input_dev =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		pr_err("sis_ts_probe: Failed to allocate input device\n");
> +		goto err_input_dev_alloc_failed;
> +	}
> +	/*This input device name should be the same to IDC file name.*/
> +	ts->input_dev->name =3D "sis_touch";
> +
> +	set_bit(EV_ABS, ts->input_dev->evbit);
> +	set_bit(EV_KEY, ts->input_dev->evbit);
> +	set_bit(ABS_MT_POSITION_X, ts->input_dev->absbit);
> +	set_bit(ABS_MT_POSITION_Y, ts->input_dev->absbit);
> +	set_bit(ABS_MT_PRESSURE, ts->input_dev->absbit);
> +	set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
> +	set_bit(ABS_MT_TOUCH_MINOR, ts->input_dev->absbit);

You do not need these.
> +
> +	input_mt_init_slots(ts->input_dev, MAX_SLOTS, INPUT_MT_DIRECT);
> +
> +	input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE,
> +						0, PRESSURE_MAX, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +						0, AREA_LENGTH_LONGER, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MINOR,
> +						0, AREA_LENGTH_SHORT, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +						0, SIS_MAX_X, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +						0, SIS_MAX_Y, 0, 0);

Please move input_mt_init_slots() here.
> +
> +	/* add for touch keys */
> +	set_bit(KEY_COMPOSE, ts->input_dev->keybit);
> +	set_bit(KEY_BACK, ts->input_dev->keybit);
> +	set_bit(KEY_MENU, ts->input_dev->keybit);
> +	set_bit(KEY_HOME, ts->input_dev->keybit);

> +	/*3. Register input device to core*/
> +	ret =3D input_register_device(ts->input_dev);
> +	if (ret) {
> +		pr_err("sis_ts_probe: Unable to register %s input device\n",
> +				ts->input_dev->name);
> +		goto err_input_register_device_failed;
> +	}
> +	/*4. irq or timer setup*/
> +	ret =3D initial_irq();
> +	if (ret >=3D 0) {
> +		client->irq =3D gpio_to_irq(GPIO_IRQ);
> +		ret =3D request_irq(client->irq, sis_ts_irq_handler,
> +					IRQF_TRIGGER_FALLING, client->name, ts);

devm_request_threaded_irq().

> +		if (ret =3D=3D 0)
> +			ts->use_irq =3D 1;
> +		else
> +			dev_err(&client->dev, "request_irq failed\n");

			return ret;

> +	}
> +	ts->desc =3D irq_to_desc(ts_bak->client->irq);
> +	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ts->timer.function =3D sis_ts_timer_func;
> +	if (!ts->use_irq)
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);

Touchscreen without IRQ is pretty much useless, let's not support
polling mode at all and require IRQ.

> +	pr_info("sis_ts_probe: Start touchscreen %s in %s mode\n",
> +			ts->input_dev->name,
> +			ts->use_irq ? "interrupt" : "polling");
> +	if (ts->use_irq) {
> +#ifdef _INT_MODE_1
> +		pr_info("sis_ts_probe: interrupt case 1 mode\n"); #else
> +		pr_info("sis_ts_probe: interrupt case 2 mode\n"); #endif
> +	}
> +	pr_info("sis SIS_SLAVE_ADDR: %d\n", SIS_SLAVE_ADDR);
> +	return 0;
> +err_input_register_device_failed:
> +	input_free_device(ts->input_dev);
> +err_input_dev_alloc_failed:
> +err_power_failed:
> +	kfree(ts->TPInfo);
> +	kfree(ts);
> +err_alloc_data_failed:
> +	return ret;
> +}
> +
> +static int sis_ts_remove(struct i2c_client *client) {
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (ts->use_irq)
> +		free_irq(client->irq, ts);
> +	else
> +		hrtimer_cancel(&ts->timer);
> +	input_unregister_device(ts->input_dev);
> +	kfree(ts);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int sis_ts_suspend(struct i2c_client *client, pm_message_t me=
sg)=20
> +{
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (ts->use_irq) {
> +		if (!irqd_irq_disabled(&ts->desc->irq_data))
> +			disable_irq(client->irq);
> +	} else
> +		hrtimer_cancel(&ts->timer);
> +	flush_workqueue(sis_wq);		/*only flush sis_wq*/
> +
> +
> +	if (ts->power) {
> +		ret =3D ts->power(0);
> +		if (ret < 0)
> +			pr_err("sis_ts_suspend power off failed\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int sis_ts_resume(struct i2c_client *client) {
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (ts->power) {
> +		ret =3D ts->power(1);
> +		if (ret < 0)
> +			pr_err("sis_ts_resume power on failed\n");
> +	}
> +
> +	if (ts->use_irq) {
> +		if (irqd_irq_disabled(&ts->desc->irq_data))
> +			enable_irq(client->irq);
> +	} else
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sis_ts_pm, sis_ts_suspend, sis_ts_resume);
> +
> +#ifdef CONFIG_X86
> +/* Return 0 if detection is successful, -ENODEV otherwise */ static =
int=20
> +sis_ts_detect(struct i2c_client *client,
> +		       struct i2c_board_info *info)
> +{
> +	const char *type_name;
> +
> +	pr_info("sis_ts_detect\n");
> +	type_name =3D "sis_i2c_ts";
> +	strlcpy(info->type, type_name, I2C_NAME_SIZE);
> +	return 0;

I think you want ACPI matching here.
> +}
> +#endif
> +
> +static const struct i2c_device_id sis_ts_id[] =3D {
> +	{ SIS_I2C_NAME, 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, sis_ts_id);
> +
> +static struct i2c_driver sis_ts_driver =3D {
> +	.driver =3D {
> +		.name =3D SIS_I2C_NAME,
> +		.pm =3D &sis_ts_pm,
> +	},
> +	.probe		=3D sis_ts_probe,
> +	.remove		=3D sis_ts_remove,
> +#ifdef CONFIG_X86
> +	.class		=3D I2C_CLASS_HWMON,
> +	.detect		=3D sis_ts_detect,
> +	.address_list	=3D normal_i2c,
> +#endif

Why do you need this?

> +	.id_table	=3D sis_ts_id,
> +};
> +
> +static int __init sis_ts_init(void)
> +{
> +	pr_info("sis_ts_init\n");
> +	sis_wq =3D create_singlethread_workqueue("sis_wq");

Why do you need dedicated workqueue? In any case once you convert to a
threaded interrupt you won't be needing it.

> +
> +	if (!sis_wq)
> +		return -ENOMEM;
> +	return i2c_add_driver(&sis_ts_driver); }
> +
> +static void __exit sis_ts_exit(void)
> +{
> +	pr_info("sis_ts_exit\n");
> +	i2c_del_driver(&sis_ts_driver);
> +	if (sis_wq)
> +		destroy_workqueue(sis_wq);
> +}
> +
> +module_init(sis_ts_init);
> +module_exit(sis_ts_exit);
> +MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");=20
> +MODULE_LICENSE("GPL");

"GPL v2"

> diff --git a/drivers/input/touchscreen/sis_i2c.h b/drivers/input/touc=
hscreen/sis_i2c.h
> new file mode 100644
> index 0000000..a075158
> --- /dev/null
> +++ b/drivers/input/touchscreen/sis_i2c.h
> @@ -0,0 +1,164 @@
> +/*
> + * Touch Screen driver for SiS 9200 family I2C Touch panels
> + *
> + * Copyright (C) 2015 SiS, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Date: 2015/07/07
> + */
> +#include <linux/version.h>
> +
> +#ifndef _LINUX_SIS_I2C_H
> +#define _LINUX_SIS_I2C_H
> +
> +
> +#define SIS_I2C_NAME "sis_i2c_ts"
> +#define SIS_SLAVE_ADDR					0x5c
> +/*10ms*/
> +#define TIMER_NS						10000000
> +#define MAX_FINGERS						10
> +
> +/* Check data CRC */
> +/*#define _CHECK_CRC*/					/*ON/OFF*/
> +
> +/* Interrupt modes */
> +#define GPIO_IRQ						54
> +
> +/*	Enable if use interrupt case 1 mode.	*/
> +/*	Disable if use interrupt case 2 mode.	*/
> +/*#define _INT_MODE_1*/					/*ON/OFF*/
> +
> +/* Resolution mode */
> +/*Constant value*/
> +#define SIS_MAX_X						4095
> +#define SIS_MAX_Y						4095
> +
> +#define ONE_BYTE						1
> +#define FIVE_BYTE						5
> +#define EIGHT_BYTE						8
> +#define SIXTEEN_BYTE					16
> +#define PACKET_BUFFER_SIZE				128
> +
> +#define SIS_CMD_NORMAL					0x0
> +#define SIS_CMD_SOFTRESET				0x82
> +#define SIS_CMD_RECALIBRATE				0x87
> +#define SIS_CMD_POWERMODE				0x90
> +#define MSK_TOUCHNUM					0x0f
> +#define MSK_HAS_CRC						0x10
> +#define MSK_DATAFMT						0xe0
> +#define MSK_PSTATE						0x0f
> +#define MSK_PID							0xf0
> +#define RES_FMT							0x00
> +#define FIX_FMT							0x40
> +
> +/* for new i2c format */
> +#define TOUCHDOWN						0x3
> +#define TOUCHUP							0x0
> +#define MAX_BYTE						64
> +#define	PRESSURE_MAX					255
> +
> +/*Resolution diagonal */
> +#define AREA_LENGTH_LONGER				5792
> +/*((SIS_MAX_X^2) + (SIS_MAX_Y^2))^0.5*/
> +#define AREA_LENGTH_SHORT				5792
> +#define AREA_UNIT						(5792/32)
> +
> +
> +#define FORMAT_MODE						1
> +
> +#define MSK_NOBTN						0
> +#define MSK_COMP						1
> +#define MSK_BACK						2
> +#define MSK_MENU						4
> +#define MSK_HOME						8
> +
> +#define P_BYTECOUNT						0
> +#define ALL_IN_ONE_PACKAGE				0x10
> +#define IS_TOUCH(x)						(x & 0x1)
> +#define IS_HIDI2C(x)					((x & 0xF) =3D=3D 0x06)
> +#define IS_AREA(x)						((x >> 4) & 0x1)
> +#define IS_PRESSURE(x)				    ((x >> 5) & 0x1)
> +#define IS_SCANTIME(x)			        ((x >> 6) & 0x1)
> +#define NORMAL_LEN_PER_POINT			6
> +#define AREA_LEN_PER_POINT				2
> +#define PRESSURE_LEN_PER_POINT			1
> +
> +#define TOUCH_FORMAT					0x1
> +#define BUTTON_FORMAT					0x4
> +#define HIDI2C_FORMAT					0x6
> +#define P_REPORT_ID						2
> +#define BUTTON_STATE					3
> +#define BUTTON_KEY_COUNT				16
> +#define BYTE_BYTECOUNT					2
> +#define BYTE_COUNT						1
> +#define BYTE_ReportID					1
> +#define BYTE_CRC_HIDI2C					0
> +#define BYTE_CRC_I2C					2
> +#define BYTE_SCANTIME					2
> +#define NO_TOUCH_BYTECOUNT				0x3
> +
> +/* TODO */
> +#define TOUCH_POWER_PIN					0
> +#define TOUCH_RESET_PIN					1
> +
> +/* CMD Define */
> +#define BUF_ACK_PLACE_L					4
> +#define BUF_ACK_PLACE_H					5
> +#define BUF_ACK_L						0xEF
> +#define BUF_ACK_H						0xBE
> +#define BUF_NACK_L						0xAD
> +#define BUF_NACK_H						0xDE
> +#define BUF_CRC_PLACE					7
> +#define MAX_SLOTS						15
> +
> +struct sis_i2c_rmi_platform_data {
> +	int (*power)(int on);	/* Only valid in first array entry */
> +};
> +
> +struct TypeB_Slot {
> +	int CheckID;
> +	int id;
> +	unsigned short x, y;
> +	uint16_t Pressure;
> +	uint16_t Width;
> +	uint16_t Height;
> +};
> +
> +struct Point {
> +	int id;
> +	unsigned short x, y;		/*uint16_t ?*/
> +	uint16_t Pressure;
> +	uint16_t Width;
> +	uint16_t Height;
> +};
> +
> +struct sisTP_driver_data {
> +	int id;
> +	int fingers;
> +	struct Point pt[MAX_FINGERS];
> +};
> +
> +struct sis_ts_data {
> +	int (*power)(int on);
> +	int use_irq;
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct hrtimer timer;
> +	struct irq_desc *desc;
> +	struct work_struct work;
> +	struct mutex mutex_wq;
> +	struct sisTP_driver_data *TPInfo;
> +};
> +
> +static int sis_ts_suspend(struct i2c_client *client, pm_message_t=20
> +mesg); static int sis_ts_resume(struct i2c_client *client);
> +
> +#endif /* _LINUX_SIS_I2C_H */
> --
> 1.9.1
>=20

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
