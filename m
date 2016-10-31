From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/6] Input: gpio_keys_polled - keep button data constant
Date: Mon, 31 Oct 2016 12:41:25 +0200
Message-ID: <20161031104125.GK23812@lahna.fi.intel.com>
References: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765275AbcJaKla (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Oct 2016 06:41:30 -0400
Content-Disposition: inline
In-Reply-To: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org

On Fri, Oct 28, 2016 at 04:14:39PM -0700, Dmitry Torokhov wrote:
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index ee2d8c6..d1250ad 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -2,7 +2,6 @@
>  #define _GPIO_KEYS_H
>  
>  struct device;
> -struct gpio_desc;
>  
>  /**
>   * struct gpio_keys_button - configuration parameters
> @@ -31,7 +30,6 @@ struct gpio_keys_button {
>  	bool can_disable;
>  	int value;
>  	unsigned int irq;
> -	struct gpio_desc *gpiod;

Please remove the kernel-doc comment of this member as well.

>  };
