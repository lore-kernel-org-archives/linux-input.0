From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH] Input: enable i8042-level wakeup control
Date: Fri, 11 Mar 2011 01:01:17 -0800
Message-ID: <20110311010117.18968941@queued.net>
References: <20110210171607.D0D419D401D@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LUNGE.MIT.EDU ([18.54.1.69]:46693 "EHLO lunge.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab1CKJBW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 04:01:22 -0500
In-Reply-To: <20110210171607.D0D419D401D@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, rjw@sisk.pl

On Thu, 10 Feb 2011 17:16:07 +0000 (GMT)
Daniel Drake <dsd@laptop.org> wrote:

> The OLPC XO laptop is able to use the PS/2 controller as a wakeup
> source. When used as a wakeup source, the key press/mouse motion must
> not be lost.
> 
> Add infrastructure to allow controllers to be marked as
> wakeup-capable, and avoid doing power control/reset on the
> i8042/serio devices when running in this mode.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/input/serio/i8042-io.h        |    4 +++
>  drivers/input/serio/i8042-ip22io.h    |    4 +++
>  drivers/input/serio/i8042-jazzio.h    |    4 +++
>  drivers/input/serio/i8042-ppcio.h     |    4 +++
>  drivers/input/serio/i8042-snirm.h     |    4 +++
>  drivers/input/serio/i8042-sparcio.h   |    4 +++
>  drivers/input/serio/i8042-x86ia64io.h |    4 +++
>  drivers/input/serio/i8042.c           |   37
> +++++++++++++++++++++++++++++---
> drivers/input/serio/serio.c           |   28 +++++++++++++++++++++---
> 9 files changed, 85 insertions(+), 8 deletions(-)
> 
> A followup patch will come soon, hooking this into OLPC's embedded
> controller:
> http://dev.laptop.org/~dsd/20110114/0015-i8042-Enable-OLPC-s-EC-based-i8042-wakeup-control.patch
> 
> diff --git a/drivers/input/serio/i8042-io.h
> b/drivers/input/serio/i8042-io.h index 5d48bb6..296633c 100644
> --- a/drivers/input/serio/i8042-io.h
> +++ b/drivers/input/serio/i8042-io.h
> @@ -92,4 +92,8 @@ static inline void i8042_platform_exit(void)
>  #endif
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool
> may_wakeup) +{
> +}
> +
>  #endif /* _I8042_IO_H */
> diff --git a/drivers/input/serio/i8042-ip22io.h
> b/drivers/input/serio/i8042-ip22io.h index ee1ad27..c5b76a4 100644
> --- a/drivers/input/serio/i8042-ip22io.h
> +++ b/drivers/input/serio/i8042-ip22io.h
> @@ -73,4 +73,8 @@ static inline void i8042_platform_exit(void)
>  #endif
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool
> may_wakeup) +{
> +}
> +
>  #endif /* _I8042_IP22_H */
> diff --git a/drivers/input/serio/i8042-jazzio.h
> b/drivers/input/serio/i8042-jazzio.h index 13fd710..a11913a 100644
> --- a/drivers/input/serio/i8042-jazzio.h
> +++ b/drivers/input/serio/i8042-jazzio.h
> @@ -66,4 +66,8 @@ static inline void i8042_platform_exit(void)
>  #endif
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool
> may_wakeup) +{
> +}
> +
>  #endif /* _I8042_JAZZ_H */
> diff --git a/drivers/input/serio/i8042-ppcio.h
> b/drivers/input/serio/i8042-ppcio.h index f708c75..c9f4292 100644
> --- a/drivers/input/serio/i8042-ppcio.h
> +++ b/drivers/input/serio/i8042-ppcio.h
> @@ -52,6 +52,10 @@ static inline void i8042_platform_exit(void)
>  {
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool
> may_wakeup) +{
> +}
> +
>  #else
>  
>  #include "i8042-io.h"
> diff --git a/drivers/input/serio/i8042-snirm.h
> b/drivers/input/serio/i8042-snirm.h index 409a934..96d034f 100644
> --- a/drivers/input/serio/i8042-snirm.h
> +++ b/drivers/input/serio/i8042-snirm.h
> @@ -72,4 +72,8 @@ static inline void i8042_platform_exit(void)
>  
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool
> may_wakeup) +{
> +}
> +
>  #endif /* _I8042_SNIRM_H */
> diff --git a/drivers/input/serio/i8042-sparcio.h
> b/drivers/input/serio/i8042-sparcio.h index c5cc450..a6c1f74 100644
> --- a/drivers/input/serio/i8042-sparcio.h
> +++ b/drivers/input/serio/i8042-sparcio.h
> @@ -154,4 +154,8 @@ static inline void i8042_platform_exit(void)
>  }
>  #endif /* !CONFIG_PCI */
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool
> may_wakeup) +{
> +}
> +
>  #endif /* _I8042_SPARCIO_H */
> diff --git a/drivers/input/serio/i8042-x86ia64io.h
> b/drivers/input/serio/i8042-x86ia64io.h index bb9f5d3..76b2e58 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -875,6 +875,10 @@ static inline int i8042_pnp_init(void) { return
> 0; } static inline void i8042_pnp_exit(void) { }
>  #endif
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool
> may_wakeup) +{
> +}
> +
>  static int __init i8042_platform_init(void)
>  {
>  	int retval;
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index ac4c936..fb9dee6 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -79,6 +79,10 @@ module_param_named(nopnp, i8042_nopnp, bool, 0);
>  MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller
> settings"); #endif
>  
> +static bool i8042_enable_wakeup;
> +module_param_named(enable_wakeup, i8042_enable_wakeup, bool, 0);
> +MODULE_PARM_DESC(enable_wakeup, "Enable i8042 as wakeup-capable
> device"); +


If we're going to default to disabling this (which we should), it would
be nice to have a quirk for OLPC (probably checking DMI or something)
that enables it.


>  #define DEBUG
>  #ifdef DEBUG
>  static bool i8042_debug;
> @@ -1081,10 +1085,17 @@ static void i8042_dritek_enable(void)
>   * before suspending.
>   */
>  
> -static int i8042_controller_resume(bool force_reset)
> +static int i8042_controller_resume(bool force_reset, bool
> soft_resume) {
>  	int error;
>  
> +	/*
> +	 * If device is selected as a wakeup source, it was not
> powered down
> +	 * or reset during suspend, so we have very little to do.
> +	 */
> +	if (soft_resume)
> +		goto soft;
> +
>  	error = i8042_controller_check();
>  	if (error)
>  		return error;
> @@ -1128,6 +1139,7 @@ static int i8042_controller_resume(bool
> force_reset) if (i8042_ports[I8042_KBD_PORT_NO].serio)
>  		i8042_enable_kbd_port();
>  
> +soft:
>  	i8042_interrupt(0, NULL);
>  
>  	return 0;
> @@ -1145,6 +1157,20 @@ static int i8042_pm_reset(struct device *dev)
>  	return 0;
>  }
>  
> +static int i8042_pm_suspend(struct device *dev)
> +{
> +	i8042_platform_suspend(dev, device_may_wakeup(dev));


What exactly is the purpose of this?   I see this allows various
architectures to provide an override here, but it seems like this
functionality wasn't previously present (they all just used
i8042_pm_reset).  Do you have a later patch that makes use of this or
something?



> +
> +	/*
> +	 * If device is selected as a wakeup source, don't powerdown
> or reset
> +	 * during suspend.
> +	 */
> +	if (device_may_wakeup(dev))
> +		return 0;
> +
> +	return i8042_pm_reset(dev);
> +}
> +
>  static int i8042_pm_resume(struct device *dev)
>  {
>  	/*
> @@ -1152,7 +1178,7 @@ static int i8042_pm_resume(struct device *dev)
>  	 * to bring it in a sane state. (In case of S2D we expect
>  	 * BIOS to reset the controller for us.)
>  	 */
> -	return i8042_controller_resume(true);
> +	return i8042_controller_resume(true, device_may_wakeup(dev));
>  }
>  
>  static int i8042_pm_thaw(struct device *dev)
> @@ -1164,11 +1190,11 @@ static int i8042_pm_thaw(struct device *dev)
>  
>  static int i8042_pm_restore(struct device *dev)
>  {
> -	return i8042_controller_resume(false);
> +	return i8042_controller_resume(false, false);
>  }
>  
>  static const struct dev_pm_ops i8042_pm_ops = {
> -	.suspend	= i8042_pm_reset,
> +	.suspend	= i8042_pm_suspend,
>  	.resume		= i8042_pm_resume,
>  	.thaw		= i8042_pm_thaw,
>  	.poweroff	= i8042_pm_reset,
> @@ -1402,6 +1428,9 @@ static int __init i8042_probe(struct
> platform_device *dev) i8042_dritek_enable();
>  #endif
>  
> +	if (i8042_enable_wakeup)
> +		device_set_wakeup_capable(&dev->dev, true);
> +
>  	if (!i8042_noaux) {
>  		error = i8042_setup_aux();
>  		if (error && error != -ENODEV && error != -EBUSY)
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index db5b0bc..7480be5 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -928,7 +928,7 @@ static int serio_uevent(struct device *dev,
> struct kobj_uevent_env *env) #endif /* CONFIG_HOTPLUG */
>  
>  #ifdef CONFIG_PM
> -static int serio_suspend(struct device *dev)
> +static int serio_poweroff(struct device *dev)
>  {
>  	struct serio *serio = to_serio_port(dev);
>  
> @@ -937,7 +937,17 @@ static int serio_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int serio_resume(struct device *dev)
> +static int serio_suspend(struct device *dev)
> +{
> +	/* If parent controller is configured as a wakeup source,
> don't
> +	 * power off. */
> +	if (device_may_wakeup(dev->parent))
> +		return 0;
> +
> +	return serio_poweroff(dev);
> +}
> +
> +static int serio_restore(struct device *dev)
>  {
>  	struct serio *serio = to_serio_port(dev);
>  
> @@ -950,11 +960,21 @@ static int serio_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int serio_resume(struct device *dev)
> +{
> +	/* If parent controller is configured as a wakeup source, we
> didn't
> +	 * power off during suspend, and hence have nothing to do. */
> +	if (device_may_wakeup(dev->parent))
> +		return 0;
> +
> +	return serio_restore(dev);
> +}
> +
>  static const struct dev_pm_ops serio_pm_ops = {
>  	.suspend	= serio_suspend,
>  	.resume		= serio_resume,
> -	.poweroff	= serio_suspend,
> -	.restore	= serio_resume,
> +	.poweroff	= serio_poweroff,
> +	.restore	= serio_restore,
>  };
>  #endif /* CONFIG_PM */
>  
