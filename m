From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
 series SoCs
Date: Sat, 5 Sep 2009 17:17:03 +0100
Message-ID: <20090905161703.GB10326@sirena.org.uk>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35516 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZIEQRH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2009 12:17:07 -0400
Content-Disposition: inline
In-Reply-To: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>
Cc: linux-input@vger.kernel.org, laforge@gnumonks.org, ben-linux@fluff.org, =?utf-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0UzKOyCrOybkCkv7IK8?= =?utf-8?B?7ISx7KCE7J6Q?= <ki0351.kim@samsung.com>, =?utf-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQpLw==?= =?utf-8?B?7IK87ISx7KCE7J6QJw==?= <kgene.kim@samsung.com>

On Sat, Sep 05, 2009 at 10:55:24PM +0900, =EC=96=91=EC=A7=84=EC=84=B1 w=
rote:

> +static void s3c_keypad_timer_handler(unsigned long data)
> +{

> +	if (keymask_low | keymask_high) {
> +		mod_timer(&keypad->timer, jiffies + HZ / 10);
> +	} else {
> +		cfg =3D readl(keypad->regs + S3C_KEYIFCON);
> +		cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
> +		cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
> +				S3C_KEYIF_DF_EN | S3C_KEYIF_FC_EN);
> +		writel(cfg, keypad->regs + S3C_KEYIFCON);
> +
> +		keypad->timer_enabled =3D 0;

This looks racy - we first enable the interrupts and then change the
variable that flags the timer as enabled.  Potentially the interrupt
could fire between these two operations, meaning that it would see the
timer as disabled.

> +static irqreturn_t s3c_keypad_irq(int irq, void *dev_id)
> +{

> +	keypad->timer.expires =3D jiffies + (HZ / 100);
> +	if (keypad->timer_enabled) {
> +		mod_timer(&keypad->timer, keypad->timer.expires);
> +	} else {
> +		add_timer(&keypad->timer);
> +		keypad->timer_enabled =3D 1;
> +	}

The driver should be able to avoid the above issue by just calling
mod_timer() unconditionally here - if mod_timer() is called on an
inactive timer then it will activate it for you.  This would also avoid
modifying the timer expiry while the timer is active, which I'm not
convinced is safe.  This would mean that the driver wouldn't need to
remember if the timer was enabled.

> +#define res_size(res)	((res)->end - (res)->start + 1)

There's resource_size() for this.

> +	/* Register the input device */
> +	error =3D input_register_device(input);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto err_reg_input;
> +	}

This is called after your interrupt handler is registerd.  Are you sure
that the interrupt handler can safely run before this happens - it look=
s=20

> +	device_init_wakeup(&pdev->dev, 1);
> +	dev_info(&pdev->dev, "Samsung Keypad Interface driver\n");

I'd drop this dev_info().

> +static int __devexit s3c_keypad_remove(struct platform_device *pdev)
> +{

I can't see anything here or elsewhere which stops the timer you're
using to poll the keypad.  This means that the timer may still be
running if someone is pressing a key when the driver is removed.  I
believe the same issue applies over suspend and resume.

> +static struct platform_driver s3c_keypad_driver =3D {
> +	.probe		=3D s3c_keypad_probe,
> +	.remove		=3D s3c_keypad_remove,
> +	.suspend	=3D s3c_keypad_suspend,
> +	.resume		=3D s3c_keypad_resume,

The driver should be using dev_pm_ops rather than the suspend and resum=
e
methods of the struct platform_driver.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
