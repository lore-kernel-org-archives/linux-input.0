From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: fix compiling error in u2fzero_probe()
Date: Mon, 15 Apr 2019 11:03:03 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1904151102250.9803@cbobk.fhfr.pm>
References: <20190413134459.76045-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413134459.76045-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mao Wenan <maowenan@huawei.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>, Andrej Shadura <andrew.shadura@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

On Sat, 13 Apr 2019, Mao Wenan wrote:

> There is one compiling error in u2fzero_probe()->u2fzero_init_hwrng(),
> this is because HW_RANDOM is not set.
> 
> drivers/hid/hid-u2fzero.o: In function `u2fzero_probe':
> hid-u2fzero.c:(.text+0xc70): undefined reference to `devm_hwrng_register'
> 
> Fixes: 42337b9d4d958("HID: add driver for U2F Zero built-in LED and RNG")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4dc1035..76d8206 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1017,6 +1017,7 @@ config HID_U2FZERO
>  	tristate "U2F Zero LED and RNG support"
>  	depends on USB_HID
>  	depends on LEDS_CLASS
> +	depends on HW_RANDOM

[ CCing Andrej ]

This was supposed to be sent by Andrej (together with other fixes), but 
you beat him to it. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
