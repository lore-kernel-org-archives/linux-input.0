From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5] mfd: ti_am335x_tscadc: don't read back REG_SE
Date: Thu, 19 Dec 2013 08:56:07 +0000
Message-ID: <20131219085607.GG2621@lee--X1>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
 <1387385577-24447-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387385577-24447-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Zubair Lutfullah <zubair.lutfullah@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Dec 2013, Sebastian Andrzej Siewior wrote:

> The purpose of reg_se_cache has been defeated. It should avoid the
> read-back of the register to avoid the latency and the fact that the
> bits are reset to 0 after the individual conversation took place.
>=20
> The reason why this is required like this to work, is that read-back =
of
> the register removes the bits of the ADC so they do not start another
> conversation after the register is re-written from the TSC side for t=
he
> update.
> To avoid the unrequired read-back I introduce a "set adc" variant whi=
ch
> does not update the cache mask. After the conversation completes, the
> register bit is removed from the SE reister anyway and we don't plan =
a
> new conversation "any time soon".
> This is a small preparation for a larger sync-rework.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c      |  2 +-
>  drivers/mfd/ti_am335x_tscadc.c       | 12 ++++++++++--
>  include/linux/mfd/ti_am335x_tscadc.h |  1 +
>  3 files changed, 12 insertions(+), 3 deletions(-)

Looks about right: Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
