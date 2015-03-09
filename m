From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042 / PM: Allow PC keyboard to wake up from
 suspend-to-idle
Date: Mon, 9 Mar 2015 11:00:04 -0700
Message-ID: <20150309180004.GA22993@dtor-ws>
References: <2197217.yzvHkR7SyK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38926 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbCISAK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 14:00:10 -0400
Content-Disposition: inline
In-Reply-To: <2197217.yzvHkR7SyK@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

Hi Rafael,

On Mon, Mar 09, 2015 at 04:19:50PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If they keyboard interrupt is registered, mark the i8042 platform
> device as wakeup-capable and check the user space wakeup setting in
> i8042_pm_suspend() and i8042_pm_resume() to enable or disable,
> respectively, the keyboard interrupt to wake up the system.
> 
> This makes it possible to use the PC keyboard to wake up the system
> from suspend-to-idle after writing "enabled" to the i8042 device's
> power/wakeup sysfs attribute.

Why do we do that for KBD but not AUX port? Should we mark individual
serio port be wakeup capable and not the whole i8042.

Also, why exactly is this needed? My laptops seem to resume just fine
from keyboard activity without this patch...

Thanks.

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/input/serio/i8042.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: linux-pm/drivers/input/serio/i8042.c
> ===================================================================
> --- linux-pm.orig/drivers/input/serio/i8042.c
> +++ linux-pm/drivers/input/serio/i8042.c
> @@ -1163,12 +1163,17 @@ static int i8042_controller_resume(bool
>  static int i8042_pm_suspend(struct device *dev)
>  {
>  	i8042_controller_reset(true);
> +	if (device_may_wakeup(&i8042_platform_device->dev))
> +		enable_irq_wake(I8042_KBD_IRQ);
>  
>  	return 0;
>  }
>  
>  static int i8042_pm_resume(struct device *dev)
>  {
> +	if (device_may_wakeup(&i8042_platform_device->dev))
> +		disable_irq_wake(I8042_KBD_IRQ);
> +
>  	/*
>  	 * On resume from S2R we always try to reset the controller
>  	 * to bring it in a sane state. (In case of S2D we expect
> @@ -1406,6 +1411,7 @@ static int __init i8042_setup_kbd(void)
>  	if (error)
>  		goto err_free_irq;
>  
> +	device_set_wakeup_capable(&i8042_platform_device->dev, true);
>  	i8042_kbd_irq_registered = true;
>  	return 0;
>  
> 

-- 
Dmitry
