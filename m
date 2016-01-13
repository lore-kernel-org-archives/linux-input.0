From: <mika.penttila@nextfour.com>
Subject: [PATCH RESEND 1/2] Input: Driver for SiS 9200 family multitouch controller.
Date: Wed, 13 Jan 2016 07:51:52 +0200
Message-ID: <1452664315-28078-2-git-send-email-mika.penttila@nextfour.com>
References: <1452664315-28078-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-am1on0078.outbound.protection.outlook.com ([157.56.112.78]:45760
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751369AbcAMHYg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 02:24:36 -0500
In-Reply-To: <1452664315-28078-1-git-send-email-mika.penttila@nextfour.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>

=46rom: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>

Multitouch protocol B support.

Signed-off-by: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>

---
 drivers/input/touchscreen/Kconfig   |  11 +
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/sis_i2c.c | 583 ++++++++++++++++++++++++++++=
++++++++
 drivers/input/touchscreen/sis_i2c.h | 141 +++++++++
 4 files changed, 736 insertions(+)
 create mode 100644 drivers/input/touchscreen/sis_i2c.c
 create mode 100644 drivers/input/touchscreen/sis_i2c.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index 30666163..d5f294e 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1106,5 +1106,16 @@ config TOUCHSCREEN_ROHM_BU21023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21023_ts.
=20
+config TOUCHSCREEN_SIS_I2C
+	tristate "SiS 9200 family I2C touchscreen driver"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  This enables support for SiS 9200 family over I2C based touchscreen=
s.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sis_i2c.
=20
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchsc=
reen/Makefile
index 30325f2..418f16f 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_TOUCHSCREEN_PCAP)		+=3D pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+=3D penmount.o
 obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+=3D pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+=3D s3c2410_ts.o
+obj-$(CONFIG_TOUCHSCREEN_SIS_I2C)       +=3D sis_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+=3D st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+=3D stmpe-ts.o
 obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+=3D sun4i-ts.o
diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchs=
creen/sis_i2c.c
new file mode 100644
index 0000000..c3869da
--- /dev/null
+++ b/drivers/input/touchscreen/sis_i2c.c
@@ -0,0 +1,583 @@
+/* drivers/input/touchscreen/sis_i2c.c
+ *  - I2C Touch panel driver for SiS 9200 family
+ *
+ * Copyright (C) 2011 SiS, Inc.
+ * Copyright (C) 2015 Nextfour Group
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/linkage.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/uaccess.h>
+#include <linux/irq.h>
+#include <asm/unaligned.h>
+#include <linux/of_gpio.h>
+#include <linux/crc-itu-t.h>
+
+#define SIS_I2C_NAME "sis_i2c_ts"
+#define MAX_FINGERS					10
+
+#define SIS_MAX_X					4095
+#define SIS_MAX_Y					4095
+
+#define ONE_BYTE					1
+#define FIVE_BYTE					5
+#define EIGHT_BYTE					8
+#define SIXTEEN_BYTE					16
+#define PACKET_BUFFER_SIZE				128
+
+#define SIS_CMD_NORMAL					0x0
+#define SIS_CMD_SOFTRESET				0x82
+#define SIS_CMD_RECALIBRATE				0x87
+#define SIS_CMD_POWERMODE				0x90
+#define MSK_TOUCHNUM					0x0f
+#define MSK_HAS_CRC					0x10
+#define MSK_DATAFMT					0xe0
+#define MSK_PSTATE				        0x0f
+#define MSK_PID                                         0xf0
+#define RES_FMT						0x00
+#define FIX_FMT						0x40
+
+/* for new i2c format */
+#define TOUCHDOWN                                       0x3
+#define TOUCHUP						0x0
+#define MAX_BYTE					64
+#define	PRESSURE_MAX                                    255
+
+/* Resolution diagonal */
+#define AREA_LENGTH_LONGER				5792
+/*((SIS_MAX_X^2) + (SIS_MAX_Y^2))^0.5*/
+#define AREA_LENGTH_SHORT				5792
+#define AREA_UNIT					(5792/32)
+
+#define FORMAT_MODE					1
+
+#define MSK_NOBTN					0
+#define MSK_COMP					1
+#define MSK_BACK					2
+#define MSK_MENU					4
+#define MSK_HOME					8
+
+#define P_BYTECOUNT					0
+#define ALL_IN_ONE_PACKAGE				0x10
+#define IS_TOUCH(x)					(x & 0x1)
+#define IS_HIDI2C(x)					((x & 0xF) =3D=3D 0x06)
+#define IS_AREA(x)					((x >> 4) & 0x1)
+#define IS_PRESSURE(x)				        ((x >> 5) & 0x1)
+#define IS_SCANTIME(x)			                ((x >> 6) & 0x1)
+
+#define NORMAL_LEN_PER_POINT			        6
+#define AREA_LEN_PER_POINT				2
+#define PRESSURE_LEN_PER_POINT			        1
+
+#define TOUCH_FORMAT					0x1
+#define BUTTON_FORMAT					0x4
+#define HIDI2C_FORMAT					0x6
+#define P_REPORT_ID					2
+#define BUTTON_STATE					3
+#define BUTTON_KEY_COUNT				16
+#define BYTE_BYTECOUNT					2
+#define BYTE_COUNT					1
+#define BYTE_REPORTID					1
+#define BYTE_CRC_HIDI2C					0
+#define BYTE_CRC_I2C					2
+#define BYTE_SCANTIME					2
+#define NO_TOUCH_BYTECOUNT				0x3
+
+/* CMD Define */
+#define BUF_ACK_PLACE_L					4
+#define BUF_ACK_PLACE_H					5
+#define BUF_ACK_L					0xEF
+#define BUF_ACK_H					0xBE
+#define BUF_NACK_L					0xAD
+#define BUF_NACK_H					0xDE
+#define BUF_CRC_PLACE					7
+
+/* SiS i2c error code */
+#define SIS_ERR						-1
+#define SIS_ERR_ACCESS_USER_MEM		-11 /* Access user memory fail */
+#define SIS_ERR_ALLOCATE_KERNEL_MEM	-12 /* Allocate memory fail */
+#define SIS_ERR_CLIENT			-13 /* Client not created */
+#define SIS_ERR_COPY_FROM_USER		-14 /* Copy data from user fail */
+#define SIS_ERR_COPY_FROM_KERNEL	-19 /* Copy data from kernel fail */
+#define SIS_ERR_TRANSMIT_I2C		-21 /* Transmit error in I2C */
+
+struct _touchpoint {
+	int id;
+	unsigned short x, y;
+	uint16_t pressure;
+	uint16_t width;
+	uint16_t height;
+};
+
+struct sistp_driver_data {
+	int id;
+	int fingers;
+	uint8_t pre_keybit_state;
+	struct _touchpoint pt[MAX_FINGERS];
+};
+
+struct sis_ts_data {
+	int irq_gpio;
+	int reset_gpio;
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+struct sistp_driver_data tpinfo;
+};
+
+static void sis_tpinfo_clear(struct sistp_driver_data *tpinfo, int max=
);
+
+static int sis_cul_unit(uint8_t report_id)
+{
+	int ret =3D NORMAL_LEN_PER_POINT;
+
+	if (report_id !=3D ALL_IN_ONE_PACKAGE) {
+
+		if (IS_AREA(report_id) /*&& IS_TOUCH(report_id)*/)
+			ret +=3D AREA_LEN_PER_POINT;
+
+		if (IS_PRESSURE(report_id))
+			ret +=3D PRESSURE_LEN_PER_POINT;
+	}
+
+	return ret;
+}
+
+static int sis_readpacket(struct i2c_client *client, uint8_t cmd, uint=
8_t *buf)
+{
+	uint8_t tmpbuf[MAX_BYTE] =3D {0};
+	int ret =3D SIS_ERR;
+	int touchnum =3D 0;
+	int p_count =3D 0;
+	int touch_format_id =3D 0;
+	int location =3D 0;
+	bool read_first =3D true;
+
+/*
+ * I2C touch report format
+ *
+ * buf[0] =3D Low 8 bits of byte count value
+ * buf[1] =3D High 8 bits of byte counte value
+ * buf[2] =3D Report ID
+ * buf[touch num * 6 + 2 ] =3D Touch informations;
+ * 1 touch point has 6 bytes, it could be none if no touch
+ * buf[touch num * 6 + 3] =3D Touch numbers
+ *
+ * One touch point information include 6 bytes, the order is
+ *
+ * 1. status =3D touch down or touch up
+ * 2. id =3D finger id
+ * 3. x axis low 8 bits
+ * 4. x axis high 8 bits
+ * 5. y axis low 8 bits
+ * 6. y axis high 8 bits
+ */
+	do {
+		if (location >=3D PACKET_BUFFER_SIZE) {
+			dev_err(&client->dev, "sis_readpacket: Buf Overflow\n");
+			return SIS_ERR;
+		}
+
+		ret =3D i2c_master_recv(client, tmpbuf, MAX_BYTE);
+
+		if (ret <=3D 0) {
+			return touchnum;
+		} else if (tmpbuf[P_BYTECOUNT] > MAX_BYTE) {
+			dev_err(&client->dev, "sis_readpacket: invalid bytecout\n");
+			return SIS_ERR;
+		}
+
+		if (tmpbuf[P_BYTECOUNT] < 10)
+			return touchnum;
+
+		if (read_first)
+			if (tmpbuf[P_BYTECOUNT] =3D=3D 0)
+				return 0;	/* touchnum is 0 */
+
+		touch_format_id =3D tmpbuf[P_REPORT_ID] & 0xf;
+
+		if ((touch_format_id !=3D TOUCH_FORMAT)
+			&& (touch_format_id !=3D HIDI2C_FORMAT)
+			&& (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE)) {
+			dev_err(&client->dev, "sis_readpacket: invalid reportid\n");
+			return SIS_ERR;
+		}
+
+		p_count =3D (int) tmpbuf[P_BYTECOUNT] - 1; /* start from 0 */
+		if (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) {
+			if (IS_TOUCH(tmpbuf[P_REPORT_ID])) {
+				p_count -=3D BYTE_CRC_I2C; /* delete 2 byte crc */
+			} else if (IS_HIDI2C(tmpbuf[P_REPORT_ID])) {
+				p_count -=3D BYTE_CRC_HIDI2C;
+			} else {
+				dev_err(&client->dev, "sis_readpacket: delete crc error\n");
+				return SIS_ERR;
+			}
+			if (IS_SCANTIME(tmpbuf[P_REPORT_ID]))
+				p_count -=3D BYTE_SCANTIME;
+		}
+
+		if (read_first)
+			touchnum =3D tmpbuf[p_count];
+		else {
+			if (tmpbuf[p_count] !=3D 0) {
+				dev_err(&client->dev, "sis_readpacket: nonzero point count in tail=
 packet\n");
+				return SIS_ERR;
+			}
+		}
+
+		if ((touch_format_id !=3D HIDI2C_FORMAT) &&
+			(tmpbuf[P_BYTECOUNT] > 3)) {
+			int crc_end =3D p_count +
+				(IS_SCANTIME(tmpbuf[P_REPORT_ID]) * 2);
+			u16 buf_crc =3D
+				crc_itu_t(0, tmpbuf + 2, crc_end - 1);
+			int l_package_crc =3D
+				(IS_SCANTIME(tmpbuf[P_REPORT_ID]) * 2) +
+				p_count + 1;
+			u16 package_crc =3D
+				get_unaligned_le16(&tmpbuf[l_package_crc]);
+			if (buf_crc !=3D package_crc) {
+				dev_err(&client->dev, "sis_readpacket: CRC Error\n");
+				return SIS_ERR;
+			}
+		}
+
+		memcpy(&buf[location], &tmpbuf[0], 64);
+		/* Buf_Data [0~63] [64~128] */
+		location +=3D MAX_BYTE;
+		read_first =3D false;
+	} while (tmpbuf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE &&
+		tmpbuf[p_count] > 5);
+
+	return touchnum;
+}
+
+static irqreturn_t sis_ts_irq_handler(int irq, void *dev_id)
+{
+	struct sis_ts_data *ts =3D dev_id;
+	struct sistp_driver_data *tpinfo =3D &ts->tpinfo;
+
+	int ret =3D SIS_ERR;
+	int point_unit;
+	uint8_t buf[PACKET_BUFFER_SIZE] =3D {0};
+	uint8_t i =3D 0, fingers =3D 0;
+	uint8_t px =3D 0, py =3D 0, pstatus =3D 0;
+	uint8_t p_area =3D 0;
+	uint8_t p_preasure =3D 0;
+
+redo:
+	/* I2C or SMBUS block data read */
+	ret =3D sis_readpacket(ts->client, SIS_CMD_NORMAL, buf);
+
+	if (ret < 0)
+		goto recheck_irq;
+
+	else if (ret =3D=3D 0) {
+		fingers =3D 0;
+		sis_tpinfo_clear(tpinfo, MAX_FINGERS);
+		goto label_send_report;
+		/*need to report input_mt_sync()*/
+	}
+	sis_tpinfo_clear(tpinfo, MAX_FINGERS);
+
+	point_unit =3D sis_cul_unit(buf[P_REPORT_ID]);
+	fingers =3D ret;
+
+	tpinfo->fingers =3D fingers =3D (fingers > MAX_FINGERS ? 0 : fingers)=
;
+
+	for (i =3D 0; i < fingers; i++) {
+		if ((buf[P_REPORT_ID] !=3D ALL_IN_ONE_PACKAGE) && (i >=3D 5)) {
+			pstatus =3D BYTE_BYTECOUNT + BYTE_REPORTID
+				+ ((i - 5) * point_unit);
+			pstatus +=3D 64;
+		} else {
+			pstatus =3D BYTE_BYTECOUNT + BYTE_REPORTID
+				+ (i * point_unit);
+		}
+		/* X and Y coordinate locations */
+		px =3D pstatus + 2;
+		py =3D px + 2;
+
+		if ((buf[pstatus]) =3D=3D TOUCHUP) {
+			tpinfo->pt[i].width    =3D 0;
+			tpinfo->pt[i].height   =3D 0;
+			tpinfo->pt[i].pressure =3D 0;
+		} else if (buf[P_REPORT_ID] =3D=3D ALL_IN_ONE_PACKAGE
+			&& (buf[pstatus]) =3D=3D TOUCHDOWN) {
+			tpinfo->pt[i].width    =3D 1;
+			tpinfo->pt[i].height   =3D 1;
+			tpinfo->pt[i].pressure =3D 1;
+		} else if ((buf[pstatus]) =3D=3D TOUCHDOWN) {
+			p_area =3D py + 2;
+			p_preasure =3D py + 2 + (IS_AREA(buf[P_REPORT_ID]) * 2);
+
+			if (IS_AREA(buf[P_REPORT_ID])) {
+				tpinfo->pt[i].width =3D buf[p_area];
+				tpinfo->pt[i].height =3D buf[p_area + 1];
+			} else {
+				tpinfo->pt[i].width =3D 1;
+				tpinfo->pt[i].height =3D 1;
+			}
+
+			if (IS_PRESSURE(buf[P_REPORT_ID]))
+				tpinfo->pt[i].pressure =3D (buf[p_preasure]);
+			else
+				tpinfo->pt[i].pressure =3D 1;
+		} else {
+			dev_err(&ts->client->dev, "Touch status error\n");
+			goto recheck_irq;
+		}
+		tpinfo->pt[i].id =3D (buf[pstatus + 1]);
+		tpinfo->pt[i].x =3D le16_to_cpu(get_unaligned_le16(&buf[px]));
+		tpinfo->pt[i].y =3D le16_to_cpu(get_unaligned_le16(&buf[py]));
+	}
+
+label_send_report:
+
+	for (i =3D 0; i < tpinfo->fingers; i++) {
+
+		int slot =3D input_mt_get_slot_by_key(
+			ts->input_dev, tpinfo->pt[i].id);
+
+		if (slot < 0)
+			continue;
+
+		input_mt_slot(ts->input_dev, slot);
+		input_mt_report_slot_state(ts->input_dev,
+					MT_TOOL_FINGER, tpinfo->pt[i].pressure);
+
+		if (tpinfo->pt[i].pressure) {
+
+			tpinfo->pt[i].width *=3D AREA_UNIT;
+			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+					tpinfo->pt[i].width);
+			tpinfo->pt[i].height *=3D AREA_UNIT;
+			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MINOR,
+					tpinfo->pt[i].height);
+			input_report_abs(ts->input_dev, ABS_MT_PRESSURE,
+					tpinfo->pt[i].pressure);
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_X,
+					tpinfo->pt[i].x);
+			input_report_abs(ts->input_dev, ABS_MT_POSITION_Y,
+					tpinfo->pt[i].y);
+
+		}
+	}
+
+	input_mt_sync_frame(ts->input_dev);
+	input_sync(ts->input_dev);
+
+recheck_irq:
+
+	ret =3D gpio_get_value(ts->irq_gpio);
+	/*
+	 * If interrupt pin is still LOW,
+	 * read data until interrupt pin is released.
+	 *
+	 */
+	if (!ret)
+		goto redo;
+
+	return IRQ_HANDLED;
+}
+
+static void sis_tpinfo_clear(struct sistp_driver_data *tpinfo, int max=
)
+{
+	int i =3D 0;
+
+	for (i =3D 0; i < max; i++) {
+		tpinfo->pt[i].id =3D -1;
+		tpinfo->pt[i].x =3D 0;
+		tpinfo->pt[i].y =3D 0;
+		tpinfo->pt[i].pressure =3D 0;
+		tpinfo->pt[i].width =3D 0;
+	}
+	tpinfo->id =3D 0x0;
+	tpinfo->fingers =3D 0;
+}
+
+static int sis_ts_configure(struct i2c_client *client, struct sis_ts_d=
ata *ts)
+{
+	struct device_node *np =3D client->dev.of_node;
+	int gpio;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	gpio =3D of_get_named_gpio(np, "irq-gpios", 0);
+	if (!gpio_is_valid(gpio))
+		return -ENODEV;
+
+	ret =3D gpio_request(gpio, "sis_irq");
+	if (ret < 0)
+		return ret;
+
+	ts->irq_gpio =3D gpio;
+
+	gpio =3D of_get_named_gpio(np, "reset-gpios", 0);
+	if (!gpio_is_valid(gpio)) {
+		gpio_free(ts->irq_gpio);
+		return -ENODEV;
+	}
+
+	ret =3D gpio_request(gpio, "sis_reset");
+	if (ret < 0) {
+		gpio_free(ts->irq_gpio);
+		return ret;
+	}
+
+	ts->reset_gpio =3D gpio;
+	/* Get out of reset */
+	gpio_direction_output(gpio, 1);
+	msleep(1);
+	gpio_direction_output(gpio, 0);
+	msleep(1);
+	gpio_direction_output(gpio, 1);
+	msleep(100);
+	return 0;
+
+}
+
+static int sis_ts_probe(
+	struct i2c_client *client, const struct i2c_device_id *id)
+{
+	int ret =3D 0;
+	struct sis_ts_data *ts =3D NULL;
+
+	ts =3D devm_kzalloc(&client->dev, sizeof(struct sis_ts_data), GFP_KER=
NEL);
+	if (ts =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto err_alloc_data_failed;
+	}
+	if (sis_ts_configure(client, ts)) {
+		kfree(ts);
+		return -ENODEV;
+	}
+
+	ts->client =3D client;
+	i2c_set_clientdata(client, ts);
+
+	ts->input_dev =3D input_allocate_device();
+	if (ts->input_dev =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		dev_err(&client->dev, "sis_ts_probe: Failed to allocate input device=
\n");
+		goto err_input_dev_alloc_failed;
+	}
+
+	ts->input_dev->name =3D "sis_touch";
+	ts->input_dev->id.bustype =3D BUS_I2C;
+
+	set_bit(EV_ABS, ts->input_dev->evbit);
+	set_bit(EV_KEY, ts->input_dev->evbit);
+	set_bit(BTN_TOUCH, ts->input_dev->keybit);
+
+	set_bit(ABS_MT_POSITION_X, ts->input_dev->absbit);
+	set_bit(ABS_MT_POSITION_Y, ts->input_dev->absbit);
+
+	set_bit(ABS_MT_PRESSURE, ts->input_dev->absbit);
+	set_bit(ABS_MT_TOUCH_MAJOR, ts->input_dev->absbit);
+	set_bit(ABS_MT_TOUCH_MINOR, ts->input_dev->absbit);
+	input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE,
+			0, PRESSURE_MAX, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR,
+			0, AREA_LENGTH_LONGER, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MINOR,
+			0, AREA_LENGTH_SHORT, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
+			0, SIS_MAX_X, 0, 0);
+	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
+			0, SIS_MAX_Y, 0, 0);
+
+	input_mt_init_slots(ts->input_dev, MAX_FINGERS,
+			INPUT_MT_DROP_UNUSED | INPUT_MT_DIRECT);
+
+	ret =3D input_register_device(ts->input_dev);
+	if (ret) {
+		dev_err(&client->dev,
+			"Unable to register %s input device\n",
+			ts->input_dev->name);
+		goto err_input_register_device_failed;
+	}
+
+	ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					sis_ts_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					client->name, ts);
+
+	if (ret) {
+		dev_err(&client->dev, "request irq failed\n");
+		goto err_irq_request_failed;
+	}
+
+	dev_info(&client->dev, "sis_ts_probe: Started touchscreen %s\n",
+		ts->input_dev->name);
+	return 0;
+
+err_irq_request_failed:
+	input_unregister_device(ts->input_dev);
+err_input_register_device_failed:
+	input_free_device(ts->input_dev);
+err_input_dev_alloc_failed:
+	kfree(ts);
+err_alloc_data_failed:
+	return ret;
+}
+
+static int sis_ts_remove(struct i2c_client *client)
+{
+	struct sis_ts_data *ts =3D i2c_get_clientdata(client);
+
+	input_unregister_device(ts->input_dev);
+	gpio_free(ts->reset_gpio);
+	gpio_free(ts->irq_gpio);
+	kfree(ts);
+	return 0;
+}
+
+static const struct i2c_device_id sis_ts_id[] =3D {
+	{ SIS_I2C_NAME, 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, sis_ts_id);
+
+static const struct of_device_id sis_ts_dt_ids[] =3D {
+	{ .compatible =3D "sis,9200_ts" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sis_ts_dt_ids);
+
+static struct i2c_driver sis_ts_driver =3D {
+	.probe		=3D sis_ts_probe,
+	.remove		=3D sis_ts_remove,
+
+	.id_table	=3D sis_ts_id,
+	.driver =3D {
+		.name	=3D SIS_I2C_NAME,
+		.of_match_table	=3D sis_ts_dt_ids,
+	},
+};
+
+module_i2c_driver(sis_ts_driver);
+MODULE_DESCRIPTION("SiS 9200 Family Touchscreen Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/input/touchscreen/sis_i2c.h b/drivers/input/touchs=
creen/sis_i2c.h
new file mode 100644
index 0000000..9d7749d
--- /dev/null
+++ b/drivers/input/touchscreen/sis_i2c.h
@@ -0,0 +1,141 @@
+/*
+ * include/linux/sis_i2c.h - platform data structure for SiS 9200 fami=
ly
+ *
+ * Copyright (C) 2011 SiS, Inc.
+ * Copyright (C) 2015 Nextfour Group
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/version.h>
+
+#ifndef _LINUX_SIS_I2C_H
+#define _LINUX_SIS_I2C_H
+
+#define SIS_I2C_NAME "sis_i2c_ts"
+#define SIS_SLAVE_ADDR					0x5c
+
+#define MAX_FINGERS					10
+
+#define SIS_MAX_X					4095
+#define SIS_MAX_Y					4095
+
+#define ONE_BYTE					1
+#define FIVE_BYTE					5
+#define EIGHT_BYTE					8
+#define SIXTEEN_BYTE					16
+#define PACKET_BUFFER_SIZE				128
+
+#define SIS_CMD_NORMAL					0x0
+#define SIS_CMD_SOFTRESET				0x82
+#define SIS_CMD_RECALIBRATE				0x87
+#define SIS_CMD_POWERMODE				0x90
+#define MSK_TOUCHNUM					0x0f
+#define MSK_HAS_CRC					0x10
+#define MSK_DATAFMT					0xe0
+#define MSK_PSTATE				        0x0f
+#define MSK_PID                                         0xf0
+#define RES_FMT						0x00
+#define FIX_FMT						0x40
+
+/* for new i2c format */
+#define TOUCHDOWN                                       0x3
+#define TOUCHUP						0x0
+#define MAX_BYTE					64
+#define	PRESSURE_MAX                                    255
+
+/* Resolution diagonal */
+#define AREA_LENGTH_LONGER				5792
+/*((SIS_MAX_X^2) + (SIS_MAX_Y^2))^0.5*/
+#define AREA_LENGTH_SHORT				5792
+#define AREA_UNIT					(5792/32)
+
+
+#define FORMAT_MODE					1
+
+#define MSK_NOBTN					0
+#define MSK_COMP					1
+#define MSK_BACK					2
+#define MSK_MENU					4
+#define MSK_HOME					8
+
+#define P_BYTECOUNT					0
+#define ALL_IN_ONE_PACKAGE				0x10
+#define IS_TOUCH(x)					(x & 0x1)
+#define IS_HIDI2C(x)					((x & 0xF) =3D=3D 0x06)
+#define IS_AREA(x)					((x >> 4) & 0x1)
+#define IS_PRESSURE(x)				        ((x >> 5) & 0x1)
+#define IS_SCANTIME(x)			                ((x >> 6) & 0x1)
+
+#define NORMAL_LEN_PER_POINT			        6
+#define AREA_LEN_PER_POINT				2
+#define PRESSURE_LEN_PER_POINT			        1
+
+#define TOUCH_FORMAT					0x1
+#define BUTTON_FORMAT					0x4
+#define HIDI2C_FORMAT					0x6
+#define P_REPORT_ID					2
+#define BUTTON_STATE					3
+#define BUTTON_KEY_COUNT				16
+#define BYTE_BYTECOUNT					2
+#define BYTE_COUNT					1
+#define BYTE_REPORTID					1
+#define BYTE_CRC_HIDI2C					0
+#define BYTE_CRC_I2C					2
+#define BYTE_SCANTIME					2
+#define NO_TOUCH_BYTECOUNT				0x3
+
+/* CMD Define */
+#define BUF_ACK_PLACE_L					4
+#define BUF_ACK_PLACE_H					5
+#define BUF_ACK_L					0xEF
+#define BUF_ACK_H					0xBE
+#define BUF_NACK_L					0xAD
+#define BUF_NACK_H					0xDE
+#define BUF_CRC_PLACE					7
+
+/* SiS i2c error code */
+#define SIS_ERR						-1
+#define SIS_ERR_ACCESS_USER_MEM		-11 /* Access user memory fail */
+#define SIS_ERR_ALLOCATE_KERNEL_MEM	-12 /* Allocate memory fail */
+#define SIS_ERR_CLIENT			-13 /* Client not created */
+#define SIS_ERR_COPY_FROM_USER		-14 /* Copy data from user fail */
+#define SIS_ERR_COPY_FROM_KERNEL	-19 /* Copy data from kernel fail */
+#define SIS_ERR_TRANSMIT_I2C		-21 /* Transmit error in I2C */
+
+struct sis_i2c_rmi_platform_data {
+	int (*power)(int on);	/* Only valid in first array entry */
+};
+
+struct _touchpoint {
+	int id;
+	unsigned short x, y;
+	uint16_t pressure;
+	uint16_t width;
+	uint16_t height;
+};
+
+struct sistp_driver_data {
+	int id;
+	int fingers;
+	uint8_t pre_keybit_state;
+	struct _touchpoint pt[MAX_FINGERS];
+};
+
+struct sis_ts_data {
+	int (*power)(int on);
+	int irq_gpio;
+	int reset_gpio;
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct sistp_driver_data tpinfo;
+};
+
+#endif /* _LINUX_SIS_I2C_H */
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
