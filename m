From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: sirf onkey: allow modular build
Date: Wed, 27 Jan 2016 15:43:50 -0800
Message-ID: <20160127234350.GH28687@dtor-ws>
References: <1453735950-1958677-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34515 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934772AbcA0Xnx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 18:43:53 -0500
Content-Disposition: inline
In-Reply-To: <1453735950-1958677-1-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Barry Song <baohua@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 25, 2016 at 04:31:35PM +0100, Arnd Bergmann wrote:
> CONFIG_INPUT may itself be a loadable module, but the sirf power key
> driver is listed as 'bool', which makes it possible to select
> a broken configuration with the driver built-in but the subsystem
> not loaded. In this configuration, we get a link error:
> 
> drivers/input/built-in.o: In function `sirfsoc_pwrc_isr':
> drivers/input/misc/sirfsoc-onkey.c:63: undefined reference to `input_event'
> drivers/input/built-in.o: In function `sirfsoc_pwrc_isr':
> include/linux/input.h:414: undefined reference to `input_event'
> drivers/input/built-in.o: In function `sirfsoc_pwrc_probe':
> drivers/input/misc/sirfsoc-onkey.c:132: undefined reference to `devm_input_allocate_device'
> drivers/input/misc/sirfsoc-onkey.c:139: undefined reference to `input_set_capability'
> drivers/input/misc/sirfsoc-onkey.c:161: undefined reference to `input_register_device'
> drivers/input/built-in.o: In function `sirfsoc_pwrc_report_event':
> drivers/input/misc/sirfsoc-onkey.c:48: undefined reference to `input_event'
> drivers/input/built-in.o: In function `sirfsoc_pwrc_report_event':
> include/linux/input.h:414: undefined reference to `input_event'
> drivers/input/built-in.o:(.debug_addr+0x24): undefined reference to `input_event'
> drivers/input/built-in.o:(.debug_addr+0xbc): undefined reference to `devm_input_allocate_device'
> drivers/input/built-in.o:(.debug_addr+0x104): undefined reference to `input_set_capability'
> drivers/input/built-in.o:(.debug_addr+0x128): undefined reference to `input_register_device'
> 
> This marks the driver as 'tristate' so it becomes possible to have
> it in a loadable module, mainly to help with randconfig builds.
> 
> We also have to add a missing semicolon here, which ended up not
> being needed in built-in mode because the following MODULE_DEVICE_TABLE
> is an empty macro followed by another semicolon then.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

> ---
>  drivers/input/misc/Kconfig         | 2 +-
>  drivers/input/misc/sirfsoc-onkey.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index d6d16fa78281..1f2337abcf2f 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -733,7 +733,7 @@ config INPUT_XEN_KBDDEV_FRONTEND
>  	  module will be called xen-kbdfront.
>  
>  config INPUT_SIRFSOC_ONKEY
> -	bool "CSR SiRFSoC power on/off/suspend key support"
> +	tristate "CSR SiRFSoC power on/off/suspend key support"
>  	depends on ARCH_SIRF && OF
>  	default y
>  	help
> diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
> index 9d5b89befe6f..ed7237f19539 100644
> --- a/drivers/input/misc/sirfsoc-onkey.c
> +++ b/drivers/input/misc/sirfsoc-onkey.c
> @@ -101,7 +101,7 @@ static void sirfsoc_pwrc_close(struct input_dev *input)
>  static const struct of_device_id sirfsoc_pwrc_of_match[] = {
>  	{ .compatible = "sirf,prima2-pwrc" },
>  	{},
> -}
> +};
>  MODULE_DEVICE_TABLE(of, sirfsoc_pwrc_of_match);
>  
>  static int sirfsoc_pwrc_probe(struct platform_device *pdev)
> -- 
> 2.7.0
> 

-- 
Dmitry
