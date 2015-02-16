From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 1/2] INPUT/HID: add touch support for SiS touch driver
Date: Mon, 16 Feb 2015 15:16:59 +0100
Message-ID: <1424096219.6633.7.camel@linux-0dmf.site>
References: <8322374EB97AA24A95D0DDBFC8F1CA1DBF987B@SISMBEV01.sis.com.tw>
	<1421063449.12454.17.camel@linux-0dmf.site>
	 <CAKR5kVFXy4GdZdHFnW2AAjqkcHfgfM5b0NhkOa079bftOoKqUQ@mail.gmail.com>
	 <8322374EB97AA24A95D0DDBFC8F1CA1DBF9DE5@SISMBEV01.sis.com.tw>
	 <8322374EB97AA24A95D0DDBFC8F1CA1DBF9E1B@SISMBEV01.sis.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38240 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755541AbbBPORW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 09:17:22 -0500
In-Reply-To: <8322374EB97AA24A95D0DDBFC8F1CA1DBF9E1B@SISMBEV01.sis.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "=?UTF-8?Q?=E6=9B=BE=E5=A9=B7=E8=91=B3?= (tammy_tseng)" <tammy_tseng@sis.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tammy0524@gmail.com

On Fri, 2015-01-16 at 18:59 +0800, =E6=9B=BE=E5=A9=B7=E8=91=B3 (tammy_t=
seng) wrote:
> Hey, Oliver
>=20
> On Mon, Jan 12, 2015 at 7:50 PM, Oliver Neukum <oneukum@suse.de> wrot=
e:
> On Mon, 2015-01-12 at 18:53 +0800, =E6=9B=BE=E5=A9=B7=E8=91=B3 (tammy=
_tseng) wrote:
> > > (Skip the code diff...)
> >=20
> > Again macros for endianness
> >=20
> > And the driver has a great number of conditional compilations are t=
hey=20
> > really needed? The driver as is has a number of issues and is hard =
to=20
> > review due to the use of "//" for comments and a lot of conditional=
=20
> > compilation and unnecessary variables used for constants. Could you=
=20
> > fix this up and resubmit?
>=20
> Thanks for the reply. I've modified the code (sis_i2c.c/sis_i2c.h/Kco=
nfig/Makefile) to fix them.
> Please help check them if anything needs to fix.
> Thanks.

You still have conditional compilation needlessly. You still haven't
addressed the issues I told you about during the review of the last
version.

	Oliver

>=20
> Tammy
>=20
> ---
> diff --git a/linux-3.18.1/drivers/input/touchscreen/Kconfig b/linux-3=
=2E18.1/drivers/input/touchscreen/Kconfig
> index e1d8003..401cd8b 100644
> --- a/linux-3.18.1/drivers/input/touchscreen/Kconfig
> +++ b/linux-3.18.1/drivers/input/touchscreen/Kconfig
> @@ -962,4 +962,12 @@ config TOUCHSCREEN_ZFORCE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called zforce_ts.
> =20
> +config TOUCHSCREEN_SIS_I2C
> +	tristate "SiS 9200 family I2C touchscreen driver"
> +	depends on I2C
> +	default n
> +	help
> +	  This enables support for SiS 9200 family over I2C based touchscre=
ens.
> +
> +
>  endif
> diff --git a/linux-3.18.1/drivers/input/touchscreen/Makefile b/linux-=
3.18.1/drivers/input/touchscreen/Makefile
> index 090e61c..67137af 100644
> --- a/linux-3.18.1/drivers/input/touchscreen/Makefile
> +++ b/linux-3.18.1/drivers/input/touchscreen/Makefile
> @@ -79,3 +79,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+=3D zylo=
nite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+=3D w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+=3D tps6507x-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+=3D zforce_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)   	+=3D sis_i2c.o
> diff --git a/linux-3.18.1/drivers/input/touchscreen/sis_i2c.c b/linux=
-3.18.1/drivers/input/touchscreen/sis_i2c.c
> new file mode 100644
> index 0000000..157f991
> --- /dev/null
> +++ b/linux-3.18.1/drivers/input/touchscreen/sis_i2c.c
> @@ -0,0 +1,1267 @@
> +/*
> + * SiS 9200 family I2C Touch Screen Controller Driver
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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +#include <linux/earlysuspend.h>
> +#endif
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
> +#include <asm/uaccess.h>
> +#include <linux/irq.h>
> +#include <asm/unaligned.h>
> +
> +#ifdef _STD_RW_IO
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#define DEVICE_NAME "sis_aegis_touch_device"
> +static int sis_char_devs_count =3D 1;        /* device count */
> +static int sis_char_major =3D 0;
> +static struct cdev sis_char_cdev;
> +static struct class *sis_char_class =3D NULL;
> +#endif
> +
> +/* Addresses to scan */
> +static const unsigned short normal_i2c[] =3D { SIS_SLAVE_ADDR, I2C_C=
LIENT_END };
> +static struct workqueue_struct *sis_wq;
> +struct sis_ts_data *ts_bak =3D 0;
> +struct sisTP_driver_data *TPInfo =3D NULL;
> +static void sis_tpinfo_clear(struct sisTP_driver_data *TPInfo, int m=
ax);
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +static void sis_ts_early_suspend(struct early_suspend *h);
> +static void sis_ts_late_resume(struct early_suspend *h);
> +#endif
> +
> +#ifdef CONFIG_X86
> +/* static const struct i2c_client_address_data addr_data; */
> +/* Insmod parameters */
> +static int sis_ts_detect(struct i2c_client *client, struct i2c_board=
_info *info);
> +#endif
> +
> +#ifdef _CHECK_CRC
> +uint16_t cal_crc (char* cmd, int start, int end);
> +#endif
> +
> +static void PrintBuffer(int start, int length, char* buf)
> +{
> +	int i;
> +	for ( i =3D start; i < length; i++ )
> +	{
> +		printk("%02x ", buf[i]);
> +		if (i !=3D 0 && i % 30 =3D=3D 0)
> +			printk("\n");
> +	}
> +	printk("\n");=09
> +}
> +
> +int sis_command_for_write(struct i2c_client *client, int wlength, un=
signed char *wdata)
> +{
> +    int ret =3D -1;
> +    struct i2c_msg msg;
> +
> +    msg.addr =3D client->addr;
> +    /* Write */
> +    msg.flags =3D 0;
> +    msg.len =3D wlength;
> +    msg.buf =3D (unsigned char *)wdata;
> +
> +    ret =3D i2c_transfer(client->adapter, &msg, 1);
> +
> +    return ret;
> +}
> +
> +int sis_command_for_read(struct i2c_client *client, int rlength, uns=
igned char *rdata)
> +{
> +    int ret =3D -1;
> +    struct i2c_msg msg;
> +
> +    msg.addr =3D client->addr;
> +    /* Read */
> +    msg.flags =3D I2C_M_RD;
> +    msg.len =3D rlength;
> +    msg.buf =3D rdata;
> +
> +    ret =3D i2c_transfer(client->adapter, &msg, 1);
> +
> +    return ret;
> +}
> +
> +int sis_cul_unit(uint8_t report_id)
> +{
> +	int ret =3D NORMAL_LEN_PER_POINT;
> +=09
> +	if (report_id !=3D ALL_IN_ONE_PACKAGE)
> +	{
> +		if (IS_AREA(report_id) /*&& IS_TOUCH(report_id)*/)
> +		{
> +			ret +=3D AREA_LEN_PER_POINT;
> +		}
> +		if (IS_PRESSURE(report_id))
> +		{
> +			ret +=3D PRESSURE_LEN_PER_POINT;
> +		}
> +	}
> +=09
> +	return ret;=09
> +}
> +
> +int sis_ReadPacket(struct i2c_client *client, uint8_t cmd, uint8_t* =
buf)
> +{
> +	uint8_t tmpbuf[MAX_BYTE] =3D {0};
> +#ifdef _CHECK_CRC
> +	uint16_t buf_crc =3D 0;
> +	uint16_t package_crc =3D 0;
> +	int l_package_crc =3D 0;
> +	int crc_end =3D 0;
> +#endif
> +    int ret =3D -1;
> +    int touchnum =3D 0;
> +    int p_count =3D 0;
> +    int touc_formate_id =3D 0;
> +    int locate =3D 0;
> +    bool read_first =3D true;
> +   =20
> +/*
> +		New i2c format=20
> +	* buf[0] =3D Low 8 bits of byte count value
> +	* buf[1] =3D High 8 bits of byte counte value
> +	* buf[2] =3D Report ID
> +	* buf[touch num * 6 + 2 ] =3D Touch informations; 1 touch point has=
 6 bytes, it could be none if no touch=20
> +	* buf[touch num * 6 + 3] =3D Touch numbers
> +	*=20
> +	* One touch point information include 6 bytes, the order is=20
> +	*=20
> +	* 1. status =3D touch down or touch up
> +	* 2. id =3D finger id=20
> +	* 3. x axis low 8 bits
> +	* 4. x axis high 8 bits
> +	* 5. y axis low 8 bits
> +	* 6. y axis high 8 bits
> +	*=20
> +*/
> +	do
> +	{
> +		if (locate >=3D PACKET_BUFFER_SIZE)
> +		{
> +			printk(KERN_ERR "sis_ReadPacket: Buf Overflow\n");
> +			return -1;
> +		}
> +	=09
> +		ret =3D sis_command_for_read(client, MAX_BYTE, tmpbuf);
> +
> +#ifdef _DEBUG_PACKAGE
> +		printk(KERN_INFO "chaoban test: Buf_Data [0~63] \n");
> +		PrintBuffer(0, 64, tmpbuf);=09
> +#endif		=09
> +
> +		if(ret < 0 )
> +		{
> +			printk(KERN_ERR "sis_ReadPacket: i2c transfer error\n");
> +			return ret;
> +		}
> +		/* error package length of receiving data */
> +		else if (tmpbuf[P_BYTECOUNT] > MAX_BYTE)
> +		{
> +			printk(KERN_ERR "sis_ReadPacket: Error Bytecount\n");
> +			return -1;=09
> +		}
> +	=09
> +		if (read_first)
> +		{
> +#ifdef _SUPPORT_BUTTON_TOUCH
> +			/* access BUTTON TOUCH event and BUTTON NO TOUCH event */
> +			if (tmpbuf[P_REPORT_ID] =3D=3D  BUTTON_FORMAT)
> +			{
> +				memcpy(&buf[0], &tmpbuf[0], 7);
> +				return 0; 	/* touchnum is 0 */
> +			}
> +#endif=20
> +			/* access NO TOUCH event unless BUTTON NO TOUCH event */
> +			if (tmpbuf[P_BYTECOUNT] =3D=3D 0/*NO_TOUCH_BYTECOUNT*/)
> +			{
> +				return 0;	/* touchnum is 0 */
> +			}
> +		}
> +
> +		/* skip parsing data when two devices are registered at the same s=
lave address
> +		 * parsing data when P_REPORT_ID && 0xf is TOUCH_FORMAT or P_REPOR=
T_ID is ALL_IN_ONE_PACKAGE
> +		 */ =20
> +		touc_formate_id =3D tmpbuf[P_REPORT_ID] & 0xf;
> +		if ((touc_formate_id !=3D TOUCH_FORMAT) && (touc_formate_id !=3D H=
IDI2C_FORMAT) && (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE))
> +		{
> +			printk(KERN_ERR "sis_ReadPacket: Error Report_ID\n");
> +			return -1;	=09
> +		}
> +	=09
> +		p_count =3D (int) tmpbuf[P_BYTECOUNT] - 1;	/* start from 0 */
> +		if (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE)
> +		{
> +			if (IS_TOUCH(tmpbuf[P_REPORT_ID]))
> +			{
> +				p_count -=3D BYTE_CRC_I2C;	/* delete 2 byte crc */
> +			}
> +			else if (IS_HIDI2C(tmpbuf[P_REPORT_ID]))
> +			{
> +				p_count -=3D BYTE_CRC_HIDI2C;
> +			}
> +			else	/* should not be happen */
> +			{
> +				printk(KERN_ERR "sis_ReadPacket: delete crc error\n");
> +				return -1;
> +			}
> +
> +			if (IS_SCANTIME(tmpbuf[P_REPORT_ID]))
> +			{
> +				p_count -=3D BYTE_SCANTIME;
> +			}
> +		}
> +		/* else {}    						 For ALL_IN_ONE_PACKAGE */
> +	=09
> +		if (read_first)
> +		{
> +			touchnum =3D tmpbuf[p_count]; =09
> +		}
> +		else
> +		{
> +			if (tmpbuf[p_count] !=3D 0)
> +			{
> +				printk(KERN_ERR "sis_ReadPacket: get error package\n");
> +				return -1;
> +			}
> +		}
> +
> +#ifdef _CHECK_CRC
> +		crc_end =3D p_count + (IS_SCANTIME(tmpbuf[P_REPORT_ID]) * 2);
> +		buf_crc =3D cal_crc(tmpbuf, 2, crc_end); /* sub bytecount (2 byte)=
 */
> +		l_package_crc =3D p_count + 1 + (IS_SCANTIME(tmpbuf[P_REPORT_ID]) =
* 2);
> +		package_crc =3D get_unaligned_le16(&tmpbuf[l_package_crc]);
> +		=09
> +		if (buf_crc !=3D package_crc)
> +		{
> +			printk(KERN_ERR "sis_ReadPacket: CRC Error\n");
> +			return -1;
> +		}
> +#endif=09
> +		memcpy(&buf[locate], &tmpbuf[0], 64);	/* Buf_Data [0~63] [64~128] =
*/
> +		locate +=3D 64;
> +		read_first =3D false;
> +	=09
> +	}while(tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE  &&  tmpbuf[p_co=
unt] > 5);
> +
> +	return touchnum;
> +}=09
> +
> +
> +int check_gpio_interrupt(void)
> +{
> +    int ret =3D 0;
> +
> +    /* CHECK GPIO INTERRUPT STATUS BY YOUR PLATFORM SETTING. */
> +    ret =3D gpio_get_value(GPIO_IRQ);
> +=09
> +    return ret;
> +}
> +
> +void ts_report_key(struct i2c_client *client, uint8_t keybit_state)
> +{
> +	int i =3D 0;
> +	uint8_t diff_keybit_state=3D 0x0; /* check keybit_state is differen=
ce with pre_keybit_state */
> +	uint8_t key_value =3D 0x0; 		/* button location for binary */
> +	uint8_t  key_pressed =3D 0x0; 	/* button is up or down */
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (!ts)
> +	{
> +		printk(KERN_ERR "%s error: Missing Platform Data!\n", __func__);
> +		return;
> +	}
> +
> +	diff_keybit_state =3D TPInfo->pre_keybit_state ^ keybit_state;
> +
> +	if (diff_keybit_state)
> +	{
> +		for (i =3D 0; i < BUTTON_KEY_COUNT; i++)
> +		{
> +		    if ((diff_keybit_state >> i) & 0x01)
> +			{
> +				key_value =3D diff_keybit_state & (0x01 << i);
> +				key_pressed =3D (keybit_state >> i) & 0x01;
> +				switch (key_value)
> +				{
> +					case MSK_COMP:
> +						input_report_key(ts->input_dev, KEY_COMPOSE, key_pressed);
> +						break;
> +					case MSK_BACK:
> +						input_report_key(ts->input_dev, KEY_BACK, key_pressed);
> +						break;
> +					case MSK_MENU:
> +						input_report_key(ts->input_dev, KEY_MENU, key_pressed);
> +						break;
> +					case MSK_HOME:
> +						input_report_key(ts->input_dev, KEY_HOME, key_pressed);
> +						break;
> +					case MSK_NOBTN:
> +						/* Release the button if it touched. */
> +					default:
> +						break;
> +				}
> +			}
> +		}
> +		TPInfo->pre_keybit_state =3D keybit_state;
> +	}
> +}
> +
> +
> +static void sis_ts_work_func(struct work_struct *work)
> +{
> +	struct sis_ts_data *ts =3D container_of(work, struct sis_ts_data, w=
ork);
> +    int ret =3D -1;
> +    int point_unit; =20
> +	uint8_t buf[PACKET_BUFFER_SIZE] =3D {0};
> +	uint8_t i =3D 0, fingers =3D 0;
> +	uint8_t px =3D 0, py =3D 0, pstatus =3D 0;
> +	uint8_t p_area =3D 0;
> +    uint8_t p_preasure =3D 0;
> +#ifdef _SUPPORT_BUTTON_TOUCH=09
> +	int button_key;
> +	uint8_t button_buf[10] =3D {0};
> +#endif
> +
> +#ifdef _ANDROID_4
> +	bool all_touch_up =3D true;
> +#endif
> +=09
> +	mutex_lock(&ts->mutex_wq);=20
> +
> +    /* I2C or SMBUS block data read */
> +    ret =3D sis_ReadPacket(ts->client, SIS_CMD_NORMAL, buf);
> +=20
> +#ifdef _SUPPORT_BUTTON_TOUCH
> +	 sis_ReadPacket(ts->client, SIS_CMD_NORMAL, button_buf);
> +#endif
> +
> +	/* Error Number */
> +	if (ret < 0)=20
> +	{
> +		goto err_free_allocate;
> +	}
> +#ifdef _SUPPORT_BUTTON_TOUCH
> +	/* access BUTTON TOUCH event and BUTTON NO TOUCH even */
> +	else if (button_buf[P_REPORT_ID] =3D=3D BUTTON_FORMAT)
> +	{
> +		button_key =3D get_unaligned_le16(&button_buf[BUTTON_STATE]);	=09
> +		ts_report_key(ts->client, button_key);
> +	}
> +#endif
> +	/* access NO TOUCH event unless BUTTON NO TOUCH event */
> +	else if (ret =3D=3D 0)
> +	{
> +		fingers =3D 0;
> +		sis_tpinfo_clear(TPInfo, MAX_FINGERS);
> +		goto label_send_report;  /* need to report input_mt_sync() */
> +	}
> +=09
> +	sis_tpinfo_clear(TPInfo, MAX_FINGERS);
> +=09
> +	/* Parser and Get the sis9200 data */
> +	point_unit =3D sis_cul_unit(buf[P_REPORT_ID]);
> +	fingers =3D ret;
> +=09
> +	TPInfo->fingers =3D fingers =3D (fingers > MAX_FINGERS ? 0 : finger=
s);
> +=09
> +	/* fingers 10 =3D  0 ~ 9 */
> +	for (i =3D 0; i < fingers; i++)=20
> +	{
> +        if ((buf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) && (i >=3D 5)=
)
> +        { /* Calc point status */
> +			pstatus =3D BYTE_BYTECOUNT + BYTE_ReportID + ((i - 5) * point_uni=
t);    =09
> +			pstatus +=3D 64;
> +		}
> +		else=20
> +		{ /* Calc point status */
> +			pstatus =3D BYTE_BYTECOUNT + BYTE_ReportID + (i * point_unit);   =
       =09
> +		}
> +
> +	    px =3D pstatus + 2;	/* Calc point x_coord */
> +	    py =3D px + 2;		/* Calc point y_coord */
> +
> +		if ((buf[pstatus]) =3D=3D TOUCHUP)
> +		{
> +			TPInfo->pt[i].Width =3D 0;
> +			TPInfo->pt[i].Height =3D 0;
> +			TPInfo->pt[i].Pressure =3D 0;
> +		}
> +		else if (buf[P_REPORT_ID] =3D=3D ALL_IN_ONE_PACKAGE && (buf[pstatu=
s]) =3D=3D TOUCHDOWN)
> +		{
> +			TPInfo->pt[i].Width =3D 1;
> +			TPInfo->pt[i].Height =3D 1;
> +			TPInfo->pt[i].Pressure =3D 1;		=09
> +		}
> +		else if ((buf[pstatus]) =3D=3D TOUCHDOWN)
> +		{=09
> +			p_area =3D py + 2;
> +			p_preasure =3D py + 2 + (IS_AREA(buf[P_REPORT_ID]) * 2);
> +
> +			/* area */
> +			if (IS_AREA(buf[P_REPORT_ID]))
> +			{
> +				TPInfo->pt[i].Width =3D buf[p_area] & 0xff;
> +				TPInfo->pt[i].Height =3D buf[p_area + 1] & 0xff;
> +			}
> +			else=20
> +			{
> +				TPInfo->pt[i].Width =3D 1;
> +				TPInfo->pt[i].Height =3D 1;
> +			}
> +			/* preasure */
> +			if (IS_PRESSURE(buf[P_REPORT_ID]))
> +				TPInfo->pt[i].Pressure =3D (buf[p_preasure]);
> +			else=20
> +				TPInfo->pt[i].Pressure =3D 1;			=09
> +		}
> +		else
> +		{
> +			printk(KERN_ERR "sis_ts_work_func: Error Touch Status\n");
> +			goto err_free_allocate;
> +		}
> +	=09
> +		TPInfo->pt[i].id =3D (buf[pstatus + 1]);
> +		TPInfo->pt[i].x =3D ((buf[px] & 0xff) | ((buf[px + 1] & 0xff)<< 8)=
);
> +        TPInfo->pt[i].y =3D ((buf[py] & 0xff) | ((buf[py + 1] & 0xff=
)<< 8));  =20

Please use the macros for endianness conversion.

>   =20
> +	}
> +	=09
> +#ifdef _DEBUG_REPORT
> +	for (i =3D 0; i < TPInfo->fingers; i++)
> +	{
> +		 printk(KERN_INFO "chaoban test: i =3D %d, id =3D %d, x =3D %d, y =
=3D %d, pstatus =3D %d, width =3D %d, height =3D %d, pressure =3D %d, \=
n", i, TPInfo->pt[i].id, TPInfo->pt[i].x, TPInfo->pt[i].y, buf[pstatus]=
, TPInfo->pt[i].Width,  TPInfo->pt[i].Height, TPInfo->pt[i].Pressure);
> +	}
> +#endif
> +
> +label_send_report:
> +/* Report co-ordinates to the multi-touch stack */
> +#ifdef _ANDROID_4=09
> +	for(i =3D 0; ((i < TPInfo->fingers) && (i < MAX_FINGERS)); i++)
> +	{
> +		if(TPInfo->pt[i].Pressure)
> +		{
> +			TPInfo->pt[i].Width *=3D AREA_UNIT;=09
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, TPInfo->pt[i]=
=2EWidth);
> +			TPInfo->pt[i].Height *=3D AREA_UNIT;
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MINOR, TPInfo->pt[i]=
=2EHeight);		=09
> +			input_report_abs(ts->input_dev, ABS_MT_PRESSURE, TPInfo->pt[i].Pr=
essure);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_X, TPInfo->pt[i].=
x);
> +			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, TPInfo->pt[i].=
y);
> +			input_report_abs(ts->input_dev, ABS_MT_TRACKING_ID, TPInfo->pt[i]=
=2Eid);
> +			input_mt_sync(ts->input_dev);
> +			all_touch_up =3D false;
> +		}
> +	=09
> +		if (i =3D=3D (TPInfo->fingers -1) && all_touch_up =3D=3D true)
> +		{
> +			input_mt_sync(ts->input_dev);
> +		}
> +	}
> +
> +	if(TPInfo->fingers =3D=3D 0)
> +	{
> +		input_mt_sync(ts->input_dev);
> +	}
> +#else
> +	i =3D 0;
> +	do
> +	{
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, TPInfo->pt[i].=
Pressure);
> +		input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, TPInfo->pt[i].=
Width);
> +		input_report_abs(ts->input_dev, ABS_MT_WIDTH_MINOR, TPInfo->pt[i].=
Height);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, TPInfo->pt[i].x=
);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, TPInfo->pt[i].y=
);
> +		input_report_abs(ts->input_dev, ABS_MT_TRACKING_ID, TPInfo->pt[i].=
id); /* Android 2.3 */
> +		input_mt_sync(ts->input_dev);
> +		i++;
> +	}
> +	while ((i < TPInfo->fingers) && (i < MAX_FINGERS));
> +#endif
> +	input_sync(ts->input_dev);
> +
> +err_free_allocate:
> +
> +    if (ts->use_irq)
> +    {
> +/* case 1 mode */
> +#ifdef _INT_MODE_1=20
> +	    /*TODO: After interrupt status low, read i2c bus data by pollin=
g, until interrupt status is high */
> +	    ret =3D check_gpio_interrupt();	/* interrupt pin is still LOW, =
read data until interrupt pin is released. */
> +	    if (!ret)
> +	    {
> +	        hrtimer_start(&ts->timer, ktime_set(0, TIMER_NS), HRTIMER_M=
ODE_REL);
> +	    }
> +	    else
> +	    {
> +			if (TPInfo->pre_keybit_state)
> +			{
> +				ts_report_key(ts->client, 0x0);	/* clear for interrupt */
> +			}
> +		=09
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +        	if ((ts->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_DIS=
ABLED)
> +#else
> +        	if ((ts->desc->irq_data.state_use_accessors & IRQD_IRQ_DISA=
BLED) =3D=3D IRQ_STATUS_DISABLED)
> +#endif
> +        	{
> +				enable_irq(ts->client->irq);
> +			}
> +	    }
> +/* case 2 mode */
> +#else
> +
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +		if ((ts->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_DISABLED)
> +#else
> +		if ((ts->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLED) =3D=
=3D IRQ_STATUS_DISABLED)
> +#endif
> +		{
> +			enable_irq(ts->client->irq);
> +		}
> +#endif
> +	}
> +
> +	mutex_unlock(&ts->mutex_wq);
> +    return;
> +}
> +
> +static void sis_tpinfo_clear(struct sisTP_driver_data *TPInfo, int m=
ax)
> +{
> +	int i =3D 0;
> +	for(i =3D 0; i < max; i++)
> +	{
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
> +	queue_work(sis_wq, &ts->work);
> +	if (!ts->use_irq)
> +	{	/* For Polling mode */
> +	    hrtimer_start(&ts->timer, ktime_set(0, TIMER_NS), HRTIMER_MODE_=
REL);
> +	}
> +	return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id)
> +{
> +	struct sis_ts_data *ts =3D dev_id;
> +=09
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +	if ((ts->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_ENABLED)
> +#else
> +	if ((ts->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLED) =3D=
=3D IRQ_STATUS_ENABLED)
> +#endif
> +	{
> +		disable_irq_nosync(ts->client->irq);
> +	}
> +	queue_work(sis_wq, &ts->work);
> +	=09
> +	return IRQ_HANDLED;
> +}
> +
> +static int initial_irq(void)
> +{
> +	int ret =3D 0;
> +#ifdef _I2C_INT_ENABLE
> +	/* initialize gpio and interrupt pins */
> +	ret =3D gpio_request(GPIO_IRQ, "GPIO_133");	/* ex. GPIO_133 for int=
errupt mode */
> +	if (ret < 0)
> +	{
> +		/* Set Active Low. Please reference the file include/linux/interru=
pt.h */
> +	}
> +	/* setting gpio direction here OR boardinfo file*/
> +
> +#else
> +	ret =3D -1;
> +#endif
> +	return ret;
> +}
> +
> +uint16_t cal_crc (char* cmd, int start, int end)
> +{
> +	int i =3D 0;
> +	uint16_t crc =3D 0;
> +=09
> +	for (i =3D start; i <=3D end ; i++)
> +	{
> +		crc =3D (crc<<8) ^ crc16tab[((crc>>8) ^ cmd[i] )&0x00FF];
> +	}
> +=09
> +	return crc;
> +}

How about making this CRC generally available?
> +
> +uint16_t cal_crc_with_cmd (char* data, int start, int end, uint8_t c=
md)
> +{
> +	int i =3D 0;
> +	uint16_t crc =3D 0;
> +=09
> +	crc =3D (crc<<8) ^ crc16tab[((crc>>8) ^ cmd)&0x00FF];
> +	for (i =3D start; i <=3D end ; i++)
> +	{
> +		crc =3D (crc<<8) ^ crc16tab[((crc>>8) ^ data[i] )&0x00FF];
> +	}
> +=09
> +	return crc;
> +}
> +
> +void write_crc (unsigned char *buf, int start, int end)
> +{
> +	uint16_t crc =3D 0;
> +=09
> +	crc =3D cal_crc (buf, start , end);
> +	buf[end+1] =3D (crc >> 8)& 0xff;
> +	buf[end+2] =3D crc & 0xff;

Please use the macro

> +}
> +
> +#ifdef _STD_RW_IO
> +#define BUFFER_SIZE MAX_BYTE
> +static ssize_t sis_cdev_write( struct file *file, const char __user =
*buf, size_t count, loff_t *f_pos )
> +{
> +	 int ret =3D 0;
> +	 char *kdata;
> +	 char cmd;
> +	=20
> +	 printk(KERN_INFO "sis_cdev_write.\n");
> +	=20
> +	 if (ts_bak =3D=3D 0)
> +    	return -13;

You _must_ use symbolic values.

> +    =09
> +    ret =3D access_ok(VERIFY_WRITE, buf, BUFFER_SIZE);
> +    if (!ret) {
> +        printk(KERN_ERR "cannot access user space memory\n");
> +        return -11;
> +    }
> +
> +	 kdata =3D kmalloc(BUFFER_SIZE, GFP_KERNEL);
> +     if (kdata =3D=3D 0)
> +    	return -12;
> +    =09
> +     ret =3D copy_from_user(kdata, buf, BUFFER_SIZE);
> +     if (ret) {
> +        printk(KERN_ERR "copy_from_user fail\n");
> +        kfree(kdata);
> +        return -14;
> +     }=20
> +#if 0
> +	PrintBuffer(0, count, kdata);
> +#endif
> +	=09
> +	cmd =3D kdata[6];
> +
> +/* Write & Read */
> +    ret =3D sis_command_for_write(ts_bak->client, count, kdata);
> +    if (ret < 0) {
> +        printk(KERN_ERR "i2c_transfer write error %d\n", ret);
> +		kfree(kdata);
> +		return -21;
> +	}
> +
> +    if ( copy_to_user((char*) buf, kdata, BUFFER_SIZE ) )
> +    {
> +        printk(KERN_ERR "copy_to_user fail\n" );
> +        ret =3D -19;
> +    }
> +
> +    kfree( kdata );
> +
> +	return ret;
> +}
> +
> +/* for get system time */
> +static ssize_t sis_cdev_read( struct file *file, char __user *buf, s=
ize_t count, loff_t *f_pos )
> +{
> +	 int ret =3D 0;
> +	 char *kdata;
> +	 char cmd;
> +	 int i;
> +	=20
> +	 printk(KERN_INFO "sis_cdev_read.\n");
> +	=20
> +	 if (ts_bak =3D=3D 0)
> +    	return -13;
> +    =09
> +    ret =3D access_ok(VERIFY_WRITE, buf, BUFFER_SIZE);
> +    if (!ret) {
> +        printk(KERN_ERR "cannot access user space memory\n");
> +        return -11;
> +    }
> +
> +	 kdata =3D kmalloc(BUFFER_SIZE, GFP_KERNEL);
> +     if (kdata =3D=3D 0)
> +    	return -12;
> +    =09
> +     ret =3D copy_from_user(kdata, buf, BUFFER_SIZE);
> +     if (ret) {
> +        printk(KERN_ERR "copy_from_user fail\n");
> +        kfree(kdata);
> +        return -14;
> +     }   =20
> +#if 0
> +    PrintBuffer(0, count, kdata);
> +#endif
> +	 cmd =3D kdata[6];
> +	 /* for making sure AP communicates with SiS driver */
> +    if(cmd =3D=3D 0xa2)
> +    {
> +		kdata[0] =3D 5;
> +		kdata[1] =3D 0;
> +		kdata[3] =3D 'S';
> +		kdata[4] =3D 'i';
> +		kdata[5] =3D 'S';
> +		if ( copy_to_user((char*) buf, kdata, BUFFER_SIZE ) )
> +		{
> +			printk(KERN_ERR "copy_to_user fail\n" );
> +			kfree( kdata );
> +			return -19;
> +		}
> +
> +		kfree( kdata );
> +		return 3;=09
> +	}
> +/* Write & Read */
> +    ret =3D sis_command_for_read(ts_bak->client, MAX_BYTE, kdata);
> +    if (ret < 0) {
> +        printk(KERN_ERR "i2c_transfer read error %d\n", ret);
> +		kfree(kdata);
> +		return -21;
> +	}
> +
> +	ret =3D kdata[0] | (kdata[1] << 8);
> +
> +    printk(KERN_INFO "%d\n", ret);
> +
> +    for ( i =3D 0; i < ret && i < BUFFER_SIZE; i++ )
> +    {
> +        printk("%02x ", kdata[i]);
> +    }
> +
> +    printk( "\n" );
> +
> +    if ( copy_to_user((char*) buf, kdata, BUFFER_SIZE ) )
> +    {
> +        printk(KERN_ERR "copy_to_user fail\n" );
> +        ret =3D -19;
> +    }
> +
> +    kfree( kdata );
> +
> +	return ret;
> +}
> +
> +#undef BUFFER_SIZE
> +
> +static int sis_cdev_open(struct inode *inode, struct file *filp)
> +{
> +	printk(KERN_INFO "sis_cdev_open.\n");
> +	if ( ts_bak =3D=3D 0 )
> +    	return -13;
> +
> +	msleep(200);
> +	if (ts_bak->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +        if ((ts_bak->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_=
ENABLED)
> +#else
> +		if ((ts_bak->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLE=
D) =3D=3D IRQ_STATUS_ENABLED)
> +#endif=09
> +		{
> +			disable_irq(ts_bak->client->irq);
> +		}
> +		else
> +		{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +			printk(KERN_INFO "sis_cdev_open: IRQ_STATUS: %x\n",(ts_bak->desc-=
>status & IRQ_DISABLED));
> +#else
> +			printk(KERN_INFO "sis_cdev_open: IRQ_STATUS: %x\n",(ts_bak->desc-=
>irq_data.state_use_accessors & IRQD_IRQ_DISABLED));
> +#endif=09
> +		}
> +	}
> +	hrtimer_cancel(&ts_bak->timer);
> +
> +	/* only flush sis_wq */
> +	flush_workqueue(sis_wq); 	  =20
> +   =20
> +    msleep(200);
> +
> +	return 0; /* success */
> +}
> +
> +static int sis_cdev_release(struct inode *inode, struct file *filp)
> +{
> +	printk(KERN_INFO "sis_cdev_release.\n");
> +=09
> +	msleep(200);
> +=09
> +    if (ts_bak =3D=3D 0)
> +    	return -13;
> +
> +	if (ts_bak->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +        if ((ts_bak->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_=
DISABLED)
> +#else
> +		if ((ts_bak->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLE=
D) =3D=3D IRQ_STATUS_DISABLED)
> +#endif=09
> +		{
> +			enable_irq(ts_bak->client->irq);
> +		}
> +	}
> +	else
> +		hrtimer_start(&ts_bak->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +
> +    return 0;
> +}
> +
> +static const struct file_operations sis_cdev_fops =3D {
> +	.owner	=3D THIS_MODULE,
> +	.read	=3D sis_cdev_read,
> +	.write	=3D sis_cdev_write,
> +	.open	=3D sis_cdev_open,
> +	.release=3D sis_cdev_release,
> +};
> +
> +static int sis_setup_chardev(struct sis_ts_data *ts)
> +{
> +=09
> +	dev_t dev =3D MKDEV(sis_char_major, 0);
> +	int alloc_ret =3D 0;
> +	int cdev_err =3D 0;
> +	int input_err =3D 0;
> +	struct device *class_dev =3D NULL;
> +	void *ptr_err;
> +=09
> +	printk("sis_setup_chardev.\n");
> +=09
> +	if (ts =3D=3D NULL)=20
> +	{
> +	  input_err =3D -ENOMEM;
> +	  goto error;
> +	}=20
> +	/* dynamic allocate driver handle */
> +	alloc_ret =3D alloc_chrdev_region(&dev, 0, sis_char_devs_count, DEV=
ICE_NAME);
> +	if (alloc_ret)
> +		goto error;
> +	=09
> +	sis_char_major =3D MAJOR(dev);
> +	cdev_init(&sis_char_cdev, &sis_cdev_fops);
> +	sis_char_cdev.owner =3D THIS_MODULE;
> +	cdev_err =3D cdev_add(&sis_char_cdev, MKDEV(sis_char_major, 0), sis=
_char_devs_count);
> +=09
> +	if (cdev_err)=20
> +		goto error;
> +=09
> +	printk(KERN_INFO "%s driver(major %d) installed.\n", DEVICE_NAME, s=
is_char_major);
> +=09
> +	/* register class */
> +	sis_char_class =3D class_create(THIS_MODULE, DEVICE_NAME);
> +	if(IS_ERR(ptr_err =3D sis_char_class))=20
> +	{
> +		goto err2;
> +	}
> +=09
> +	class_dev =3D device_create(sis_char_class, NULL, MKDEV(sis_char_ma=
jor, 0), NULL, DEVICE_NAME);
> +=09
> +	if(IS_ERR(ptr_err =3D class_dev))=20
> +	{
> +		goto err;
> +	}
> +=09
> +	return 0;
> +error:
> +	if (cdev_err =3D=3D 0)
> +		cdev_del(&sis_char_cdev);
> +	if (alloc_ret =3D=3D 0)
> +		unregister_chrdev_region(MKDEV(sis_char_major, 0), sis_char_devs_c=
ount);
> +	if(input_err !=3D 0)
> +	{
> +		printk("sis_ts_bak error!\n");
> +	}
> +err:
> +	device_destroy(sis_char_class, MKDEV(sis_char_major, 0));
> +err2:
> +	class_destroy(sis_char_class);
> +	return -1;
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
> +    printk(KERN_INFO "sis_ts_probe\n");
> +
> +    TPInfo =3D kzalloc(sizeof(struct sisTP_driver_data), GFP_KERNEL)=
;
> +    if (TPInfo =3D=3D NULL)=20
> +    {
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +
> +	ts =3D kzalloc(sizeof(struct sis_ts_data), GFP_KERNEL);
> +	if (ts =3D=3D NULL)=20
> +	{
> +		ret =3D -ENOMEM;
> +		goto err_alloc_data_failed;
> +	}
> +
> +	ts_bak =3D ts;
> +
> +	mutex_init(&ts->mutex_wq);
> +=09
> +	/* 1. Init Work queue and necessary buffers */
> +	INIT_WORK(&ts->work, sis_ts_work_func);
> +	ts->client =3D client;
> +	i2c_set_clientdata(client, ts);
> +    pdata =3D client->dev.platform_data;
> +
> +	if (pdata)
> +		ts->power =3D pdata->power;
> +	if (ts->power)=20
> +	{
> +		ret =3D ts->power(1);
> +		if (ret < 0)=20
> +		{
> +			printk(KERN_ERR "sis_ts_probe power on failed\n");
> +			goto err_power_failed;
> +		}
> +	}
> +
> +	/* 2. Allocate input device */
> +	ts->input_dev =3D input_allocate_device();
> +	if (ts->input_dev =3D=3D NULL)=20
> +	{
> +		ret =3D -ENOMEM;
> +		printk(KERN_ERR "sis_ts_probe: Failed to allocate input device\n")=
;
> +		goto err_input_dev_alloc_failed;
> +	}
> +
> +	/* This input device name should be the same to IDC file name. */
> +	ts->input_dev->name =3D "sis_touch";
> +
> +	set_bit(EV_ABS, ts->input_dev->evbit);
> +	set_bit(EV_KEY, ts->input_dev->evbit);
> +    set_bit(ABS_MT_POSITION_X, ts->input_dev->absbit);
> +    set_bit(ABS_MT_POSITION_Y, ts->input_dev->absbit);
> +    set_bit(ABS_MT_TRACKING_ID, ts->input_dev->absbit);
> +
> +#ifdef _ANDROID_4
> +	set_bit(INPUT_PROP_DIRECT, ts->input_dev->propbit);
> +    set_bit(ABS_MT_PRESSURE, ts->input_dev->absbit);
> +    set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
> +    set_bit(ABS_MT_TOUCH_MINOR, ts->input_dev->absbit);
> +    input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE, 0, PRESSURE=
_MAX, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, AREA_=
LENGTH_LONGER, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MINOR, 0, AREA_=
LENGTH_SHORT, 0, 0);  =20
> +#else
> +    set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
> +    set_bit(ABS_MT_WIDTH_MAJOR, ts->input_dev->absbit);
> +    set_bit(ABS_MT_WIDTH_MINOR, ts->input_dev->absbit);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, PRESS=
URE_MAX, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, AREA_=
LENGTH_LONGER, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MINOR, 0, AREA_=
LENGTH_SHORT, 0, 0);
> +#endif
> +
> +    input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0, SIS_MA=
X_X, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0, SIS_MA=
X_Y, 0, 0);
> +    input_set_abs_params(ts->input_dev, ABS_MT_TRACKING_ID, 0, 15, 0=
, 0);
> +=09
> +    /* add for touch keys */
> +	set_bit(KEY_COMPOSE, ts->input_dev->keybit);
> +	set_bit(KEY_BACK, ts->input_dev->keybit);
> +	set_bit(KEY_MENU, ts->input_dev->keybit);
> +	set_bit(KEY_HOME, ts->input_dev->keybit);
> +
> +	/* 3. Register input device to core */
> +	ret =3D input_register_device(ts->input_dev);
> +
> +	if (ret)=20
> +	{
> +		printk(KERN_ERR "sis_ts_probe: Unable to register %s input device\=
n", ts->input_dev->name);
> +		goto err_input_register_device_failed;
> +	}
> +=09
> +	/* 4. irq or timer setup */
> +	ret =3D initial_irq();
> +	if (ret < 0)=20
> +	{
> +
> +	}
> +	else
> +	{
> +		client->irq =3D gpio_to_irq(GPIO_IRQ);
> +		ret =3D request_irq(client->irq, sis_ts_irq_handler, IRQF_TRIGGER_=
=46ALLING, client->name, ts);
> +		if (ret =3D=3D 0)=20
> +		{
> +		   ts->use_irq =3D 1;
> +		}
> +		else=20
> +		{
> +			dev_err(&client->dev, "request_irq failed\n");
> +		}
> +	}
> +
> +	ts->desc =3D irq_to_desc(ts_bak->client->irq);
> +=09
> +	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ts->timer.function =3D sis_ts_timer_func;
> +
> +	if (!ts->use_irq)=20
> +	{
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +	}
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	ts->early_suspend.level =3D EARLY_SUSPEND_LEVEL_BLANK_SCREEN + 1;
> +	ts->early_suspend.suspend =3D sis_ts_early_suspend;
> +	ts->early_suspend.resume =3D sis_ts_late_resume;
> +	register_early_suspend(&ts->early_suspend);
> +#endif
> +	printk(KERN_INFO "sis_ts_probe: Start touchscreen %s in %s mode\n",=
 ts->input_dev->name, ts->use_irq ? "interrupt" : "polling");
> +=09
> +	if (ts->use_irq)
> +	{
> +#ifdef _INT_MODE_1
> +		printk(KERN_INFO "sis_ts_probe: interrupt case 1 mode\n");
> +#else
> +		printk(KERN_INFO "sis_ts_probe: interrupt case 2 mode\n");
> +#endif
> +	}
> +=09
> +#ifdef _STD_RW_IO
> +	ret =3D sis_setup_chardev(ts);
> +	if(ret)
> +	{
> +		printk( KERN_INFO"sis_setup_chardev fail\n");
> +	}
> +#endif
> +
> +	printk( KERN_INFO"sis SIS_SLAVE_ADDR: %d\n", SIS_SLAVE_ADDR);
> +
> +	return 0;
> +
> +err_input_register_device_failed:
> +	input_free_device(ts->input_dev);
> +
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
> +=09
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +	unregister_early_suspend(&ts->early_suspend);
> +#endif
> +	if (ts->use_irq)
> +		free_irq(client->irq, ts);
> +	else
> +		hrtimer_cancel(&ts->timer);
> +	input_unregister_device(ts->input_dev);
> +	kfree(ts);
> +=09
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
> +	if (ts->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +		if ((ts->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_ENABLED)
> +#else
> +		if ((ts->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLED) =3D=
=3D IRQ_STATUS_ENABLED)
> +#endif
> +		{
> +			disable_irq(client->irq);
> +		}
> +	}
> +	else
> +		hrtimer_cancel(&ts->timer);
> +	/* only flush sis_wq */
> +	flush_workqueue(sis_wq); 	   	=09
> +
> +	if (ts->power) {
> +		ret =3D ts->power(0);
> +		if (ret < 0)
> +			printk(KERN_ERR "sis_ts_suspend power off failed\n");
> +	}
> +=09
> +	return 0;
> +}
> +
> +static int sis_ts_resume(struct i2c_client *client)
> +{
> +	int ret =3D 0;
> +	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
> +
> +	if (ts->power)
> +	{
> +		ret =3D ts->power(1);
> +		if (ret < 0)
> +			printk(KERN_ERR "sis_ts_resume power on failed\n");
> +	}
> +
> +	if (ts->use_irq)
> +	{
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +		if ((ts->desc->status & IRQ_DISABLED) =3D=3D IRQ_STATUS_DISABLED)
> +#else
> +		if ((ts->desc->irq_data.state_use_accessors & IRQD_IRQ_DISABLED) =3D=
=3D IRQ_STATUS_DISABLED)
> +#endif
> +		{
> +			enable_irq(client->irq);
> +		}
> +	}
> +	else
> +		hrtimer_start(&ts->timer, ktime_set(1, 0), HRTIMER_MODE_REL);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +static void sis_ts_early_suspend(struct early_suspend *h)
> +{
> +	struct sis_ts_data *ts;
> +=09
> +	TPInfo->pre_keybit_state =3D 0x0;
> +	ts =3D container_of(h, struct sis_ts_data, early_suspend);
> +	sis_ts_suspend(ts->client, PMSG_SUSPEND);
> +}
> +
> +static void sis_ts_late_resume(struct early_suspend *h)
> +{
> +	struct sis_ts_data *ts;
> +=09
> +	ts =3D container_of(h, struct sis_ts_data, early_suspend);
> +	sis_ts_resume(ts->client);
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
> +    .class      =3D I2C_CLASS_HWMON,
> +    .detect		=3D sis_ts_detect,
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
> +	printk( KERN_INFO "sis_ts_init\n" );
> +=09
> +	sis_wq =3D create_singlethread_workqueue("sis_wq");
> +
> +	if (!sis_wq)
> +		return -ENOMEM;
> +	=09
> +	return i2c_add_driver(&sis_ts_driver);
> +}
> +
> +#ifdef CONFIG_X86
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int sis_ts_detect(struct i2c_client *client,
> +		       struct i2c_board_info *info)
> +{
> +	const char *type_name;
> +=09
> +    printk(KERN_INFO "sis_ts_detect\n");
> +=09
> +	type_name =3D "sis_i2c_ts";
> +	strlcpy(info->type, type_name, I2C_NAME_SIZE);
> +=09
> +	return 0;
> +}
> +#endif
> +
> +static void __exit sis_ts_exit(void)
> +{
> +#ifdef _STD_RW_IO
> +	dev_t dev;
> +#endif
> +
> +	printk(KERN_INFO "sis_ts_exit\n");
> +=09
> +	i2c_del_driver(&sis_ts_driver);
> +=09
> +	if (sis_wq)
> +		destroy_workqueue(sis_wq);
> +
> +#ifdef _STD_RW_IO
> +	dev =3D MKDEV(sis_char_major, 0);
> +	cdev_del(&sis_char_cdev);
> +	unregister_chrdev_region(dev, sis_char_devs_count);
> +	device_destroy(sis_char_class, MKDEV(sis_char_major, 0));
> +	class_destroy(sis_char_class);

This is a race condition. You must destroy the character devce
first, then the infrastructure it uses.
> +#endif
> +}
> +
> +module_init(sis_ts_init);
> +module_exit(sis_ts_exit);
> +MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/linux-3.18.1/drivers/input/touchscreen/sis_i2c.h b/linux=
-3.18.1/drivers/input/touchscreen/sis_i2c.h
> new file mode 100644
> index 0000000..c1d65c4
> --- /dev/null
> +++ b/linux-3.18.1/drivers/input/touchscreen/sis_i2c.h
> @@ -0,0 +1,215 @@
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
> +#define TIMER_NS    					10000000 //10ms
> +#define MAX_FINGERS						10
> +
> +
> +/* For Android 4.0 							*/
> +/* Only for Linux kernel 2.6.34 and later 	*/
> +#define _ANDROID_4					//  ON/OFF
> +
> +/* For standard R/W IO*/
> +#define _STD_RW_IO						//  ON/OFF
> +
> +/* Interrupt setting and modes */
> +#define _I2C_INT_ENABLE					//  ON/OFF
> +#define GPIO_IRQ 						133
> +
> +/*  Enable if use interrupt case 1 mode.  */
> +/* 	Disable if use interrupt case 2 mode. */
> +//#define _INT_MODE_1					//	ON/OFF
> +
> +/* IRQ STATUS */
> +#if ( LINUX_VERSION_CODE < KERNEL_VERSION (2, 6, 39) )
> +#define IRQ_STATUS_DISABLED				0x200 =20
> +#else
> +#define IRQ_STATUS_DISABLED				(1<<16)
> +#endif
> +#define IRQ_STATUS_ENABLED				0x0
> +
> +/* Resolution mode */
> +// Constant value=20
> +#define SIS_MAX_X						4095
> +#define SIS_MAX_Y						4095
> +
> +#define ONE_BYTE						1
> +#define FIVE_BYTE						5
> +#define EIGHT_BYTE  					8
> +#define SIXTEEN_BYTE					16
> +#define PACKET_BUFFER_SIZE				128
> +
> +#define SIS_CMD_NORMAL					0x0
> +#define SIS_CMD_SOFTRESET				0x82
> +#define SIS_CMD_RECALIBRATE				0x87
> +#define SIS_CMD_POWERMODE       		0x90
> +#define MSK_TOUCHNUM					0x0f
> +#define MSK_HAS_CRC						0x10
> +#define MSK_DATAFMT						0xe0
> +#define MSK_PSTATE						0x0f
> +#define MSK_PID	                		0xf0
> +#define RES_FMT							0x00
> +#define FIX_FMT							0x40
> +
> +/* for new i2c format */
> +#define TOUCHDOWN						0x3
> +#define TOUCHUP							0x0
> +#define MAX_BYTE						64
> +#define	PRESSURE_MAX					255
> +
> +#ifdef _ANDROID_4
> +#define AREA_LENGTH_LONGER				5792 //Resolution diagonal=20
> +#define AREA_LENGTH_SHORT				5792 // ((SIS_MAX_X^2) + (SIS_MAX_Y^2))=
^0.5
> +#define AREA_UNIT						(5792/32)
> +#else
> +#define AREA_LENGTH_LONGER				31
> +#define AREA_LENGTH_SHORT				31
> +#endif
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
> +#define P_BYTECOUNT						0=20
> +#define ALL_IN_ONE_PACKAGE				0x10
> +#define IS_TOUCH(x)						(x & 0x1)
> +#define IS_HIDI2C(x)					(x & 0x6)
> +#define IS_AREA(x)						((x >> 4) & 0x1)
> +#define IS_PRESSURE(x)				    ((x >> 5) & 0x1)
> +#define IS_SCANTIME(x)			        ((x >> 6) & 0x1)
> +//#define _DEBUG_PACKAGE				//  ON/OFF
> +//#define _DEBUG_REPORT					//  ON/OFF
> +#define NORMAL_LEN_PER_POINT			6
> +#define AREA_LEN_PER_POINT				2
> +#define PRESSURE_LEN_PER_POINT			1
> +
> +//#define _CHECK_CRC					//  ON/OFF
> +//#define _SUPPORT_BUTTON_TOUCH			//  ON/OFF
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
> +
> +
> +struct sis_i2c_rmi_platform_data {
> +	int (*power)(int on);	/* Only valid in first array entry */
> +};
> +
> +static const unsigned short crc16tab[256]=3D {
> +		0x0000,0x1021,0x2042,0x3063,0x4084,0x50a5,0x60c6,0x70e7,
> +        0x8108,0x9129,0xa14a,0xb16b,0xc18c,0xd1ad,0xe1ce,0xf1ef,
> +        0x1231,0x0210,0x3273,0x2252,0x52b5,0x4294,0x72f7,0x62d6,
> +        0x9339,0x8318,0xb37b,0xa35a,0xd3bd,0xc39c,0xf3ff,0xe3de,
> +        0x2462,0x3443,0x0420,0x1401,0x64e6,0x74c7,0x44a4,0x5485,
> +        0xa56a,0xb54b,0x8528,0x9509,0xe5ee,0xf5cf,0xc5ac,0xd58d,
> +        0x3653,0x2672,0x1611,0x0630,0x76d7,0x66f6,0x5695,0x46b4,
> +        0xb75b,0xa77a,0x9719,0x8738,0xf7df,0xe7fe,0xd79d,0xc7bc,
> +        0x48c4,0x58e5,0x6886,0x78a7,0x0840,0x1861,0x2802,0x3823,
> +        0xc9cc,0xd9ed,0xe98e,0xf9af,0x8948,0x9969,0xa90a,0xb92b,
> +        0x5af5,0x4ad4,0x7ab7,0x6a96,0x1a71,0x0a50,0x3a33,0x2a12,
> +        0xdbfd,0xcbdc,0xfbbf,0xeb9e,0x9b79,0x8b58,0xbb3b,0xab1a,
> +        0x6ca6,0x7c87,0x4ce4,0x5cc5,0x2c22,0x3c03,0x0c60,0x1c41,
> +        0xedae,0xfd8f,0xcdec,0xddcd,0xad2a,0xbd0b,0x8d68,0x9d49,
> +        0x7e97,0x6eb6,0x5ed5,0x4ef4,0x3e13,0x2e32,0x1e51,0x0e70,
> +        0xff9f,0xefbe,0xdfdd,0xcffc,0xbf1b,0xaf3a,0x9f59,0x8f78,
> +        0x9188,0x81a9,0xb1ca,0xa1eb,0xd10c,0xc12d,0xf14e,0xe16f,
> +        0x1080,0x00a1,0x30c2,0x20e3,0x5004,0x4025,0x7046,0x6067,
> +        0x83b9,0x9398,0xa3fb,0xb3da,0xc33d,0xd31c,0xe37f,0xf35e,
> +        0x02b1,0x1290,0x22f3,0x32d2,0x4235,0x5214,0x6277,0x7256,
> +        0xb5ea,0xa5cb,0x95a8,0x8589,0xf56e,0xe54f,0xd52c,0xc50d,
> +        0x34e2,0x24c3,0x14a0,0x0481,0x7466,0x6447,0x5424,0x4405,
> +        0xa7db,0xb7fa,0x8799,0x97b8,0xe75f,0xf77e,0xc71d,0xd73c,
> +        0x26d3,0x36f2,0x0691,0x16b0,0x6657,0x7676,0x4615,0x5634,
> +        0xd94c,0xc96d,0xf90e,0xe92f,0x99c8,0x89e9,0xb98a,0xa9ab,
> +        0x5844,0x4865,0x7806,0x6827,0x18c0,0x08e1,0x3882,0x28a3,
> +        0xcb7d,0xdb5c,0xeb3f,0xfb1e,0x8bf9,0x9bd8,0xabbb,0xbb9a,
> +        0x4a75,0x5a54,0x6a37,0x7a16,0x0af1,0x1ad0,0x2ab3,0x3a92,
> +        0xfd2e,0xed0f,0xdd6c,0xcd4d,0xbdaa,0xad8b,0x9de8,0x8dc9,
> +        0x7c26,0x6c07,0x5c64,0x4c45,0x3ca2,0x2c83,0x1ce0,0x0cc1,
> +        0xef1f,0xff3e,0xcf5d,0xdf7c,0xaf9b,0xbfba,0x8fd9,0x9ff8,
> +        0x6e17,0x7e36,0x4e55,0x5e74,0x2e93,0x3eb2,0x0ed1,0x1ef0
> +};
> +
> +struct Point {
> +	int id;
> +	unsigned short x, y;   	// uint16_t ?
> +	uint16_t Pressure;
> +	uint16_t Width;
> +	uint16_t Height;
> +};
> +
> +struct sisTP_driver_data {
> +	int id;
> +	int fingers;
> +	uint8_t pre_keybit_state;=09
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


--=20
Oliver Neukum <oneukum@suse.de>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
