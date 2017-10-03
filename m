From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Regulator] Request for clarification - GPIO controlled
 regulator, USB VBUS,
Date: Tue, 3 Oct 2017 12:16:41 -0700
Message-ID: <CAKdAkRSB4wAx1CnaQKFq2jdvmk15NisWegYbS1iHqMOgvothKg@mail.gmail.com>
References: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36904 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdJCTQn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Oct 2017 15:16:43 -0400
In-Reply-To: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <l.majewski@majess.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

Hi =C5=81ukasz,

On Tue, Oct 3, 2017 at 9:58 AM, =C5=81ukasz Majewski <l.majewski@majess.pl>=
 wrote:
> Dear All,
>
> Maybe somebody could shed some light to following issue:
>
> On my setup I do have USB connected touchscreen powered from VBUS.
>
> The VBUS power is controlled by a GPIO pin, which in turn is governed by
> regulator API:
>
>         reg_usbh1_vbus: usb-h1-vbus {
>                 compatible =3D "regulator-fixed";
>                 gpio =3D <&gpio3 31 GPIO_ACTIVE_LOW>;
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&pinctrl_usbh1_vbus>;
>                 regulator-name =3D "usb_h1_vbus";
>                 regulator-min-microvolt =3D <5000000>;
>                 regulator-max-microvolt =3D <5000000>;
>                 regulator-settling-time-us =3D <100000>;
>         };
>
>
> This regulator is then passed to USB controller:
>
> &usbh1 {
>         vbus-supply =3D <&reg_usbh1_vbus>;
>
> }
>
> The regulator API starts VBUS -> USB host get info about the VBUS present
> and starts enumeration of the USB device.
>
>
> I would like to ask if there is any recommended way to remove VBUS power =
and
> have a way to force from user space the touchscreen (re-)enumeration?
>
> As fair as I know the Regulator API is RO on purpose, so I cannot toggle
> vbus from there.
>
> I could use hacks presented here (the userspace-regulator API):
> https://patchwork.ozlabs.org/patch/374912/
> https://lkml.org/lkml/2014/7/30/357
>
> but for some reason they did not find the way to the upstream. Also it se=
ems
> like such approach is for testing, not for production system.
>
>
> I could write a "dummy" regulator driver, which would export control API =
to
> /dev/sys/proc.
> Something like:
> http://elixir.free-electrons.com/linux/latest/source/drivers/usb/phy/phy-=
fsl-usb.c
>
> (but with opposite way).
>
> or ./drivers/input/misc/regulator-haptic.c
>
>
> I've also tried the "usb" power control tricks;
>
> echo "0" > /sys/bus/usb/devices/usb1/power/autosuspend_delay_ms
> echo "auto" > /sys/bus/usb/devices/usb1/power/control
>
> But without any effect (probably because of above dependencies).
>
>
>
> Have I overlooked something? Maybe there is any other mainline code, whic=
h I
> could reuse?
>
>
> My goal is to reuse as much as possible from ML and avoid developing any =
new
> code :-)
>

Please start from the beginning: it is not quite clear why you want
the touchscreen to be re-enumerated.

Thanks.

--=20
Dmitry
