From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 10:23:31 -0800
Message-ID: <20111115182331.GA6410@core.coreip.homeip.net>
References: <4EC10878.20109@edigma.com>
 <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com>
 <4EC15CD1.2010409@edigma.com>
 <201111141057.42310.dmitry.torokhov@gmail.com>
 <4EC23252.8030003@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64424 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757134Ab1KOSXl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 13:23:41 -0500
Received: by yenq3 with SMTP id q3so933277yen.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 10:23:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC23252.8030003@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

On Tue, Nov 15, 2011 at 09:35:14AM +0000, Nuno Santos wrote:
> On 11/14/2011 06:57 PM, Dmitry Torokhov wrote:
> >On Monday, November 14, 2011 10:24:17 AM Nuno Santos wrote:
> >>Hi,
> >>
> >>I have defined my first attribute in the following way:
> >>
> >>static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
> >>                                          struct device_attribute *attr,
> >>                                          const char *buf, size_t count)
> >>{
> >>
> >>      printk(KERN_INFO "update sensibility called");
> >>
> >Updating sensibility is always a good thing but I gather you mean
> >sensitivity here...
> 
> hahaahha thanks for the correction!!!! I need to do it in several
> places now! :)
> >
> >BTW this should probably be a per-user setting and belong to the X driver,
> >not kernel driver. I.e. kernel streams all data and userspace (X) decides
> >what data do discard according to current user preferences.
> didn't knew about this capability. but how do you change the
> settings thru X? where can I find the API for that?

This API is private to particular X driver. For example Synaptics X
driver (that handles all touchpads that we support in Linux, be it
actualy Synaptics, ALPS, Elantech, Sentelic, Broadcom, etc) allows user
select touch sensitivity. If device support pressure reading
(ABS_PRESSURE) then X driver will simply ignore all event packets where
pressure is less than the threshold. The kernel portion still streams
all events; the X portion is simply choses to ignore some of them,
according to user preference.

> >
> >>      return 0;

Actually this shoudl be

	return count;

> >>}
> >>
> >>static DEVICE_ATTR(sensibility, 0664, NULL,
> >>usbtouchscreen_update_sensibility);
> >>
> >>static struct attribute *usbtouchscreen_attrs[] = {
> >>&dev_attr_sensibility.attr,
> >>          NULL
> >>};
> >>
> >>static const struct attribute_group usbtouchscreen_attr_group = {
> >>          .attrs = usbtouchscreen_attrs,
> >>};
> >>
> >>In the probe function I have added:
> >>
> >>if (sysfs_create_group(&intf->dev.kobj,&usbtouchscreen_attr_group))
> >>          goto out_unregister_input;
> >>
> >>
> >>Then I tried to write on the attribute in the following way:
> >>
> >>nsantos@NS-PC:~/workspaces/linux-kernel-driver$ echo 45>
> >>/sys/class/input/input7/sensibility
> >>bash: /sys/class/input/input7/sensibility: No such file or directory
> >>
> >>After digging a bit under /sys/class/input/input7 i found that the sub
> >>directory device add sensibilty listed so I tried the following:
> >>
> >>nsantos@NS-PC:~/workspaces/workspace-mtt/linux-kernel-driver$ sudo echo
> >>45>  /sys/class/input/input7/device/sensibility
> >>bash: /sys/class/input/input7/device/sensibility: Permission denied
> >>
> >>With no success again...
> >>
> >>Am I doing something terribly wrong?
> >You aren't doing this as root and don't have permission to access the
> >attribute.
> sudo doesn't work in this case? Because I was suddoing.

Should have worked, something else must be wrong then.

> if I change
> the attribute to 777 will it be available to everyone? is this a
> good way of doing it?

Generally we restrict access to sysfs attributes to root since they
control behavior for all users, not only one why is changin sysfs
attribute.

BTW, please use "reply-all" on linux kernel mailing lists - it is most
preferred method. This way you ensure faster responses from people who
already participating in the thread as I scan my inbox is much more
often than folder where I save linux-input mails.

-- 
Dmitry
