From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] INPUT/HID: add touch support for SiS touch driver
Date: Wed, 11 Feb 2015 23:02:04 -0800
Message-ID: <20150212070204.GA38837@dtor-ws>
References: <8322374EB97AA24A95D0DDBFC8F1CA1DBF987B@SISMBEV01.sis.com.tw>
 <1421063449.12454.17.camel@linux-0dmf.site>
 <CAKR5kVFXy4GdZdHFnW2AAjqkcHfgfM5b0NhkOa079bftOoKqUQ@mail.gmail.com>
 <8322374EB97AA24A95D0DDBFC8F1CA1DBF9DE5@SISMBEV01.sis.com.tw>
 <8322374EB97AA24A95D0DDBFC8F1CA1DBF9E1B@SISMBEV01.sis.com.tw>
 <1421413862.17198.23.camel@linux-0dmf.site>
 <CAKdAkRSGumi5rK9ToxUoQXo9OrTutPTgv2z8pRQix6gwDS45EA@mail.gmail.com>
 <8322374EB97AA24A95D0DDBFC8F1CA1DCB07F9@SISMBEV01.sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49480 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbBLHCN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2015 02:02:13 -0500
Content-Disposition: inline
In-Reply-To: <8322374EB97AA24A95D0DDBFC8F1CA1DCB07F9@SISMBEV01.sis.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5pu+5am36JGzICh0YW1teV90c2VuZyk=?= <tammy_tseng@sis.com>
Cc: Oliver Neukum <oneukum@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, tammy0524@gmail.com

Hi Tammy,

On Thu, Feb 12, 2015 at 02:07:21PM +0800, =E6=9B=BE=E5=A9=B7=E8=91=B3 (=
tammy_tseng) wrote:
> Hi,=20
>=20
> I've checked the coding style and modified the i2c and hid touch driv=
er for sis touch controller.
> Please help review them.=20
> Thanks a lot.

This was again sent in base64, with DOS file endings...

>=20
> Tammy
> -----
> Here is the sis i2c driver in input:
>=20
> linux-3.18.5/drivers/input/touchscreen/Kconfig   |    7 +
>  linux-3.18.5/drivers/input/touchscreen/Makefile  |    1 +
>  linux-3.18.5/drivers/input/touchscreen/sis_i2c.c | 1032 ++++++++++++=
++++++++++
>  linux-3.18.5/drivers/input/touchscreen/sis_i2c.h |  173 ++++
>  4 files changed, 1213 insertions(+)
>=20
>=20
> -----
> diff --git a/linux-3.18.5/drivers/input/touchscreen/Kconfig b/linux-3=
=2E18.5/drivers/input/touchscreen/Kconfig
> index e1d8003..5093ccc 100644
> --- a/linux-3.18.5/drivers/input/touchscreen/Kconfig
> +++ b/linux-3.18.5/drivers/input/touchscreen/Kconfig
> @@ -962,4 +962,11 @@ config TOUCHSCREEN_ZFORCE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zforce_ts.
> =20
> +config TOUCHSCREEN_SIS_I2C
> +	tristate "SiS 9200 family I2C touchscreen driver"
> +	depends on I2C
> +	default n

No need to say "default n".

> +	help
> +	  This enables support for SiS 9200 family over I2C based touchscre=
ens.

Please add

	To compile this driver as a module...

as all the rest of input dirvers.

> +
>  endif
> diff --git a/linux-3.18.5/drivers/input/touchscreen/Makefile b/linux-=
3.18.5/drivers/input/touchscreen/Makefile
> index 090e61c..25cfd9f 100644
> --- a/linux-3.18.5/drivers/input/touchscreen/Makefile
> +++ b/linux-3.18.5/drivers/input/touchscreen/Makefile
> @@ -79,3 +79,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+=3D zylo=
nite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+=3D w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+=3D tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+=3D zforce_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)   +=3D sis_i2c.o
> diff --git a/linux-3.18.5/drivers/input/touchscreen/sis_i2c.c b/linux=
-3.18.5/drivers/input/touchscreen/sis_i2c.c
> new file mode 100644
> index 0000000..260a7b6
> --- /dev/null
> +++ b/linux-3.18.5/drivers/input/touchscreen/sis_i2c.c
> @@ -0,0 +1,1032 @@
> +/* drivers/input/touchscreen/sis_i2c.c
> + *  - I2C Touch panel driver for SiS 9200 family
> + *
> + * Copyright (C) 2011 SiS, Inc.

Not 2015?

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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +#include <linux/earlysuspend.h>
> +#endif

There is no CONFIG_HAS_EARLYSUSPEND in mainline, please drop.

> +#include <linux/hrtimer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include "sis_i2c.h"
> +#include <linux/linkage.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/uaccess.h>
> +#include <linux/irq.h>
> +#include <asm/unaligned.h>
> +
> +#ifdef _STD_RW_IO
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#define DEVICE_NAME "sis_aegis_touch_device"
> +static const int sis_char_devs_count =3D 1;        /* device count *=
/
> +static int sis_char_major;
> +static struct cdev sis_char_cdev;
> +static struct class *sis_char_class;

This all should go away, we do not need custom char device for a
touchscreen.

> +#endif
> +
> +/* Addresses to scan */
> +static const unsigned short normal_i2c[] =3D { SIS_SLAVE_ADDR, I2C_C=
LIENT_END };
> +static struct workqueue_struct *sis_wq;

I see you are trying to support polling mode... Please don't, it is not
useful for production code. Also please switch to using threaded irq
instead of having hard irq + work queue - it is really hard to manage i=
t
in race-free way.

> +struct sis_ts_data *ts_bak;
> +struct sisTP_driver_data *TPInfo;

Global? Why?

> +static void sis_tpinfo_clear(struct sisTP_driver_data *TPInfo, int m=
ax);
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +static void sis_ts_early_suspend(struct early_suspend *h);
> +static void sis_ts_late_resume(struct early_suspend *h);

Nope, don't have it.

> +#endif
> +
> +#ifdef _CHECK_CRC
> +static const unsigned short crc16tab[256] =3D {
> +	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
> +	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,

Isn't this CRC ITU-T V.41? We already have it in kernel.

> +	0x1231, 0x0210, 0x3273, 0x2252, 0x52b5, 0x4294, 0x72f7, 0x62d6,
> +	0x9339, 0x8318, 0xb37b, 0xa35a, 0xd3bd, 0xc39c, 0xf3ff, 0xe3de,
> +	0x2462, 0x3443, 0x0420, 0x1401, 0x64e6, 0x74c7, 0x44a4, 0x5485,
> +	0xa56a, 0xb54b, 0x8528, 0x9509, 0xe5ee, 0xf5cf, 0xc5ac, 0xd58d,
> +	0x3653, 0x2672, 0x1611, 0x0630, 0x76d7, 0x66f6, 0x5695, 0x46b4,
> +	0xb75b, 0xa77a, 0x9719, 0x8738, 0xf7df, 0xe7fe, 0xd79d, 0xc7bc,
> +	0x48c4, 0x58e5, 0x6886, 0x78a7, 0x0840, 0x1861, 0x2802, 0x3823,
> +	0xc9cc, 0xd9ed, 0xe98e, 0xf9af, 0x8948, 0x9969, 0xa90a, 0xb92b,
> +	0x5af5, 0x4ad4, 0x7ab7, 0x6a96, 0x1a71, 0x0a50, 0x3a33, 0x2a12,
> +	0xdbfd, 0xcbdc, 0xfbbf, 0xeb9e, 0x9b79, 0x8b58, 0xbb3b, 0xab1a,
> +	0x6ca6, 0x7c87, 0x4ce4, 0x5cc5, 0x2c22, 0x3c03, 0x0c60, 0x1c41,
> +	0xedae, 0xfd8f, 0xcdec, 0xddcd, 0xad2a, 0xbd0b, 0x8d68, 0x9d49,
> +	0x7e97, 0x6eb6, 0x5ed5, 0x4ef4, 0x3e13, 0x2e32, 0x1e51, 0x0e70,
> +	0xff9f, 0xefbe, 0xdfdd, 0xcffc, 0xbf1b, 0xaf3a, 0x9f59, 0x8f78,
> +	0x9188, 0x81a9, 0xb1ca, 0xa1eb, 0xd10c, 0xc12d, 0xf14e, 0xe16f,
> +	0x1080, 0x00a1, 0x30c2, 0x20e3, 0x5004, 0x4025, 0x7046, 0x6067,
> +	0x83b9, 0x9398, 0xa3fb, 0xb3da, 0xc33d, 0xd31c, 0xe37f, 0xf35e,
> +	0x02b1, 0x1290, 0x22f3, 0x32d2, 0x4235, 0x5214, 0x6277, 0x7256,
> +	0xb5ea, 0xa5cb, 0x95a8, 0x8589, 0xf56e, 0xe54f, 0xd52c, 0xc50d,
> +	0x34e2, 0x24c3, 0x14a0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
> +	0xa7db, 0xb7fa, 0x8799, 0x97b8, 0xe75f, 0xf77e, 0xc71d, 0xd73c,
> +	0x26d3, 0x36f2, 0x0691, 0x16b0, 0x6657, 0x7676, 0x4615, 0x5634,
> +	0xd94c, 0xc96d, 0xf90e, 0xe92f, 0x99c8, 0x89e9, 0xb98a, 0xa9ab,
> +	0x5844, 0x4865, 0x7806, 0x6827, 0x18c0, 0x08e1, 0x3882, 0x28a3,
> +	0xcb7d, 0xdb5c, 0xeb3f, 0xfb1e, 0x8bf9, 0x9bd8, 0xabbb, 0xbb9a,
> +	0x4a75, 0x5a54, 0x6a37, 0x7a16, 0x0af1, 0x1ad0, 0x2ab3, 0x3a92,
> +	0xfd2e, 0xed0f, 0xdd6c, 0xcd4d, 0xbdaa, 0xad8b, 0x9de8, 0x8dc9,
> +	0x7c26, 0x6c07, 0x5c64, 0x4c45, 0x3ca2, 0x2c83, 0x1ce0, 0x0cc1,
> +	0xef1f, 0xff3e, 0xcf5d, 0xdf7c, 0xaf9b, 0xbfba, 0x8fd9, 0x9ff8,
> +	0x6e17, 0x7e36, 0x4e55, 0x5e74, 0x2e93, 0x3eb2, 0x0ed1, 0x1ef0
> +};
> +
> +static uint16_t cal_crc(char *cmd, int start, int end)
> +{
> +	int i =3D 0;
> +	uint16_t crc =3D 0;
> +
> +	for (i =3D start; i <=3D end ; i++)
> +		crc =3D (crc << 8) ^ crc16tab[((crc >> 8) ^ cmd[i]) & 0x00FF];
> +	return crc;
> +}
> +#endif
> +
> +#ifdef _DEBUG_PACKAGE
> +static void PrintBuffer(int start, int length, char *buf)
> +{
> +	int i;
> +
> +	for (i =3D start; i < length; i++) {
> +		pr_info("%02x ", buf[i]);
> +		if (i !=3D 0 && i % 30 =3D=3D 0)
> +			pr_info("\n");
> +	}
> +	pr_info("\n");
> +}

To print hex buffer please use dev_dbg(dev, "%*ph", length, buf) instea=
d
of rolling your custom implementation.

Also please avoid camel casing.

> +#endif
> +
> +static int sis_command_for_write(struct i2c_client *client, int wlen=
gth,
> +							unsigned char *wdata)
> +{
> +	int ret =3D SIS_ERR;

We definitely do not need custom error codes.

> +	struct i2c_msg msg;
> +
> +	msg.addr =3D client->addr;
> +	msg.flags =3D 0; /*Write*/
> +	msg.len =3D wlength;
> +	msg.buf =3D (unsigned char *)wdata;
> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +	return ret;

i2c_master_send()?

> +}
> +
> +static int sis_command_for_read(struct i2c_client *client, int rleng=
th,
> +							unsigned char *rdata)
> +{
> +	int ret =3D SIS_ERR;
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
> +static int sis_cul_unit(uint8_t report_id)
> +{
> +	int ret =3D NORMAL_LEN_PER_POINT;
> +
> +	if (report_id !=3D ALL_IN_ONE_PACKAGE) {
> +		if (IS_AREA(report_id) /*&& IS_TOUCH(report_id)*/)
> +			ret +=3D AREA_LEN_PER_POINT;
> +		if (IS_PRESSURE(report_id))
> +			ret +=3D PRESSURE_LEN_PER_POINT;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sis_ReadPacket(struct i2c_client *client, uint8_t cmd, ui=
nt8_t *buf)
> +{
> +	uint8_t tmpbuf[MAX_BYTE] =3D {0};	/*MAX_BYTE =3D 64;*/
> +	int ret =3D SIS_ERR;
> +	int touchnum =3D 0;
> +	int p_count =3D 0;
> +	int touc_formate_id =3D 0;
> +	int locate =3D 0;
> +	bool read_first =3D true;
> +	/*
> +	* New i2c format
> +	* buf[0] =3D Low 8 bits of byte count value
> +	* buf[1] =3D High 8 bits of byte counte value
> +	* buf[2] =3D Report ID
> +	* buf[touch num * 6 + 2 ] =3D Touch informations;
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
> +			return SIS_ERR;
> +		}
> +		ret =3D sis_command_for_read(client, MAX_BYTE, tmpbuf);
> +#ifdef _DEBUG_PACKAGE

Please drop this define and use dev_dbg().

> +		pr_info("chaoban test: Buf_Data [0~63]\n");
> +		PrintBuffer(0, 64, tmpbuf);
> +#endif
> +		if (ret < 0) {
> +			pr_err("sis_ReadPacket: i2c transfer error\n");
> +			return ret;
> +		}
> +		/*error package length of receiving data*/
> +		else if (tmpbuf[P_BYTECOUNT] > MAX_BYTE) {
> +			pr_err("sis_ReadPacket: Error Bytecount\n");
> +			return SIS_ERR;
> +		}
> +		if (read_first) {
> +			/*access NO TOUCH event unless BUTTON NO TOUCH event*/
> +			if (tmpbuf[P_BYTECOUNT] =3D=3D 0/*NO_TOUCH_BYTECOUNT*/)
> +				return 0;	/*touchnum is 0*/
> +		}
> +		/*skip parsing data when two devices are registered
> +		 * at the same slave address*/
> +		/*parsing data when P_REPORT_ID && 0xf is TOUCH_FORMAT
> +		 * or P_REPORT_ID is ALL_IN_ONE_PACKAGE*/
> +		touc_formate_id =3D tmpbuf[P_REPORT_ID] & 0xf;
> +		if ((touc_formate_id !=3D TOUCH_FORMAT)
> +		&& (touc_formate_id !=3D HIDI2C_FORMAT)
> +		&& (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE)) {
> +			pr_err("sis_ReadPacket: Error Report_ID\n");
> +			return SIS_ERR;
> +		}
> +		p_count =3D (int) tmpbuf[P_BYTECOUNT] - 1;	/*start from 0*/
> +		if (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) {
> +			if (IS_TOUCH(tmpbuf[P_REPORT_ID])) {
> +				p_count -=3D BYTE_CRC_I2C;/*delete 2 byte crc*/
> +			} else if (IS_HIDI2C(tmpbuf[P_REPORT_ID])) {
> +				p_count -=3D BYTE_CRC_HIDI2C;
> +			} else {	/*should not be happen*/
> +				pr_err("sis_ReadPacket: delete crc error\n");
> +				return SIS_ERR;
> +			}
> +			if (IS_SCANTIME(tmpbuf[P_REPORT_ID]))
> +				p_count -=3D BYTE_SCANTIME;
> +		}
> +		/*else {}*/ /*For ALL_IN_ONE_PACKAGE*/
> +		if (read_first) {
> +			touchnum =3D tmpbuf[p_count];
> +		} else {
> +			if (tmpbuf[p_count] !=3D 0) {
> +				pr_err("sis_ReadPacket: get error package\n");
> +				return SIS_ERR;
> +			}
> +		}
> +
> +#ifdef _CHECK_CRC
> +		/* HID over I2C data foramt and no touch packet without CRC */

If this device indeed uses HID protocol over I2C why do we need special
driver?

> +		if ((touc_formate_id !=3D HIDI2C_FORMAT) &&
> +			(tmpbuf[P_BYTECOUNT] > 3)) {
> +			int crc_end =3D p_count + (IS_SCANTIME(
> +				tmpbuf[P_REPORT_ID]) * 2);
> +			uint16_t buf_crc =3D cal_crc(
> +				tmpbuf, 2, crc_end);/*sub bytecount(2 byte)*/
> +			int l_package_crc =3D (IS_SCANTIME(
> +				tmpbuf[P_REPORT_ID]) * 2) + p_count + 1;
> +			uint16_t package_crc =3D le16_to_cpu(get_unaligned_le16(
> +				&tmpbuf[l_package_crc]));
> +
> +			if (buf_crc !=3D package_crc) {
> +				pr_err("sis_ReadPacket: CRC Error\n");
> +				return SIS_ERR;
> +			}
> +		}
> +#endif
> +		memcpy(&buf[locate], &tmpbuf[0], 64);
> +		/*Buf_Data [0~63] [64~128]*/
> +		locate +=3D 64;
> +		read_first =3D false;
> +	} while (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE &&
> +			tmpbuf[p_count] > 5);
> +	return touchnum;
> +}
> +
> +#ifdef _INT_MODE_1
> +static void ts_report_key(struct i2c_client *client, uint8_t keybit_=
state)
> +{
> +	int i =3D 0;
> +	uint8_t diff_keybit_state =3D 0x0;
> +	/*check keybit_state is difference with pre_keybit_state*/
> +	uint8_t key_value =3D 0x0; /*button location for binary*/
> +	uint8_t  key_pressed =3D 0x0; /*button is up or down*/
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (!ts) {
> +		pr_err("%s error: Missing Platform Data!\n", __func__);
> +		return;
> +	}
> +
> +	diff_keybit_state =3D TPInfo->pre_keybit_state ^ keybit_state;
> +
> +	if (diff_keybit_state) {
> +		for (i =3D 0; i < BUTTON_KEY_COUNT; i++) {
> +			if ((diff_keybit_state >> i) & 0x01) {
> +				key_value =3D diff_keybit_state & (0x01 << i);
> +				key_pressed =3D (keybit_state >> i) & 0x01;
> +				switch (key_value) {
> +				case MSK_COMP:
> +					input_report_key(ts->input_dev,
> +						KEY_COMPOSE, key_pressed);
> +					break;
> +				case MSK_BACK:
> +					input_report_key(ts->input_dev,
> +						KEY_BACK, key_pressed);
> +					break;
> +				case MSK_MENU:
> +					input_report_key(ts->input_dev,
> +						KEY_MENU, key_pressed);
> +					break;
> +				case MSK_HOME:
> +					input_report_key(ts->input_dev,
> +						KEY_HOME, key_pressed);

I do not think you mean for the cursor to go to beginning of the
screen. All in all the set of events is unusual for a touchscreen.

> +					break;
> +				case MSK_NOBTN:
> +					/*Release the button if it touched.*/
> +				default:
> +					break;
> +				}
> +			}
> +		}
> +		TPInfo->pre_keybit_state =3D keybit_state;
> +	}
> +}
> +#endif
> +
> +static void sis_ts_work_func(struct work_struct *work)
> +{
> +	struct sis_ts_data *ts =3D container_of(work, struct sis_ts_data, w=
ork);
> +	int ret =3D SIS_ERR;
> +	int point_unit;
> +	uint8_t buf[PACKET_BUFFER_SIZE] =3D {0};
> +	uint8_t i =3D 0, fingers =3D 0;
> +	uint8_t px =3D 0, py =3D 0, pstatus =3D 0;
> +	uint8_t p_area =3D 0;
> +	uint8_t p_preasure =3D 0;
> +	bool all_touch_up =3D true;
> +
> +	mutex_lock(&ts->mutex_wq);
> +    /* I2C or SMBUS block data read */
> +	ret =3D sis_ReadPacket(ts->client, SIS_CMD_NORMAL, buf);
> +	/*Error Number*/
> +	if (ret < 0)
> +		goto err_free_allocate;
> +	/*access NO TOUCH event unless BUTTON NO TOUCH event*/
> +	else if (ret =3D=3D 0) {
> +		fingers =3D 0;
> +		sis_tpinfo_clear(TPInfo, MAX_FINGERS);
> +		goto label_send_report;
> +		/*need to report input_mt_sync()*/
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
> +			/*preasure*/
> +			if (IS_PRESSURE(buf[P_REPORT_ID]))
> +				TPInfo->pt[i].Pressure =3D (buf[p_preasure]);
> +			else
> +				TPInfo->pt[i].Pressure =3D 1;
> +		} else {
> +			pr_err("sis_ts_work_func: Error Touch Status\n");
> +			goto err_free_allocate;
> +		}
> +		TPInfo->pt[i].id =3D (buf[pstatus + 1]);
> +		TPInfo->pt[i].x =3D le16_to_cpu(get_unaligned_le16(&buf[px]));
> +		TPInfo->pt[i].y =3D le16_to_cpu(get_unaligned_le16(&buf[py]));
> +	}
> +
> +#ifdef _DEBUG_REPORT
> +	for (i =3D 0; i < TPInfo->fingers; i++)
> +		pr_info("chaoban test: i =3D %d, id =3D %d, x =3D %d, y =3D %d, ps=
tatus =3D %d, width =3D %d, height =3D %d, pressure =3D %d\n",
> +		i, TPInfo->pt[i].id, TPInfo->pt[i].x, TPInfo->pt[i].y,
> +		buf[pstatus], TPInfo->pt[i].Width, TPInfo->pt[i].Height,
> +		TPInfo->pt[i].Pressure);
> +#endif
> +label_send_report:
> +/* Report co-ordinates to the multi-touch stack */
> +	for (i =3D 0; ((i < TPInfo->fingers) && (i < MAX_FINGERS)); i++) {
> +		if (TPInfo->pt[i].Pressure) {
> +			TPInfo->pt[i].Width *=3D AREA_UNIT;
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> +							TPInfo->pt[i].Width);
> +			TPInfo->pt[i].Height *=3D AREA_UNIT;
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MINOR,
> +							TPInfo->pt[i].Height);
> +			input_report_abs(ts->input_dev, ABS_MT_PRESSURE,
> +							TPInfo->pt[i].Pressure);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
> +							TPInfo->pt[i].x);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
> +							TPInfo->pt[i].y);
> +			input_report_abs(ts->input_dev, ABS_MT_TRACKING_ID,
> +							TPInfo->pt[i].id);
> +			/*Android 2.3*/

Huh?

> +			input_mt_sync(ts->input_dev);
> +			all_touch_up =3D false;

We need slotted MT-B protocol for new drivers, not MT-A.

> +		}
> +		if (i =3D=3D (TPInfo->fingers - 1) && all_touch_up =3D=3D true)
> +			input_mt_sync(ts->input_dev);
> +	}
> +	if (TPInfo->fingers =3D=3D 0)
> +		input_mt_sync(ts->input_dev);
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
> +			if (TPInfo->pre_keybit_state)
> +				/*clear for interrupt*/
> +				ts_report_key(ts->client, 0x0);
> +
> +			if (irqd_irq_disabled(&ts->desc->irq_data))
> +				enable_irq(ts->client->irq);
> +		}
> +#else /*case 2 mode*/
> +		if (irqd_irq_disabled(&ts->desc->irq_data))
> +			enable_irq(ts->client->irq);
> +#endif
> +	}
> +
> +	mutex_unlock(&ts->mutex_wq);
> +}
> +
> +static void sis_tpinfo_clear(struct sisTP_driver_data *TPInfo, int m=
ax)
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
> +static enum hrtimer_restart sis_ts_timer_func(struct hrtimer *timer)
> +{
> +	struct sis_ts_data *ts =3D container_of(timer, struct sis_ts_data, =
timer);
> +
> +	queue_work(sis_wq, &ts->work);
> +	if (!ts->use_irq)	/*For Polling mode*/
> +	    hrtimer_start(&ts->timer, ktime_set(0, TIMER_NS), HRTIMER_MODE_=
REL);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct sis_ts_data *ts =3D dev_id;
> +
> +	if (!irqd_irq_disabled(&ts->desc->irq_data))
> +		disable_irq_nosync(ts->client->irq);
> +	queue_work(sis_wq, &ts->work);
> +	return IRQ_HANDLED;
> +}
> +
> +static int initial_irq(void)
> +{
> +	int ret =3D 0;
> +#ifdef _I2C_INT_ENABLE
> +	/* initialize gpio and interrupt pins */
> +	/*ex. GPIO_133 for interrupt mode*/
> +	ret =3D gpio_request(GPIO_IRQ, "GPIO_133");
> +	if (ret < 0) {
> +		/*Set Active Low.
> +		 * Please reference the file include/linux/interrupt.h*/
> +		pr_err("sis_ts_probe: Failed to gpio_request\n");
> +		pr_err("sis_ts_probe: Fail : gpio_request was called before this d=
river call\n");
> +	}
> +	/* setting gpio direction here OR boardinfo file*/
> +
> +#else
> +	ret =3D SIS_ERR;
> +#endif
> +	return ret;
> +}
> +
> +/*static uint16_t cal_crc_with_cmd(char *data, int start, int end, u=
int8_t cmd)
> +{
> +	int i =3D 0;
> +	uint16_t crc =3D 0;
> +
> +	crc =3D (crc << 8) ^ crc16tab[((crc >> 8) ^ cmd) & 0x00FF];
> +	for (i =3D start; i <=3D end ; i++)
> +		crc =3D (crc << 8) ^ crc16tab[((crc >> 8) ^ data[i]) & 0x00FF];
> +	return crc;
> +}*/
> +
> +/*static void write_crc(unsigned char *buf, int start, int end)
> +{
> +	uint16_t crc =3D 0;
> +
> +	crc =3D cal_crc(buf, start , end);
> +	buf[end+1] =3D (crc >> 8) & 0xff;
> +	buf[end+2] =3D crc & 0xff;
> +}*/

Why do we need this commented out code? Please do clean up the code fro=
m
old cruft, debugging bits, etc, etc.

> +
> +#ifdef _STD_RW_IO
> +#define BUFFER_SIZE MAX_BYTE
> +static ssize_t sis_cdev_write(struct file *file, const char __user *=
buf,
> +								size_t count,
> +								loff_t *f_pos)
> +{
> +	int ret =3D 0;
> +	char *kdata;
> +	char cmd;
> +
> +	pr_info("sis_cdev_write.\n");
> +	if (ts_bak =3D=3D 0)
> +		return SIS_ERR_CLIENT;
> +
> +	ret =3D access_ok(VERIFY_WRITE, buf, BUFFER_SIZE);
> +	if (!ret) {
> +		pr_err("cannot access user space memory\n");
> +		return SIS_ERR_ACCESS_USER_MEM;
> +	}
> +
> +	kdata =3D kmalloc(BUFFER_SIZE, GFP_KERNEL);
> +	if (kdata =3D=3D 0)
> +		return SIS_ERR_ALLOCATE_KERNEL_MEM;
> +
> +	ret =3D copy_from_user(kdata, buf, BUFFER_SIZE);
> +	if (ret) {
> +		pr_err("copy_from_user fail\n");
> +		kfree(kdata);
> +		return SIS_ERR_COPY_FROM_USER;
> +	}
> +#ifdef _DEBUG_PACKAGE
> +	PrintBuffer(0, count, kdata);
> +#endif
> +
> +	cmd =3D kdata[6];
> +
> +/*Write & Read*/
> +	ret =3D sis_command_for_write(ts_bak->client, count, kdata);
> +	if (ret < 0) {
> +		pr_err("i2c_transfer write error %d\n", ret);
> +		kfree(kdata);
> +		return SIS_ERR_TRANSMIT_I2C;
> +	}
> +	if (copy_to_user((char *) buf, kdata, BUFFER_SIZE)) {
> +		pr_err("copy_to_user fail\n");
> +		ret =3D SIS_ERR_COPY_FROM_KERNEL;
> +	}
> +	kfree(kdata);
> +	return ret;
> +}
> +
> +/*for get system time*/
> +static ssize_t sis_cdev_read(struct file *file, char __user *buf,
> +								size_t count,
> +								loff_t *f_pos)
> +{
> +	int ret =3D 0;
> +	char *kdata;
> +
> +	pr_info("sis_cdev_read.\n");
> +	if (ts_bak =3D=3D 0)
> +		return SIS_ERR_CLIENT;
> +	ret =3D access_ok(VERIFY_WRITE, buf, BUFFER_SIZE);
> +	if (!ret) {
> +		pr_err("cannot access user space memory\n");
> +		return SIS_ERR_ACCESS_USER_MEM;
> +	}
> +	kdata =3D kmalloc(BUFFER_SIZE, GFP_KERNEL);
> +	if (kdata =3D=3D 0)
> +		return SIS_ERR_ALLOCATE_KERNEL_MEM;
> +	ret =3D copy_from_user(kdata, buf, BUFFER_SIZE);
> +	if (ret) {
> +		pr_err("copy_from_user fail\n");
> +		kfree(kdata);
> +		return SIS_ERR_COPY_FROM_USER;
> +	}
> +#ifdef _DEBUG_PACKAGE
> +	PrintBuffer(0, count, kdata);
> +#endif
> +	/*Write & Read*/
> +	ret =3D sis_command_for_read(ts_bak->client, MAX_BYTE, kdata);
> +	if (ret < 0) {
> +		pr_err("i2c_transfer read error %d\n", ret);
> +		kfree(kdata);
> +		return SIS_ERR_TRANSMIT_I2C;
> +	}
> +
> +	ret =3D le16_to_cpu(get_unaligned_le16(kdata));
> +
> +	/*{
> +		int i;
> +
> +		pr_info("ret=3D%d\n", ret);
> +		for (i =3D 0; i < ret && i < BUFFER_SIZE; i++)
> +			pr_info("%02x ", kdata[i]);
> +		pr_info("\n");
> +	}*/
> +
> +	if (copy_to_user((char *)buf, kdata, BUFFER_SIZE)) {
> +		pr_err("copy_to_user fail\n");
> +		ret =3D SIS_ERR_COPY_FROM_KERNEL;
> +	}
> +
> +	kfree(kdata);
> +	return ret;
> +}
> +
> +#undef BUFFER_SIZE
> +
> +static int sis_cdev_open(struct inode *inode, struct file *filp)
> +{
> +	pr_info("sis_cdev_open.\n");
> +	if (ts_bak =3D=3D 0)
> +		return SIS_ERR_CLIENT;
> +
> +	if (ts_bak->use_irq) {
> +		if (!irqd_irq_disabled(&ts_bak->desc->irq_data))
> +			disable_irq(ts_bak->client->irq);
> +		else {
> +			pr_info("sis_cdev_open: IRQ_STATUS: %x\n",
> +			irqd_irq_disabled(&ts_bak->desc->irq_data));
> +		}
> +	}
> +	hrtimer_cancel(&ts_bak->timer);
> +	flush_workqueue(sis_wq);		/*only flush sis_wq*/
> +	return 0;	/*success*/
> +}
> +
> +static int sis_cdev_release(struct inode *inode, struct file *filp)
> +{
> +	pr_info("sis_cdev_release.\n");
> +	if (ts_bak =3D=3D 0)
> +		return SIS_ERR_CLIENT;
> +	if (ts_bak->use_irq) {
> +		if (irqd_irq_disabled(&ts_bak->desc->irq_data))
> +			enable_irq(ts_bak->client->irq);
> +	} else
> +		hrtimer_start(&ts_bak->timer, ktime_set(1, 0),
> +					HRTIMER_MODE_REL);
> +	return 0;
> +}
> +
> +static const struct file_operations sis_cdev_fops =3D {
> +	.owner	=3D THIS_MODULE,
> +	.read	=3D sis_cdev_read,
> +	.write	=3D sis_cdev_write,
> +	.open	=3D sis_cdev_open,
> +	.release	=3D sis_cdev_release,
> +};
> +
> +static int sis_setup_chardev(struct sis_ts_data *ts)
> +{
> +	dev_t dev =3D MKDEV(sis_char_major, 0);
> +	int ret =3D 0;
> +	struct device *class_dev =3D NULL;
> +
> +	pr_info("sis_setup_chardev.\n");
> +	if (ts =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	/*dynamic allocate driver handle*/
> +	ret =3D alloc_chrdev_region(&dev, 0,
> +				sis_char_devs_count, DEVICE_NAME);
> +	if (ret)
> +		return ret;
> +
> +	sis_char_major =3D MAJOR(dev);
> +	cdev_init(&sis_char_cdev, &sis_cdev_fops);
> +	sis_char_cdev.owner =3D THIS_MODULE;
> +	ret =3D cdev_add(&sis_char_cdev, dev, sis_char_devs_count);
> +	if (ret)
> +		goto err1;
> +
> +	pr_info("%s driver(major %d) installed.\n",
> +			DEVICE_NAME, sis_char_major);
> +	/*register class*/
> +	sis_char_class =3D class_create(THIS_MODULE, DEVICE_NAME);
> +	if (IS_ERR(sis_char_class)) {
> +		ret =3D PTR_ERR(sis_char_class);
> +		goto err2;
> +	}
> +
> +	class_dev =3D device_create(sis_char_class, NULL, dev, NULL, DEVICE=
_NAME);
> +	if (IS_ERR(class_dev)) {
> +		ret =3D PTR_ERR(class_dev);
> +		goto err3;
> +	}
> +
> +	return 0;
> +err3:
> +	class_destroy(sis_char_class);
> +	sis_char_class =3D NULL;
> +err2:
> +	cdev_del(&sis_char_cdev);
> +	memset(&sis_char_cdev, 0, sizeof(struct cdev));
> +err1:
> +	sis_char_major =3D 0;
> +	unregister_chrdev_region(dev, sis_char_devs_count);
> +	return ret;
> +}
> +
> +static void sis_deinit_chardev(void)
> +{
> +	dev_t dev =3D MKDEV(sis_char_major, 0);
> +
> +	if (sis_char_class) {
> +		pr_info("sis_deinit_chardev\n");
> +		device_destroy(sis_char_class, dev);
> +		class_destroy(sis_char_class);
> +		sis_char_class =3D NULL;
> +		cdev_del(&sis_char_cdev);
> +		memset(&sis_char_cdev, 0, sizeof(struct cdev));
> +		sis_char_major =3D 0;
> +		unregister_chrdev_region(dev, sis_char_devs_count);
> +	}
> +}
> +#endif
> +
> +static int sis_ts_probe(
> +	struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D NULL;
> +	struct sis_i2c_rmi_platform_data *pdata =3D NULL;
> +
> +	pr_info("sis_ts_probe\n");
> +	TPInfo =3D kzalloc(sizeof(struct sisTP_driver_data), GFP_KERNEL);
> +	if (TPInfo =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +	ts =3D kzalloc(sizeof(struct sis_ts_data), GFP_KERNEL);
> +	if (ts =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +	ts_bak =3D ts;
> +	mutex_init(&ts->mutex_wq);
> +	/*1. Init Work queue and necessary buffers*/
> +	INIT_WORK(&ts->work, sis_ts_work_func);
> +	ts->client =3D client;
> +	i2c_set_clientdata(client, ts);
> +	pdata =3D client->dev.platform_data;
> +	if (pdata)
> +		ts->power =3D pdata->power;
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
> +	set_bit(ABS_MT_TRACKING_ID, ts->input_dev->absbit);
> +	set_bit(INPUT_PROP_DIRECT, ts->input_dev->propbit);
> +	set_bit(ABS_MT_PRESSURE, ts->input_dev->absbit);
> +	set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
> +	set_bit(ABS_MT_TOUCH_MINOR, ts->input_dev->absbit);
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
> +	input_set_abs_params(ts->input_dev, ABS_MT_TRACKING_ID,
> +						0, 15, 0, 0);
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
> +		if (ret =3D=3D 0)
> +			ts->use_irq =3D 1;
> +		else
> +			dev_err(&client->dev, "request_irq failed\n");
> +	}
> +	ts->desc =3D irq_to_desc(ts_bak->client->irq);
> +	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ts->timer.function =3D sis_ts_timer_func;
> +	if (!ts->use_irq)
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	ts->early_suspend.level =3D EARLY_SUSPEND_LEVEL_BLANK_SCREEN + 1;
> +	ts->early_suspend.suspend =3D sis_ts_early_suspend;
> +	ts->early_suspend.resume =3D sis_ts_late_resume;
> +	register_early_suspend(&ts->early_suspend);
> +#endif
> +	pr_info("sis_ts_probe: Start touchscreen %s in %s mode\n",
> +			ts->input_dev->name,
> +			ts->use_irq ? "interrupt" : "polling");
> +	if (ts->use_irq) {
> +#ifdef _INT_MODE_1
> +		pr_info("sis_ts_probe: interrupt case 1 mode\n");
> +#else
> +		pr_info("sis_ts_probe: interrupt case 2 mode\n");
> +#endif
> +	}
> +#ifdef _STD_RW_IO
> +	ret =3D sis_setup_chardev(ts);
> +	if (ret)
> +		pr_err("sis_setup_chardev fail\n");
> +#endif
> +	pr_info("sis SIS_SLAVE_ADDR: %d\n", SIS_SLAVE_ADDR);
> +	return 0;
> +err_input_register_device_failed:
> +	input_free_device(ts->input_dev);
> +err_input_dev_alloc_failed:
> +err_power_failed:
> +	kfree(ts);
> +err_alloc_data_failed:
> +	return ret;
> +}
> +
> +static int sis_ts_remove(struct i2c_client *client)
> +{
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	unregister_early_suspend(&ts->early_suspend);
> +#endif
> +#ifdef _STD_RW_IO
> +	sis_deinit_chardev();
> +#endif
> +	if (ts->use_irq)
> +		free_irq(client->irq, ts);
> +	else
> +		hrtimer_cancel(&ts->timer);
> +	input_unregister_device(ts->input_dev);
> +	kfree(ts);
> +	return 0;
> +}
> +
> +static int sis_ts_suspend(struct i2c_client *client, pm_message_t me=
sg)
> +{
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	TPInfo->pre_keybit_state =3D 0x0;
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
> +static int sis_ts_resume(struct i2c_client *client)
> +{
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
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +static void sis_ts_early_suspend(struct early_suspend *h)
> +{
> +	struct sis_ts_data *ts;
> +
> +	TPInfo->pre_keybit_state =3D 0x0;
> +	ts =3D container_of(h, struct sis_ts_data, early_suspend);
> +	sis_ts_suspend(ts->client, PMSG_SUSPEND);
> +}
> +
> +static void sis_ts_late_resume(struct early_suspend *h)
> +{
> +	struct sis_ts_data *ts;
> +
> +	ts =3D container_of(h, struct sis_ts_data, early_suspend);
> +	sis_ts_resume(ts->client);
> +}
> +#endif
> +
> +#ifdef CONFIG_X86
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int sis_ts_detect(struct i2c_client *client,
> +		       struct i2c_board_info *info)
> +{
> +	const char *type_name;
> +
> +	pr_info("sis_ts_detect\n");
> +	type_name =3D "sis_i2c_ts";
> +	strlcpy(info->type, type_name, I2C_NAME_SIZE);
> +	return 0;
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
> +	.probe		=3D sis_ts_probe,
> +	.remove		=3D sis_ts_remove,
> +#ifndef CONFIG_HAS_EARLYSUSPEND
> +	.suspend	=3D sis_ts_suspend,
> +	.resume		=3D sis_ts_resume,
> +#endif
> +#ifdef CONFIG_X86
> +	.class		=3D I2C_CLASS_HWMON,
> +	.detect		=3D sis_ts_detect,
> +	.address_list	=3D normal_i2c,
> +#endif
> +	.id_table	=3D sis_ts_id,
> +	.driver =3D {
> +		.name	=3D SIS_I2C_NAME,
> +	},
> +};
> +
> +static int __init sis_ts_init(void)
> +{
> +	pr_info("sis_ts_init\n");
> +	sis_wq =3D create_singlethread_workqueue("sis_wq");
> +
> +	if (!sis_wq)
> +		return -ENOMEM;
> +	return i2c_add_driver(&sis_ts_driver);
> +}
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
> +MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/linux-3.18.5/drivers/input/touchscreen/sis_i2c.h b/linux=
-3.18.5/drivers/input/touchscreen/sis_i2c.h
> new file mode 100644
> index 0000000..7639a52
> --- /dev/null
> +++ b/linux-3.18.5/drivers/input/touchscreen/sis_i2c.h
> @@ -0,0 +1,173 @@
> +/*
> + * include/linux/sis_i2c.h - platform data structure for SiS 9200 fa=
mily
> + *
> + * Copyright (C) 2011 SiS, Inc.
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
> + * Date: 2015/01/15
> + * Version:	Android_v2.05.00-A639-1113
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
> +/* For standard R/W IO ( SiS firmware application )*/
> +#define _STD_RW_IO						/*ON/OFF*/
> +
> +/* Check data CRC */
> +/*#define _CHECK_CRC*/						/*ON/OFF*/
> +
> +/* Interrupt setting and modes */
> +#define _I2C_INT_ENABLE					/*ON/OFF*/
> +#define GPIO_IRQ						133
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
> +/*#define _DEBUG_PACKAGE*/				/*ON/OFF*/
> +/*#define _DEBUG_REPORT*/				/*ON/OFF*/
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
> +
> +/* SiS i2c error code */
> +#define SIS_ERR						-1
> +#define SIS_ERR_ACCESS_USER_MEM		-11 /* Access user memory fail */
> +#define SIS_ERR_ALLOCATE_KERNEL_MEM	-12 /* Allocate memory fail */
> +#define SIS_ERR_CLIENT				-13 /* Client not created */
> +#define SIS_ERR_COPY_FROM_USER		-14 /* Copy data from user fail */
> +#define SIS_ERR_COPY_FROM_KERNEL	-19 /* Copy data from kernel fail *=
/
> +#define SIS_ERR_TRANSMIT_I2C		-21 /* Transmit error in I2C */
> +
> +struct sis_i2c_rmi_platform_data {
> +	int (*power)(int on);	/* Only valid in first array entry */
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
> +	uint8_t pre_keybit_state;
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
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	struct early_suspend early_suspend;
> +#endif
> +};
> +
> +static int sis_ts_suspend(struct i2c_client *client, pm_message_t me=
sg);
> +static int sis_ts_resume(struct i2c_client *client);
> +
> +#endif /* _LINUX_SIS_I2C_H */

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
