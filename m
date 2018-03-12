From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v4 1/4] mfd: syscon: Set name of regmap_config
Date: Mon, 12 Mar 2018 09:12:14 +0000
Message-ID: <20180312091214.f6dwq6q3eqqblfnf@dell>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
 <20180309084351.32009-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309084351.32009-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, alexandre.belloni@bootlin.com, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.>
List-Id: linux-input@vger.kernel.org

On Fri, 09 Mar 2018, Jeffy Chen wrote:

> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> Modify commit message.
> 
>  drivers/mfd/syscon.c | 1 +
>  1 file changed, 1 insertion(+)

Is this the RESEND I requested?  I can still only see this patch.

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index fc9ba0ea4e44..b6d05cd934e6 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -110,6 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
>  	syscon_config.reg_stride = reg_io_width;
>  	syscon_config.val_bits = reg_io_width * 8;
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
> +	syscon_config.name = of_node_full_name(np);
>  
>  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
>  	if (IS_ERR(regmap)) {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
