From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input
 device
Date: Mon, 02 Jan 2017 16:27:05 +0100
Message-ID: <1483370825.2420.8.camel@hadess.net>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41057 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756282AbdABP1m (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 2 Jan 2017 10:27:42 -0500
In-Reply-To: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 2016-12-25 at 11:04 +0100, Pali Rohár wrote:
> This patch allows user to disable events from any input device so
> events
> would not be delivered to userspace.
> 
> Currently there is no way to disable particular input device by
> kernel.
> User for different reasons would need it for integrated PS/2 keyboard
> or
> touchpad in notebook or touchscreen on mobile device to prevent
> sending
> events. E.g. mobile phone in pocket or broken integrated PS/2
> keyboard.
> 
> This is just a RFC patch, not tested yet. Original post about
> motivation
> about this patch is there: https://lkml.org/lkml/2014/11/29/92

Having implemented something of that ilk in user-space (we
automatically disable touch devices when the associated screen is
turned off/suspended), I think this might need more thought.

What happens when a device is opened and the device disabled through
sysfs, are the users revoked?

Does this put the device in suspend in the same way that closing the
device's last user does?

Is this not better implemented in user-space at the session level,
where it knows about which output corresponds to which input device?

Is this useful enough to disable misbehaving devices on hardware, so
that the device is not effective on boot?

> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> ---
>  drivers/input/input.c |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/input.h |    4 ++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index d95c34e..9f0da7e 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -430,6 +430,9 @@ void input_event(struct input_dev *dev,
>  {
>  	unsigned long flags;
>  
> +	if (unlikely(dev->disabled))
> +		return;
> +
>  	if (is_event_supported(type, dev->evbit, EV_MAX)) {
>  
>  		spin_lock_irqsave(&dev->event_lock, flags);
> @@ -457,6 +460,9 @@ void input_inject_event(struct input_handle
> *handle,
>  	struct input_handle *grab;
>  	unsigned long flags;
>  
> +	if (unlikely(dev->disabled))
> +		return;
> +
>  	if (is_event_supported(type, dev->evbit, EV_MAX)) {
>  		spin_lock_irqsave(&dev->event_lock, flags);
>  
> @@ -1389,12 +1395,41 @@ static ssize_t
> input_dev_show_properties(struct device *dev,
>  }
>  static DEVICE_ATTR(properties, S_IRUGO, input_dev_show_properties,
> NULL);
>  
> +static ssize_t input_dev_show_disable(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct input_dev *input_dev = to_input_dev(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", input_dev->disabled
> ? 1 : 0);
> +}
> +static ssize_t input_dev_store_disable(struct device *dev,
> +				       struct device_attribute
> *attr,
> +				       const char *buf, size_t
> count)
> +{
> +	struct input_dev *input_dev = to_input_dev(dev);
> +	int disable;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &disable);
> +	if (ret)
> +		return ret;
> +
> +	if (disable != 0 && disable != 1)
> +		return -EINVAL;
> +
> +	input_dev->disabled = disable;
> +	return count;
> +}
> +static DEVICE_ATTR(disable, S_IRUGO | S_IWUSR,
> input_dev_show_disable, input_dev_store_disable);
> +
>  static struct attribute *input_dev_attrs[] = {
>  	&dev_attr_name.attr,
>  	&dev_attr_phys.attr,
>  	&dev_attr_uniq.attr,
>  	&dev_attr_modalias.attr,
>  	&dev_attr_properties.attr,
> +	&dev_arrr_disable.attr,
>  	NULL
>  };
>  
> diff --git a/include/linux/input.h b/include/linux/input.h
> index a65e3b2..e390b56 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -117,6 +117,8 @@ struct input_value {
>   * @vals: array of values queued in the current frame
>   * @devres_managed: indicates that devices is managed with devres
> framework
>   *	and needs not be explicitly unregistered or freed.
> + * @disabled: indicates that device is in disabled state and kernel
> drop
> + *	all events from it
>   */
>  struct input_dev {
>  	const char *name;
> @@ -187,6 +189,8 @@ struct input_dev {
>  	struct input_value *vals;
>  
>  	bool devres_managed;
> +
> +	bool disabled;
>  };
>  #define to_input_dev(d) container_of(d, struct input_dev, dev)
>  
