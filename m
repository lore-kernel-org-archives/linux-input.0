From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] input: gpio-keys: add support to name the gpio-keys
Date: Tue, 12 Jan 2016 08:43:01 -0600
Message-ID: <20160112144301.GA30932@rob-hp-laptop>
References: <1452598370-28509-1-git-send-email-ldewangan@nvidia.com>
 <1452598370-28509-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452598370-28509-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 12, 2016 at 05:02:50PM +0530, Laxman Dewangan wrote:
> Add support from DT to name the gpio-keys driver to have
> desired key name for this input system.
> 
> This helps userspace code to get name and perform proper
> event to key mapping in some of cases. In android, the
> user space map the key code to application code using
> key character layout and for this it uses the name of
> input system.

Why is specifying the key code not enough?

> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.txt | 1 +
>  drivers/input/keyboard/gpio_keys.c                    | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> index cf1333d..2e6bcd2 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -4,6 +4,7 @@ Required properties:
>  	- compatible = "gpio-keys";
>  
>  Optional properties:
> +	- gpio-keys,name: String, name of the gpio-keys input system.

gpio-keys is not a vendor.

Would "label" work for you instead?

Either way, I'm concerned this doesn't work for other key bindings 
which have multiple keys.

>  	- autorepeat: Boolean, Enable auto repeat feature of Linux input
>  	  subsystem.
>  
