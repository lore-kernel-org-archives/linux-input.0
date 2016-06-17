From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: misc: remove outdated USB LED driver
Date: Fri, 17 Jun 2016 08:13:29 +0200
Message-ID: <d67c0d46-a3f9-746e-4c31-c14fe1288f7f@gmail.com>
References: <bc0c4bbd-d65d-eeb8-ed13-20bdb4cea6df@gmail.com>
 <20160616191347.GA12513@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160616191347.GA12513-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am 16.06.2016 um 21:13 schrieb Greg Kroah-Hartman:
> On Thu, Jun 16, 2016 at 09:00:50PM +0200, Heiner Kallweit wrote:
>> The USB LED driver exposes a undocumented sysfs interface and doesn't
>> use the standard kernel LED subsystem. It supports three devices:
>>
>> Delcom Visual Signal Indicator
>> The driver supports generation 1 of the device only which was
>> manufactured until 2008. Remove support for this device completely.
>>
>> Riso Kagaku RGB LED + Dream Cheeky Webmail Notifier
>> These devices are HID compliant and will be supported by a new driver
>> under drivers/hid utilizing the kernel LED subsystem.
>>
>> So let's remove the USB LED driver.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Has the HID driver been merged yet?  I'd like to have this go in as the
> 2nd patch in that series, so feel free to add my:
> 
Yes, I just submitted the patch set.

Regards, Heiner

> Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> 
> to this one.
> 
> thanks,
> 
> greg k-h
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
