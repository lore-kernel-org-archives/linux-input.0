From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 3/5] Input: add driver for Ilitek ili2139
 touch IC
Date: Wed, 12 Oct 2016 02:34:01 +0800
Message-ID: <220181476210841@web5j.yandex.ru>
References: <20161011003359.26079-1-icenowy@aosc.xyz>
	 <20161011003359.26079-3-icenowy@aosc.xyz> <20161011174046.GA27925@dtor-ws>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBHHB6S7QKGQETCM7CVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161011174046.GA27925@dtor-ws>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Rask Ingemann Lambertsen <ccc94453-1EA3ORoCGBhoJ7GROcy7lA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Damien Riegel <damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jeffrey Lin <jeffrey.lin-s3Ivl27awEzQT0dZR+AlfA@public.gmane.org>, Javier
List-Id: linux-input@vger.kernel.org



12.10.2016, 01:40, "Dmitry Torokhov" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi Icenowy,
>
> On Tue, Oct 11, 2016 at 08:33:57AM +0800, Icenowy Zheng wrote:
>> =C2=A0This driver adds support for Ilitek ili2139 touch IC, which is use=
d in
>> =C2=A0several Colorfly tablets (for example, Colorfly E708 Q1, which is =
an
>> =C2=A0Allwinner A31s tablet with mainline kernel support).
>>
>> =C2=A0Theortically it may support more Ilitek touch ICs, however, only i=
li2139
>> =C2=A0is used in any mainlined device.
>>
>> =C2=A0It supports device tree enumeration, with screen resolution and ax=
is
>> =C2=A0quirks configurable.
>>
>> =C2=A0Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>
> Please extend ili210x.c instead of adding brand new driver, they look
> very similar.
>
> Thanks.

The driver is too old, lack of maintaince and needs some platform data hack=
s.
(At least makes it not capable to be used on current ARM devices, as they'r=
e
described with device tree)

Maybe I will rename the new driver modified by me to ili210x, add support f=
or
the old protocol (but I have no chips to test it), and drop the old ili210x=
.
(This driver is capable of dt probing, and uses devm_ functions)

>
>> =C2=A0---
>> =C2=A0=C2=A0drivers/input/touchscreen/Kconfig | 14 ++
>> =C2=A0=C2=A0drivers/input/touchscreen/Makefile | 1 +
>> =C2=A0=C2=A0drivers/input/touchscreen/ili2139.c | 320 ++++++++++++++++++=
++++++++++++++++++
>> =C2=A0=C2=A03 files changed, 335 insertions(+)
>> =C2=A0=C2=A0create mode 100644 drivers/input/touchscreen/ili2139.c
>>
>> =C2=A0diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/tou=
chscreen/Kconfig
>> =C2=A0index 5079813..bb4d9d2 100644
>> =C2=A0--- a/drivers/input/touchscreen/Kconfig
>> =C2=A0+++ b/drivers/input/touchscreen/Kconfig
>> =C2=A0@@ -348,6 +348,20 @@ config TOUCHSCREEN_ILI210X
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
To compile this driver as a module, choose M here: the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
module will be called ili210x.
>>
>> =C2=A0+config TOUCHSCREEN_ILI2139
>> =C2=A0+ tristate "Ilitek ILI2139 based touchscreen"
>> =C2=A0+ depends on I2C
>> =C2=A0+ depends on OF
>> =C2=A0+ help
>> =C2=A0+ Say Y here if you have a ILI2139 based touchscreen
>> =C2=A0+ controller. Such kind of chipsets can be found in several
>> =C2=A0+ Colorfly tablets.
>> =C2=A0+
>> =C2=A0+ If unsure, say N.
>> =C2=A0+
>> =C2=A0+ To compile this driver as a module, choose M here; the
>> =C2=A0+ module will be called ili2139.
>> =C2=A0+
>> =C2=A0=C2=A0config TOUCHSCREEN_IPROC
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "IP=
ROC touch panel driver support"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on A=
RCH_BCM_IPROC || COMPILE_TEST
>> =C2=A0diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/to=
uchscreen/Makefile
>> =C2=A0index 81b8645..930b5e2 100644
>> =C2=A0--- a/drivers/input/touchscreen/Makefile
>> =C2=A0+++ b/drivers/input/touchscreen/Makefile
>> =C2=A0@@ -40,6 +40,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL) +=3D ega=
lax_ts_serial.o
>> =C2=A0=C2=A0obj-$(CONFIG_TOUCHSCREEN_FUJITSU) +=3D fujitsu_ts.o
>> =C2=A0=C2=A0obj-$(CONFIG_TOUCHSCREEN_GOODIX) +=3D goodix.o
>> =C2=A0=C2=A0obj-$(CONFIG_TOUCHSCREEN_ILI210X) +=3D ili210x.o
>> =C2=A0+obj-$(CONFIG_TOUCHSCREEN_ILI2139) +=3D ili2139.o
>> =C2=A0=C2=A0obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC) +=3D imx6ul_tsc.o
>> =C2=A0=C2=A0obj-$(CONFIG_TOUCHSCREEN_INEXIO) +=3D inexio.o
>> =C2=A0=C2=A0obj-$(CONFIG_TOUCHSCREEN_INTEL_MID) +=3D intel-mid-touch.o
>> =C2=A0diff --git a/drivers/input/touchscreen/ili2139.c b/drivers/input/t=
ouchscreen/ili2139.c
>> =C2=A0new file mode 100644
>> =C2=A0index 0000000..65c2dea
>> =C2=A0--- /dev/null
>> =C2=A0+++ b/drivers/input/touchscreen/ili2139.c
>> =C2=A0@@ -0,0 +1,320 @@
>> =C2=A0+/* --------------------------------------------------------------=
-----------
>> =C2=A0+ * Copyright (C) 2016, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
>> =C2=A0+ *
>> =C2=A0+ * Derived from:
>> =C2=A0+ * ili210x.c
>> =C2=A0+ * Copyright (C) Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>
>> =C2=A0+ *
>> =C2=A0+ * This program is free software; you can redistribute it and/or =
modify
>> =C2=A0+ * it under the terms of the GNU General Public License as publis=
hed by
>> =C2=A0+ * the Free Software Foundation; either version 2 of the License,=
 or
>> =C2=A0+ * (at your option) any later version.
>> =C2=A0+ *
>> =C2=A0+ * This program is distributed in the hope that it will be useful=
,
>> =C2=A0+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> =C2=A0+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> =C2=A0+ * GNU General Public License for more details.
>> =C2=A0+ * --------------------------------------------------------------=
-----------
>> =C2=A0+ */
>> =C2=A0+
>> =C2=A0+#include <linux/module.h>
>> =C2=A0+#include <linux/i2c.h>
>> =C2=A0+#include <linux/interrupt.h>
>> =C2=A0+#include <linux/slab.h>
>> =C2=A0+#include <linux/input.h>
>> =C2=A0+#include <linux/input/mt.h>
>> =C2=A0+#include <linux/input/touchscreen.h>
>> =C2=A0+#include <linux/delay.h>
>> =C2=A0+#include <linux/workqueue.h>
>> =C2=A0+
>> =C2=A0+#define DEFAULT_POLL_PERIOD 20
>> =C2=A0+
>> =C2=A0+#define MAX_TOUCHES 10
>> =C2=A0+#define COMPATIBLE_TOUCHES 2
>> =C2=A0+
>> =C2=A0+/* Touchscreen commands */
>> =C2=A0+#define REG_TOUCHDATA 0x10
>> =C2=A0+#define REG_TOUCHSUBDATA 0x11
>> =C2=A0+#define REG_PANEL_INFO 0x20
>> =C2=A0+#define REG_FIRMWARE_VERSION 0x40
>> =C2=A0+#define REG_PROTO_VERSION 0x42
>> =C2=A0+
>> =C2=A0+#define SUBDATA_STATUS_TOUCH_POINT 0x80
>> =C2=A0+#define SUBDATA_STATUS_RELEASE_POINT 0x00
>> =C2=A0+
>> =C2=A0+struct finger {
>> =C2=A0+ u8 x_low;
>> =C2=A0+ u8 x_high;
>> =C2=A0+ u8 y_low;
>> =C2=A0+ u8 y_high;
>> =C2=A0+} __packed;
>> =C2=A0+
>> =C2=A0+struct touchdata {
>> =C2=A0+ u8 length;
>> =C2=A0+ struct finger finger[COMPATIBLE_TOUCHES];
>> =C2=A0+} __packed;
>> =C2=A0+
>> =C2=A0+struct touch_subdata {
>> =C2=A0+ u8 status;
>> =C2=A0+ struct finger finger;
>> =C2=A0+} __packed;
>> =C2=A0+
>> =C2=A0+struct panel_info {
>> =C2=A0+ struct finger finger_max;
>> =C2=A0+ u8 xchannel_num;
>> =C2=A0+ u8 ychannel_num;
>> =C2=A0+} __packed;
>> =C2=A0+
>> =C2=A0+struct firmware_version {
>> =C2=A0+ u8 id;
>> =C2=A0+ u8 major;
>> =C2=A0+ u8 minor;
>> =C2=A0+} __packed;
>> =C2=A0+
>> =C2=A0+struct ili2139 {
>> =C2=A0+ struct i2c_client *client;
>> =C2=A0+ struct input_dev *input;
>> =C2=A0+ unsigned int poll_period;
>> =C2=A0+ struct delayed_work dwork;
>> =C2=A0+ struct touchscreen_properties prop;
>> =C2=A0+ int slots[MAX_TOUCHES];
>> =C2=A0+ int ids[MAX_TOUCHES];
>> =C2=A0+ struct input_mt_pos pos[MAX_TOUCHES];
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0+static int ili2139_read_reg(struct i2c_client *client, u8 reg, vo=
id *buf,
>> =C2=A0+ size_t len)
>> =C2=A0+{
>> =C2=A0+ struct i2c_msg msg[2] =3D {
>> =C2=A0+ {
>> =C2=A0+ .addr =3D client->addr,
>> =C2=A0+ .flags =3D 0,
>> =C2=A0+ .len =3D 1,
>> =C2=A0+ .buf =3D &reg,
>> =C2=A0+ },
>> =C2=A0+ {
>> =C2=A0+ .addr =3D client->addr,
>> =C2=A0+ .flags =3D I2C_M_RD,
>> =C2=A0+ .len =3D len,
>> =C2=A0+ .buf =3D buf,
>> =C2=A0+ }
>> =C2=A0+ };
>> =C2=A0+
>> =C2=A0+ if (i2c_transfer(client->adapter, msg, 2) !=3D 2) {
>> =C2=A0+ dev_err(&client->dev, "i2c transfer failed\n");
>> =C2=A0+ return -EIO;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static void ili2139_work(struct work_struct *work)
>> =C2=A0+{
>> =C2=A0+ int id;
>> =C2=A0+ struct ili2139 *priv =3D container_of(work, struct ili2139,
>> =C2=A0+ dwork.work);
>> =C2=A0+ struct i2c_client *client =3D priv->client;
>> =C2=A0+ struct touchdata touchdata;
>> =C2=A0+ struct touch_subdata subdata;
>> =C2=A0+ int error;
>> =C2=A0+
>> =C2=A0+ error =3D ili2139_read_reg(client, REG_TOUCHDATA,
>> =C2=A0+ &touchdata, sizeof(touchdata));
>> =C2=A0+ if (error) {
>> =C2=A0+ dev_err(&client->dev,
>> =C2=A0+ "Unable to get touchdata, err =3D %d\n", error);
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ for (id =3D 0; id < touchdata.length; id++) {
>> =C2=A0+ error =3D ili2139_read_reg(client, REG_TOUCHSUBDATA, &subdata,
>> =C2=A0+ sizeof(subdata));
>> =C2=A0+ if (error) {
>> =C2=A0+ dev_err(&client->dev,
>> =C2=A0+ "Unable to get touch subdata, err =3D %d\n",
>> =C2=A0+ error);
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ priv->ids[id] =3D subdata.status & 0x3F;
>> =C2=A0+
>> =C2=A0+ /* The sequence changed in the v2 subdata protocol. */
>> =C2=A0+ touchscreen_set_mt_pos(&priv->pos[id], &priv->prop,
>> =C2=A0+ (subdata.finger.x_high | (subdata.finger.x_low << 8)),
>> =C2=A0+ (subdata.finger.y_high | (subdata.finger.y_low << 8)));
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ input_mt_assign_slots(priv->input, priv->slots, priv->pos,
>> =C2=A0+ touchdata.length, 0);
>> =C2=A0+
>> =C2=A0+ for (id =3D 0; id < touchdata.length; id++) {
>> =C2=A0+ input_mt_slot(priv->input, priv->slots[id]);
>> =C2=A0+ input_mt_report_slot_state(priv->input, MT_TOOL_FINGER,
>> =C2=A0+ subdata.status &
>> =C2=A0+ SUBDATA_STATUS_TOUCH_POINT);
>> =C2=A0+ input_report_abs(priv->input, ABS_MT_POSITION_X,
>> =C2=A0+ priv->pos[id].x);
>> =C2=A0+ input_report_abs(priv->input, ABS_MT_POSITION_Y,
>> =C2=A0+ priv->pos[id].y);
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ input_mt_sync_frame(priv->input);
>> =C2=A0+ input_sync(priv->input);
>> =C2=A0+
>> =C2=A0+ schedule_delayed_work(&priv->dwork,
>> =C2=A0+ msecs_to_jiffies(priv->poll_period));
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static irqreturn_t ili2139_irq(int irq, void *irq_data)
>> =C2=A0+{
>> =C2=A0+ struct ili2139 *priv =3D irq_data;
>> =C2=A0+
>> =C2=A0+ schedule_delayed_work(&priv->dwork, 0);
>> =C2=A0+
>> =C2=A0+ return IRQ_HANDLED;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static int ili2139_i2c_probe(struct i2c_client *client,
>> =C2=A0+ const struct i2c_device_id *id)
>> =C2=A0+{
>> =C2=A0+ struct device *dev =3D &client->dev;
>> =C2=A0+ struct ili2139 *priv;
>> =C2=A0+ struct input_dev *input;
>> =C2=A0+ struct panel_info panel;
>> =C2=A0+ struct firmware_version firmware;
>> =C2=A0+ int xmax, ymax;
>> =C2=A0+ int error;
>> =C2=A0+
>> =C2=A0+ dev_dbg(dev, "Probing for ILI2139 I2C Touschreen driver");
>> =C2=A0+
>> =C2=A0+ if (client->irq <=3D 0) {
>> =C2=A0+ dev_err(dev, "No IRQ!\n");
>> =C2=A0+ return -ENODEV;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ /* Get firmware version */
>> =C2=A0+ error =3D ili2139_read_reg(client, REG_FIRMWARE_VERSION,
>> =C2=A0+ &firmware, sizeof(firmware));
>> =C2=A0+ if (error) {
>> =C2=A0+ dev_err(dev, "Failed to get firmware version, err: %d\n",
>> =C2=A0+ error);
>> =C2=A0+ return error;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ /* get panel info */
>> =C2=A0+ error =3D ili2139_read_reg(client, REG_PANEL_INFO, &panel, sizeo=
f(panel));
>> =C2=A0+ if (error) {
>> =C2=A0+ dev_err(dev, "Failed to get panel information, err: %d\n",
>> =C2=A0+ error);
>> =C2=A0+ return error;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ xmax =3D panel.finger_max.x_low | (panel.finger_max.x_high << 8)=
;
>> =C2=A0+ ymax =3D panel.finger_max.y_low | (panel.finger_max.y_high << 8)=
;
>> =C2=A0+
>> =C2=A0+ priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> =C2=A0+ input =3D devm_input_allocate_device(dev);
>> =C2=A0+ if (!priv || !input)
>> =C2=A0+ return -ENOMEM;
>> =C2=A0+
>> =C2=A0+ priv->client =3D client;
>> =C2=A0+ priv->input =3D input;
>> =C2=A0+ priv->poll_period =3D DEFAULT_POLL_PERIOD;
>> =C2=A0+ INIT_DELAYED_WORK(&priv->dwork, ili2139_work);
>> =C2=A0+
>> =C2=A0+ /* Setup input device */
>> =C2=A0+ input->name =3D "ILI2139 Touchscreen";
>> =C2=A0+ input->id.bustype =3D BUS_I2C;
>> =C2=A0+ input->dev.parent =3D dev;
>> =C2=A0+
>> =C2=A0+ __set_bit(EV_SYN, input->evbit);
>> =C2=A0+ __set_bit(EV_KEY, input->evbit);
>> =C2=A0+ __set_bit(EV_ABS, input->evbit);
>> =C2=A0+
>> =C2=A0+ /* Multi touch */
>> =C2=A0+ input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_DIRECT |
>> =C2=A0+ INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
>> =C2=A0+ input_set_abs_params(input, ABS_MT_POSITION_X, 0, xmax, 0, 0);
>> =C2=A0+ input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ymax, 0, 0);
>> =C2=A0+
>> =C2=A0+ touchscreen_parse_properties(input, true, &priv->prop);
>> =C2=A0+
>> =C2=A0+ input_set_drvdata(input, priv);
>> =C2=A0+ i2c_set_clientdata(client, priv);
>> =C2=A0+
>> =C2=A0+ error =3D devm_request_irq(dev, client->irq, ili2139_irq,
>> =C2=A0+ IRQF_TRIGGER_FALLING, client->name, priv);
>> =C2=A0+ if (error) {
>> =C2=A0+ dev_err(dev, "Unable to request touchscreen IRQ, err: %d\n",
>> =C2=A0+ error);
>> =C2=A0+ return error;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ error =3D input_register_device(priv->input);
>> =C2=A0+ if (error) {
>> =C2=A0+ dev_err(dev, "Cannot register input device, err: %d\n", error);
>> =C2=A0+ return error;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ device_init_wakeup(&client->dev, 1);
>> =C2=A0+
>> =C2=A0+ dev_dbg(dev,
>> =C2=A0+ "ILI2139 initialized (IRQ: %d), firmware version %d.%d.%d",
>> =C2=A0+ client->irq, firmware.id, firmware.major, firmware.minor);
>> =C2=A0+
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static int ili2139_i2c_remove(struct i2c_client *client)
>> =C2=A0+{
>> =C2=A0+ struct ili2139 *priv =3D i2c_get_clientdata(client);
>> =C2=A0+
>> =C2=A0+ cancel_delayed_work_sync(&priv->dwork);
>> =C2=A0+
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static int __maybe_unused ili2139_i2c_suspend(struct device *dev)
>> =C2=A0+{
>> =C2=A0+ struct i2c_client *client =3D to_i2c_client(dev);
>> =C2=A0+
>> =C2=A0+ if (device_may_wakeup(&client->dev))
>> =C2=A0+ enable_irq_wake(client->irq);
>> =C2=A0+
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static int __maybe_unused ili2139_i2c_resume(struct device *dev)
>> =C2=A0+{
>> =C2=A0+ struct i2c_client *client =3D to_i2c_client(dev);
>> =C2=A0+
>> =C2=A0+ if (device_may_wakeup(&client->dev))
>> =C2=A0+ disable_irq_wake(client->irq);
>> =C2=A0+
>> =C2=A0+ return 0;
>> =C2=A0+}
>> =C2=A0+
>> =C2=A0+static SIMPLE_DEV_PM_OPS(ili2139_i2c_pm,
>> =C2=A0+ ili2139_i2c_suspend, ili2139_i2c_resume);
>> =C2=A0+
>> =C2=A0+static const struct i2c_device_id ili2139_i2c_id[] =3D {
>> =C2=A0+ { "ili2139", 0 },
>> =C2=A0+ { }
>> =C2=A0+};
>> =C2=A0+MODULE_DEVICE_TABLE(i2c, ili2139_i2c_id);
>> =C2=A0+
>> =C2=A0+static struct i2c_driver ili2139_ts_driver =3D {
>> =C2=A0+ .driver =3D {
>> =C2=A0+ .name =3D "ili2139_i2c",
>> =C2=A0+ .pm =3D &ili2139_i2c_pm,
>> =C2=A0+ },
>> =C2=A0+ .id_table =3D ili2139_i2c_id,
>> =C2=A0+ .probe =3D ili2139_i2c_probe,
>> =C2=A0+ .remove =3D ili2139_i2c_remove,
>> =C2=A0+};
>> =C2=A0+
>> =C2=A0+module_i2c_driver(ili2139_ts_driver);
>> =C2=A0+
>> =C2=A0+MODULE_AUTHOR("Olivier Sobrie <olivier-Ui3EtX6WB9GzQB+pC5nmwQ@public.gmane.org>");
>> =C2=A0+MODULE_DESCRIPTION("ILI2139 I2C Touchscreen Driver");
>> =C2=A0+MODULE_LICENSE("GPL");
>> =C2=A0--
>> =C2=A02.10.1
>
> --
> Dmitry

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
