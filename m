From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] leds-alix2: add support for button connected to J15
Date: Sun, 18 Oct 2009 00:27:39 -0700
Message-ID: <20091018072738.GF3935@core.coreip.homeip.net>
References: <20091016130315.GT28832@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752633AbZJRH1m@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091016130315.GT28832@buzzloop.caiaq.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Constantin Baranov <const@mimas.ru>
List-Id: linux-input@vger.kernel.org

Hi Daniel,

On Fri, Oct 16, 2009 at 03:03:15PM +0200, Daniel Mack wrote:
>  
> +#ifdef CONFIG_LEDS_ALIX2_BUTTON
> +static void alix_button_poll(struct input_polled_dev *ipdev)
> +{
> +	unsigned int val = !(inl(gpio_base + 0x30) & (1 << 1));
> +
> +	if (val == alix_button_last)
> +		return;

You can probably let input core filter out duplicate events...
> +
> +	input_report_key(ipdev->input, BTN_MISC, val);

BTN_MISC is expected to be used by joysticks or poniting devices, I'd
recomment KEY_PROG1 for a key.

> +	input_sync(ipdev->input);
> +	alix_button_last = val;
> +}
> +#endif
> +
>  static int __init alix_led_probe(struct platform_device *pdev)
>  {
>  	int i;
> @@ -89,6 +110,35 @@ static int __init alix_led_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto fail;
>  	}
> +
> +#ifdef CONFIG_LEDS_ALIX2_BUTTON
> +	/* enable button input */
> +	outl(1 << 1, gpio_base + 0x20);
> +
> +	/* enable pullup on input pin */
> +	outl(1 << 1, gpio_base + 0x18);
> +
> +	alix_button_last = 0;
> +	ipdev = input_allocate_polled_device();
> +	if (!ipdev)
> +		goto fail;
> +
> +	ipdev->poll = alix_button_poll;
> +	ipdev->poll_interval = POLL_INTERVAL_DEFAULT;
> +	ipdev->input->name = "ALIX2 button";
> +	ipdev->input->phys = "alix2/input0";
> +	ipdev->input->id.bustype = BUS_HOST;
> +
> +	set_bit(EV_KEY, ipdev->input->evbit);
> +        ipdev->input->keybit[BIT_WORD(BTN_MISC)] = BIT_MASK(BTN_MISC);
> +
> +	ret = input_register_polled_device(ipdev);
> +	if (ret) {
> +		input_free_polled_device(ipdev);
> +		goto fail;
> +	}
> +#endif

Fells like you want to make it a function (and a stub if not
configured)...

-- 
Dmitry
