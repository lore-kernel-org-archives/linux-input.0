From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: mc13xxx: Add mc34708 adc support
Date: Fri, 4 Oct 2019 14:58:39 +0100
Message-ID: <20191004135839.GG18429@dell>
References: <20190909214440.30674-1-lukma@denx.de>
 <20190909214440.30674-2-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190909214440.30674-2-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Mon, 09 Sep 2019, Lukasz Majewski wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has an improved adc. The older variants will always convert
> a fixed order of channels. The mc34708 can do up to eight conversions
> in arbitrary channel order. Currently this extended feature is not
> supported. We only support touchscreen conversions now, which will
> be sampled in a data format compatible to the older chips in order
> to keep the API between the mfd and the touchscreen driver.

Please take this opportunity to split all the ADC stuff out into an
ADC specific driver.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v5:
> - Remove adc_do_conversion() callbacks from struct mc13xxx_variant
> - Remove duplicated MC13XXX_ADC_WORKING #define
> 
> Changes for v4:
> - None
> 
> Changes for v3:
> - None
> 
> Changes for v2:
> - Change the return code patch when the mc13xxx ADC is performing conversion
> - Introduce new include/linux/mfd/mc34708.h header file for mc34708 specific
>   defines
> 
> Changes from the original patches:
> - ADC conversion functions prototypes added to fix build error
> - Adjustments to make checkpatch clean (-ENOSYS, line over 80 char)
> 
> This patch applies on top of Linux 5.3-rc8
> SHA1: f74c2bb98776e2de508f4d607cd519873065118e
> ---
>  drivers/mfd/mc13xxx-core.c  | 98 ++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/mc34708.h | 37 ++++++++++++++
>  2 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/mfd/mc34708.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
