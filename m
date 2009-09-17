From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH v2 1/2] Input: Add DaVinci DM365 Keypad support
Date: Thu, 17 Sep 2009 11:49:51 -0600
Message-ID: <4AB276BF.9000807@ridgerun.com>
References: <1252951959-31015-1-git-send-email-miguel.aguilar@ridgerun.com> <200909141145.48252.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:39278 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbZIQRt4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2009 13:49:56 -0400
In-Reply-To: <200909141145.48252.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, clark.becker@ridgerun.com

David,

What are the proper error codes when platform_get_resource, request_mem_region 
and ioremap functions fail?.

Thanks,

Miguel Aguilar
David Brownell wrote:
> On Monday 14 September 2009, miguel.aguilar@ridgerun.com wrote:
>> +       dm365_kp = kzalloc(sizeof *dm365_kp, GFP_KERNEL);
>> +       key_dev = input_allocate_device();
>> +
>> +       if (!dm365_kp || !key_dev) {
>> +               dev_dbg(dev, "Could not allocate input device\n");
>> +               return -ENOMEM;
>> +       }
> 
> Can still leak the kzalloc'ed data...
> 
> 
>> +       dm365_kp->irq = platform_get_irq(pdev, 0);
>> +       if (dm365_kp->irq <= 0) {
>> +               dev_dbg(dev, "%s: No DM365 Keypad irq\n", pdev->name);
>> +               goto fail1;
>> +       }
> 
> Still discards the true fault codes here and later ...
> 
> 
>> +       printk(KERN_INFO "DaVinci DM365 Keypad Driver\n");
> 
> Nicer not to have such banners; a dev_info() in probe() is
> better and won't show on boards where this driver isn't used.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


