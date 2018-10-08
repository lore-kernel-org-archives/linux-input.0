From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
Date: Mon, 8 Oct 2018 09:35:34 -0700
Message-ID: <5257d6f9-7481-de33-64a5-0e1188304716@infradead.org>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-9-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539016176-4072-9-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org

On 10/8/18 9:29 AM, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 PMIC embeds a watchdog which is disabled by default. As soon
> as the watchdog is started, it must be refreshed periodically otherwise
> the PMIC goes off.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3:
> * Rename struct stpmic1_dev by struct stpmic1.
> * Add nowayout module param.
> * Fix set timeout. 
> * Call watchdog_init_timeout so that the timeout can be set in the devicetree.
> * Add email address in MODULE_AUTHOR.
> 
>  drivers/watchdog/Kconfig       |  12 ++++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/stpmic1_wdt.c | 138 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 drivers/watchdog/stpmic1_wdt.c

Hi,

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 5ea8909..985781e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -806,6 +806,18 @@ config STM32_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stm32_iwdg.
>  
> +config STPMIC1_WATCHDOG
> +	tristate "STPMIC1 PMIC watchdog support"
> +	depends on MFD_STPMIC1
> +	select WATCHDOG_CORE
> +	help
> +	  Say Y here to include watchdog support embedded into STPMIC1 PMIC.
> +	  If the watchdog timer expires, stpmic1 shut-down all its power

	  If the watchdog timer expires, stpmic1 shuts down all its power
or
	  If the watchdog timer expires, stpmic1 will shut down all its power

> +	  supplies.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called spmic1_wdt.
> +
>  config UNIPHIER_WATCHDOG
>  	tristate "UniPhier watchdog support"
>  	depends on ARCH_UNIPHIER || COMPILE_TEST

cheers.
-- 
~Randy
