From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] matrix_keypad: convert to threaded IRQs
Date: Tue, 3 Apr 2012 09:37:06 -0700
Message-ID: <20120403163706.GA24832@core.coreip.homeip.net>
References: <1333440600-4183-1-git-send-email-rusko.peter@prolan.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57633 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2DCQhN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 12:37:13 -0400
Received: by pbcun15 with SMTP id un15so76750pbc.19
        for <linux-input@vger.kernel.org>; Tue, 03 Apr 2012 09:37:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333440600-4183-1-git-send-email-rusko.peter@prolan.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Rusko <rusko.peter@prolan.hu>
Cc: Yong Zhang <yong.zhang0@gmail.com>, w.sang@pengutronix.de, linux-input@vger.kernel.org

On Tue, Apr 03, 2012 at 10:10:00AM +0200, Peter Rusko wrote:
> Tested on Ka-Ro TX28 SOC

Needs justification; plus this is not how debounce works - you need to
postpone scan until IRQ line settles, not simply wait so many
milliseconds.

I think what you really need is request_any_context_irq().

Thanks.

> 
> Signed-off-by: Peter Rusko <rusko.peter@prolan.hu>
> ---
>  drivers/input/keyboard/matrix_keypad.c |   58 +++++++++----------------------
>  1 files changed, 17 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index e2ae657..c3d3532 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -33,7 +33,6 @@ struct matrix_keypad {
>  	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
>  
>  	uint32_t last_key_state[MATRIX_MAX_COLS];
> -	struct delayed_work work;
>  	spinlock_t lock;
>  	bool scan_pending;
>  	bool stopped;
> @@ -112,15 +111,16 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
>  /*
>   * This gets the keys from keyboard and reports it to input subsystem
>   */
> -static void matrix_keypad_scan(struct work_struct *work)
> +static irqreturn_t matrix_keypad_scan(int irq, void *id)
>  {
> -	struct matrix_keypad *keypad =
> -		container_of(work, struct matrix_keypad, work.work);
> +	struct matrix_keypad *keypad = id;
>  	struct input_dev *input_dev = keypad->input_dev;
>  	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
>  	uint32_t new_state[MATRIX_MAX_COLS];
>  	int row, col, code;
>  
> +	msleep(keypad->pdata->debounce_ms);
> +
>  	/* de-activate all columns for scanning */
>  	activate_all_cols(pdata, false);
>  
> @@ -165,32 +165,8 @@ static void matrix_keypad_scan(struct work_struct *work)
>  	/* Enable IRQs again */
>  	spin_lock_irq(&keypad->lock);
>  	keypad->scan_pending = false;
> -	enable_row_irqs(keypad);
>  	spin_unlock_irq(&keypad->lock);
> -}
> -
> -static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
> -{
> -	struct matrix_keypad *keypad = id;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&keypad->lock, flags);
>  
> -	/*
> -	 * See if another IRQ beaten us to it and scheduled the
> -	 * scan already. In that case we should not try to
> -	 * disable IRQs again.
> -	 */
> -	if (unlikely(keypad->scan_pending || keypad->stopped))
> -		goto out;
> -
> -	disable_row_irqs(keypad);
> -	keypad->scan_pending = true;
> -	schedule_delayed_work(&keypad->work,
> -		msecs_to_jiffies(keypad->pdata->debounce_ms));
> -
> -out:
> -	spin_unlock_irqrestore(&keypad->lock, flags);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -201,11 +177,8 @@ static int matrix_keypad_start(struct input_dev *dev)
>  	keypad->stopped = false;
>  	mb();
>  
> -	/*
> -	 * Schedule an immediate key scan to capture current key state;
> -	 * columns will be activated and IRQs be enabled after the scan.
> -	 */
> -	schedule_delayed_work(&keypad->work, 0);
> +	matrix_keypad_scan(0, keypad);
> +	enable_row_irqs(keypad);
>  
>  	return 0;
>  }
> @@ -216,7 +189,6 @@ static void matrix_keypad_stop(struct input_dev *dev)
>  
>  	keypad->stopped = true;
>  	mb();
> -	flush_work(&keypad->work.work);
>  	/*
>  	 * matrix_keypad_scan() will leave IRQs enabled;
>  	 * we should disable them now.
> @@ -330,9 +302,11 @@ static int __devinit init_matrix_gpio(struct platform_device *pdev,
>  	}
>  
>  	if (pdata->clustered_irq > 0) {
> -		err = request_irq(pdata->clustered_irq,
> -				matrix_keypad_interrupt,
> -				pdata->clustered_irq_flags,
> +		err = request_threaded_irq(pdata->clustered_irq,
> +				NULL,
> +				matrix_keypad_scan,
> +				pdata->clustered_irq_flags |
> +				IRQF_ONESHOT,
>  				"matrix-keypad", keypad);
>  		if (err) {
>  			dev_err(&pdev->dev,
> @@ -341,10 +315,13 @@ static int __devinit init_matrix_gpio(struct platform_device *pdev,
>  		}
>  	} else {
>  		for (i = 0; i < pdata->num_row_gpios; i++) {
> -			err = request_irq(gpio_to_irq(pdata->row_gpios[i]),
> -					matrix_keypad_interrupt,
> +			err = request_threaded_irq(
> +					gpio_to_irq(pdata->row_gpios[i]),
> +					NULL,
> +					matrix_keypad_scan,
>  					IRQF_TRIGGER_RISING |
> -					IRQF_TRIGGER_FALLING,
> +					IRQF_TRIGGER_FALLING |
> +					IRQF_ONESHOT,
>  					"matrix-keypad", keypad);
>  			if (err) {
>  				dev_err(&pdev->dev,
> @@ -414,7 +391,6 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
>  	keypad->keycodes = keycodes;
>  	keypad->row_shift = row_shift;
>  	keypad->stopped = true;
> -	INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
>  	spin_lock_init(&keypad->lock);
>  
>  	input_dev->name		= pdev->name;
> -- 
> 1.7.5.4
> 

-- 
Dmitry
