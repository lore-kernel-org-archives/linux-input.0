From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] input/keyboard: new OpenCores Keyboard Controller
	driver
Date: Tue, 15 Sep 2009 20:45:55 -0700
Message-ID: <20090916034555.GA2756@core.coreip.homeip.net>
References: <20090915055224.GD1132@core.coreip.homeip.net> <1253066440-25555-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f172.google.com ([209.85.221.172]:36675 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZIPDp5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 23:45:57 -0400
Content-Disposition: inline
In-Reply-To: <1253066440-25555-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Herrero <jherrero@hvsistemas.es>, Bryan Wu <cooloney@kernel.org>

Hi Mike,

On Tue, Sep 15, 2009 at 10:00:40PM -0400, Mike Frysinger wrote:
> +
> +static int __devexit opencores_kbd_remove(struct platform_device *pdev)
> +{
> +	struct opencores_kbd *opencores_kbd = platform_get_drvdata(pdev);
> +
> +	free_irq(opencores_kbd->irq, opencores_kbd);
> +
> +	input_unregister_device(opencores_kbd->input);
> +	kfree(opencores_kbd);

You need to do iounmap and free the memory region here as well.
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +

-- 
Dmitry
