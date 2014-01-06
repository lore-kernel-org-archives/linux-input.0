From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] iio: ti_am335x_adc: Adjust the closing bracket in
 tiadc_read_raw()
Date: Mon, 6 Jan 2014 09:36:02 +0000
Message-ID: <20140106093602.GF23772@lee--X1>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
 <1387466911-3732-2-git-send-email-bigeasy@linutronix.de>
 <52B71973.1000907@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58937 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaAFJgH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jan 2014 04:36:07 -0500
Received: by mail-wi0-f178.google.com with SMTP id bz8so2566216wib.11
        for <linux-input@vger.kernel.org>; Mon, 06 Jan 2014 01:36:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52B71973.1000907@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 22 Dec 2013, Jonathan Cameron wrote:

> On 12/19/13 15:28, Sebastian Andrzej Siewior wrote:
> > It somehow looks like the ending bracket belongs to the if statemen=
t but
> > it does belong to the while loop. This patch moves the bracket wher=
e it
> > belongs.
> >=20
> > Reviewed-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>=20
> Lee, I'm assuming you are fine taking the whole series!

Sure, no problem.

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
