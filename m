From: TAO HU <tghk48@motorola.com>
Subject: Re: [RFC] Input: ADP5588 - Support GPI event for ADP5588 devices
Date: Fri, 11 Jun 2010 10:39:33 +0800
Message-ID: <AANLkTimubPIlTrbIBUGHbvOHK1XAhUATbWjEgPIk_QX1@mail.gmail.com>
References: <AANLkTinaguxmGVrx3lWqNT__xE6S2CIjoLc69TrS-yyN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:33677 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab0FKDd3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jun 2010 23:33:29 -0400
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id o5B2dndj008474
	for <linux-input@vger.kernel.org>; Thu, 10 Jun 2010 20:39:49 -0600 (MDT)
Received: from mail-pw0-f54.google.com (mail-pw0-f54.google.com [209.85.160.54])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id o5B2dmp6008468
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Thu, 10 Jun 2010 20:39:48 -0600 (MDT)
Received: by pwj1 with SMTP id 1so347713pwj.27
        for <linux-input@vger.kernel.org>; Thu, 10 Jun 2010 19:39:33 -0700 (PDT)
In-Reply-To: <AANLkTinaguxmGVrx3lWqNT__xE6S2CIjoLc69TrS-yyN@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <hennerich@blackfin.uclinux.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>, Xiaolong CHEN <xiao-long.chen@motorola.com>

Hi, Michael  and Dmitry

Any comments?

--=20
Best Regards
Hu Tao

On Thu, Jun 10, 2010 at 10:36 AM, Xiaolong CHEN
<xiao-long.chen@motorola.com> wrote:
> Hi,
>
> This patch supports GPI event for ADP5588 devices.
>
> Kernel Version: 2.6.34
>
> A column or row configured as a GPI can be programmed to be part of
> the key event table and therefore also capable of generating a key
> event interrupt. A key event interrupt caused by a GPI follows the
> same process flow as a key event interrupt caused by a key press. GPI=
s
> configured as part of the key event table allow single key switches
> and other GPI interrupts to bemonitored. As part of the event table,
> GPIs are represented by the decimal value 97 (0x61or 1100001) through
> the decimal value 114 (0x72 or 1110010). See Table as below for GPI
> event number assignments for rows and columns.
>
> GPI Event Number Assignments for Rows
> Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
> 97 =A0 =A0 =A0 98 =A0 =A0 =A0 99 =A0 =A0 =A0 100 =A0 =A0 101 =A0 =A0 =
102 =A0 =A0 103 =A0 =A0104
>
> GPI Event Number Assignments for Cols
> Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
> 105 =A0106 =A0 107 =A0 108 =A0 109 =A0 110 =A0 111 =A0 112 =A0113 =A0=
114
>
> Usage:
> 1. Enable CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> 2. Add gpimap and gpimapsize setting in adp5588_kpad_platform_data
> (The settings should not conflict with rows/cols for keymap)
>
> Patch:
> From 75412f66cc16c19c8b6046ed499ccf6e34db01c3 Mon Sep 17 00:00:00 200=
1
> From: xiaolong <a21785@motorola.com>
> Date: Thu, 10 Jun 2010 05:13:13 -0400
> Subject: [PATCH] Input: ADP5588 - Support GPI event for ADP5588 devic=
es
>
> A column or row configured as a GPI can be programmed to be part
> of the key event table and therefore also capable of generating a
> key event interrupt. A key event interrupt caused by a GPI follows
> the same process flow as a key event interrupt caused by a key
> press. GPIs configured as part of the key event table allow single
> key switches and other GPI interrupts to bemonitored. As part of
> the event table, GPIs are represented by the decimal value 97 (0x61
> or 1100001) through the decimal value 114 (0x72 or 1110010). See
> Table as below for GPI event number assignments for rows and columns.
>
> GPI Event Number Assignments for Rows
> Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
> 97 =A0 98 =A0 99 =A0 100 =A0101 =A0102 =A0103 =A0104
>
> GPI Event Number Assignments for Cols
> Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
> 105 =A0106 =A0107 =A0108 =A0109 =A0110 =A0111 =A0112 =A0113 =A0114
>
> Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
> Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
> Signed-off-by: Tao Hu <taohu@motorola.com>
> ---
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0| =A0 =A08 ++
> =A0drivers/input/keyboard/adp5588-keys.c | =A0126 +++++++++++++++++++=
++++++++++++++
> =A0include/linux/i2c/adp5588.h =A0 =A0 =A0 =A0 =A0 | =A0 40 +++++++++=
+
> =A03 files changed, 174 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index 64c1023..aebf8de 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -44,6 +44,14 @@ config KEYBOARD_ADP5588
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called adp5588-keys.
>
> +config KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 tristate "ADP5588 GPI event on key event interrupt"
> + =A0 =A0 =A0 depends on KEYBOARD_ADP5588
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Enable GPI events on key event interrupt, GPIs conf=
igured
> + =A0 =A0 =A0 =A0 as part of the key event table allow single key swi=
tches
> + =A0 =A0 =A0 =A0 and other GPI interrupts to be monitored.
> +
> =A0config KEYBOARD_AMIGA
> =A0 =A0 =A0 =A0tristate "Amiga keyboard"
> =A0 =A0 =A0 =A0depends on AMIGA
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index b5142d2..4cd5cee 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -66,6 +66,10 @@ struct adp5588_kpad {
> =A0 =A0 =A0 =A0struct delayed_work work;
> =A0 =A0 =A0 =A0unsigned long delay;
> =A0 =A0 =A0 =A0unsigned short keycode[ADP5588_KEYMAPSIZE];
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 const struct adp5588_gpi_map *gpimap;
> + =A0 =A0 =A0 unsigned short gpimapsize;
> +#endif
> =A0};
>
> =A0static int adp5588_read(struct i2c_client *client, u8 reg)
> @@ -99,10 +103,33 @@ static void adp5588_work(struct work_struct *wor=
k)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ev_cnt =3D adp5588_read(client, KEY_LC=
K_EC_STAT) & KEC;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ev_cnt) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < ev_c=
nt; i++) {
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int j, =
key_val, pin;
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0key =3D=
 adp5588_read(client, Key_EVENTA + i);
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_val=
 =3D key & (~KEY_EV_PRESSED);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ke=
y_val >=3D GPI_PIN_BASE) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (key_val <=3D GPI_PIN_END)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 for (j =3D 0; j < kpad->gpimapsize; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 pin =3D kpad->gpimap[j].pin;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (key_val !=3D pin)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 input_report_switch(kpad->input,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kpad->gpimap[j].sw_evt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key & KEY_EV_PRESSED);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_=
report_key(kpad->input,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0kpad->keycode[(key & KEY_EV_MASK) - 1],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0key & KEY_EV_PRESSED);
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_sync(kpad->input=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -129,6 +156,9 @@ static int __devinit adp5588_setup(struct
> i2c_client *client)
> =A0{
> =A0 =A0 =A0 =A0struct adp5588_kpad_platform_data *pdata =3D client->d=
ev.platform_data;
> =A0 =A0 =A0 =A0int i, ret;
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 unsigned char evt_mode1 =3D 0, evt_mode2 =3D 0, evt_mod=
e3 =3D 0;
> +#endif
>
> =A0 =A0 =A0 =A0ret =3D adp5588_write(client, KP_GPIO1, KP_SEL(pdata->=
rows));
> =A0 =A0 =A0 =A0ret |=3D adp5588_write(client, KP_GPIO2, KP_SEL(pdata-=
>cols) & 0xFF);
> @@ -143,6 +173,23 @@ static int __devinit adp5588_setup(struct
> i2c_client *client)
> =A0 =A0 =A0 =A0for (i =3D 0; i < KEYP_MAX_EVENT; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret |=3D adp5588_read(client, Key_EVEN=
TA);
>
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->gpimapsize; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short pin =3D pdata->gpimap[i]=
=2Epin;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pin <=3D GPI_PIN_ROW_END) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 evt_mode1 |=3D (1 << (p=
in - GPI_PIN_ROW_BASE));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 evt_mode2 |=3D ((1 << (=
pin - GPI_PIN_COL_BASE)) & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 evt_mode3 |=3D ((1 << (=
pin - GPI_PIN_COL_BASE)) >> 8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret |=3D adp5588_write(client, GPI_EM1, evt_mode1);
> + =A0 =A0 =A0 ret |=3D adp5588_write(client, GPI_EM2, evt_mode2);
> + =A0 =A0 =A0 ret |=3D adp5588_write(client, GPI_EM3, evt_mode3);
> +#endif
> +
> =A0 =A0 =A0 =A0ret |=3D adp5588_write(client, INT_STAT, CMP2_INT | CM=
P1_INT |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0OVR_FLOW_INT | K_LCK_INT |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0GPI_INT | KE_INT); /* Status is W1C */
> @@ -166,6 +213,9 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0unsigned int revid;
> =A0 =A0 =A0 =A0int ret, i;
> =A0 =A0 =A0 =A0int error;
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 int gpi_stat1 =3D 0, gpi_stat2 =3D 0, gpi_stat3 =3D 0;
> +#endif
>
> =A0 =A0 =A0 =A0if (!i2c_check_functionality(client->adapter,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0I2C_FUNC_SMBUS_BYTE_DATA)) {
> @@ -188,6 +238,39 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 if (!pdata->gpimap) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "no gpimap from p=
data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdata->gpimapsize > ADP5588_GPIMAPSIZE_MAX) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "invalid gpimapsi=
ze\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->gpimapsize; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short pin =3D pdata->gpimap[i]=
=2Epin;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pin < GPI_PIN_BASE) || (pin > GPI_=
PIN_END)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "=
invalid gpi pin data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pin <=3D GPI_PIN_ROW_END) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pin - GPI_PIN_ROW_=
BASE + 1) <=3D pdata->rows) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err=
(&client->dev, "invalid gpi row data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pin - GPI_PIN_COL_=
BASE + 1) <=3D pdata->cols) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err=
(&client->dev, "invalid gpi col data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +#endif
> +
> =A0 =A0 =A0 =A0if (!client->irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "no IRQ?\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -232,6 +315,11 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0memcpy(kpad->keycode, pdata->keymap,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->keymapsize * input->keycodesize=
);
>
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 kpad->gpimap =3D pdata->gpimap;
> + =A0 =A0 =A0 kpad->gpimapsize =3D pdata->gpimapsize;
> +#endif
> +
> =A0 =A0 =A0 =A0/* setup input device */
> =A0 =A0 =A0 =A0__set_bit(EV_KEY, input->evbit);
>
> @@ -242,6 +330,12 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(kpad->keycode[i] & KEY_MAX, =
input->keybit);
> =A0 =A0 =A0 =A0__clear_bit(KEY_RESERVED, input->keybit);
>
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 __set_bit(EV_SW, input->evbit);
> + =A0 =A0 =A0 for (i =3D 0; i < kpad->gpimapsize; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(kpad->gpimap[i].sw_evt, input=
->swbit);
> +#endif
> +
> =A0 =A0 =A0 =A0error =3D input_register_device(input);
> =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "unable to regis=
ter input device\n");
> @@ -263,6 +357,38 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0device_init_wakeup(&client->dev, 1);
> =A0 =A0 =A0 =A0i2c_set_clientdata(client, kpad);
>
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 gpi_stat1 =3D adp5588_read(client, GPIO_DAT_STAT1);
> + =A0 =A0 =A0 gpi_stat2 =3D adp5588_read(client, GPIO_DAT_STAT2);
> + =A0 =A0 =A0 gpi_stat3 =3D adp5588_read(client, GPIO_DAT_STAT3);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < kpad->gpimapsize; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int gpi_stat_tmp, pin_loc;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short pin =3D kpad->gpimap[i].=
pin;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pin <=3D GPI_PIN_ROW_END) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpi_stat_tmp =3D gpi_st=
at1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin_loc =3D pin - GPI_P=
IN_ROW_BASE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if ((pin - GPI_PIN_COL_BASE) < 8=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpi_stat_tmp =3D gpi_st=
at2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin_loc =3D pin - GPI_P=
IN_COL_BASE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpi_stat_tmp =3D gpi_st=
at3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pin_loc =3D pin - GPI_P=
IN_COL_BASE - 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpi_stat_tmp < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "=
Can't read GPIO_DAT_STAT "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "switch=
 %d default to OFF\n", pin);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpi_stat_tmp =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_switch(input, kpad->gpimap=
[i].sw_evt,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(gpi_stat_tmp & (1 << =
pin_loc)));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input);
> + =A0 =A0 =A0 }
> +#endif
> +
> =A0 =A0 =A0 =A0dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revi=
d, client->irq);
> =A0 =A0 =A0 =A0return 0;
>
> diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.=
h
> index 02c9af3..bb6365d 100644
> --- a/include/linux/i2c/adp5588.h
> +++ b/include/linux/i2c/adp5588.h
> @@ -78,6 +78,42 @@
>
> =A0#define ADP5588_KEYMAPSIZE =A0 =A0 80
>
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> +#define GPI_PIN_ROW0 97
> +#define GPI_PIN_ROW1 98
> +#define GPI_PIN_ROW2 99
> +#define GPI_PIN_ROW3 100
> +#define GPI_PIN_ROW4 101
> +#define GPI_PIN_ROW5 102
> +#define GPI_PIN_ROW6 103
> +#define GPI_PIN_ROW7 104
> +#define GPI_PIN_COL0 105
> +#define GPI_PIN_COL1 106
> +#define GPI_PIN_COL2 107
> +#define GPI_PIN_COL3 108
> +#define GPI_PIN_COL4 109
> +#define GPI_PIN_COL5 110
> +#define GPI_PIN_COL6 111
> +#define GPI_PIN_COL7 112
> +#define GPI_PIN_COL8 113
> +#define GPI_PIN_COL9 114
> +
> +#define GPI_PIN_ROW_BASE GPI_PIN_ROW0
> +#define GPI_PIN_ROW_END GPI_PIN_ROW7
> +#define GPI_PIN_COL_BASE GPI_PIN_COL0
> +#define GPI_PIN_COL_END GPI_PIN_COL9
> +
> +#define GPI_PIN_BASE GPI_PIN_ROW_BASE
> +#define GPI_PIN_END GPI_PIN_COL_END
> +
> +#define ADP5588_GPIMAPSIZE_MAX (GPI_PIN_END - GPI_PIN_BASE + 1)
> +
> +struct adp5588_gpi_map {
> + =A0 =A0 =A0 unsigned short pin;
> + =A0 =A0 =A0 unsigned short sw_evt;
> +};
> +#endif
> +
> =A0struct adp5588_kpad_platform_data {
> =A0 =A0 =A0 =A0int rows; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
/* Number of rows */
> =A0 =A0 =A0 =A0int cols; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
/* Number of columns */
> @@ -87,6 +123,10 @@ struct adp5588_kpad_platform_data {
> =A0 =A0 =A0 =A0unsigned en_keylock:1; =A0 =A0 =A0 =A0 =A0/* Enable Ke=
y Lock feature */
> =A0 =A0 =A0 =A0unsigned short unlock_key1; =A0 =A0 /* Unlock Key 1 */
> =A0 =A0 =A0 =A0unsigned short unlock_key2; =A0 =A0 /* Unlock Key 2 */
> +#ifdef CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> + =A0 =A0 =A0 const struct adp5588_gpi_map *gpimap;
> + =A0 =A0 =A0 unsigned short gpimapsize;
> +#endif
> =A0};
>
> =A0struct adp5588_gpio_platform_data {
> --
> 1.5.4.3
>
> If there is any comments and suggestion, please let me know.
>
> Thanks,
> Xiaolong
>



--=20
Best Regards
Hu Tao
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
