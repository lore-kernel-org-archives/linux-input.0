From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add driver for Neonode zForce based touchscreens
Date: Thu, 29 Aug 2013 09:29:04 -0700
Message-ID: <20130829162903.GB1576@core.coreip.homeip.net>
References: <201308161359.40134.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34658 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab3H2Q3I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 12:29:08 -0400
Content-Disposition: inline
In-Reply-To: <201308161359.40134.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Heiko,

On Fri, Aug 16, 2013 at 01:59:39PM +0200, Heiko St=FCbner wrote:
> This adds a driver for touchscreens using the zforce infrared
> technology from Neonode connected via i2c to the host system.
>=20
> It supports multitouch with up to two fingers and tracking of the
> contacts in hardware.

Generally looks good, just a few comments...

>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/input/touchscreen/Kconfig     |   13 +
>  drivers/input/touchscreen/Makefile    |    1 +
>  drivers/input/touchscreen/zforce_ts.c |  837 +++++++++++++++++++++++=
++++++++++
>  include/linux/input/zforce_ts.h       |   26 +
>  4 files changed, 877 insertions(+)
>  create mode 100644 drivers/input/touchscreen/zforce_ts.c
>  create mode 100644 include/linux/input/zforce_ts.h
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 3b9758b..ade11b7 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -919,4 +919,17 @@ config TOUCHSCREEN_TPS6507X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tps6507x_ts.
> =20
> +config TOUCHSCREEN_ZFORCE
> +	tristate "Neonode zForce infrared touchscreens"
> +	depends on I2C
> +	depends on GPIOLIB
> +	help
> +	  Say Y here if you have a touchscreen using the zforce
> +	  infraread technology from Neonode.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called zforce_ts.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touch=
screen/Makefile
> index f5216c1..7587883 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -75,3 +75,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+=3D mai=
nstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+=3D zylonite-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_W90X900)	+=3D w90p910_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+=3D tps6507x-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+=3D zforce_ts.o
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/to=
uchscreen/zforce_ts.c
> new file mode 100644
> index 0000000..92af632
> --- /dev/null
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -0,0 +1,837 @@
> +/*
> + * Copyright (C) 2012-2013 MundoReader S.L.
> + * Author: Heiko Stuebner <heiko@sntech.de>
> + *
> + * based in parts on Nook zforce driver
> + *
> + * Copyright (C) 2010 Barnes & Noble, Inc.
> + * Author: Pieter Truter<ptruter@intrinsyc.com>
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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/hrtimer.h>
> +#include <linux/slab.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/device.h>
> +#include <linux/sysfs.h>
> +#include <linux/input/zforce_ts.h>
> +#include <linux/input/mt.h>
> +
> +#define WAIT_TIMEOUT		msecs_to_jiffies(1000)
> +
> +#define FRAME_START		0xee
> +
> +/* Offsets of the different parts of the payload the controller send=
s */
> +#define PAYLOAD_HEADER		0
> +#define PAYLOAD_LENGTH		1
> +#define PAYLOAD_BODY		2
> +
> +/* Response offsets */
> +#define RESPONSE_ID		0
> +#define RESPONSE_DATA		1
> +
> +/* Commands */
> +#define COMMAND_DEACTIVATE	0x00
> +#define COMMAND_INITIALIZE	0x01
> +#define COMMAND_RESOLUTION	0x02
> +#define COMMAND_SETCONFIG	0x03
> +#define COMMAND_DATAREQUEST	0x04
> +#define COMMAND_SCANFREQ	0x08
> +#define COMMAND_STATUS		0X1e
> +
> +/*
> + * Responses the controller sends as a result of
> + * command requests
> + */
> +#define RESPONSE_DEACTIVATE	0x00
> +#define RESPONSE_INITIALIZE	0x01
> +#define RESPONSE_RESOLUTION	0x02
> +#define RESPONSE_SETCONFIG	0x03
> +#define RESPONSE_SCANFREQ	0x08
> +#define RESPONSE_STATUS		0X1e
> +
> +/*
> + * Notifications are send by the touch controller without
> + * being requested by the driver and include for example
> + * touch indications
> + */
> +#define NOTIFICATION_TOUCH		0x04
> +#define NOTIFICATION_BOOTCOMPLETE	0x07
> +#define NOTIFICATION_OVERRUN		0x25
> +#define NOTIFICATION_PROXIMITY		0x26
> +#define NOTIFICATION_INVALID_COMMAND	0xfe
> +
> +#define ZFORCE_REPORT_POINTS		2
> +#define ZFORCE_MAX_AREA			0xff
> +
> +#define STATE_DOWN			0
> +#define STATE_MOVE			1
> +#define STATE_UP			2
> +
> +#define SETCONFIG_DUALTOUCH		(1 << 0)
> +
> +struct zforce_point {
> +	int coord_x;
> +	int coord_y;
> +	int state;
> +	int id;
> +	int area_major;
> +	int area_minor;
> +	int orientation;
> +	int pressure;
> +	int prblty;
> +};
> +
> +/*
> + * @client		the i2c_client
> + * @input		the input device
> + * @suspending		in the process of going to suspend (don't emit wakeu=
p
> + *			events for commands executed to suspend the device)
> + * @suspended		device suspended
> + * @access_mutex	serialize i2c-access, to keep multipart reads toget=
her
> + * @command_done	completion to wait for the command result
> + * @command_mutex	serialize commands send to the ic
> + * @command_waiting	the id of the command that that is currently wai=
ting
> + *			for a result
> + * @command_result	returned result of the command
> + */
> +struct zforce_ts {
> +	struct i2c_client	*client;
> +	struct input_dev	*input;
> +	const struct zforce_ts_platdata *pdata;
> +	char			phys[32];
> +
> +	bool			suspending;
> +	bool			suspended;
> +	bool			boot_complete;
> +
> +	/* Firmware version information */
> +	u16			version_major;
> +	u16			version_minor;
> +	u16			version_build;
> +	u16			version_rev;
> +
> +	struct mutex		access_mutex;
> +
> +	struct completion	command_done;
> +	struct mutex		command_mutex;
> +	int			command_waiting;
> +	int			command_result;
> +};
> +
> +static int zforce_command(struct zforce_ts *ts, u8 cmd)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	char buf[3];
> +	int ret;
> +
> +	dev_dbg(&client->dev, "%s: 0x%x\n", __func__, cmd);
> +
> +	buf[0] =3D FRAME_START;
> +	buf[1] =3D 1; /* data size, command only */
> +	buf[2] =3D cmd;
> +
> +	mutex_lock(&ts->access_mutex);
> +	ret =3D i2c_master_send(client, &buf[0], ARRAY_SIZE(buf));
> +	mutex_unlock(&ts->access_mutex);

I am unsure why you need this lock. Doesn't i2c core already ensure
necessary locking?

Also, it does not look like zforec_command() will reace with your
interrupt handler that does multi-reads...

> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c send data request error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zforce_send_wait(struct zforce_ts *ts, const char *buf, i=
nt len)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	ret =3D mutex_trylock(&ts->command_mutex);
> +	if (!ret) {
> +		dev_err(&client->dev, "already waiting for a command\n");
> +		return -EBUSY;
> +	}
> +
> +	dev_dbg(&client->dev, "sending %d bytes for command 0x%x\n",
> +		buf[1], buf[2]);
> +
> +	ts->command_waiting =3D buf[2];
> +
> +	mutex_lock(&ts->access_mutex);
> +	ret =3D i2c_master_send(client, buf, len);
> +	mutex_unlock(&ts->access_mutex);

Same here.

> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c send data request error: %d\n", ret);
> +		goto unlock;
> +	}
> +
> +	dev_dbg(&client->dev, "waiting for result for command 0x%x\n", buf[=
2]);
> +
> +	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) =3D=
=3D 0) {
> +		ret =3D -ETIME;
> +		goto unlock;
> +	}
> +
> +	ret =3D ts->command_result;
> +
> +unlock:
> +	mutex_unlock(&ts->command_mutex);
> +	return ret;
> +}
> +
> +static int zforce_command_wait(struct zforce_ts *ts, u8 cmd)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	char buf[3];
> +	int ret;
> +
> +	dev_dbg(&client->dev, "%s: 0x%x\n", __func__, cmd);
> +
> +	buf[0] =3D FRAME_START;
> +	buf[1] =3D 1; /* data size, command only */
> +	buf[2] =3D cmd;
> +
> +	ret =3D zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c send data request error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zforce_resolution(struct zforce_ts *ts, u16 x, u16 y)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	char buf[7] =3D { FRAME_START, 5, COMMAND_RESOLUTION,
> +			(x & 0xff), ((x >> 8) & 0xff),
> +			(y & 0xff), ((y >> 8) & 0xff) };
> +
> +	dev_dbg(&client->dev, "set resolution to (%d,%d)\n", x, y);
> +
> +	return zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
> +}
> +
> +static int zforce_scan_frequency(struct zforce_ts *ts, u16 idle, u16=
 finger,
> +				 u16 stylus)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	char buf[9] =3D { FRAME_START, 7, COMMAND_SCANFREQ,
> +			(idle & 0xff), ((idle >> 8) & 0xff),
> +			(finger & 0xff), ((finger >> 8) & 0xff),
> +			(stylus & 0xff), ((stylus >> 8) & 0xff) };
> +
> +	dev_dbg(&client->dev, "set scan frequency to (idle: %d, finger: %d,=
 stylus: %d)\n",
> +		idle, finger, stylus);
> +
> +	return zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
> +}
> +
> +static int zforce_setconfig(struct zforce_ts *ts, char b1)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	char buf[7] =3D { FRAME_START, 5, COMMAND_SETCONFIG,
> +			b1, 0, 0, 0 };
> +
> +	dev_dbg(&client->dev, "set config to (%d)\n", b1);
> +
> +	return zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
> +}
> +
> +static int zforce_start(struct zforce_ts *ts)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	const struct zforce_ts_platdata *pdata =3D client->dev.platform_dat=
a;
> +	int ret;
> +
> +	dev_dbg(&client->dev, "starting device\n");
> +
> +	ret =3D zforce_command_wait(ts, COMMAND_INITIALIZE);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to initialize, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D zforce_resolution(ts, pdata->x_max, pdata->y_max);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to set resolution, %d\n", ret);
> +		goto error;
> +	}
> +
> +	ret =3D zforce_scan_frequency(ts, 10, 50, 50);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to set scan frequency, %d\n",
> +			ret);
> +		goto error;
> +	}
> +
> +	if (zforce_setconfig(ts, SETCONFIG_DUALTOUCH)) {
> +		dev_err(&client->dev, "Unable to set config\n");
> +		goto error;
> +	}
> +
> +	/* start sending touch events */
> +	ret =3D zforce_command(ts, COMMAND_DATAREQUEST);
> +	if (ret) {
> +		dev_err(&client->dev, "Unable to request data\n");
> +		goto error;
> +	}
> +
> +	/* Per NN, initial cal. take max. of 200msec.
> +	 * Allow time to complete this calibration
> +	 */
> +	msleep(200);
> +
> +	return 0;
> +
> +error:
> +	zforce_command_wait(ts, COMMAND_DEACTIVATE);
> +	return ret;
> +}
> +
> +static int zforce_stop(struct zforce_ts *ts)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	dev_dbg(&client->dev, "stopping device\n");
> +
> +	/* deactivates touch sensing and puts the device into sleep */
> +	ret =3D zforce_command_wait(ts, COMMAND_DEACTIVATE);
> +	if (ret !=3D 0) {
> +		dev_err(&client->dev, "could not deactivate device, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	struct zforce_point point[ZFORCE_REPORT_POINTS];
> +	const struct zforce_ts_platdata *pdata =3D client->dev.platform_dat=
a;

dev_get_plantdata()

> +	int count, i;
> +
> +	count =3D payload[0];
> +	if (count > ZFORCE_REPORT_POINTS) {
> +		dev_warn(&client->dev, "to many coordinates %d, expected max %d\n"=
,
> +			 count, ZFORCE_REPORT_POINTS);
> +		count =3D ZFORCE_REPORT_POINTS;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		point[i].coord_x =3D
> +			payload[9 * i + 2] << 8 | payload[9 * i + 1];
> +		point[i].coord_y =3D
> +			payload[9 * i + 4] << 8 | payload[9 * i + 3];
> +
> +		if (point[i].coord_x > pdata->x_max ||
> +		    point[i].coord_y > pdata->y_max) {
> +			dev_warn(&client->dev, "coordinates (%d,%d) invalid\n",
> +				point[i].coord_x, point[i].coord_y);
> +			point[i].coord_x =3D point[i].coord_y =3D 0;
> +		}
> +
> +		point[i].state =3D payload[9 * i + 5] & 0x03;
> +		point[i].id =3D (payload[9 * i + 5] & 0xfc) >> 2;
> +
> +		/* determine touch major, minor and orientation */
> +		point[i].area_major =3D max(payload[9 * i + 6],
> +					  payload[9 * i + 7]);
> +		point[i].area_minor =3D min(payload[9 * i + 6],
> +					  payload[9 * i + 7]);
> +		point[i].orientation =3D payload[9 * i + 6] > payload[9 * i + 7];
> +
> +		point[i].pressure =3D payload[9 * i + 8];
> +		point[i].prblty =3D payload[9 * i + 9];
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		dev_dbg(&client->dev, "point %d/%d: state %d, id %d, pressure %d, =
prblty %d, x %d, y %d, amajor %d, aminor %d, ori %d\n",
> +			i, count, point[i].state, point[i].id,
> +			point[i].pressure, point[i].prblty,
> +			point[i].coord_x, point[i].coord_y,
> +			point[i].area_major, point[i].area_minor,
> +			point[i].orientation);
> +
> +		/* the zforce id starts with "1", so needs to be decreased */
> +		input_mt_slot(ts->input, point[i].id - 1);
> +
> +		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER,
> +						point[i].state !=3D STATE_UP);
> +
> +		if (point[i].state !=3D STATE_UP) {
> +			input_report_abs(ts->input, ABS_MT_POSITION_X,
> +					 point[i].coord_x);
> +			input_report_abs(ts->input, ABS_MT_POSITION_Y,
> +					 point[i].coord_y);
> +			input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
> +					 point[i].area_major);
> +			input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
> +					 point[i].area_minor);
> +			input_report_abs(ts->input, ABS_MT_ORIENTATION,
> +					 point[i].orientation);
> +		}
> +	}
> +
> +	if (point[0].state !=3D STATE_UP) {
> +		input_report_abs(ts->input, ABS_X, point[0].coord_x);
> +		input_report_abs(ts->input, ABS_Y, point[0].coord_y);
> +	}
> +
> +	input_report_key(ts->input, BTN_TOUCH, point[0].state !=3D STATE_UP=
);
> +
> +	input_sync(ts->input);
> +
> +	return 0;
> +}
> +
> +static int zforce_read_packet(struct zforce_ts *ts, u8 *buf)
> +{
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	mutex_lock(&ts->access_mutex);
> +
> +	/* read 2 byte message header */
> +	ret =3D i2c_master_recv(client, buf, 2);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "error reading header: %d\n", ret);
> +		goto unlock;
> +	}
> +
> +	if (buf[PAYLOAD_HEADER] !=3D FRAME_START) {
> +		dev_err(&client->dev, "invalid frame start: %d\n", buf[0]);
> +		ret =3D -EIO;
> +		goto unlock;
> +	}
> +
> +	if (buf[PAYLOAD_LENGTH] <=3D 0 || buf[PAYLOAD_LENGTH] > 255) {
> +		dev_err(&client->dev, "invalid payload length: %d\n",
> +			buf[PAYLOAD_LENGTH]);
> +		ret =3D -EIO;
> +		goto unlock;
> +	}
> +
> +	/* read the message */
> +	ret =3D i2c_master_recv(client, &buf[PAYLOAD_BODY], buf[PAYLOAD_LEN=
GTH]);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "error reading payload: %d\n", ret);
> +		goto unlock;
> +	}
> +
> +	dev_dbg(&client->dev, "read %d bytes for response command 0x%x\n",
> +		buf[PAYLOAD_LENGTH], buf[PAYLOAD_BODY]);
> +
> +unlock:
> +	mutex_unlock(&ts->access_mutex);
> +	return ret;
> +}
> +
> +static void zforce_complete(struct zforce_ts *ts, int cmd, int resul=
t)
> +{
> +	struct i2c_client *client =3D ts->client;
> +
> +	if (ts->command_waiting =3D=3D cmd) {
> +		dev_dbg(&client->dev, "completing command 0x%x\n", cmd);
> +		ts->command_result =3D result;
> +		complete(&ts->command_done);
> +	} else {
> +		dev_dbg(&client->dev, "command %d not for us\n", cmd);
> +	}
> +}
> +
> +static irqreturn_t zforce_interrupt(int irq, void *dev_id)
> +{
> +	struct zforce_ts *ts =3D dev_id;
> +	struct i2c_client *client =3D ts->client;
> +	const struct zforce_ts_platdata *pdata =3D client->dev.platform_dat=
a;
> +	int ret;
> +	u8 payload_buffer[512];
> +	u8 *payload;
> +
> +	/*
> +	 * When suspended, emit a wakeup signal if necessary and return.
> +	 * Due to the level-interrupt we will get re-triggered later.
> +	 */
> +	if (ts->suspended) {
> +		if (device_may_wakeup(&client->dev))
> +			pm_wakeup_event(&client->dev, 500);
> +		msleep(20);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_dbg(&client->dev, "handling interrupt\n");
> +
> +	/* Don't emit wakeup events from commands run by zforce_suspend */
> +	if (!ts->suspending && device_may_wakeup(&client->dev))
> +		pm_stay_awake(&client->dev);
> +
> +	while (!gpio_get_value(pdata->gpio_int)) {
> +		ret =3D zforce_read_packet(ts, payload_buffer);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "could not read packet, ret: %d\n",
> +				ret);
> +			break;
> +		}
> +
> +		payload =3D  &payload_buffer[PAYLOAD_BODY];
> +
> +		switch (payload[RESPONSE_ID]) {
> +		case NOTIFICATION_TOUCH:
> +			/* Always report touch-events received while
> +			 * suspending, when being a wakeup source
> +			 */
> +			if (ts->suspending && device_may_wakeup(&client->dev))
> +				pm_wakeup_event(&client->dev, 500);
> +			zforce_touch_event(ts, &payload[RESPONSE_DATA]);
> +			break;
> +		case NOTIFICATION_BOOTCOMPLETE:
> +			ts->boot_complete =3D payload[RESPONSE_DATA];
> +			zforce_complete(ts, payload[RESPONSE_ID], 0);
> +			break;
> +		case RESPONSE_INITIALIZE:
> +		case RESPONSE_DEACTIVATE:
> +		case RESPONSE_SETCONFIG:
> +		case RESPONSE_RESOLUTION:
> +		case RESPONSE_SCANFREQ:
> +			zforce_complete(ts, payload[RESPONSE_ID],
> +					payload[RESPONSE_DATA]);
> +			break;
> +		case RESPONSE_STATUS:
> +			/* Version Payload Results
> +			 * [2:major] [2:minor] [2:build] [2:rev]
> +			 */
> +			ts->version_major =3D (payload[RESPONSE_DATA + 1] << 8) |
> +						payload[RESPONSE_DATA];
> +			ts->version_minor =3D (payload[RESPONSE_DATA + 3] << 8) |
> +						payload[RESPONSE_DATA + 2];
> +			ts->version_build =3D (payload[RESPONSE_DATA + 5] << 8) |
> +						payload[RESPONSE_DATA + 4];
> +			ts->version_rev   =3D (payload[RESPONSE_DATA + 7] << 8) |
> +						payload[RESPONSE_DATA + 6];
> +			dev_dbg(&ts->client->dev, "Firmware Version %04x:%04x %04x:%04x\n=
",
> +				ts->version_major, ts->version_minor,
> +				ts->version_build, ts->version_rev);
> +
> +			zforce_complete(ts, payload[RESPONSE_ID], 0);
> +			break;
> +		case NOTIFICATION_INVALID_COMMAND:
> +			dev_err(&ts->client->dev, "invalid command: 0x%x\n",
> +				payload[RESPONSE_DATA]);
> +			break;
> +		default:
> +			dev_err(&ts->client->dev, "unrecognized response id: 0x%x\n",
> +				payload[RESPONSE_ID]);
> +			break;
> +		}
> +	}
> +
> +	if (!ts->suspending && device_may_wakeup(&client->dev))
> +		pm_relax(&client->dev);
> +
> +	dev_dbg(&client->dev, "finished interrupt\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int zforce_input_open(struct input_dev *dev)
> +{
> +	struct zforce_ts *ts =3D input_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D zforce_start(ts);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void zforce_input_close(struct input_dev *dev)
> +{
> +	struct zforce_ts *ts =3D input_get_drvdata(dev);
> +	struct i2c_client *client =3D ts->client;
> +	int ret;
> +
> +	ret =3D zforce_stop(ts);
> +	if (ret)
> +		dev_warn(&client->dev, "stopping zforce failed\n");
> +
> +	return;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int zforce_suspend(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct zforce_ts *ts =3D i2c_get_clientdata(client);
> +	struct input_dev *input =3D ts->input;
> +	int ret =3D 0;
> +
> +	mutex_lock(&input->mutex);
> +	ts->suspending =3D true;
> +
> +	/* when configured as wakeup source, device should always wake syst=
em
> +	 * therefore start device if necessary
> +	 */
> +	if (device_may_wakeup(&client->dev)) {
> +		dev_dbg(&client->dev, "suspend while being a wakeup source\n");
> +
> +		/* need to start device if not open, to be wakeup source */
> +		if (!input->users) {
> +			ret =3D zforce_start(ts);
> +			if (ret)
> +				goto unlock;
> +		}
> +
> +		enable_irq_wake(client->irq);
> +	} else if (input->users) {
> +		dev_dbg(&client->dev, "suspend without being a wakeup source\n");
> +
> +		ret =3D zforce_stop(ts);
> +		if (ret)
> +			goto unlock;
> +
> +		disable_irq(client->irq);
> +	}
> +
> +	ts->suspended =3D true;
> +
> +unlock:
> +	ts->suspending =3D false;
> +	mutex_unlock(&input->mutex);
> +
> +	return ret;
> +}
> +
> +static int zforce_resume(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct zforce_ts *ts =3D i2c_get_clientdata(client);
> +	struct input_dev *input =3D ts->input;
> +	int ret =3D 0;
> +
> +	mutex_lock(&input->mutex);
> +
> +	ts->suspended =3D false;
> +
> +	if (device_may_wakeup(&client->dev)) {
> +		dev_dbg(&client->dev, "resume from being a wakeup source\n");
> +
> +		disable_irq_wake(client->irq);
> +
> +		/* need to stop device if it was not open on suspend */
> +		if (!input->users) {
> +			ret =3D zforce_stop(ts);
> +			if (ret)
> +				goto unlock;
> +		}
> +	} else if (input->users) {
> +		dev_dbg(&client->dev, "resume without being a wakeup source\n");
> +
> +		enable_irq(client->irq);
> +
> +		ret =3D zforce_start(ts);
> +		if (ret < 0)
> +			goto unlock;
> +	}
> +
> +unlock:
> +	mutex_unlock(&input->mutex);
> +
> +	return ret;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(zforce_pm_ops, zforce_suspend, zforce_resum=
e);
> +
> +static void zforce_reset(void *data)
> +{
> +	struct zforce_ts *ts =3D data;
> +
> +	gpio_set_value(ts->pdata->gpio_rst, 0);
> +}
> +
> +static int zforce_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	const struct zforce_ts_platdata *pdata =3D client->dev.platform_dat=
a;

dev_get_platdata()

> +	struct zforce_ts *ts;
> +	struct input_dev *input_dev;
> +	int ret;
> +
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	ts =3D devm_kzalloc(&client->dev, sizeof(struct zforce_ts), GFP_KER=
NEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ret =3D devm_gpio_request_one(&client->dev, pdata->gpio_int, GPIOF_=
IN,
> +				    "zforce_ts_int");
> +	if (ret) {
> +		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> +			pdata->gpio_int, ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_gpio_request_one(&client->dev, pdata->gpio_rst,
> +				    GPIOF_OUT_INIT_LOW, "zforce_ts_rst");
> +	if (ret) {
> +		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> +			pdata->gpio_rst, ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action(&client->dev, zforce_reset, ts);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to register reset action, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	msleep(20);

Why are we sleeping here? We have not called zforce_reset() - it will b=
e
called on unwinding only.

> +
> +	snprintf(ts->phys, sizeof(ts->phys),
> +		 "%s/input0", dev_name(&client->dev));
> +
> +	input_dev =3D devm_input_allocate_device(&client->dev);
> +	if (!input_dev) {
> +		dev_err(&client->dev, "could not allocate input device\n");
> +		return -ENOMEM;
> +	}
> +
> +	mutex_init(&ts->access_mutex);
> +	mutex_init(&ts->command_mutex);
> +
> +	ts->pdata =3D pdata;
> +	ts->client =3D client;
> +	ts->input =3D input_dev;
> +
> +	input_dev->name =3D "Neonode zForce touchscreen";
> +	input_dev->phys =3D ts->phys;
> +	input_dev->id.bustype =3D BUS_I2C;
> +	input_dev->dev.parent =3D &client->dev;
> +
> +	input_dev->open =3D zforce_input_open;
> +	input_dev->close =3D zforce_input_close;
> +
> +	set_bit(EV_KEY, input_dev->evbit);
> +	set_bit(EV_SYN, input_dev->evbit);
> +	set_bit(EV_ABS, input_dev->evbit);
> +	set_bit(BTN_TOUCH, input_dev->keybit);
> +
> +	/* For single touch */
> +	input_set_abs_params(input_dev, ABS_X, 0, pdata->x_max, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, pdata->y_max, 0, 0);
> +
> +	/* For multi touch */
> +	input_mt_init_slots(input_dev, ZFORCE_REPORT_POINTS, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> +			     pdata->x_max, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> +			     pdata->y_max, 0, 0);
> +
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> +			     ZFORCE_MAX_AREA, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0,
> +			     ZFORCE_MAX_AREA, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0);
> +
> +	input_set_drvdata(ts->input, ts);
> +
> +	init_completion(&ts->command_done);
> +
> +	/* The zforce pulls the interrupt low when it has data ready.
> +	 * After it is triggered the isr thread runs until all the availabl=
e
> +	 * packets have been read and the interrupt is high again.
> +	 * Therefore we can trigger the interrupt anytime it is low and do
> +	 * not need to limit it to the interrupt edge.
> +	 */
> +	ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					zforce_interrupt,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					input_dev->name, ts);
> +	if (ret) {
> +		dev_err(&client->dev, "irq %d request failed\n", client->irq);
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, ts);
> +
> +	/* let the controller boot */
> +	gpio_set_value(pdata->gpio_rst, 1);
> +
> +	ts->command_waiting =3D NOTIFICATION_BOOTCOMPLETE;
> +	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) =3D=
=3D 0)
> +		dev_warn(&client->dev, "bootcomplete timed out\n");
> +
> +	/* need to start device to get version information */
> +	ret =3D zforce_command_wait(ts, COMMAND_INITIALIZE);
> +	if (ret) {
> +		dev_err(&client->dev, "unable to initialize, %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* this gets the firmware version among other informations */
> +	ret =3D zforce_command_wait(ts, COMMAND_STATUS);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "couldn't get status, %d\n", ret);
> +		zforce_stop(ts);
> +		return ret;
> +	}
> +
> +	/* stop device and put it into sleep until it is opened */
> +	ret =3D zforce_stop(ts);
> +	if (ret < 0)
> +		return ret;
> +
> +	device_set_wakeup_capable(&client->dev, true);
> +
> +	ret =3D input_register_device(input_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "could not register input device, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct i2c_device_id zforce_idtable[] =3D {
> +	{ "zforce-ts", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, zforce_idtable);
> +
> +static struct i2c_driver zforce_driver =3D {
> +	.driver =3D {
> +		.owner	=3D THIS_MODULE,
> +		.name	=3D "zforce-ts",
> +		.pm	=3D &zforce_pm_ops,
> +	},
> +	.probe		=3D zforce_probe,
> +	.id_table	=3D zforce_idtable,
> +};
> +
> +module_i2c_driver(zforce_driver);
> +
> +MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
> +MODULE_DESCRIPTION("zForce TouchScreen Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/input/zforce_ts.h b/include/linux/input/zf=
orce_ts.h
> new file mode 100644
> index 0000000..0472ab2
> --- /dev/null
> +++ b/include/linux/input/zforce_ts.h

I think we now have a separate directory for platform data...


> @@ -0,0 +1,26 @@
> +/* drivers/input/touchscreen/zforce.c
> + *
> + * Copyright (C) 2012-2013 MundoReader S.L.
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
> + */
> +
> +#ifndef _LINUX_INPUT_ZFORCE_TS_H
> +#define _LINUX_INPUT_ZFORCE_TS_H
> +
> +struct zforce_ts_platdata {
> +	int gpio_int;
> +	int gpio_rst;
> +
> +	unsigned int x_max;
> +	unsigned int y_max;
> +};
> +
> +#endif /* _LINUX_INPUT_ZFORCE_TS_H */
> --=20
> 1.7.10.4
>=20

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
