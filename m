From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Tue, 2 Jun 2009 16:55:17 +0200
Message-ID: <200906021655.18476.u.luckas@road.de>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <200905271526.59064.u.luckas@road.de> <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from server.road.de ([85.10.209.111]:33437 "EHLO mail.road.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755942AbZFBOzV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Jun 2009 10:55:21 -0400
In-Reply-To: <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sunday, 31. May 2009, Eric Miao wrote:
> +#ifdef CONFIG_PM
> +static int matrix_keypad_suspend(struct platform_device *pdev,
> pm_message_t state)
> +{
> +       struct matrix_keypad *keypad = platform_get_drvdata(pdev);
> +       struct matrix_keypad_platform_data *pdata = keypad->pdata;
> +       int i;
> +
> +       disable_row_irqs(keypad);
> +       flush_work(&keypad->work.work);
> 
Hi Eric,
thanks for fixing the problems. One comment on the approach:
disable_row_irqs uses disable_irq_nosync. I guess this still works as
the interrupt handler is requested with IRQF_DISABLED.

Some more non-show stoppers:
1) On some SoCs wakeup gpios are a precoius resource. Therfore a hardware design which ORs all row gpios and connects the result to a single row_interrupt might be smart. Could 
the driver be made generic enought to support this?
2) Did anyone ever wonder why this driver is able to detect a second key press on the same row? Actually the driver has polling behavior while any key is pressed. This is 
because scanning the key matix triggers a new interrupt on every row. Every one of these interrupts will fire as soon as enable_irq is called, scheduling a new scan after the 
debounce period. I think that is worth being documented in the source code.

regards,
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

