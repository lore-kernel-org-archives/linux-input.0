From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 18:24:17 +0000
Message-ID: <4EC15CD1.2010409@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com> <4EC13B0F.2080509@edigma.com> <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com> <4EC1427D.2090703@edigma.com> <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:57847 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab1KNSYV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 13:24:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id C4A933761900
	for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 18:24:19 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1JUaF4wh6+e for <linux-input@vger.kernel.org>;
	Mon, 14 Nov 2011 18:24:19 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id BE31237618FC
	for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 18:24:18 +0000 (WET)
In-Reply-To: <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have defined my first attribute in the following way:

static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
                                         struct device_attribute *attr,
                                         const char *buf, size_t count)
{

     printk(KERN_INFO "update sensibility called");

     return 0;
}

static DEVICE_ATTR(sensibility, 0664, NULL, 
usbtouchscreen_update_sensibility);

static struct attribute *usbtouchscreen_attrs[] = {
&dev_attr_sensibility.attr,
         NULL
};

static const struct attribute_group usbtouchscreen_attr_group = {
         .attrs = usbtouchscreen_attrs,
};

In the probe function I have added:

if (sysfs_create_group(&intf->dev.kobj, &usbtouchscreen_attr_group))
         goto out_unregister_input;


Then I tried to write on the attribute in the following way:

nsantos@NS-PC:~/workspaces/linux-kernel-driver$ echo 45 > 
/sys/class/input/input7/sensibility
bash: /sys/class/input/input7/sensibility: No such file or directory

After digging a bit under /sys/class/input/input7 i found that the sub 
directory device add sensibilty listed so I tried the following:

nsantos@NS-PC:~/workspaces/workspace-mtt/linux-kernel-driver$ sudo echo 
45 > /sys/class/input/input7/device/sensibility
bash: /sys/class/input/input7/device/sensibility: Permission denied

With no success again...

Am I doing something terribly wrong?

Thanks in advance,

Regards,

Nuno
