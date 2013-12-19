From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] iio: ti_am335x_adc: adjust the closing bracket in
 tiadc_read_raw()
Date: Thu, 19 Dec 2013 08:49:46 +0000
Message-ID: <20131219084946.GE2621@lee--X1>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
 <1387385577-24447-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:42841 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3LSItv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Dec 2013 03:49:51 -0500
Received: by mail-we0-f180.google.com with SMTP id t61so719944wes.25
        for <linux-input@vger.kernel.org>; Thu, 19 Dec 2013 00:49:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387385577-24447-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Dec 2013, Sebastian Andrzej Siewior wrote:

> It somehow looks like the ending bracket belongs to the if statement =
but
> it does belong to the while loop. This patch moves the bracket where =
it
> belongs.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Lee Jones <lee.jones@linaro.org>

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
