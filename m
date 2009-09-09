From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
Date: Wed, 9 Sep 2009 12:52:55 +0100
Message-ID: <20090909115255.GB9548@sirena.org.uk>
References: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55899 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbZIILwz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:52:55 -0400
Content-Disposition: inline
In-Reply-To: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jsgood.yang@samsung.com
Cc: dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyeongil Kim <ki0351.kim@samsung.com>

On Wed, Sep 09, 2009 at 08:11:03PM +0900, jsgood.yang@samsung.com wrote:

> +#ifdef CONFIG_PM
> +static int s3c_keypad_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	struct s3c_keypad *keypad = platform_get_drvdata(pdev);
> +
> +	keypad->keyifcon = readl(keypad->regs + S3C_KEYIFCON);
> +	keypad->keyiffc = readl(keypad->regs + S3C_KEYIFFC);
> +
> +	disable_irq(IRQ_KEYPAD);
> +	clk_disable(keypad->clk);
> +
> +	return 0;
> +}

This will unconditionally enable the clock but the clock is only enabled
while the input device is opened.  This may create confusion or generate
warnings with the clock API so it'd be better to avoid doing this.

A similar problem exists in the resume function.
