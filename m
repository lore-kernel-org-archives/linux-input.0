From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 2/2] input: gpio-keys: add support to name the
 gpio-keys
Date: Tue, 12 Jan 2016 23:02:33 -0800
Message-ID: <20160113070233.GA8906@dtor-ws>
References: <1452665657-9412-1-git-send-email-ldewangan@nvidia.com>
 <1452665657-9412-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34303 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbcAMHCg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 02:02:36 -0500
Content-Disposition: inline
In-Reply-To: <1452665657-9412-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com

On Wed, Jan 13, 2016 at 11:44:17AM +0530, Laxman Dewangan wrote:
> Add support from DT to name the gpio-keys driver to have
> desired key name for this input system.
> 
> This helps userspace code to get name and perform proper
> event to key mapping in some of cases. In android, the
> user space map the key code to application code using
> key character layout and for this it uses the name of
> input system.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Applied, thank you.

> ---
> Changes from V1:
> - Use standard property "label" instead of custom property "gpio-keys,name"
> 
>  Documentation/devicetree/bindings/input/gpio-keys.txt | 1 +
>  drivers/input/keyboard/gpio_keys.c                    | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> index cf1333d..f23bfa1 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -4,6 +4,7 @@ Required properties:
>  	- compatible = "gpio-keys";
>  
>  Optional properties:
> +	- label: String, name of the gpio-keys input system.
>  	- autorepeat: Boolean, Enable auto repeat feature of Linux input
>  	  subsystem.
>  
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 08bada8..448f38f 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -628,6 +628,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  
>  	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
>  
> +	of_property_read_string(node, "label", &pdata->name);
> +
>  	i = 0;
>  	for_each_child_of_node(node, pp) {
>  		enum of_gpio_flags flags;
> -- 
> 2.1.4
> 

-- 
Dmitry
