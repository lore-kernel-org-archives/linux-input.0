From: Kim Jaejoong <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] HID: hiddev: allocate minor number hiddev's USB
 interface is bound to
Date: Thu, 2 Mar 2017 14:01:45 +0900
Message-ID: <CAL6iAa+_ZeiyVpuybCpU=iNkp3yx8sVQ0K_Zmc=eNR42oerRqA@mail.gmail.com>
References: <1487152516-12335-1-git-send-email-climbbb.kim@gmail.com> <20170228170507.GA7064@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170228170507.GA7064-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin

Thanks for the review my patch :)

2017-03-01 2:05 GMT+09:00 Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> On Feb 15 2017 or thereabouts, Jaejoong Kim wrote:
>> When HID device connected to the PC, HID device driver announces which
>> driver is loaded with a kernel info message. In this case, hiddev's minor
>> number is always '0' even though hiddev's real minor number is not zero.
>>
>> To display hiddev with minor number asked from usb core, we need
>> to fill hiddev's minor number this interface is bound to.
>>
>> Signed-off-by: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>
> That's a single line of code, and I get into some headaches :)
>
> So, the commit that broke this (.minor not being set) is actually commit
> bd25f4dd69727555 ("HID: hiddev: use usb_find_interface, get rid of
> BKL"), from 2010-07-11...
>
> And this patch reverts to the intended behavior.

Could you explain more about 'intended behavior'?

> But I am wondering if we
> should really store the minor in struct hid_device if it is only used by
> hiddev. hidraw does use a minor too, but stores it in struct hidraw
> directly, so IMO it would make sense to store this in struct hiddev. The
> problem is that this struct is not exported, and it's going to be some
> refactoring work to do so.
>

I agree with you. My patch is just allocate 'right' minor number in
struct hid_device.
After got your review mail,I also think struct hiddev and struct hid_device
need some refactoring work for minor number handling as you said.

For example, hid-cp2112.c uses a minor number of struct hid_device.
Based on comment
for minor in struct hid_device, it is for hiddev not hidraw. But,
hid-cp2112's connect_mask
for hid_hw_start is HIDRAW.

I will do some work for this one, so please ignore this patch :)

Thanks, jaejoong

> So, in a way, I am tempted to give my:
> Acked-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>
> But if Jiri feels that a cleanup of hiddev would be required instead, I
> would follow him :)
>
> Cheers,
> Benjamin
>
>> Changes in v2:
>>  - fix typo in commit message
>> ---
>>
>>  drivers/hid/usbhid/hiddev.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
>> index 700145b..27e1f8d 100644
>> --- a/drivers/hid/usbhid/hiddev.c
>> +++ b/drivers/hid/usbhid/hiddev.c
>> @@ -910,6 +910,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>>               kfree(hiddev);
>>               return -1;
>>       }
>> +     hid->minor = usbhid->intf->minor;
>>       return 0;
>>  }
>>
>> --
>> 2.7.4
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
