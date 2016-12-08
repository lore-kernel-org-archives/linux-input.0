From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v11 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Thu, 8 Dec 2016 23:56:28 +0100
Message-ID: <8b5ad884-ed94-c776-043d-1dbdd64182d2@denx.de>
References: <cover.1481234322.git.ksenija.stanojevic@gmail.com>
 <7122f136e4735fe18c8b431006e6d6314b3c7e41.1481234322.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7122f136e4735fe18c8b431006e6d6314b3c7e41.1481234322.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 12/08/2016 11:27 PM, Ksenija Stanojevic wrote:
> Add core files for low resolution analog-to-digital converter (mxs-lradc)
> MFD driver.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Just a nit below.

> +++ b/include/linux/mfd/mxs-lradc.h
> @@ -0,0 +1,187 @@
> +/*

[...]

> +#define LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
> +#define LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
> +#define LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
> +#define LRADC_CTRL1_TOUCH_DETECT_IRQ		BIT(8)
> +#define LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))

This would turn into BIT(n) , no ?

> +#define LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
> +#define LRADC_CTRL1_MX23_LRADC_IRQ_MASK		0x01ff
> +#define LRADC_CTRL1_LRADC_IRQ_OFFSET		0

[...]

-- 
Best regards,
Marek Vasut
