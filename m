From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH v3 1/1] input: add support for Nomadik SKE keypad controller
Date: Tue, 07 Sep 2010 19:31:47 +0530
Message-ID: <4C8645CB.9070206@codeaurora.org>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:57354 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159Ab0IGOBu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Sep 2010 10:01:50 -0400
In-Reply-To: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Linus Walleij <linus.walleij@stericsson.com>

Hi Sundar,

On 9/6/2010 6:18 PM, Sundar Iyer wrote:
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> ---

More description about the keypad controller please.

> 
> Changes:
> v3:
>  - fixed Dmitry's comments assorted comments,
>  - re-orged the IRQ to include a timer instead of cpu_relax()
> 
>  arch/arm/plat-nomadik/include/plat/ske.h    |   54 ++++
>  drivers/input/keyboard/Kconfig              |   10 +
>  drivers/input/keyboard/Makefile             |    1 +
>  drivers/input/keyboard/nomadik-ske-keypad.c |  449 +++++++++++++++++++++++++++
>  4 files changed, 514 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-nomadik/include/plat/ske.h

Is it Onchip on the NomaDik or over PMIC?

> +
> +#include <linux/input/matrix_keypad.h>
> +
> +/* register definitions for SKE peripheral */
> +#define SKE_CR		0x00
> +#define SKE_VAL0	0x04
> +#define SKE_VAL1	0x08
> +#define SKE_DBCR	0x0C
> +#define SKE_IMSC	0x10
> +#define SKE_RIS		0x14
> +#define SKE_MIS		0x18
> +#define SKE_ICR		0x1C
> +#define SKE_ASR0	0x20
> +#define SKE_ASR1	0x24
> +#define SKE_ASR2	0x28
> +#define SKE_ASR3	0x2C
> +
> +#define SKE_NUM_ASRX_REGISTERS	(4)


Why they need to be in the header? These registers #define can be moved to .c file.

> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
> new file mode 100644
> index 0000000..1697181
> --- /dev/null
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -0,0 +1,449 @@
> +/*
> + * Copyright (C) ST-Ericsson SA 2010
> + *
> + * Author: Naveen Kumar G <naveen.gaddipati@stericsson.com> for ST-Ericsson
> + * Author: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
> + *
> + * License terms:GNU General Public License (GPL) version 2
> + *
> + * Keypad controller driver for the SKE (Scroll Key Encoder) module used in
> + * the Nomadik 8815 and Ux500 platforms.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/input.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +
> +#include <plat/ske.h>
> +
> +/* SKE_CR bits */
> +#define SKE_KPMLT	(0x1 << 6)
> +#define SKE_KPCN	(0x7 << 3)
> +#define SKE_KPASEN	(0x1 << 2)
> +#define SKE_KPASON	(0x1 << 7)
> +
> +/* SKE_IMSC bits */
> +#define SKE_KPIMA	(0x1 << 2)
> +
> +/* SKE_ICR bits */
> +#define SKE_KPICS	(0x1 << 3)
> +#define SKE_KPICA	(0x1 << 2)
> +
> +/* SKE_RIS bits */
> +#define SKE_KPRISA	(0x1 << 2)
> +
> +#define SKE_KEYPAD_ROW_SHIFT	3
> +#define SKE_KPD_KEYMAP_SIZE	(8 * 8)
> +
> +/**
> + * struct ske_keypad  - data structure used by keypad driver
> + * @irq:	irq no
> + * @reg_base:	ske regsiters base address
> + * @input:	pointer to input device object
> + * @board:	keypad platform device
> + * @keymap:	matrix scan code table for keycodes
> + * @clk:	clock structure pointer
> + */
> +struct ske_keypad {
> +	int irq;
> +	void __iomem *reg_base;
> +	struct input_dev *input;
> +	const struct ske_keypad_platform_data *board;
> +	unsigned short keymap[SKE_KPD_KEYMAP_SIZE];
> +	struct clk *clk;
> +	spinlock_t ske_keypad_lock;
> +	struct timer_list timer;
> +};
> +

> +
> +
> +static void ske_keypad_timer(unsigned long data)
> +{
> +	struct platform_device *pdev =  (struct platform_device *) data;
> +	struct ske_keypad *keypad = platform_get_drvdata(pdev);
> +	int ske_kpason;
> +	int timeout = keypad->board->debounce_ms;
> +
> +	ske_kpason = readl(keypad->reg_base + SKE_CR) & SKE_KPASON;
> +	if (ske_kpason) {
> +		mod_timer(&keypad->timer, jiffies + msecs_to_jiffies(timeout));
> +		return;
> +	}
> +
> +	/* read data registers and report event */
> +	ske_keypad_read_data(keypad);
> +
> +	return;

No need.

> +}

...

> +
> +
> +
> +	spin_lock_init(&keypad->ske_keypad_lock);
> +	setup_timer(&keypad->timer, ske_keypad_timer, (unsigned long)pdev);
> +
> +	ret =  request_threaded_irq(keypad->irq, NULL, ske_keypad_irq,
> +				IRQF_ONESHOT, "ske-keypad", keypad);
> +	if (ret) {
> +		dev_err(&pdev->dev, "allocate irq %d failed\n", keypad->irq);
> +		goto out_unregisterinput;
> +	}

Can you please clarify why you need thread? Looking at the code, I don't think that
we have any need of creating thread. request_irq(...) should work just fine.

> +
> +	device_init_wakeup(&pdev->dev, true);

Can you make this pdata?

> +
> +	platform_set_drvdata(pdev, keypad);
> +
> +	return 0;
> +
> +out_unregisterinput:
> +	input_unregister_device(input);
> +	input = NULL;
> +	clk_disable(keypad->clk);
> +out_freeinput:
> +	input_free_device(input);
> +out_freekeypad:
> +	kfree(keypad);
> +out_freeclk:
> +	clk_put(clk);
> +out_freeioremap:
> +	iounmap(reg_base);
> +out_freerequest_memregions:
> +	release_mem_region(res->start, resource_size(res));
> +out_ret:
> +	return ret;
> +}
> +

> +
> +static const struct dev_pm_ops ske_keypad_dev_pm_ops = {
> +	.suspend = ske_keypad_suspend,
> +	.resume = ske_keypad_resume,
> +};
> +#endif
> +
> +struct platform_driver ske_keypad_driver = {
> +	.driver = {
> +		.name = "nmk-ske-keypad",
> +		.owner  = THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm = &ske_keypad_dev_pm_ops,
> +#endif
> +	},
> +	.probe = ske_keypad_probe,
> +	.remove = __devexit_p(ske_keypad_remove),
> +};
> +

> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Naveen Kumar G/Sundar Iyer");

Care to add e-mail address?

> +MODULE_DESCRIPTION("Nomadik Scroll-Key-Encoder Keypad Driver");
> +MODULE_ALIAS("platform:nomadik-ske-keypad");


---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
