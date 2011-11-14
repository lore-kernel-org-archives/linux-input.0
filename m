From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 10:57:41 -0800
Message-ID: <201111141057.42310.dmitry.torokhov@gmail.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com> <4EC15CD1.2010409@edigma.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57794 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab1KNS5t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 13:57:49 -0500
Received: by gyc15 with SMTP id 15so5201378gyc.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 10:57:49 -0800 (PST)
In-Reply-To: <4EC15CD1.2010409@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

On Monday, November 14, 2011 10:24:17 AM Nuno Santos wrote:
> Hi,
> 
> I have defined my first attribute in the following way:
> 
> static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
>                                          struct device_attribute *attr,
>                                          const char *buf, size_t count)
> {
> 
>      printk(KERN_INFO "update sensibility called");
> 

Updating sensibility is always a good thing but I gather you mean 
sensitivity here...

BTW this should probably be a per-user setting and belong to the X driver, 
not kernel driver. I.e. kernel streams all data and userspace (X) decides 
what data do discard according to current user preferences.

>      return 0;
> }
> 
> static DEVICE_ATTR(sensibility, 0664, NULL,
> usbtouchscreen_update_sensibility);
> 
> static struct attribute *usbtouchscreen_attrs[] = {
> &dev_attr_sensibility.attr,
>          NULL
> };
> 
> static const struct attribute_group usbtouchscreen_attr_group = {
>          .attrs = usbtouchscreen_attrs,
> };
> 
> In the probe function I have added:
> 
> if (sysfs_create_group(&intf->dev.kobj, &usbtouchscreen_attr_group))
>          goto out_unregister_input;
> 
> 
> Then I tried to write on the attribute in the following way:
> 
> nsantos@NS-PC:~/workspaces/linux-kernel-driver$ echo 45 >
> /sys/class/input/input7/sensibility
> bash: /sys/class/input/input7/sensibility: No such file or directory
> 
> After digging a bit under /sys/class/input/input7 i found that the sub
> directory device add sensibilty listed so I tried the following:
> 
> nsantos@NS-PC:~/workspaces/workspace-mtt/linux-kernel-driver$ sudo echo
> 45 > /sys/class/input/input7/device/sensibility
> bash: /sys/class/input/input7/device/sensibility: Permission denied
> 
> With no success again...
> 
> Am I doing something terribly wrong?

You aren't doing this as root and don't have permission to access the 
attribute.

-- 
Dmitry
