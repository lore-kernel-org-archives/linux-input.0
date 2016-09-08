From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input: jornada720_kbd - switch to devm_* APIs
Date: Wed, 7 Sep 2016 19:24:17 -0700
Message-ID: <20160908022417.GE6445@dtor-ws>
References: <20160907095029.GL1041@n2100.armlinux.org.uk>
 <E1bhZVY-0005cT-0G@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36711 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbcIHCYU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2016 22:24:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id x24so1766978pfa.3
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2016 19:24:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1bhZVY-0005cT-0G@rmk-PC.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-input@vger.kernel.org

Hi Russell,

On Wed, Sep 07, 2016 at 10:51:04AM +0100, Russell King wrote:
> Switch the jornada720_kbd driver to use the devm_* APIs.  This is in
> preparation to removing the mach/irqs.h include from this driver.

I already applied a version of this driver (without extraneous irq
field and empty remove() method), why are you resending it?

Thanks.

> 
> Tested-by: Adam Wysocki <armlinux@chmurka.net>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/input/keyboard/jornada720_kbd.c | 38 ++++++++-------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
> index 421d9c55b0e8..4b2e9ff18ba1 100644
> --- a/drivers/input/keyboard/jornada720_kbd.c
> +++ b/drivers/input/keyboard/jornada720_kbd.c
> @@ -53,6 +53,7 @@ static unsigned short jornada_std_keymap[128] = {					/* ROW */
>  struct jornadakbd {
>  	unsigned short keymap[ARRAY_SIZE(jornada_std_keymap)];
>  	struct input_dev *input;
> +	int irq;
>  };
>  
>  static irqreturn_t jornada720_kbd_interrupt(int irq, void *dev_id)
> @@ -99,12 +100,10 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
>  	struct input_dev *input_dev;
>  	int i, err;
>  
> -	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
> -	input_dev = input_allocate_device();
> -	if (!jornadakbd || !input_dev) {
> -		err = -ENOMEM;
> -		goto fail1;
> -	}
> +	jornadakbd = devm_kzalloc(&pdev->dev, sizeof(*jornadakbd), GFP_KERNEL);
> +	input_dev = devm_input_allocate_device(&pdev->dev);
> +	if (!jornadakbd || !input_dev)
> +		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, jornadakbd);
>  
> @@ -127,37 +126,18 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
>  
>  	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
>  
> -	err = request_irq(IRQ_GPIO0,
> -			  jornada720_kbd_interrupt,
> -			  IRQF_TRIGGER_FALLING,
> -			  "jornadakbd", pdev);
> +	err = devm_request_irq(&pdev->dev, IRQ_GPIO0, jornada720_kbd_interrupt,
> +			       IRQF_TRIGGER_FALLING, "jornadakbd", pdev);
>  	if (err) {
>  		printk(KERN_INFO "jornadakbd720_kbd: Unable to grab IRQ\n");
> -		goto fail1;
> +		return err;
>  	}
>  
> -	err = input_register_device(jornadakbd->input);
> -	if (err)
> -		goto fail2;
> -
> -	return 0;
> -
> - fail2:	/* IRQ, DEVICE, MEMORY */
> -	free_irq(IRQ_GPIO0, pdev);
> - fail1:	/* DEVICE, MEMORY */
> -	input_free_device(input_dev);
> -	kfree(jornadakbd);
> -	return err;
> +	return input_register_device(jornadakbd->input);
>  };
>  
>  static int jornada720_kbd_remove(struct platform_device *pdev)
>  {
> -	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
> -
> -	free_irq(IRQ_GPIO0, pdev);
> -	input_unregister_device(jornadakbd->input);
> -	kfree(jornadakbd);
> -
>  	return 0;
>  }
>  
> -- 
> 2.1.0
> 

-- 
Dmitry
