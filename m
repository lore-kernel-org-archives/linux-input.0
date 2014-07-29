From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 6/7] mfd: cros_ec: Instantiate sub-devices from device
 tree
Date: Tue, 29 Jul 2014 15:28:00 +0200
Message-ID: <53D7A160.7010801@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk> <1406549967-21291-7-git-send-email-javier.martinez@collabora.co.uk> <53D794E1.1090003@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53D794E1.1090003@suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Andreas,

On 07/29/2014 02:34 PM, Andreas F=E4rber wrote:
> Hi Javier,
>=20
> Am 28.07.2014 14:19, schrieb Javier Martinez Canillas:
>> From: Todd Broch <tbroch@chromium.org>
>>=20
>> If the EC device tree node has sub-nodes, try to instantiate them as
>> MFD sub-devices.  We can configure the EC features provided by the b=
oard.
>>=20
>> Signed-off-by: Todd Broch <tbroch@chromium.org>
>=20
> This is provoking the blunt question: What sub-devices is it good for=
?
> I.e., do you have a matching DT patchset that adds such devices?
>=20

=46or Peach Pit and Pi, the matching DTS changes is [0]. But answering =
your
question it is to instantiate the subdevices that can be child nodes of=
 either
cros-ec-spi or cros-ec-i2c. So for the devices that are directly connec=
ted to
the EC Cortex-M through i2c.

> In particular I'm wondering whether that would help with the tps65090=
 on
> Spring? It's a "power-regulator" sub-node of cros-ec in 3.8.
>=20

Spring is a little more complicated since the EC in Spring don't have t=
he full
EC_CMD_I2C_PASSTHRU. So the downstream Chrome OS 3.8 kernel has a forke=
d
tps65090 driver (drivers/regulator/cros_ec-tps65090.c) that talks direc=
tly with
the cros_ec MFD driver, you can get more info from [1] in the "About Sp=
ring"
section.

> Thanks,
> Andreas
>=20

Best regards,
Javier

[0]:
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/co=
mmit/?h=3Dfor-next&id=3D8060098bbb564d27a287057a93d4fe3bfd266290
[1]: http://code.google.com/p/chromium/issues/detail?id=3D391797
