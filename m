From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/4] input: ti_tsc: Enable shared IRQ for TSC and add
 overrun, underflow checks
Date: Tue, 13 Aug 2013 18:07:34 +0100
Message-ID: <20130813170734.GJ15278@lee--X1>
References: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376412499-21007-4-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1376412499-21007-4-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

On Tue, 13 Aug 2013, Zubair Lutfullah wrote:

> Enable shared IRQ to allow ADC to share IRQ line from
> parent MFD core. Only FIFO0 IRQs are for TSC and handled
> on the TSC side.
>=20
> Patch also adds overrun and underflow irq handlers.
>=20
> Russ Dill (TI) worked on overrun and underflow handlers.
> Rachna Patil (TI) laid ground work for shared IRQ.
>=20
> Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c |   37 +++++++++++++++++++=
++++++----
>  include/linux/mfd/ti_am335x_tscadc.h      |    2 ++
>  2 files changed, 34 insertions(+), 5 deletions(-)

=46or the MFD part when the remainder of the entries have been placed i=
n
order:

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
