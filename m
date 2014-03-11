From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2] input: misc: da9063: OnKey driver
Date: Tue, 11 Mar 2014 07:20:19 +0000
Message-ID: <20140311072019.GI2839@lee--X1>
References: <201403101740.s2AHebta017785@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:59538 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbaCKHUY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2014 03:20:24 -0400
Received: by mail-wg0-f43.google.com with SMTP id x13so9824732wgg.14
        for <linux-input@vger.kernel.org>; Tue, 11 Mar 2014 00:20:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201403101740.s2AHebta017785@swsrvapps-01.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>, LKML-INPUT <linux-input@vger.kernel.org>, LKML-KERNEL <linux-kernel@vger.kernel.org>, Mark Brown <broonie@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>

> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
>=20
> Add the OnKey driver for DA9063
>=20
> Plus some minor dependencies:
> - Addition of "ONKEY" name to OnKey IRQ resource structure;
> - Bool key_power platform data driver configuration option.
>=20
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.co=
m>
> ---
>=20
>  drivers/input/misc/Kconfig        |   10 ++
>  drivers/input/misc/Makefile       |    1 +
>  drivers/input/misc/da9063-onkey.c |  209 +++++++++++++++++++++++++++=
++++++++++
>  drivers/mfd/da9063-core.c         |    1 +
>  include/linux/mfd/da9063/pdata.h  |    1 +

=46or the MFD parts:
  Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
