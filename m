From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Introduce Naming Convention in Input Subsystem
Date: Wed, 8 Jan 2014 22:52:59 -0800
Message-ID: <20140109065259.GB29893@core.coreip.homeip.net>
References: <1389243476-11196-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:61522 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbaAIGxD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 01:53:03 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so2913448pad.31
        for <linux-input@vger.kernel.org>; Wed, 08 Jan 2014 22:53:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389243476-11196-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, cpgs@samsung.com, a.anurag@samsung.com, naveen.sel@samsung.com, aniroop.mathur@gmail.com, vikas.kala@samsung.com, narendra.m1@samsung.com, poorva.s@samsung.com

Hi Aniroop,

On Thu, Jan 09, 2014 at 10:27:56AM +0530, Aniroop Mathur wrote:
> This patch allows user(driver) to set sysfs node name of input
> devices.  To set sysfs node name, user(driver) just needs to set
> node_name_unique variable.  If node_name_unique is not set, default
> name is given(as before).  So, this patch is completely
> backward-compatible.
> 
> Sysfs Input node name format is: input_<name>
> Sysfs Event node name format is: event_<name>
>
> This "name" is given by user and automatically, prefix(input and
> event) is added by input core.
> 
> This name must be unique among all input devices and driver(user) has
> the responsibility to ensure it.  If same name is used again for other
> input device, registration of that input device will fail because two
> input devices cannot have same name.
> 
> Advantages of this patch are:
> 
> 1. Reduces Booting Time of HAL/Upper-Layer because now HAL or
> Upper-Layer do not need to search input/event number corresponding to
> each input device in /dev/input/...  This searching in /dev/input/ was
> taking too much time.  (Especially in mobile devices, where there are
> many input devices (many sensors, touchscreen, etc), it reduces a lot
> of booting time)

I am sorry, how much time does it take to scan a directory of what, 20
devices? If it such a factor have udev create nodes that are easier for
you to locate, similarly how we already create nodes by-id and by-path.
For example you can encode major:minor in device name.

> 
> 2. Improves Readabilty of input and event sysfs node paths because
> names are used instead of numbers.

I do not see why it is that important. If one wants overview
/proc/bus/input/devices gives nice picture.

> 
> 3. Removes Input Devices Dependency. If one input device probe fails,
> other input devices still work.  Before this patch, if one input
> device probe fails before input_register_device, then input number of
> other input devices changes and due to this permission settings are
> disturbed and hence HAL or upper layer cannot open the required sysfs
> node because permission denied error comes.

I have only one suggestion here: fix your userspace so that does not
depend on device initialization ordering.

IOW I am totally unconvinced that this facility is needed.

Thanks.

-- 
Dmitry
