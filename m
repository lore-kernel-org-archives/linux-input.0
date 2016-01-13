From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Wed, 13 Jan 2016 00:31:11 -0800
Message-ID: <CAKdAkRRJrexxyYHHS5_KnmXaxWdJ5W4Of6iQRzZsMBhT3xFQuA@mail.gmail.com>
References: <1452671352-792-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33932 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbcAMIbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 03:31:12 -0500
In-Reply-To: <1452671352-792-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Lin <yajohn@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Doug Anderson <dianders@chromium.org>, Benson Leung <bleung@chromium.org>, Scott Liu <scott.liu@emc.com.tw>, "jeffrey.lin" <jeffrey.lin@rad-ic.com>, roger.yang@rad-ic.com, KP.li@rad-ic.com, lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Jeffrey,

On Tue, Jan 12, 2016 at 11:49 PM, Jeffrey Lin <yajohn@gmail.com> wrote:
> This patch is porting Raydium I2C touch driver. Developer can enable =
raydium touch driver by modifying define
> "CONFIG_TOUCHSCREEN_RM_TS".
>
> Signed-off-by: jeffrey.lin<jeffrey.lin@rad-ic.com>
> ---
>  drivers/input/touchscreen/Kconfig      |  12 +
>  drivers/input/touchscreen/Makefile     |   1 +
>  drivers/input/touchscreen/rm31100_ts.c | 772 +++++++++++++++++++++++=
++++++++++
>  3 files changed, 785 insertions(+)
>  create mode 100644 drivers/input/touchscreen/rm31100_ts.c

Thank you for sending the full patch. Unfortunately it does not even co=
mpile:

dtor@dtor-ws:~/kernel/work$ make drivers/input/touchscreen/rm31100_ts.o
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CC [M]  drivers/input/touchscreen/rm31100_ts.o
drivers/input/touchscreen/rm31100_ts.c: In function =E2=80=98rm_fw_vers=
ion_show=E2=80=99:
drivers/input/touchscreen/rm31100_ts.c:190:7: error: request for
member =E2=80=98u8_version=E2=80=99 in something not a structure or uni=
on
   info.u8_version,
       ^
drivers/input/touchscreen/rm31100_ts.c:191:7: error: request for
member =E2=80=98u8_sub_version=E2=80=99 in something not a structure or=
 union
   info.u8_sub_version);
       ^
drivers/input/touchscreen/rm31100_ts.c: In function =E2=80=98rm_ts_powe=
r_on=E2=80=99:
drivers/input/touchscreen/rm31100_ts.c:304:2: error: implicit
declaration of function =E2=80=98regulator_enable=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  error =3D regulator_enable(ts->avdd);
  ^
drivers/input/touchscreen/rm31100_ts.c:317:3: error: implicit
declaration of function =E2=80=98regulator_disable=E2=80=99
[-Werror=3Dimplicit-function-declaration]
   regulator_disable(ts->dvdd);
   ^
drivers/input/touchscreen/rm31100_ts.c: In function =E2=80=98rm31100_ts=
_suspend=E2=80=99:
drivers/input/touchscreen/rm31100_ts.c:392:6: warning: unused variable
=E2=80=98rc=E2=80=99 [-Wunused-variable]
  int rc =3D 0;
      ^
drivers/input/touchscreen/rm31100_ts.c: In function =E2=80=98rm31100_ts=
_probe=E2=80=99:
drivers/input/touchscreen/rm31100_ts.c:581:2: error: implicit
declaration of function =E2=80=98devm_regulator_get=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  ts->avdd =3D devm_regulator_get(&client->dev, "avdd");
  ^
drivers/input/touchscreen/rm31100_ts.c:581:11: warning: assignment
makes pointer from integer without a cast [enabled by default]
  ts->avdd =3D devm_regulator_get(&client->dev, "avdd");
           ^
drivers/input/touchscreen/rm31100_ts.c:591:11: warning: assignment
makes pointer from integer without a cast [enabled by default]
  ts->dvdd =3D devm_regulator_get(&client->dev, "dvdd");
           ^
drivers/input/touchscreen/rm31100_ts.c:601:2: error: too few arguments
to function =E2=80=98devm_gpiod_get=E2=80=99
  ts->resout_gpio =3D devm_gpiod_get(&client->dev, "rm31100_resout_gpio=
");
  ^
In file included from drivers/input/touchscreen/rm31100_ts.c:31:0:
include/linux/gpio/consumer.h:73:32: note: declared here
 struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
                                ^
drivers/input/touchscreen/rm31100_ts.c:664:61: error: =E2=80=98err=E2=80=
=99 undeclared
(first use in this function)
   dev_err(&client->dev, "%s crated failed, %d\n", __func__, err);
                                                             ^
drivers/input/touchscreen/rm31100_ts.c:664:61: note: each undeclared
identifier is reported only once for each function it appears in
drivers/input/touchscreen/rm31100_ts.c: In function =E2=80=98rm31100_ts=
_init=E2=80=99:
drivers/input/touchscreen/rm31100_ts.c:754:4: error:
=E2=80=98driver_attr_myAttr=E2=80=99 undeclared (first use in this func=
tion)
   &driver_attr_myAttr);
    ^
drivers/input/touchscreen/rm31100_ts.c: At top level:
drivers/input/touchscreen/rm31100_ts.c:172:12: warning:
=E2=80=98rm31100_ts_write=E2=80=99 defined but not used [-Wunused-funct=
ion]
 static int rm31100_ts_write(struct i2c_client *client, u8 *buf, int nu=
m)
            ^
drivers/input/touchscreen/rm31100_ts.c: In function =E2=80=98rm_fw_vers=
ion_show=E2=80=99:
drivers/input/touchscreen/rm31100_ts.c:192:1: warning: control reaches
end of non-void function [-Wreturn-type]
 }
 ^
cc1: some warnings being treated as errors
make[1]: *** [drivers/input/touchscreen/rm31100_ts.o] Error 1
make: *** [drivers/input/touchscreen/rm31100_ts.o] Error 2
dtor@dtor-ws:~/kernel/work$

Please next time submit version that you actually tested.

Thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
