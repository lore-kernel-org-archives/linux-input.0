From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 3/7] Input: synaptics-rmi4 - add support for F34
 device reflash
Date: Mon, 7 Nov 2016 17:47:13 -0800
Message-ID: <20161108014713.GB10133@dtor-ws>
References: <1477345917-25326-1-git-send-email-nick@shmanahar.org>
 <1477345917-25326-4-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35885 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbcKHBrR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2016 20:47:17 -0500
Content-Disposition: inline
In-Reply-To: <1477345917-25326-4-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 24, 2016 at 10:51:53PM +0100, Nick Dyer wrote:
> Add support for updating firmware, triggered by a sysfs attribute.
> 
> This patch has been tested on Synaptics S7300.
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>
> Tested-by: Chris Healy <cphealy@gmail.com>
> ---
>  drivers/input/rmi4/Kconfig      |  11 +
>  drivers/input/rmi4/Makefile     |   1 +
>  drivers/input/rmi4/rmi_bus.c    |   3 +
>  drivers/input/rmi4/rmi_driver.c |  89 ++++++--
>  drivers/input/rmi4/rmi_driver.h |  24 ++
>  drivers/input/rmi4/rmi_f01.c    |   6 +
>  drivers/input/rmi4/rmi_f34.c    | 494 ++++++++++++++++++++++++++++++++++++++++
>  drivers/input/rmi4/rmi_f34.h    |  68 ++++++
>  include/linux/rmi.h             |   1 +
>  9 files changed, 673 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/input/rmi4/rmi_f34.c
>  create mode 100644 drivers/input/rmi4/rmi_f34.h
> 
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index 4c8a558..9f10b1f 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -62,6 +62,17 @@ config RMI4_F30
>  	  Function 30 provides GPIO and LED support for RMI4 devices. This
>  	  includes support for buttons on TouchPads and ClickPads.
>  
> +config RMI4_F34
> +	bool "RMI4 Function 34 (Device reflash)"
> +	depends on RMI4_CORE
> +	select FW_LOADER
> +	help
> +	  Say Y here if you want to add support for RMI4 function 34.
> +
> +	  Function 34 provides support for upgrading the firmware on the RMI4
> +	  device via the firmware loader interface. This is triggered using a
> +	  sysfs attribute.
> +
>  config RMI4_F54
>  	bool "RMI4 Function 54 (Analog diagnostics)"
>  	depends on RMI4_CORE
> diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
> index 0bafc85..5f165ad 100644
> --- a/drivers/input/rmi4/Makefile
> +++ b/drivers/input/rmi4/Makefile
> @@ -7,6 +7,7 @@ rmi_core-$(CONFIG_RMI4_2D_SENSOR) += rmi_2d_sensor.o
>  rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
>  rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
>  rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
> +rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o
>  rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
>  
>  # Transports
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 3c6a1b5..178d388 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -314,6 +314,9 @@ static struct rmi_function_handler *fn_handlers[] = {
>  #ifdef CONFIG_RMI4_F30
>  	&rmi_f30_handler,
>  #endif
> +#ifdef CONFIG_RMI4_F34
> +	&rmi_f34_handler,
> +#endif
>  #ifdef CONFIG_RMI4_F54
>  	&rmi_f54_handler,
>  #endif
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index adb3ee8..545f7db 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -33,14 +33,21 @@
>  #define RMI_DEVICE_RESET_CMD	0x01
>  #define DEFAULT_RESET_DELAY_MS	100
>  
> -static void rmi_free_function_list(struct rmi_device *rmi_dev)
> +void rmi_free_function_list(struct rmi_device *rmi_dev)
>  {
>  	struct rmi_function *fn, *tmp;
>  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
>  
>  	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
>  
> +	mutex_lock(&data->irq_mutex);
> +
>  	data->f01_container = NULL;
> +	data->f34_container = NULL;
> +	data->irq_status = NULL;

So you simply "lose" old irq_status memory and rely on devm clear it
later? If anything it requires a comment, but I would like we did not
leave stray memory.

Thanks.

-- 
Dmitry
