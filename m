From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input polldev: Sysfs interface for setting of
	polling interval
Date: Mon, 9 Nov 2009 09:28:50 -0800
Message-ID: <20091109172850.GB30386@core.coreip.homeip.net>
References: <1257771783-31210-1-git-send-email-samu.p.onkalo@nokia.com> <1257771783-31210-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60584 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbZKIR2w (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2009 12:28:52 -0500
Received: by pwi3 with SMTP id 3so742798pwi.21
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2009 09:28:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257771783-31210-2-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-input@vger.kernel.org

Hi Samu,

On Mon, Nov 09, 2009 at 03:03:03PM +0200, Samu Onkalo wrote:
> Sysfs entry for reading and setting of the polling interval.
> If the interval is set to 0, polling is stopped. Polling
> is restarted when interval is changed to non-zero.
> 
> Minimum and maximum limit for interval can be set while setting up the
> device.
> 
> Interval can be adjusted even if the input device is not currently open.
> 
> applicable to Dmitry Torokhov's input-tree->next
> (git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git->next)
> 
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> ---
>  drivers/input/input-polldev.c |   86 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/input-polldev.h |    3 +
>  2 files changed, 85 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
> index 910220c..5d7fffd 100644
> --- a/drivers/input/input-polldev.c
> +++ b/drivers/input/input-polldev.c
> @@ -46,10 +46,12 @@ static int input_polldev_start_workqueue(void)
>  	return retval;
>  }
>  
> -static void input_polldev_stop_workqueue(void)
> +static void input_polldev_stop_workqueue(struct input_polled_dev *dev)
>  {
>  	mutex_lock(&polldev_mutex);
>  
> +	cancel_delayed_work_sync(&dev->work);
> +

Why is this needed? We cancel the work when we close the device.


>  	if (!--polldev_users)
>  		destroy_workqueue(polldev_wq);
>  
> @@ -83,6 +85,8 @@ static int input_open_polled_device(struct input_dev *input)
>  	if (dev->open)
>  		dev->open(dev);
>  
> +	dev->is_opened = 1;
> +
>  	queue_delayed_work(polldev_wq, &dev->work,
>  			   msecs_to_jiffies(dev->poll_interval));
>  
> @@ -93,13 +97,72 @@ static void input_close_polled_device(struct input_dev *input)
>  {
>  	struct input_polled_dev *dev = input_get_drvdata(input);
>  
> -	cancel_delayed_work_sync(&dev->work);
> -	input_polldev_stop_workqueue();
> +	dev->is_opened = 0;
> +	input_polldev_stop_workqueue(dev);
>  
>  	if (dev->close)
>  		dev->close(dev);
>  }
>  
> +/* SYSFS interface */
> +
> +static ssize_t input_polldev_get_interval(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct input_polled_dev *polldev = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", polldev->poll_interval);
> +}
> +
> +static ssize_t input_polldev_set_interval(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	struct input_polled_dev *polldev = dev_get_drvdata(dev);
> +	unsigned long delay;
> +	unsigned long interval;
> +
> +	if (strict_strtoul(buf, 0, &interval))
> +		return -EINVAL;
> +
> +	if (interval < polldev->poll_interval_min)
> +		return -EINVAL;
> +
> +	if (interval > polldev->poll_interval_max)
> +		return -EINVAL;
> +
> +	mutex_lock(&polldev_mutex);

I think you want to use polldev->dev->mutex here instead.

> +
> +	polldev->poll_interval = interval;
> +
> +	if (polldev->is_opened) {

polldev->dev->users.

> +		if (polldev->poll_interval > 0) {
> +			delay = msecs_to_jiffies(polldev->poll_interval);
> +			if (delay >= HZ)
> +				delay = round_jiffies_relative(delay);
> +
> +			queue_delayed_work(polldev_wq, &polldev->work, delay);

This will not treschedule the work with the new interval if the old one
is already scheduled.

> +		} else {
> +			cancel_delayed_work_sync(&polldev->work);

Do we need to support stopping the polling ocmpletely?

> +		}
> +	}
> +	mutex_unlock(&polldev_mutex);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(interval, S_IRUGO | S_IWUSR, input_polldev_get_interval,
> +						input_polldev_set_interval);
> +
> +static struct attribute *sysfs_attrs[] = {
> +	&dev_attr_interval.attr,
> +	NULL
> +};
> +
> +static struct attribute_group input_polldev_attribute_group = {
> +	.attrs = sysfs_attrs
> +};

Do you need attribute group? It is unnamed and we have just one
attribute... But maybe we should make it named, like "poll" and add
upper and lower limits (read-only).

> +
>  /**
>   * input_allocate_polled_device - allocated memory polled device
>   *
> @@ -153,15 +216,27 @@ EXPORT_SYMBOL(input_free_polled_device);
>  int input_register_polled_device(struct input_polled_dev *dev)
>  {
>  	struct input_dev *input = dev->input;
> +	int error;
>  
>  	input_set_drvdata(input, dev);
>  	INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
>  	if (!dev->poll_interval)
>  		dev->poll_interval = 500;
> +	if (!dev->poll_interval_max)
> +		dev->poll_interval_max = dev->poll_interval;
>  	input->open = input_open_polled_device;
>  	input->close = input_close_polled_device;
>  
> -	return input_register_device(input);
> +	error = input_register_device(input);
> +	if (error < 0)
> +		goto fail;
> +
> +	error = sysfs_create_group(&input->dev.kobj,
> +				   &input_polldev_attribute_group);
> +	if (error < 0)
> +		input_unregister_device(input);
> +fail:
> +	return error;
>  }
>  EXPORT_SYMBOL(input_register_polled_device);
>  
> @@ -177,6 +252,9 @@ EXPORT_SYMBOL(input_register_polled_device);
>   */
>  void input_unregister_polled_device(struct input_polled_dev *dev)
>  {
> +	sysfs_remove_group(&dev->input->dev.kobj,
> +			   &input_polldev_attribute_group);
> +
>  	input_unregister_device(dev->input);
>  	dev->input = NULL;
>  }
> diff --git a/include/linux/input-polldev.h b/include/linux/input-polldev.h
> index 5c0ec68..f2b1e03 100644
> --- a/include/linux/input-polldev.h
> +++ b/include/linux/input-polldev.h
> @@ -36,6 +36,9 @@ struct input_polled_dev {
>  	void (*close)(struct input_polled_dev *dev);
>  	void (*poll)(struct input_polled_dev *dev);
>  	unsigned int poll_interval; /* msec */
> +	unsigned int poll_interval_max; /* msec */
> +	unsigned int poll_interval_min; /* msec */
> +	int is_opened;
>  
>  	struct input_dev *input;
>  	struct delayed_work work;
> -- 
> 1.5.6.3
> 

-- 
Dmitry
