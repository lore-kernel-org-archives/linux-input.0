From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] Input: enable i8042-level wakeup control
Date: Sun, 10 Jul 2011 23:00:13 +0200
Message-ID: <201107102300.14064.rjw@sisk.pl>
References: <20110709211321.5FE139D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43452 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756255Ab1GJU73 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jul 2011 16:59:29 -0400
In-Reply-To: <20110709211321.5FE139D401C@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, dilinger@queued.net, linux-pm@lists.linux-foundation.org

Hi,

On Saturday, July 09, 2011, Daniel Drake wrote:
> The OLPC XO laptop is able to use the PS/2 controller as a wakeup source.
> When used as a wakeup source, the key press/mouse motion must not be lost.
> 
> Add infrastructure to allow controllers to be marked as wakeup-capable,
> and avoid doing power control/reset on the i8042/serio/input devices when
> running in this mode. Default behaviour is unchanged - hardware platforms
> must explicitly enable this functionality if they can support it.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/input/input.c                 |   18 +++++++++++
>  drivers/input/serio/i8042-io.h        |    4 ++
>  drivers/input/serio/i8042-ip22io.h    |    4 ++
>  drivers/input/serio/i8042-jazzio.h    |    4 ++
>  drivers/input/serio/i8042-ppcio.h     |    4 ++
>  drivers/input/serio/i8042-snirm.h     |    4 ++
>  drivers/input/serio/i8042-sparcio.h   |    4 ++
>  drivers/input/serio/i8042-x86ia64io.h |    4 ++
>  drivers/input/serio/i8042.c           |   54 ++++++++++++++++++++++++++++++--
>  drivers/input/serio/serio.c           |   28 ++++++++++++++--
>  10 files changed, 120 insertions(+), 8 deletions(-)
> 
> A followup patch will come soon, hooking this into OLPC's embedded controller:
> http://dev.laptop.org/~dsd/20110114/0015-i8042-Enable-OLPC-s-EC-based-i8042-wakeup-control.patch
> The underlying infrastructure for this work has now been merged in linux-next.
> 
> On last submission, Dmitry was worried about this functionality not working
> at all on other platforms. I agree, it will only work where the hardware
> has been specifically designed with this consideration. v2 of the patch
> therefore removes the module param option, meaning that it will only be
> activated on platforms that explicitly enable it at the code level.
> 
> v2 also performs a more extensive job. We avoid resetting the device
> at the input_device level during suspend/resume - but this is ugly. Rafael,
> is there a better way? Please see the input.c hunks. We also disable
> i8042 interrupts when going into suspend, to avoid races handling interrupts
> in the wrong order during resume.
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index da38d97..81a87bc 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1588,6 +1588,15 @@ static int input_dev_suspend(struct device *dev)
>  {
>  	struct input_dev *input_dev = to_input_dev(dev);
>  
> +	/*
> +	 * If this device is a child of serio, which is a child of i8042, and
> +	 * i8042 wakeup is enabled (i.e. this input device is not being
> +	 * suspended), do nothing.
> +	 */
> +	if (dev->parent && dev->parent->parent
> +			&& device_may_wakeup(dev->parent->parent))
> +		return 0;
> +
>  	mutex_lock(&input_dev->mutex);
>  
>  	if (input_dev->users)
> @@ -1602,6 +1611,15 @@ static int input_dev_resume(struct device *dev)
>  {
>  	struct input_dev *input_dev = to_input_dev(dev);
>  
> +	/*
> +	 * If this device is a child of serio, which is a child of i8042, and
> +	 * i8042 wakeup is enabled (i.e. this input device was not suspended),
> +	 * do nothing.
> +	 */
> +	if (dev->parent && dev->parent->parent
> +			&& device_may_wakeup(dev->parent->parent))
> +		return 0;
> +

You check exactly the same condition in two places with very similar comments.
I'd put it into a bool function and add a kerneldoc description to it instead.

>  	input_reset_device(input_dev);
>  
>  	return 0;
> diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
> index 5d48bb6..296633c 100644
> --- a/drivers/input/serio/i8042-io.h
> +++ b/drivers/input/serio/i8042-io.h
> @@ -92,4 +92,8 @@ static inline void i8042_platform_exit(void)
>  #endif
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
> +{
> +}
> +
>  #endif /* _I8042_IO_H */
> diff --git a/drivers/input/serio/i8042-ip22io.h b/drivers/input/serio/i8042-ip22io.h
> index ee1ad27..c5b76a4 100644
> --- a/drivers/input/serio/i8042-ip22io.h
> +++ b/drivers/input/serio/i8042-ip22io.h
> @@ -73,4 +73,8 @@ static inline void i8042_platform_exit(void)
>  #endif
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
> +{
> +}
> +
>  #endif /* _I8042_IP22_H */
> diff --git a/drivers/input/serio/i8042-jazzio.h b/drivers/input/serio/i8042-jazzio.h
> index 13fd710..a11913a 100644
> --- a/drivers/input/serio/i8042-jazzio.h
> +++ b/drivers/input/serio/i8042-jazzio.h
> @@ -66,4 +66,8 @@ static inline void i8042_platform_exit(void)
>  #endif
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
> +{
> +}
> +
>  #endif /* _I8042_JAZZ_H */
> diff --git a/drivers/input/serio/i8042-ppcio.h b/drivers/input/serio/i8042-ppcio.h
> index f708c75..c9f4292 100644
> --- a/drivers/input/serio/i8042-ppcio.h
> +++ b/drivers/input/serio/i8042-ppcio.h
> @@ -52,6 +52,10 @@ static inline void i8042_platform_exit(void)
>  {
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
> +{
> +}
> +
>  #else
>  
>  #include "i8042-io.h"
> diff --git a/drivers/input/serio/i8042-snirm.h b/drivers/input/serio/i8042-snirm.h
> index 409a934..96d034f 100644
> --- a/drivers/input/serio/i8042-snirm.h
> +++ b/drivers/input/serio/i8042-snirm.h
> @@ -72,4 +72,8 @@ static inline void i8042_platform_exit(void)
>  
>  }
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
> +{
> +}
> +
>  #endif /* _I8042_SNIRM_H */
> diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> index 395a9af..e5381d3 100644
> --- a/drivers/input/serio/i8042-sparcio.h
> +++ b/drivers/input/serio/i8042-sparcio.h
> @@ -154,4 +154,8 @@ static inline void i8042_platform_exit(void)
>  }
>  #endif /* !CONFIG_PCI */
>  
> +static inline void i8042_platform_suspend(struct device *dev, bool may_wakeup)
> +{
> +}

The fact that you need provide several empty definitions of
i8042_platform_suspend() is a bit worrisome.  Have you considered using a
different approach?

Rafael
