From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v2] HID: leave dev_rdesc unmodified and use it for comparisons
Date: Wed, 19 Sep 2012 10:05:01 +0200
Message-ID: <50597CAD.7010801@suse.cz>
References: <50592FB1.7000800@kdau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53455 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2ISIFJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Sep 2012 04:05:09 -0400
In-Reply-To: <50592FB1.7000800@kdau.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Daughtridge <kevin@kdau.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On 09/19/2012 04:36 AM, Kevin Daughtridge wrote:
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -775,12 +775,14 @@ int hid_open_report(struct hid_device *d
>          return -ENODEV;
>      size = device->dev_rsize;
>  
> +    start = kmemdup(start, size, GFP_KERNEL);
> +    if (start == NULL)
> +        return -ENOMEM;
> +
>      if (device->driver->report_fixup)
>          start = device->driver->report_fixup(device, start, &size);
>  
> -    device->rdesc = kmemdup(start, size, GFP_KERNEL);
> -    if (device->rdesc == NULL)
> -        return -ENOMEM;
> +    device->rdesc = start;
>      device->rsize = size;

AFAICS this is incorrect. Some drivers return pointers to their own
static structure from their .report_fixup. Hence there are two problems:
* leak, because kmemdup'ped start is never freed
* invalid free -- kfree(device->rdesc) will try to free a static structure

regards,
-- 
js
suse labs
