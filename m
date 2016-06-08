From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/8] TI AM335x TSC/ADC cleanup
Date: Wed, 8 Jun 2016 16:36:42 +0100
Message-ID: <20160608153642.GW14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531170013.2649-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> Hello all,
>=20
> This series is a group of non-functional changes I would
> like to get in this cycle to prepare some regmap based
> changes I would like to make next cycle. Hopefully the
> churn can be seen as more useful in that case.

Once you've finished spell checking all of your commits, please submit
with the Acks you have collected.

> Andrew F. Davis (8):
>   mfd: ti_am335x_tscadc: Use SIMPLE_DEV_PM_OPS helper macro
>   iio: adc: ti_am335x_adc: use SIMPLE_DEV_PM_OPS helper macro
>   mfd: ti_am335x_tscadc: Remove use of single line functions
>   mfd: ti_am335x_tscadc: Unify variable naming when refrencing
>     ti_tscadc_dev
>   mfd: ti_am335x_tscadc: Rename regmap_tscadc to regmap
>   mfd: ti_am335x_tscadc: use variable name for sizeof() operator
>   iio: adc: ti_am335x_adc: use variable names for sizeof() operator
>   Input: ti_am335x_tsc - use variable name for sizeof() operator
>=20
>  drivers/iio/adc/ti_am335x_adc.c           |  22 ++---
>  drivers/input/touchscreen/ti_am335x_tsc.c |   2 +-
>  drivers/mfd/ti_am335x_tscadc.c            | 135 +++++++++++++-------=
----------
>  include/linux/mfd/ti_am335x_tscadc.h      |   2 +-
>  4 files changed, 64 insertions(+), 97 deletions(-)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
