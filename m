From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Thu, 2 Aug 2018 09:35:06 +0100
Message-ID: <20180802083506.GO4662@dell>
References: <cover.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
 <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <77184f651e5cefb112f1061bc682b759f88144c6.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com, linus.walleij@linaro.org, mazziesaccount@gmail.com, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

On Mon, 30 Jul 2018, Matti Vaittinen wrote:

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
>  drivers/mfd/rohm-bd718x7.c       | 208 ++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd718x7.h | 332 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 554 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd718x7.c
>  create mode 100644 include/linux/mfd/rohm-bd718x7.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
