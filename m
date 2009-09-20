From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
Subject: Re: [PATCH] Atmel AT42QT2160 sensor chip input driver
Date: Sun, 20 Sep 2009 10:03:19 -0300
Message-ID: <f20381800909200603v1a1fc3a5l73fcfca55731943e@mail.gmail.com>
References: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com>
	 <20090915042612.GB1132@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:58873 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbZITNDQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Sep 2009 09:03:16 -0400
Received: by ywh3 with SMTP id 3so2751252ywh.22
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2009 06:03:19 -0700 (PDT)
In-Reply-To: <20090915042612.GB1132@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello,

I have made some other working on this code, so I'll sync with your
differences and send you the complete code on monday, as it is in my
office computer.

Best Regards,

2009/9/15 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Raphael,
>
> On Thu, Aug 20, 2009 at 05:15:52PM -0300, Raphael Derosso Pereira wro=
te:
>> From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
>>
>> Initial version of AT42QT2160 Atmel Sensor Chip support. This versio=
n only
>> supports individual cells (no slide support yet). The code has been =
tested
>> on proprietary development ARM board, but should work fine on other =
machines.
>>
>> Signed-off-by: Raphael Derosso Pereira <raphaelpereira@gmail.com>
>
> This version is much better, thank you very much for making the chang=
es
> I requested.
>
>> +
>> +#define QT2160_CMD_CHIPID =A0 =A0(00)
>> +#define QT2160_CMD_CODEVER =A0 (01)
>> +#define QT2160_CMD_GSTAT =A0 =A0 (02)
>> +#define QT2160_CMD_KEYS3 =A0 =A0 (03)
>> +#define QT2160_CMD_KEYS4 =A0 =A0 (04)
>> +#define QT2160_CMD_SLIDE =A0 =A0 (05)
>> +#define QT2160_CMD_GPIOS =A0 =A0 (06)
>> +#define QT2160_CMD_SUBVER =A0 =A0(07)
>> +#define QT2160_CMD_CALIBRATE (10)
>
> I am a bit concerned about this chunk. The first 8 commands are writt=
en
> as octal while the last (calibrate) as decimal. Is this intentional?
>
> I also made a few more changes. Could you please trythe patch below a=
nd
> if everything is still working I will apply to my tree.
>
> Thanks!
>
> --
> Dmitry
>
> Input: AT42QT2160 - various fixups
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/keyboard/qt2160.c | =A0374 ++++++++++++++++++-------=
--------------
> =A01 files changed, 171 insertions(+), 203 deletions(-)
>
>
> diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard=
/qt2160.c
> index 1f9882b..c1b80da 100644
> --- a/drivers/input/keyboard/qt2160.c
> +++ b/drivers/input/keyboard/qt2160.c
> @@ -1,22 +1,22 @@
> =A0/*
> - =A0 =A0qt2160.c - Atmel AT42QT2160 Touch Sense Controller
> -
> - =A0 =A0Copyright (C) 2009 Raphael Derosso Pereira <raphaelpereira@g=
mail.com>
> -
> - =A0 =A0This program is free software; you can redistribute it and/o=
r modify
> - =A0 =A0it under the terms of the GNU General Public License as publ=
ished by
> - =A0 =A0the Free Software Foundation; either version 2 of the Licens=
e, or
> - =A0 =A0(at your option) any later version.
> -
> - =A0 =A0This program is distributed in the hope that it will be usef=
ul,
> - =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty =
of
> - =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See =
the
> - =A0 =A0GNU General Public License for more details.
> -
> - =A0 =A0You should have received a copy of the GNU General Public Li=
cense
> - =A0 =A0along with this program; if not, write to the Free Software
> - =A0 =A0Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> -*/
> + * qt2160.c - Atmel AT42QT2160 Touch Sense Controller
> + *
> + * =A0Copyright (C) 2009 Raphael Derosso Pereira <raphaelpereira@gma=
il.com>
> + *
> + * =A0This program is free software; you can redistribute it and/or =
modify
> + * =A0it under the terms of the GNU General Public License as publis=
hed by
> + * =A0the Free Software Foundation; either version 2 of the License,=
 or
> + * =A0(at your option) any later version.
> + *
> + * =A0This program is distributed in the hope that it will be useful=
,
> + * =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e
> + * =A0GNU General Public License for more details.
> + *
> + * =A0You should have received a copy of the GNU General Public Lice=
nse
> + * =A0along with this program; if not, write to the Free Software
> + * =A0Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
>
> =A0#include <linux/kernel.h>
> =A0#include <linux/init.h>
> @@ -27,117 +27,110 @@
> =A0#include <linux/irq.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/input.h>
> -#include <linux/mutex.h>
>
> -#define QT2160_VALID_CHIPID (0x11)
> +#define QT2160_VALID_CHIPID =A0 =A00x11
>
> -#define QT2160_CMD_CHIPID =A0 =A0(00)
> -#define QT2160_CMD_CODEVER =A0 (01)
> -#define QT2160_CMD_GSTAT =A0 =A0 (02)
> -#define QT2160_CMD_KEYS3 =A0 =A0 (03)
> -#define QT2160_CMD_KEYS4 =A0 =A0 (04)
> -#define QT2160_CMD_SLIDE =A0 =A0 (05)
> -#define QT2160_CMD_GPIOS =A0 =A0 (06)
> -#define QT2160_CMD_SUBVER =A0 =A0(07)
> -#define QT2160_CMD_CALIBRATE (10)
> +#define QT2160_CMD_CHIPID =A0 =A0 =A000
> +#define QT2160_CMD_CODEVER =A0 =A0 01
> +#define QT2160_CMD_GSTAT =A0 =A0 =A0 02
> +#define QT2160_CMD_KEYS3 =A0 =A0 =A0 03
> +#define QT2160_CMD_KEYS4 =A0 =A0 =A0 04
> +#define QT2160_CMD_SLIDE =A0 =A0 =A0 05
> +#define QT2160_CMD_GPIOS =A0 =A0 =A0 06
> +#define QT2160_CMD_SUBVER =A0 =A0 =A007
> +#define QT2160_CMD_CALIBRATE =A0 10
>
> =A0#define QT2160_CYCLE_INTERVAL =A0(HZ)
>
> -static unsigned char qt2160_key2code[] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 KEY_0, KEY_1, KEY_2, KEY_3,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 KEY_4, KEY_5, KEY_6, KEY_7,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 KEY_8, KEY_9, KEY_A, KEY_B,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 KEY_C, KEY_D, KEY_E, KEY_F,
> +static const unsigned short qt2160_keycodes[] =3D {
> + =A0 =A0 =A0 KEY_0, KEY_1, KEY_2, KEY_3,
> + =A0 =A0 =A0 KEY_4, KEY_5, KEY_6, KEY_7,
> + =A0 =A0 =A0 KEY_8, KEY_9, KEY_A, KEY_B,
> + =A0 =A0 =A0 KEY_C, KEY_D, KEY_E, KEY_F,
> =A0};
>
> =A0struct qt2160_data {
> - =A0 =A0 =A0 struct mutex mlock;
> =A0 =A0 =A0 =A0struct i2c_client *client;
> - =A0 =A0 =A0 struct delayed_work handle_work;
> - =A0 =A0 =A0 struct work_struct handle_irq_work;
> =A0 =A0 =A0 =A0struct input_dev *input;
> - =A0 =A0 =A0 u8 version_major;
> - =A0 =A0 =A0 u8 version_minor;
> - =A0 =A0 =A0 u8 version_rev;
> + =A0 =A0 =A0 struct delayed_work dwork;
> + =A0 =A0 =A0 spinlock_t lock; =A0 =A0 =A0 =A0/* Protects canceling/r=
escheduling of dwork */
> + =A0 =A0 =A0 unsigned short keycodes[ARRAY_SIZE(qt2160_keycodes)];
> =A0 =A0 =A0 =A0u16 key_matrix;
> =A0};
>
> =A0static int qt2160_read(struct i2c_client *client, u8 reg)
> =A0{
> - =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int error;
>
> - =A0 =A0 =A0 ret =3D i2c_smbus_write_byte(client, reg);
> - =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 error =3D i2c_smbus_write_byte(client, reg);
> + =A0 =A0 =A0 if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn=
't send request. Returned %d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn't send request.=
 Returned %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D i2c_smbus_read_byte(client);
> - =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 error =3D i2c_smbus_read_byte(client);
> + =A0 =A0 =A0 if (error < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn=
't read register. Returned %d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn't read register=
=2E Returned %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static int qt2160_write(struct i2c_client *client, u8 reg, u8 data=
)
> =A0{
> - =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int error;
>
> - =A0 =A0 =A0 ret =3D i2c_smbus_write_byte(client, reg);
> - =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 error =3D i2c_smbus_write_byte(client, reg);
> + =A0 =A0 =A0 if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn=
't send request. Returned %d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn't send request.=
 Returned %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D i2c_smbus_write_byte(client, data);
> - =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 error =3D i2c_smbus_write_byte(client, data);
> + =A0 =A0 =A0 if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn=
't write data. Returned %d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "couldn't write data. R=
eturned %d\n", error);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 return 0;
> =A0}
>
> -static int qt2160_get_key_matrix(struct i2c_client *client)
> +static int qt2160_get_key_matrix(struct qt2160_data *qt2160)
> =A0{
> - =A0 =A0 =A0 int ret, i;
> - =A0 =A0 =A0 struct qt2160_data *qt2160;
> + =A0 =A0 =A0 struct i2c_client *client =3D qt2160->client;
> + =A0 =A0 =A0 struct input_dev *input =3D qt2160->input;
> =A0 =A0 =A0 =A0u16 old_matrix;
> + =A0 =A0 =A0 int ret, i;
>
> =A0 =A0 =A0 =A0dev_dbg(&client->dev, "requesting keys...\n");
> - =A0 =A0 =A0 qt2160 =3D i2c_get_clientdata(client);
> - =A0 =A0 =A0 mutex_lock(&qt2160->mlock);
>
> =A0 =A0 =A0 =A0/* Read General Status Register */
> =A0 =A0 =A0 =A0ret =3D qt2160_read(client, QT2160_CMD_GSTAT);
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could =
not get general status register\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could not get general =
status register\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0old_matrix =3D qt2160->key_matrix;
>
> =A0 =A0 =A0 =A0ret =3D qt2160_read(client, QT2160_CMD_KEYS3);
> =A0 =A0 =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could =
not get keys from register 3\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "could not get ke=
ys from register 3\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0qt2160->key_matrix =3D ret;
>
> =A0 =A0 =A0 =A0ret =3D qt2160_read(client, QT2160_CMD_KEYS4);
> =A0 =A0 =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could =
not get keys from register 4\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "could not get ke=
ys from register 4\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0qt2160->key_matrix |=3D (ret << 8);
> @@ -145,199 +138,183 @@ static int qt2160_get_key_matrix(struct i2c_c=
lient *client)
> =A0 =A0 =A0 =A0/* Read slide and GPIOs to clear CHANGE pin */
> =A0 =A0 =A0 =A0ret =3D qt2160_read(client, QT2160_CMD_SLIDE);
> =A0 =A0 =A0 =A0if (ret < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "could =
not get slide status\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "could not get sl=
ide status\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ret =3D qt2160_read(client, QT2160_CMD_GPIOS);
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "could not get G=
PIOs\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unlock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 16; ++i) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int keyval =3D (qt2160->key_matrix >> =
i) & 0x01;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (((old_matrix >> i) & 0x01) !=3D ke=
yval) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(qt2160=
->input,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsig=
ned char *)qt2160->input->keycode)[i],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keyval)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(qt2160->inpu=
t);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (keyval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&client->dev, "key %d pressed\n", i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&client->dev, "key %d released\n", i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&client->dev, "=
key %d %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, keyv=
al ? "pressed" : "released");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 qt2160->keycodes[i], keyval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mutex_unlock(&qt2160->mlock);
> =A0 =A0 =A0 =A0return 0;
> -
> -err_unlock:
> - =A0 =A0 =A0 mutex_unlock(&qt2160->mlock);
> - =A0 =A0 =A0 return ret;
> =A0}
>
> =A0static irqreturn_t qt2160_irq(int irq, void *_qt2160)
> =A0{
> =A0 =A0 =A0 =A0struct qt2160_data *qt2160 =3D _qt2160;
> + =A0 =A0 =A0 unsigned long flags;
>
> - =A0 =A0 =A0 schedule_work(&qt2160->handle_irq_work);
> - =A0 =A0 =A0 return IRQ_HANDLED;
> -}
> + =A0 =A0 =A0 spin_lock_irqsave(&qt2160->lock, flags);
>
> -static void qt2160_worker(struct work_struct *work)
> -{
> - =A0 =A0 =A0 struct qt2160_data *qt2160;
> + =A0 =A0 =A0 __cancel_delayed_work(&qt2160->dwork);
> + =A0 =A0 =A0 schedule_delayed_work(&qt2160->dwork, 0);
>
> - =A0 =A0 =A0 qt2160 =3D container_of(work, struct qt2160_data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_irq_work);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&qt2160->lock, flags);
>
> - =A0 =A0 =A0 dev_dbg(&qt2160->client->dev, "irq worker\n");
> - =A0 =A0 =A0 qt2160_get_key_matrix(qt2160->client);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> =A0}
>
> -static void qt2160_cycle_worker(struct work_struct *work)
> +static void qt2160_worker(struct work_struct *work)
> =A0{
> - =A0 =A0 =A0 struct qt2160_data *qt2160;
> + =A0 =A0 =A0 struct qt2160_data *qt2160 =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct qt2160_data, =
dwork.work);
>
> - =A0 =A0 =A0 qt2160 =3D container_of(work, struct qt2160_data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_work.work);
> + =A0 =A0 =A0 dev_dbg(&qt2160->client->dev, "worker\n");
>
> - =A0 =A0 =A0 dev_dbg(&qt2160->client->dev, "cycling worker\n");
> - =A0 =A0 =A0 qt2160_get_key_matrix(qt2160->client);
> + =A0 =A0 =A0 qt2160_get_key_matrix(qt2160);
>
> =A0 =A0 =A0 =A0/* Avoid lock checking every 500ms */
> - =A0 =A0 =A0 schedule_delayed_work(&qt2160->handle_work, QT2160_CYCL=
E_INTERVAL);
> + =A0 =A0 =A0 spin_lock_irq(&qt2160->lock);
> + =A0 =A0 =A0 schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTE=
RVAL);
> + =A0 =A0 =A0 spin_unlock_irq(&qt2160->lock);
> =A0}
>
> -static int __devinit qt2160_probe(struct i2c_client *client,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_id *id)
> -{
> - =A0 =A0 =A0 int ret, i;
> - =A0 =A0 =A0 struct qt2160_data *qt2160;
>
> - =A0 =A0 =A0 dev_info(&client->dev, "probing device...\n");
> +static bool __devinit qt2160_identify(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 int id, ver, rev;
>
> =A0 =A0 =A0 =A0/* Read Chid ID to check if chip is valid */
> - =A0 =A0 =A0 ret =3D qt2160_read(client, QT2160_CMD_CHIPID);
> - =A0 =A0 =A0 if (ret !=3D QT2160_VALID_CHIPID) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "ID %d not suppor=
ted\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 id =3D qt2160_read(client, QT2160_CMD_CHIPID);
> + =A0 =A0 =A0 if (id !=3D QT2160_VALID_CHIPID) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "ID %d not suppor=
ted\n", id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Chip is valid and active. Allocate structure */
> - =A0 =A0 =A0 qt2160 =3D kzalloc(sizeof(struct qt2160_data), GFP_KERN=
EL);
> - =A0 =A0 =A0 if (!qt2160) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "insufficient mem=
ory\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 i2c_set_clientdata(client, qt2160);
> - =A0 =A0 =A0 qt2160->client =3D client;
> -
> =A0 =A0 =A0 =A0/* Read chip firmware version */
> - =A0 =A0 =A0 ret =3D qt2160_read(client, QT2160_CMD_CODEVER);
> - =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 ver =3D qt2160_read(client, QT2160_CMD_CODEVER);
> + =A0 =A0 =A0 if (ver < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "could not get f=
irmware version\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_qtdata;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 qt2160->version_major =3D ret >> 4;
> - =A0 =A0 =A0 qt2160->version_minor =3D ret & 0xf;
> -
> =A0 =A0 =A0 =A0/* Read chip firmware revision */
> - =A0 =A0 =A0 ret =3D qt2160_read(client, QT2160_CMD_SUBVER);
> - =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 rev =3D qt2160_read(client, QT2160_CMD_SUBVER);
> + =A0 =A0 =A0 if (rev < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev, "could not get f=
irmware revision\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_qtdata;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 qt2160->version_rev =3D ret;
> -
> =A0 =A0 =A0 =A0dev_info(&client->dev, "AT42QT2160 firmware version %d=
=2E%d.%d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qt2160->version_major, =
qt2160->version_minor,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qt2160->version_rev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ver >> 4, ver &0xf, rev);
>
> - =A0 =A0 =A0 /* Calibrate device */
> - =A0 =A0 =A0 ret =3D qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
> - =A0 =A0 =A0 if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed to calibrate de=
vice\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 return true;
> +}
>
> - =A0 =A0 =A0 /* Initialize input structure */
> - =A0 =A0 =A0 qt2160->input =3D input_allocate_device();
> - =A0 =A0 =A0 if (!qt2160->input) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "input device: No=
t enough memory\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_qtdata;
> - =A0 =A0 =A0 }
> +static int __devinit qt2160_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con=
st struct i2c_device_id *id)
> +{
> + =A0 =A0 =A0 struct qt2160_data *qt2160;
> + =A0 =A0 =A0 struct input_dev *input;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int error;
>
> - =A0 =A0 =A0 qt2160->input->name =3D "AT42QT2160 Touch Sense Keyboar=
d";
> - =A0 =A0 =A0 qt2160->input->id.bustype =3D BUS_I2C;
> - =A0 =A0 =A0 qt2160->input->keycode =3D qt2160_key2code;
> - =A0 =A0 =A0 qt2160->input->keycodesize =3D sizeof(unsigned char);
> - =A0 =A0 =A0 qt2160->input->keycodemax =3D ARRAY_SIZE(qt2160_key2cod=
e);
> + =A0 =A0 =A0 dev_dbg(&client->dev, "probing device...\n");
>
> - =A0 =A0 =A0 __set_bit(EV_KEY, qt2160->input->evbit);
> - =A0 =A0 =A0 __clear_bit(EV_REP, qt2160->input->evbit);
> - =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(qt2160_key2code); i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(qt2160_key2code[i], qt2160->i=
nput->keybit);
> + =A0 =A0 =A0 if (!qt2160_identify(client))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> - =A0 =A0 =A0 ret =3D input_register_device(qt2160->input);
> - =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 /* Calibrate device */
> + =A0 =A0 =A0 error =3D qt2160_write(client, QT2160_CMD_CALIBRATE, 1)=
;
> + =A0 =A0 =A0 if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "input device: Failed t=
o register device\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed to calibrate de=
vice\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Initialize IRQ structure */
> - =A0 =A0 =A0 mutex_init(&qt2160->mlock);
> + =A0 =A0 =A0 /* Chip is valid and active. Allocate structures */
> + =A0 =A0 =A0 qt2160 =3D kzalloc(sizeof(struct qt2160_data), GFP_KERN=
EL);
> + =A0 =A0 =A0 input =3D input_allocate_device();
> + =A0 =A0 =A0 if (!qt2160 || !input) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "insufficient mem=
ory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 INIT_DELAYED_WORK(&qt2160->handle_work, qt2160_cycle_wo=
rker);
> - =A0 =A0 =A0 INIT_WORK(&qt2160->handle_irq_work, qt2160_worker);
> - =A0 =A0 =A0 schedule_delayed_work(&qt2160->handle_work, QT2160_CYCL=
E_INTERVAL);
> + =A0 =A0 =A0 qt2160->client =3D client;
> + =A0 =A0 =A0 qt2160->input =3D input;
> + =A0 =A0 =A0 INIT_DELAYED_WORK(&qt2160->dwork, qt2160_worker);
> + =A0 =A0 =A0 spin_lock_init(&qt2160->lock);
> +
> + =A0 =A0 =A0 input->name =3D "AT42QT2160 Touch Sense Keyboard";
> + =A0 =A0 =A0 input->id.bustype =3D BUS_I2C;
> +
> + =A0 =A0 =A0 input->keycode =3D qt2160->keycodes;
> + =A0 =A0 =A0 input->keycodesize =3D sizeof(qt2160->keycodes[0]);
> + =A0 =A0 =A0 input->keycodemax =3D ARRAY_SIZE(qt2160->keycodes);
> +
> + =A0 =A0 =A0 __set_bit(EV_KEY, input->evbit);
> + =A0 =A0 =A0 __clear_bit(EV_REP, input->evbit);
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(qt2160_keycodes); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qt2160->keycodes[i] =3D qt2160_keycodes=
[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(qt2160_keycodes[i], input->ke=
ybit);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (client->irq) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(client->irq, qt2160=
_irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (IR=
QF_TRIGGER_FALLING), "qt2160", qt2160);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D request_irq(client->irq, qt21=
60_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 IRQF_TRIGGER_FALLING, "qt2160", qt2160);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 to allocate irq %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client-=
>irq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 to allocate irq %d\n", client->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 dev_info(&client->dev, "AT42QT2160 reset completed\n");
> + =A0 =A0 =A0 error =3D input_register_device(qt2160->input);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "failed to regist=
er input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTE=
RVAL);
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, qt2160);
> =A0 =A0 =A0 =A0return 0;
>
> -err_free_input:
> +err_free_irq:
> + =A0 =A0 =A0 if (client->irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(client->irq, qt2160);
> +err_free_mem:
> =A0 =A0 =A0 =A0input_free_device(qt2160->input);
> -
> -err_free_qtdata:
> =A0 =A0 =A0 =A0kfree(qt2160);
> - =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> - =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 return error;
> =A0}
>
> =A0static int __devexit qt2160_remove(struct i2c_client *client)
> =A0{
> - =A0 =A0 =A0 struct qt2160_data *qt2160;
> -
> - =A0 =A0 =A0 qt2160 =3D i2c_get_clientdata(client);
> + =A0 =A0 =A0 struct qt2160_data *qt2160 =3D i2c_get_clientdata(clien=
t);
>
> =A0 =A0 =A0 =A0/* Release IRQ so no queue will be scheduled */
> - =A0 =A0 =A0 free_irq(client->irq, qt2160);
> + =A0 =A0 =A0 if (client->irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(client->irq, qt2160);
>
> - =A0 =A0 =A0 /* Wait all pending works */
> - =A0 =A0 =A0 cancel_delayed_work_sync(&qt2160->handle_work);
> - =A0 =A0 =A0 cancel_work_sync(&qt2160->handle_irq_work);
> + =A0 =A0 =A0 /* Wait for delayed work to complete */
> + =A0 =A0 =A0 cancel_delayed_work_sync(&qt2160->dwork);
>
> =A0 =A0 =A0 =A0/* Unregister input device */
> =A0 =A0 =A0 =A0input_unregister_device(qt2160->input);
> @@ -346,7 +323,6 @@ static int __devexit qt2160_remove(struct i2c_cli=
ent *client)
> =A0 =A0 =A0 =A0kfree(qt2160);
> =A0 =A0 =A0 =A0i2c_set_clientdata(client, NULL);
>
> - =A0 =A0 =A0 dev_info(&client->dev, "AT42QT2160 removed.\n");
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -365,20 +341,12 @@ static struct i2c_driver qt2160_driver =3D {
>
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D qt2160_idtable,
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D qt2160_probe,
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D qt2160_remove,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(qt2160_remove),
> =A0};
>
> =A0static int __init qt2160_init(void)
> =A0{
> - =A0 =A0 =A0 int res;
> -
> - =A0 =A0 =A0 res =3D i2c_add_driver(&qt2160_driver);
> - =A0 =A0 =A0 if (res) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "qt2160: Driver registr=
ation failed, "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "module=
 not inserted.\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return res;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return i2c_add_driver(&qt2160_driver);
> =A0}
>
> =A0static void __exit qt2160_cleanup(void)
>



--=20
Raphael Derosso Pereira
Engenheiro de Computa=E7=E3o
msn: rderossopereira@hotmail.com
Skype: rderossopereira
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
