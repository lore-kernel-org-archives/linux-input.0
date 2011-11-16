From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Findind input event device path with libudev
Date: Wed, 16 Nov 2011 14:44:08 +0000
Message-ID: <4EC3CC38.9080304@edigma.com>
References: <4EC3A656.7050800@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:54433 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1KPOoR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 09:44:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id EA7433761930
	for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 14:44:13 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkGFRcj9Wvn0 for <linux-input@vger.kernel.org>;
	Wed, 16 Nov 2011 14:44:08 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id A60BE376192D
	for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 14:44:08 +0000 (WET)
In-Reply-To: <4EC3A656.7050800@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

After digging a little bit around this i found that my problem is with 
this function:

dev = udev_device 
*udev_device_get_parent_with_subsystem_devtype(dev,"usb","usb_device");

dev is always null. He can't find me the usb device for my input device. 
Maybe i'm not specifiying subsystem and dev type correctly.

If I make several calls to udev_device_get_parent I can get to the 
correct device.

Does anyone knows what should be the correct subsystem and dev type pair 
to find the parent usb device for an input device?

Thanks,

Nuno

On 11/16/2011 12:02 PM, Nuno Santos wrote:
> Hi,
>
> I found an example on how to use libudev to iterate over devices 
> present in the system to find its precise path since the path can be 
> different everytime we plug a device into the system.
>
> http://www.signal11.us/oss/udev/
>
> In this example, the type of device searched is hidraw, however I have 
> already tried input, event, etc and none of this match criterias in 
> the following function:
>
> |*udev_enumerate_add_match_subsystem*(enumerate,*"hidraw"*);|
>
>
> Only hidraw seems to work.
>
> Can I use this technic to found the path a of input event device?
>
> Thanks,
>
> With my best regards,
>
> Nuno
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

