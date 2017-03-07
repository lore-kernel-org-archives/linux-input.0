From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: pwm-beeper: support customized freq for
 SND_BELL
Date: Tue, 7 Mar 2017 10:44:25 -0800
Message-ID: <20170307184425.GF13740@dtor-ws>
References: <1488346642-14351-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488346642-14351-1-git-send-email-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-input@vger.kernel.org, Guan Ben <ben.guan@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 01, 2017 at 06:37:22AM +0100, Heiko Schocher wrote:
> From: Guan Ben <ben.guan@cn.bosch.com>
> 
> extend the pwm-beeper driver to support customized frequency
> for SND_BELL from device tree.
> 
> Signed-off-by: Guan Ben <ben.guan@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> [hs@denx.de: adapted to 4.10-rc7]
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Reconciled with the latest version and applied, thank you.

> ---
> 
> Changes in v3:
> - add comment from David Lechner:
>   - readd the switch statement, instead using if / then
>   - remove check IS_ENABLED(CONFIG_OF)
>   - remove not used node variable
>   - change warning string from "Failed to read beeper-hz" to
>     "'beeper-hz' not specified"
>   - remove function pwm_beeper_init_bell_frequency() as it is
>     to simple.
>   - checked that device_property_read_u32() does not modify the
>     bell_frequency, if the property "beeper_hz" is not defined.
> - add comment from Rob Herring:
>   - add Acked-by from Rob Herring
>     Rob also mentioned to remove the IS_ENABLED(CONFIG_OF) check
>     and node variable is unused.
> 
> Changes in v2:
> - add comment from Rob Herring:
>   rename property name "bell-frequency" to "beeper-hz"
> - add comment from Dmitry Torokhov:
>   use device_property_read_u32() instead of of_property_read_u32()
> - rebased against c470abd4fde40ea6a0846a2beab642a578c0b8cd
>   Linux 4.10
> 
>  Documentation/devicetree/bindings/input/pwm-beeper.txt |  3 +++
>  drivers/input/misc/pwm-beeper.c                        | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> index be332ae..4e4e128 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -5,3 +5,6 @@ Registers a PWM device as beeper.
>  Required properties:
>  - compatible: should be "pwm-beeper"
>  - pwms: phandle to the physical PWM device
> +
> +optional properties:
> +- beeper-hz:  bell frequency in Hz
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index 5f9655d..f2fcd50 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -27,6 +27,7 @@ struct pwm_beeper {
>  	struct pwm_device *pwm;
>  	struct work_struct work;
>  	unsigned long period;
> +	unsigned int bell_frequency;
>  };
>  
>  #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
> @@ -60,7 +61,7 @@ static int pwm_beeper_event(struct input_dev *input,
>  
>  	switch (code) {
>  	case SND_BELL:
> -		value = value ? 1000 : 0;
> +		value = value ? beeper->bell_frequency : 0;
>  		break;
>  	case SND_TONE:
>  		break;
> @@ -97,6 +98,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  {
>  	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
>  	struct pwm_beeper *beeper;
> +	unsigned int bell_frequency = 1000;
>  	int error;
>  
>  	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
> @@ -122,6 +124,13 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  	pwm_apply_args(beeper->pwm);
>  
>  	INIT_WORK(&beeper->work, pwm_beeper_work);
> +	error = device_property_read_u32(&pdev->dev, "beeper-hz",
> +				       &bell_frequency);
> +	if (error < 0)
> +		dev_dbg(&pdev->dev, "'beeper-hz' not specified, using default: %u Hz\n",
> +			bell_frequency);
> +
> +	beeper->bell_frequency = bell_frequency;
>  
>  	beeper->input = input_allocate_device();
>  	if (!beeper->input) {
> -- 
> 2.7.4
> 

-- 
Dmitry
