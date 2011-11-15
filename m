From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 09:35:14 +0000
Message-ID: <4EC23252.8030003@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com> <4EC15CD1.2010409@edigma.com> <201111141057.42310.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:55604 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab1KOJfR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 04:35:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id E2FDC37618D9
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:35:15 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Phg29zbl8aqV for <linux-input@vger.kernel.org>;
	Tue, 15 Nov 2011 09:35:15 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id DE4A3376185B
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 09:35:14 +0000 (WET)
In-Reply-To: <201111141057.42310.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 11/14/2011 06:57 PM, Dmitry Torokhov wrote:
> On Monday, November 14, 2011 10:24:17 AM Nuno Santos wrote:
>> Hi,
>>
>> I have defined my first attribute in the following way:
>>
>> static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
>>                                           struct device_attribute *attr,
>>                                           const char *buf, size_t count)
>> {
>>
>>       printk(KERN_INFO "update sensibility called");
>>
> Updating sensibility is always a good thing but I gather you mean
> sensitivity here...

hahaahha thanks for the correction!!!! I need to do it in several places 
now! :)
>
> BTW this should probably be a per-user setting and belong to the X driver,
> not kernel driver. I.e. kernel streams all data and userspace (X) decides
> what data do discard according to current user preferences.
didn't knew about this capability. but how do you change the settings 
thru X? where can I find the API for that?
>
>>       return 0;
>> }
>>
>> static DEVICE_ATTR(sensibility, 0664, NULL,
>> usbtouchscreen_update_sensibility);
>>
>> static struct attribute *usbtouchscreen_attrs[] = {
>> &dev_attr_sensibility.attr,
>>           NULL
>> };
>>
>> static const struct attribute_group usbtouchscreen_attr_group = {
>>           .attrs = usbtouchscreen_attrs,
>> };
>>
>> In the probe function I have added:
>>
>> if (sysfs_create_group(&intf->dev.kobj,&usbtouchscreen_attr_group))
>>           goto out_unregister_input;
>>
>>
>> Then I tried to write on the attribute in the following way:
>>
>> nsantos@NS-PC:~/workspaces/linux-kernel-driver$ echo 45>
>> /sys/class/input/input7/sensibility
>> bash: /sys/class/input/input7/sensibility: No such file or directory
>>
>> After digging a bit under /sys/class/input/input7 i found that the sub
>> directory device add sensibilty listed so I tried the following:
>>
>> nsantos@NS-PC:~/workspaces/workspace-mtt/linux-kernel-driver$ sudo echo
>> 45>  /sys/class/input/input7/device/sensibility
>> bash: /sys/class/input/input7/device/sensibility: Permission denied
>>
>> With no success again...
>>
>> Am I doing something terribly wrong?
> You aren't doing this as root and don't have permission to access the
> attribute.
sudo doesn't work in this case? Because I was suddoing. if I change the 
attribute to 777 will it be available to everyone? is this a good way of 
doing it?


Sorry for all this questions. Is my first linux driver ever!

Thanks,

With my best regards,

Nuno
