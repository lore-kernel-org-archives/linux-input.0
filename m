From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042 / PM: Allow PC keyboard to wake up from
 suspend-to-idle
Date: Mon, 9 Mar 2015 17:05:03 -0700
Message-ID: <20150310000503.GC22993@dtor-ws>
References: <2197217.yzvHkR7SyK@vostro.rjw.lan>
 <20150309180004.GA22993@dtor-ws>
 <3127745.ybR8YAlvTb@vostro.rjw.lan>
 <2514027.izE5Direg3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:40016 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbCJAFI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 20:05:08 -0400
Content-Disposition: inline
In-Reply-To: <2514027.izE5Direg3@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Tue, Mar 10, 2015 at 12:08:43AM +0100, Rafael J. Wysocki wrote:
> On Monday, March 09, 2015 11:41:12 PM Rafael J. Wysocki wrote:
> > On Monday, March 09, 2015 11:00:04 AM Dmitry Torokhov wrote:
> > > Hi Rafael,
> > > 
> > > On Mon, Mar 09, 2015 at 04:19:50PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > If they keyboard interrupt is registered, mark the i8042 platform
> > > > device as wakeup-capable and check the user space wakeup setting in
> > > > i8042_pm_suspend() and i8042_pm_resume() to enable or disable,
> > > > respectively, the keyboard interrupt to wake up the system.
> > > > 
> > > > This makes it possible to use the PC keyboard to wake up the system
> > > > from suspend-to-idle after writing "enabled" to the i8042 device's
> > > > power/wakeup sysfs attribute.
> > > 
> > > Why do we do that for KBD but not AUX port? Should we mark individual
> > > serio port be wakeup capable and not the whole i8042.
> > 
> > We can do that, but only after the port serio device has been registered.
> > 
> > I guess I can add code for that to i8042_register_ports().  Let me try that.
> 
> Yeah, that works too.  And you're right that there's no reason to do that for
> keyboard only.
> 
> Patch below.

Applied, thank you.

> 
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: i8042 / PM: Allow i8042 ports to wake up from suspend-to-idle
> 
> While registering serio device for i8042, mark them as wakeup-capable
> and check their user space wakeup settings in i8042_pm_suspend() and
> i8042_pm_resume() to enable or disable, respectively, their interrupts
> to wake up the system.
> 
> This makes it possible to use the PC keyboard to wake up the system
> from suspend-to-idle, among other things, after writing "enabled" to
> the keyboard serio device's power/wakeup sysfs attribute.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/input/serio/i8042.c |   28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/input/serio/i8042.c
> ===================================================================
> --- linux-pm.orig/drivers/input/serio/i8042.c
> +++ linux-pm/drivers/input/serio/i8042.c
> @@ -1162,13 +1162,32 @@ static int i8042_controller_resume(bool
>  
>  static int i8042_pm_suspend(struct device *dev)
>  {
> +	int i;
> +
>  	i8042_controller_reset(true);
>  
> +	/* Set up serio interrupts for system wakeup. */
> +	for (i = 0; i < I8042_NUM_PORTS; i++) {
> +		struct serio *serio = i8042_ports[i].serio;
> +
> +		if (serio && device_may_wakeup(&serio->dev))
> +			enable_irq_wake(i8042_ports[i].irq);
> +	}
> +
>  	return 0;
>  }
>  
>  static int i8042_pm_resume(struct device *dev)
>  {
> +	int i;
> +
> +	for (i = 0; i < I8042_NUM_PORTS; i++) {
> +		struct serio *serio = i8042_ports[i].serio;
> +
> +		if (serio && device_may_wakeup(&serio->dev))
> +			disable_irq_wake(i8042_ports[i].irq);
> +	}
> +
>  	/*
>  	 * On resume from S2R we always try to reset the controller
>  	 * to bring it in a sane state. (In case of S2D we expect
> @@ -1300,13 +1319,16 @@ static void __init i8042_register_ports(
>  	int i;
>  
>  	for (i = 0; i < I8042_NUM_PORTS; i++) {
> -		if (i8042_ports[i].serio) {
> +		struct serio *serio = i8042_ports[i].serio;
> +
> +		if (serio) {
>  			printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
> -				i8042_ports[i].serio->name,
> +				serio->name,
>  				(unsigned long) I8042_DATA_REG,
>  				(unsigned long) I8042_COMMAND_REG,
>  				i8042_ports[i].irq);
> -			serio_register_port(i8042_ports[i].serio);
> +			serio_register_port(serio);
> +			device_set_wakeup_capable(&serio->dev, true);
>  		}
>  	}
>  }
> 

-- 
Dmitry
