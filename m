From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v5 2/4] rtc: at91sam9: Set name of regmap_config
Date: Tue, 13 Mar 2018 01:37:00 +0100
Message-ID: <20180313003700.GG3795@piout.net>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-3-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180312095142.30854-3-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, lee.jones@linaro.org, Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@>
List-Id: linux-input@vger.kernel.org

On 12/03/2018 at 17:51:40 +0800, Jeffy Chen wrote:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4:
> Not to use rtc dev to init regmap, the gpbr is not directly related to
> the rtc.
> 
> Changes in v3: None
> 
>  drivers/rtc/rtc-at91sam9.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
