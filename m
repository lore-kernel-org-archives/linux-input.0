From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v12 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Thu, 16 Aug 2018 10:06:10 +0100
Message-ID: <20180816090610.GC10054@dell>
References: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
 <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com, linus.walleij@linaro.org, mazziesaccount@gmail.com, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Fri, 03 Aug 2018, Matti Vaittinen wrote:

> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/mfd/Kconfig              |  13 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd718x7.c       | 211 +++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd718x7.h | 332 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 557 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd718x7.c
>  create mode 100644 include/linux/mfd/rohm-bd718x7.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
