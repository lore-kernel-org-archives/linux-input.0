From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] HID: leave dev_rdesc unmodified and use it for comparisons
Date: Wed, 19 Sep 2012 15:47:59 +0400
Message-ID: <5059B0EF.5020905@mvista.com>
References: <50592FB1.7000800@kdau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50592FB1.7000800@kdau.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Daughtridge <kevin@kdau.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

Hello.

On 19-09-2012 6:36, Kevin Daughtridge wrote:

> The dev_rdesc member of the hid_device structure is meant to store the original
> report descriptor received from the device, but it is currently passed to any
> report_fixup method before it is copied to the rdesc member. This patch moves
> the kmemdup to before, not after, the report_fixup call, keeping dev_rdesc
> unchanged.

> usbhid's hid_post_reset checks the report descriptor currently returned by the
> device against a descriptor that may have been modified by a driver's
> report_fixup method. That leaves some devices nonfunctional after a resume, with
> a "reset_resume error 1" reported. This patch checks the new descriptor against
> the unmodified dev_rdesc instead.

> BugLink:http://bugs.launchpad.net/bugs/1049623
> Signed-off-by: Kevin Daughtridge<kevin@kdau.com>

    Need space before the email. I've checked your original mail, it's not my 
Thunderbird this time (which does this kind of damage while quoting).

> ---
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -775,12 +775,14 @@ int hid_open_report(struct hid_device *d
>           return -ENODEV;
>       size = device->dev_rsize;
>
> +    start = kmemdup(start, size, GFP_KERNEL);
> +    if (start == NULL)
> +        return -ENOMEM;
> +
>       if (device->driver->report_fixup)
>           start = device->driver->report_fixup(device, start, &size);
>
> -    device->rdesc = kmemdup(start, size, GFP_KERNEL);
> -    if (device->rdesc == NULL)
> -        return -ENOMEM;
> +    device->rdesc = start;
>       device->rsize = size;
>
>       parser = vzalloc(sizeof(struct hid_parser));

    It still seems like the patch is whitespace damaged, but in another way: 
to every line satrting with space, another spece was added.

WBR, Sergei
