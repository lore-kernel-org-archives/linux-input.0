From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/5] mfd: input: iio: ti_amm335x: Rework TSC/ADC
 synchronization
Date: Thu, 19 Dec 2013 17:18:23 +0000
Message-ID: <20131219171823.GC16145@lee--X1>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
 <1387466911-3732-6-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:52753 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3LSRS3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Dec 2013 12:18:29 -0500
Received: by mail-wg0-f43.google.com with SMTP id k14so1360902wgh.34
        for <linux-input@vger.kernel.org>; Thu, 19 Dec 2013 09:18:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387466911-3732-6-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 19 Dec 2013, Sebastian Andrzej Siewior wrote:

> The ADC driver always programs all possible ADC values and discards
> them except for the value IIO asked for. On the am335x-evm the driver
> programs four values and it takes 500us to gather them. Reducing the =
number
> of conversations down to the (required) one also reduces the busy loo=
p down
> to 125us.
>=20
> This leads to another error, namely the FIFOCOUNT register is sometim=
es
> (like one out of 10 attempts) not updated in time leading to EBUSY.
> The next read has the FIFOCOUNT register updated.
> Checking for the ADCSTAT register for being idle isn't a good choice =
either.
> The problem is that if TSC is used at the same time, the HW completes=
 the
> conversation for ADC *and* before the driver noticed it, the HW begin=
s to
> perform a TSC conversation and so the driver never seen the HW idle. =
The
> next time we would have two values in the FIFO but since the driver r=
eads
> everything we always see the current one.
> So instead of polling for the IDLE bit in ADCStatus register, we shou=
ld
> check the FIFOCOUNT register. It should be one instead of zero becaus=
e we
> request one value.
>=20
> This change in turn leads to another error. Sometimes if TSC & ADC ar=
e
> used together the TSC starts becoming interrupts even if nobody
> actually touched the touchscreen. The interrupts seem valid because T=
SC's
> FIFO is filled with values for each channel of the TSC. This conditio=
n stops
> after a few ADC reads but will occur again. Not good.
>=20
> On top of this (even without the changes I just mentioned) there is a=
 ADC
> & TSC lockup condition which was reported to me by Jeff Lance includi=
ng the
> following test case:
> A busy loop of "cat /sys/bus/iio/devices/iio\:device0/in_voltage4_raw=
"
> and a mug on touch screen. With this setup, the hardware will lockup =
after
> something between 20 minutes and it could take up to a couple of hour=
s.
> During that lockup, the ADCSTAT register says 0x30 (or 0x70) which me=
ans
> STEP_ID =3D IDLE and FSM_BUSY =3D yes. That means the hardware says t=
hat it is
> idle and busy at the same time which is an invalid condition.
>=20
> For all this reasons I decided to rework this TSC/ADC part and add a
> handshake / synchronization here:
> First the ADC signals that it needs the HW and writes a 0 mask into t=
he
> SE register. The HW (if active) will complete the current conversatio=
n
> and become idle. The TSC driver will gather the values from the FIFO
> (woken up by an interrupt) and won't "enable" another conversation.
> Instead it will wake up the ADC driver which is already waiting. The =
ADC
> driver will start "its" conversation and once it is done, it will
> enable the TSC steps so the TSC will work again.
>=20
> After this rework I haven't observed the lockup so far. Plus the busy
> loop has been reduced from 500us to 125us.
>=20
> The continues-read mode remains unchanged.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c      | 64 ++++++++++++++++++++++++++=
----------
>  drivers/mfd/ti_am335x_tscadc.c       | 63 ++++++++++++++++++++++++++=
+++------
>  include/linux/mfd/ti_am335x_tscadc.h |  4 +++

Assuming nothing else has changed since the answers you gave me:
  Acked-by: Lee Jones <lee.jones@linaro.org>

Once we have the remaining Acks I'll happily apply this patch-set.

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
