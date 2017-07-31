From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] serio: PS2 gpio bit banging driver for the serio bus
Date: Mon, 31 Jul 2017 16:34:23 -0700
Message-ID: <29d8794c-93ae-c609-8a24-38325a32fddd@infradead.org>
References: <20170731223557.23845-1-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51418 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbdGaXec (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Jul 2017 19:34:32 -0400
In-Reply-To: <20170731223557.23845-1-danilokrummrich@dk-develop.de>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Danilo Krummrich <danilokrummrich@dk-develop.de>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linus.walleij@linaro.org

On 07/31/2017 03:35 PM, Danilo Krummrich wrote:

> diff --git a/Documentation/gpio/drivers-on-gpio.txt b/Documentation/gpio/drivers-on-gpio.txt
> index 3065132..b106e72 100644
> --- a/Documentation/gpio/drivers-on-gpio.txt
> +++ b/Documentation/gpio/drivers-on-gpio.txt
> @@ -84,6 +84,11 @@ hardware descriptions such as device tree or ACPI:
>    NAND flash MTD subsystem and provides chip access and partition parsing like
>    any other NAND driving hardware.
>  
> +- ps2-gpio: drivers/input/serio/ps2-gpio.c is used to drive an PS2 serio bus,

                                                         drive a PS2
Is this PS2 as in IBM Micro Channel or PlayStation 2?

> +  data and clock line, by bit banging two GPIO lines. It will appear as any
> +  other serio bus to the system and makes it possible to connect drivers for
> +  e.g. keyboards and other PS2 protocol based devices.
> +
>  Apart from this there are special GPIO drivers in subsystems like MMC/SD to
>  read card detect and write protect GPIO lines, and in the TTY serial subsystem
>  to emulate MCTRL (modem control) signals CTS/RTS by using two GPIO lines. The
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index c3d05b4..abca0e0 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -292,6 +292,16 @@ config SERIO_SUN4I_PS2
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called sun4i-ps2.
>  
> +config SERIO_GPIO_PS2
> +	tristate "GPIO PS/2 bit banging driver"

	depends on GPIO
??

> +	help
> +	  Say Y here if you want PS/2 bit banging support via GPIO.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gpio-ps2.
> +
> +	  If you are unsure, say N.
> +
>  config USERIO
>  	tristate "User space serio port driver support"
>  	help


-- 
~Randy
