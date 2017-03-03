From: Kim Jaejoong <climbbb.kim@gmail.com>
Subject: Re: [PATCH 2/2] HID: hiddev: store hiddev's minor number when hiddev
 is connected
Date: Fri, 3 Mar 2017 16:05:56 +0900
Message-ID: <CAL6iAa+cxAUnSvgKbA0=VDJPruew_wL_zA3TUJ+W6q+MKa2KpQ@mail.gmail.com>
References: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
 <1488462330-12349-3-git-send-email-climbbb.kim@gmail.com> <20170302141306.GO7064@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34118 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbdCCHPK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Mar 2017 02:15:10 -0500
In-Reply-To: <20170302141306.GO7064@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

2017-03-02 23:13 GMT+09:00 Benjamin Tissoires <benjamin.tissoires@redhat.com>:
> On Mar 02 2017 or thereabouts, Jaejoong Kim wrote:
>> The hid-core announces kernel message which driver is loaded if there is
>> a hiddev, but hiddev's minor number is always zero even though it's not
>> zero.
>>
>> So, we need to store the minor number asked from usb core and do some
>> refactoring work(move from hiddev.c to hiddev.h) to access hiddev in
>> hid-core.
>>
>> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
>> ---
>>  drivers/hid/hid-core.c      |  2 +-
>>  drivers/hid/usbhid/hiddev.c | 26 +++-----------------------
>>  include/linux/hiddev.h      | 24 ++++++++++++++++++++++++
>>  3 files changed, 28 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index e9e87d3..1a0b910 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1695,7 +1695,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>>               len += sprintf(buf + len, "input");
>>       if (hdev->claimed & HID_CLAIMED_HIDDEV)
>>               len += sprintf(buf + len, "%shiddev%d", len ? "," : "",
>> -                             hdev->minor);
>> +                             ((struct hiddev *)hdev->hiddev)->minor);
>>       if (hdev->claimed & HID_CLAIMED_HIDRAW)
>>               len += sprintf(buf + len, "%shidraw%d", len ? "," : "",
>>                               ((struct hidraw *)hdev->hidraw)->minor);
>> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
>> index 5c2c489..ef83d68 100644
>> --- a/drivers/hid/usbhid/hiddev.c
>> +++ b/drivers/hid/usbhid/hiddev.c
>> @@ -44,29 +44,6 @@
>>  #define HIDDEV_MINOR_BASE    96
>>  #define HIDDEV_MINORS                16
>>  #endif
>> -#define HIDDEV_BUFFER_SIZE   2048
>> -
>> -struct hiddev {
>> -     int minor;
>> -     int exist;
>> -     int open;
>> -     struct mutex existancelock;
>> -     wait_queue_head_t wait;
>> -     struct hid_device *hid;
>> -     struct list_head list;
>> -     spinlock_t list_lock;
>> -};
>> -
>> -struct hiddev_list {
>> -     struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
>> -     int head;
>> -     int tail;
>> -     unsigned flags;
>> -     struct fasync_struct *fasync;
>> -     struct hiddev *hiddev;
>> -     struct list_head node;
>> -     struct mutex thread_lock;
>> -};
>>
>>  /*
>>   * Find a report, given the report's type and ID.  The ID can be specified
>> @@ -911,6 +888,9 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>>               kfree(hiddev);
>>               return -1;
>>       }
>> +
>> +     hiddev->minor = usbhid->intf->minor;
>> +
>>       return 0;
>>  }
>>
>> diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
>> index a5dd814..ff3701b 100644
>> --- a/include/linux/hiddev.h
>> +++ b/include/linux/hiddev.h
>> @@ -32,6 +32,30 @@
>>   * In-kernel definitions.
>>   */
>>
>> +#define HIDDEV_BUFFER_SIZE      2048
>> +
>> +struct hiddev {
>> +     int minor;
>> +     int exist;
>> +     int open;
>> +     struct mutex existancelock;
>> +     wait_queue_head_t wait;
>> +     struct hid_device *hid;
>> +     struct list_head list;
>> +     spinlock_t list_lock;
>> +};
>> +
>> +struct hiddev_list {
>> +     struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
>> +     int head;
>> +     int tail;
>> +     unsigned flags;
>> +     struct fasync_struct *fasync;
>> +     struct hiddev *hiddev;
>> +     struct list_head node;
>> +     struct mutex thread_lock;
>> +};
>
> Why do you need to also export struct hiddev_list? Unless I am missing
> something we don't need it elsewhere but in hiddev.c, and so there is no
> point exporting this struct to the world.

You're right. I will export only struct hiddev.

>
> With this change amended, the end result looks good and the series
> should be ready to be integrated IMO.
>

I will resend v2 patchset your said.

Thanks,
jaejoong

> Cheers,
> Benjamin
>
>> +
>>  struct hid_device;
>>  struct hid_usage;
>>  struct hid_field;
>> --
>> 2.7.4
>>
