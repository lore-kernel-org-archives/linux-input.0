From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/4] input: mc13783: Add MC13892 support
Date: Mon, 10 Feb 2014 11:23:50 +0000
Message-ID: <20140210112350.GC21522@lee--X1>
References: <1392006148-10417-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:43941 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbaBJLX4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Feb 2014 06:23:56 -0500
Received: by mail-wi0-f177.google.com with SMTP id e4so2676533wiv.10
        for <linux-input@vger.kernel.org>; Mon, 10 Feb 2014 03:23:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392006148-10417-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>

> This patch adds support for MC13892 PMIC to mc13783-pwrbutton driver.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/input/misc/Kconfig             | 4 ++--
>  drivers/input/misc/mc13783-pwrbutton.c | 8 ++++++++
>  include/linux/mfd/mc13892.h            | 4 ++++

=46or the MFD changes:
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
