From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Wed, 27 May 2009 15:26:58 +0200
Message-ID: <200905271526.59064.u.luckas@road.de>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thursday, 7. May 2009, Eric Miao wrote:
>+static int matrix_keypad_suspend(struct platform_device *pdev,
>pm_message_t state)
>+{
>+       struct matrix_keypad *keypad = platform_get_drvdata(pdev);
>+       struct matrix_keypad_platform_data *pdata = keypad->pdata;
>+       int i;
>+
>+       if (device_may_wakeup(&pdev->dev))
>+               for (i = 0; i < pdata->num_row_gpios; i++)
>+                       enable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
>+
>+       return 0;
>+}
>+
Hi Eric,
what about the workqueue and interrupts? Shouldn't the interrupts be disabled and then the wq flushed?

> +static int matrix_keypad_resume(struct platform_device *pdev)
> +{
> +	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
> +	struct matrix_keypad_platform_data *pdata = keypad->pdata;
> +	int i;
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		for (i = 0; i < pdata->num_row_gpios; i++)
> +			disable_irq_wake(gpio_to_irq(pdata->row_gpios[i]));
> +
> +	return 0;
> +}
>+
You should probably schedule an imediate key scan as all key state changes where lost while the device was suspended.

Uli

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
