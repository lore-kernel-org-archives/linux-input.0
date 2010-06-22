From: Xiaolong CHEN <a21785@motorola.com>
Subject: [PATCH] Input: ADP5588 - Support GPI event for ADP5588 devices
Date: Tue, 22 Jun 2010 19:12:40 +0800
Message-ID: <AANLkTimKan1n39_04KDhaBG5iQ_2lwl1bIcuiEvppLJn@mail.gmail.com>
References: <AANLkTinaguxmGVrx3lWqNT__xE6S2CIjoLc69TrS-yyN@mail.gmail.com>
	<201006101228.03993.dmitry.torokhov@gmail.com>
	<AANLkTilAVOBLQBstGBtjgWVvOJVIQ_pgkcy5-A_Vwe3H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:47463 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab0FVLMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jun 2010 07:12:47 -0400
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id o5MBCvqD029565
	for <linux-input@vger.kernel.org>; Tue, 22 Jun 2010 05:12:57 -0600 (MDT)
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com [209.85.214.182])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id o5MBCvS1029554
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Tue, 22 Jun 2010 05:12:57 -0600 (MDT)
Received: by iwn7 with SMTP id 7so6040116iwn.27
        for <linux-input@vger.kernel.org>; Tue, 22 Jun 2010 04:12:44 -0700 (PDT)
In-Reply-To: <AANLkTilAVOBLQBstGBtjgWVvOJVIQ_pgkcy5-A_Vwe3H@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Hennerich <hennerich@blackfin.uclinux.org>, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi,

This patch supports GPI event for ADP5588 devices and remove the compil=
e option.

Kernel Version: 2.6.34

Usage:
Add gpimap and gpimapsize setting in adp5588_kpad_platform_data (The
settings should not conflict with rows/cols for keymap), set gpimap =3D
null, gpimapsize =3D 0 if don't use gpi event.

Patch:
=46rom a300f8fc2fc5855109777c89ccec5ff1303f0ec2 Mon Sep 17 00:00:00 200=
1
=46rom: xiaolong <a21785@motorola.com>
Date: Wed, 23 Jun 2010 06:39:28 -0400
Subject: [PATCH] Input: ADP5588 - Support GPI event for ADP5588 devices

A column or row configured as a GPI can be programmed to be part
of the key event table and therefore also capable of generating a
key event interrupt. A key event interrupt caused by a GPI follows
the same process flow as a key event interrupt caused by a key
press. GPIs configured as part of the key event table allow single
key switches and other GPI interrupts to bemonitored. As part of
the event table, GPIs are represented by the decimal value 97 (0x61
or 1100001) through the decimal value 114 (0x72 or 1110010). See
Table as below for GPI event number assignments for rows and columns.

GPI Event Number Assignments for Rows
Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
97   98   99   100  101  102  103  104

GPI Event Number Assignments for Cols
Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
105  106  107  108  109  110  111  112  113  114

Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
Signed-off-by: Tao Hu <taohu@motorola.com>
---
 drivers/input/keyboard/adp5588-keys.c |  116 +++++++++++++++++++++++++=
+++++++-
 include/linux/i2c/adp5588.h           |   36 ++++++++++
 2 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c
b/drivers/input/keyboard/adp5588-keys.c
index b5142d2..ca5085e 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -66,6 +66,8 @@ struct adp5588_kpad {
 	struct delayed_work work;
 	unsigned long delay;
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
+	const struct adp5588_gpi_map *gpimap;
+	unsigned short gpimapsize;
 };

 static int adp5588_read(struct i2c_client *client, u8 reg)
@@ -99,10 +101,28 @@ static void adp5588_work(struct work_struct *work)
 		ev_cnt =3D adp5588_read(client, KEY_LCK_EC_STAT) & KEC;
 		if (ev_cnt) {
 			for (i =3D 0; i < ev_cnt; i++) {
+				int j, key_val, pin;
+
 				key =3D adp5588_read(client, Key_EVENTA + i);
-				input_report_key(kpad->input,
-					kpad->keycode[(key & KEY_EV_MASK) - 1],
-					key & KEY_EV_PRESSED);
+				key_val =3D key & KEY_EV_MASK;
+
+				if ((key_val >=3D GPI_PIN_BASE) &&
+					(key_val <=3D GPI_PIN_END)) {
+					for (j =3D 0; j < kpad->gpimapsize; j++) {
+						pin =3D kpad->gpimap[j].pin;
+						if (key_val !=3D pin)
+							continue;
+
+						input_report_switch(kpad->input,
+							kpad->gpimap[j].sw_evt,
+							key & KEY_EV_PRESSED);
+						break;
+					}
+				} else {
+					input_report_key(kpad->input,
+						kpad->keycode[key_val - 1],
+						key & KEY_EV_PRESSED);
+				}
 			}
 			input_sync(kpad->input);
 		}
@@ -129,6 +149,7 @@ static int __devinit adp5588_setup(struct
i2c_client *client)
 {
 	struct adp5588_kpad_platform_data *pdata =3D client->dev.platform_dat=
a;
 	int i, ret;
+	unsigned char evt_mode1 =3D 0, evt_mode2 =3D 0, evt_mode3 =3D 0;

 	ret =3D adp5588_write(client, KP_GPIO1, KP_SEL(pdata->rows));
 	ret |=3D adp5588_write(client, KP_GPIO2, KP_SEL(pdata->cols) & 0xFF);
@@ -143,6 +164,23 @@ static int __devinit adp5588_setup(struct
i2c_client *client)
 	for (i =3D 0; i < KEYP_MAX_EVENT; i++)
 		ret |=3D adp5588_read(client, Key_EVENTA);

+	for (i =3D 0; i < pdata->gpimapsize; i++) {
+		unsigned short pin =3D pdata->gpimap[i].pin;
+
+		if (pin <=3D GPI_PIN_ROW_END) {
+			evt_mode1 |=3D (1 << (pin - GPI_PIN_ROW_BASE));
+		} else {
+			evt_mode2 |=3D ((1 << (pin - GPI_PIN_COL_BASE)) & 0xFF);
+			evt_mode3 |=3D ((1 << (pin - GPI_PIN_COL_BASE)) >> 8);
+		}
+	}
+
+	if (pdata->gpimapsize) {
+		ret |=3D adp5588_write(client, GPI_EM1, evt_mode1);
+		ret |=3D adp5588_write(client, GPI_EM2, evt_mode2);
+		ret |=3D adp5588_write(client, GPI_EM3, evt_mode3);
+	}
+
 	ret |=3D adp5588_write(client, INT_STAT, CMP2_INT | CMP1_INT |
 					OVR_FLOW_INT | K_LCK_INT |
 					GPI_INT | KE_INT); /* Status is W1C */
@@ -166,6 +204,7 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	unsigned int revid;
 	int ret, i;
 	int error;
+	int gpi_stat1 =3D 0, gpi_stat2 =3D 0, gpi_stat3 =3D 0;

 	if (!i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -188,6 +227,37 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 		return -EINVAL;
 	}

+	if ((!pdata->gpimap) && pdata->gpimapsize) {
+		dev_err(&client->dev, "invalid gpimap from pdata\n");
+		return -EINVAL;
+	}
+
+	if (pdata->gpimapsize > ADP5588_GPIMAPSIZE_MAX) {
+		dev_err(&client->dev, "invalid gpimapsize\n");
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < pdata->gpimapsize; i++) {
+		unsigned short pin =3D pdata->gpimap[i].pin;
+
+		if ((pin < GPI_PIN_BASE) || (pin > GPI_PIN_END)) {
+			dev_err(&client->dev, "invalid gpi pin data\n");
+			return -EINVAL;
+		}
+
+		if (pin <=3D GPI_PIN_ROW_END) {
+			if ((pin - GPI_PIN_ROW_BASE + 1) <=3D pdata->rows) {
+				dev_err(&client->dev, "invalid gpi row data\n");
+				return -EINVAL;
+			}
+		} else {
+			if ((pin - GPI_PIN_COL_BASE + 1) <=3D pdata->cols) {
+				dev_err(&client->dev, "invalid gpi col data\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	if (!client->irq) {
 		dev_err(&client->dev, "no IRQ?\n");
 		return -EINVAL;
@@ -232,6 +302,9 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	memcpy(kpad->keycode, pdata->keymap,
 		pdata->keymapsize * input->keycodesize);

+	kpad->gpimap =3D pdata->gpimap;
+	kpad->gpimapsize =3D pdata->gpimapsize;
+
 	/* setup input device */
 	__set_bit(EV_KEY, input->evbit);

@@ -242,6 +315,11 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 		__set_bit(kpad->keycode[i] & KEY_MAX, input->keybit);
 	__clear_bit(KEY_RESERVED, input->keybit);

+	if (kpad->gpimapsize)
+		__set_bit(EV_SW, input->evbit);
+	for (i =3D 0; i < kpad->gpimapsize; i++)
+		__set_bit(kpad->gpimap[i].sw_evt, input->swbit);
+
 	error =3D input_register_device(input);
 	if (error) {
 		dev_err(&client->dev, "unable to register input device\n");
@@ -263,6 +341,38 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	device_init_wakeup(&client->dev, 1);
 	i2c_set_clientdata(client, kpad);

+	if (kpad->gpimapsize) {
+		gpi_stat1 =3D adp5588_read(client, GPIO_DAT_STAT1);
+		gpi_stat2 =3D adp5588_read(client, GPIO_DAT_STAT2);
+		gpi_stat3 =3D adp5588_read(client, GPIO_DAT_STAT3);
+	}
+
+	for (i =3D 0; i < kpad->gpimapsize; i++) {
+		int gpi_stat_tmp, pin_loc;
+		unsigned short pin =3D kpad->gpimap[i].pin;
+
+		if (pin <=3D GPI_PIN_ROW_END) {
+			gpi_stat_tmp =3D gpi_stat1;
+			pin_loc =3D pin - GPI_PIN_ROW_BASE;
+		} else if ((pin - GPI_PIN_COL_BASE) < 8) {
+			gpi_stat_tmp =3D gpi_stat2;
+			pin_loc =3D pin - GPI_PIN_COL_BASE;
+		} else {
+			gpi_stat_tmp =3D gpi_stat3;
+			pin_loc =3D pin - GPI_PIN_COL_BASE - 8;
+		}
+
+		if (gpi_stat_tmp < 0) {
+			dev_err(&client->dev, "Can't read GPIO_DAT_STAT "
+				"switch %d default to OFF\n", pin);
+			gpi_stat_tmp =3D 0;
+		}
+
+		input_report_switch(input, kpad->gpimap[i].sw_evt,
+			!(gpi_stat_tmp & (1 << pin_loc)));
+		input_sync(input);
+	}
+
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq)=
;
 	return 0;

diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index 02c9af3..b5f57c4 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -78,6 +78,40 @@

 #define ADP5588_KEYMAPSIZE	80

+#define GPI_PIN_ROW0 97
+#define GPI_PIN_ROW1 98
+#define GPI_PIN_ROW2 99
+#define GPI_PIN_ROW3 100
+#define GPI_PIN_ROW4 101
+#define GPI_PIN_ROW5 102
+#define GPI_PIN_ROW6 103
+#define GPI_PIN_ROW7 104
+#define GPI_PIN_COL0 105
+#define GPI_PIN_COL1 106
+#define GPI_PIN_COL2 107
+#define GPI_PIN_COL3 108
+#define GPI_PIN_COL4 109
+#define GPI_PIN_COL5 110
+#define GPI_PIN_COL6 111
+#define GPI_PIN_COL7 112
+#define GPI_PIN_COL8 113
+#define GPI_PIN_COL9 114
+
+#define GPI_PIN_ROW_BASE GPI_PIN_ROW0
+#define GPI_PIN_ROW_END GPI_PIN_ROW7
+#define GPI_PIN_COL_BASE GPI_PIN_COL0
+#define GPI_PIN_COL_END GPI_PIN_COL9
+
+#define GPI_PIN_BASE GPI_PIN_ROW_BASE
+#define GPI_PIN_END GPI_PIN_COL_END
+
+#define ADP5588_GPIMAPSIZE_MAX (GPI_PIN_END - GPI_PIN_BASE + 1)
+
+struct adp5588_gpi_map {
+	unsigned short pin;
+	unsigned short sw_evt;
+};
+
 struct adp5588_kpad_platform_data {
 	int rows;			/* Number of rows */
 	int cols;			/* Number of columns */
@@ -87,6 +121,8 @@ struct adp5588_kpad_platform_data {
 	unsigned en_keylock:1;		/* Enable Key Lock feature */
 	unsigned short unlock_key1;	/* Unlock Key 1 */
 	unsigned short unlock_key2;	/* Unlock Key 2 */
+	const struct adp5588_gpi_map *gpimap;
+	unsigned short gpimapsize;
 };

 struct adp5588_gpio_platform_data {
--=20
1.5.4.3

Any comments and suggestion please let me know.

Thanks,
Xiaolong


---------- Forwarded message ----------
=46rom: Xiaolong CHEN <a21785@motorola.com>
Date: Thu, Jun 17, 2010 at 3:33 PM
Subject: Re: [RFC] Input: ADP5588 - Support GPI event for ADP5588 devic=
es
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Xiaolong CHEN <xiao-long.chen@motorola.com>,
linux-input@vger.kernel.org, Michael Hennerich
<hennerich@blackfin.uclinux.org>, TAO HU <taohu@motorola.com>,
"Yuan.Bo YE" <yuan-bo.ye@motorola.com>


Hi Dmitry,

Sorry for the late, I'm on vacation these days.

1. Why did you go with a compile option?
It's easy to use on different target board, sometimes the adp5588 will
not used for switch events.

Is it possible to enable this functionality unconditionally and let
board setup code specify what it wants to use?
Yes, I think it should be ok if checking the parameter.

2. Why did you decide to make the events switches and not keys?
Do you mean why use input_report_switch in this patch? Since a target
board might need a switch (for example: slider switch, slience
switch), and it will report to the user space. Also, it's not
economical to report a key event by GPI event, one pin could report
one event, but if use one pin in key matrix, it could report
1xrow/1xcol events.

Thanks,
Xiaolong

On Fri, Jun 11, 2010 at 3:28 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Xiaolong,
>
> On Wednesday, June 09, 2010 07:36:14 pm Xiaolong CHEN wrote:
> > Hi,
> >
> > This patch supports GPI event for ADP5588 devices.
> >
> > Kernel Version: 2.6.34
> >
> > A column or row configured as a GPI can be programmed to be part of
> > the key event table and therefore also capable of generating a key
> > event interrupt. A key event interrupt caused by a GPI follows the
> > same process flow as a key event interrupt caused by a key press. G=
PIs
> > configured as part of the key event table allow single key switches
> > and other GPI interrupts to bemonitored. As part of the event table=
,
> > GPIs are represented by the decimal value 97 (0x61or 1100001) throu=
gh
> > the decimal value 114 (0x72 or 1110010). See Table as below for GPI
> > event number assignments for rows and columns.
> >
> > GPI Event Number Assignments for Rows
> > Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
> > 97 =A0 =A0 =A0 98 =A0 =A0 =A0 99 =A0 =A0 =A0 100 =A0 =A0 101 =A0 =A0=
 102 =A0 =A0 103 =A0 =A0104
> >
> > GPI Event Number Assignments for Cols
> > Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
> > 105 =A0106 =A0 107 =A0 108 =A0 109 =A0 110 =A0 111 =A0 112 =A0113 =A0=
114
> >
> > Usage:
> > 1. Enable CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> > 2. Add gpimap and gpimapsize setting in adp5588_kpad_platform_data
> > (The settings should not conflict with rows/cols for keymap)
>
> A couple of questions:
>
> 1. Why did you go with a compile option? Is it possible to enable thi=
s
> =A0 functionality unconditionally and let board setup code specify wh=
at
> =A0 it wants to use?
>
> 2. Why did you decide to make the events switches and not keys?
>
> Thanks.
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
