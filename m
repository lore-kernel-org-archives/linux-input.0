From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH v3 1/2] Input: enable i8042-level wakeup
 control
Date: Thu, 28 Jul 2011 10:53:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107281051220.1990-100000@iolanthe.rowland.org>
References: <20110728143121.E57469D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36672 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754356Ab1G1OxE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 10:53:04 -0400
In-Reply-To: <20110728143121.E57469D401C@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org

On Thu, 28 Jul 2011, Daniel Drake wrote:

> The OLPC XO laptop is able to use the PS/2 controller as a wakeup source.
> When used as a wakeup source, the key press/mouse motion must not be lost.
> 
> Add infrastructure to allow controllers to be marked as wakeup-capable,
> and avoid doing power control/reset on the i8042/serio/input devices when
> running in this mode.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1584,10 +1584,30 @@ void input_reset_device(struct input_dev *dev)
>  EXPORT_SYMBOL(input_reset_device);
>  
>  #ifdef CONFIG_PM
> +static bool input_may_wakeup(struct device *dev)
> +{
> +	/*
> +	 * Handle an i8042 wakeup corner case. The kernel sees the i8042 device
> +	 * and its grandchild input device as independent devices on different
> +	 * buses, so each one has its own suspend/resume implementation called
> +	 * from the PM layer.
> +	 *
> +	 * In this particular case, the wakeup enable setting on the
> +	 * grandparent i8042 device must take effect here, indicating that the
> +	 * input device is powered up and should not be touched during
> +	 * suspend/resume.
> +	 */
> +	return dev->parent && dev->parent->parent
> +		&& device_may_wakeup(dev->parent->parent);
> +}

Shouldn't this also check device_may_wakeup(dev)?  The user might 
disable wakeup for the input device while leaving it enabled for the 
i8042 device.

Alan Stern

