From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
Date: Thu, 04 Oct 2012 17:00:23 +0200
Message-ID: <506DA487.9070400@metafoo.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Andrew Jones <drjones@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/04/2012 08:06 AM, Thierry Reding wrote:
> [...]
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 331d574..b38f23d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -219,7 +219,8 @@ config MACH_JZ4740
>  	select GENERIC_GPIO
>  	select ARCH_REQUIRE_GPIOLIB
>  	select SYS_HAS_EARLY_PRINTK
> -	select HAVE_PWM
> +	select PWM
> +	select PWM_JZ4740
>  	select HAVE_CLK
>  	select GENERIC_IRQ_CHIP

I'm not sure if this is such a good idea, not all jz4740 based board
necessarily require PWM.

- Lars
