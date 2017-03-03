From: Kim Jaejoong <climbbb.kim@gmail.com>
Subject: Re: [PATCH 1/2] HID: hiddev: move hiddev's minor number from struct
 hid_device to hiddev
Date: Fri, 3 Mar 2017 16:00:00 +0900
Message-ID: <CAL6iAaJoCYeFdqbf+dkSV3SB45Vn9rLfW+V74aWvjKeNadEG2Q@mail.gmail.com>
References: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
 <1488462330-12349-2-git-send-email-climbbb.kim@gmail.com> <20170302141053.GN7064@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302141053.GN7064@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2017-03-02 23:10 GMT+09:00 Benjamin Tissoires <benjamin.tissoires@redhat.com>:
> On Mar 02 2017 or thereabouts, Jaejoong Kim wrote:
>> We need to store the minor number each drivers. In case of hidraw, it's
>> minor number stores in struct hidraw. But hiddev's minor is located in
>> struct hid_device.
>>
>> So reallocates for hiddev's minor number.
>>
>
> There is not a real need to have this one in a separate patch. Also, it
> depends on the patch "[PATCH] HID: cp2112: use proper hidraw name with
> minor number", so better include this cp2112 in this series (as I
> mentioned in the cp2112 patch).
>
> I'd say simply squash this patch with 2/2 and have the cp2112 as 1/2.

Ok. I will resend v2 patchset.

Thanks.
jaejoong

>
> Cheers,
> Benjamin
>
>> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
>> ---
>>  drivers/hid/usbhid/hiddev.c | 1 +
>>  include/linux/hid.h         | 1 -
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
>> index 700145b..5c2c489 100644
>> --- a/drivers/hid/usbhid/hiddev.c
>> +++ b/drivers/hid/usbhid/hiddev.c
>> @@ -47,6 +47,7 @@
>>  #define HIDDEV_BUFFER_SIZE   2048
>>
>>  struct hiddev {
>> +     int minor;
>>       int exist;
>>       int open;
>>       struct mutex existancelock;
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index 28f38e2b8..643c017 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -541,7 +541,6 @@ struct hid_device {                                                       /* device report descriptor */
>>       struct list_head inputs;                                        /* The list of inputs */
>>       void *hiddev;                                                   /* The hiddev structure */
>>       void *hidraw;
>> -     int minor;                                                      /* Hiddev minor number */
>>
>>       int open;                                                       /* is the device open by anyone? */
>>       char name[128];                                                 /* Device name */
>> --
>> 2.7.4
>>
