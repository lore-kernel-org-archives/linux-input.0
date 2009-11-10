From: Onkalo Samu <samu.p.onkalo@nokia.com>
Subject: Re: [PATCH 1/1] Input polldev: Sysfs interface for setting of
 polling interval
Date: Tue, 10 Nov 2009 09:02:18 +0200
Message-ID: <1257836538.22403.3.camel@4fid08082>
References: <1257771783-31210-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1257771783-31210-2-git-send-email-samu.p.onkalo@nokia.com>
	 <20091109172850.GB30386@core.coreip.homeip.net>
Reply-To: samu.p.onkalo@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56237 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZKJHCV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 02:02:21 -0500
In-Reply-To: <20091109172850.GB30386@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,
Thank you for the comments.

On Mon, 2009-11-09 at 18:28 +0100, ext Dmitry Torokhov wrote:
  
>> -static void input_polldev_stop_workqueue(void)
>> +static void input_polldev_stop_workqueue(struct input_polled_dev 
>> +*dev)
>>  {
>>  	mutex_lock(&polldev_mutex);
>>  
>> +	cancel_delayed_work_sync(&dev->work);
>> +
>
>Why is this needed? We cancel the work when we close the device.
>

Actually not needed. I'll remove that.

>> +static ssize_t input_polldev_set_interval(struct device *dev,
>> +				struct device_attribute *attr, 
>const char *buf,
>> +				size_t count)
>> +{
>> +	struct input_polled_dev *polldev = dev_get_drvdata(dev);
>> +	unsigned long delay;
>> +	unsigned long interval;
>> +
>> +	if (strict_strtoul(buf, 0, &interval))
>> +		return -EINVAL;
>> +
>> +	if (interval < polldev->poll_interval_min)
>> +		return -EINVAL;
>> +
>> +	if (interval > polldev->poll_interval_max)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&polldev_mutex);
>
>I think you want to use polldev->dev->mutex here instead.

Yes, there is not need to lock all polled devices. And using 
that mutex we also avoid possible race conditions between close / open
operations.

>
>> +
>> +	polldev->poll_interval = interval;
>> +
>> +	if (polldev->is_opened) {
>
>polldev->dev->users.

Sure.

>
>> +		if (polldev->poll_interval > 0) {
>> +			delay = 
>msecs_to_jiffies(polldev->poll_interval);
>> +			if (delay >= HZ)
>> +				delay = round_jiffies_relative(delay);
>> +
>> +			queue_delayed_work(polldev_wq, 
>&polldev->work, delay);
>
>This will not treschedule the work with the new interval if 
>the old one is already scheduled.

True. I'll cancel work before scheduling new one. 

>
>> +		} else {
>> +			cancel_delayed_work_sync(&polldev->work);
>
>Do we need to support stopping the polling ocmpletely?

If the polled device is used for cases where there are parallel
need for polled and interrupt based events, users may want to disable
polling. Some small sensors can utilize this combination. Especially in
battery operated devices this makes sense. Userspace can stop regular
polling, but still get part of the events from the device.

>> +
>> +static DEVICE_ATTR(interval, S_IRUGO | S_IWUSR, 
>input_polldev_get_interval,
>> +						
>input_polldev_set_interval);
>> +
>> +static struct attribute *sysfs_attrs[] = {
>> +	&dev_attr_interval.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group input_polldev_attribute_group = {
>> +	.attrs = sysfs_attrs
>> +};
>
>Do you need attribute group? It is unnamed and we have just 
>one attribute... But maybe we should make it named, like 
>"poll" and add upper and lower limits (read-only).

I'll change interface to "poll", "min" and "max"

-Samu


