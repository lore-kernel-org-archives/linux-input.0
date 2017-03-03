From: Kim Jaejoong <climbbb.kim@gmail.com>
Subject: Re: [PATCH] HID: cp2112: use proper hidraw name with minor number
Date: Fri, 3 Mar 2017 15:57:12 +0900
Message-ID: <CAL6iAaL398z3zZnVQK_oRqktrsGf7H2AzepsFjSo6xDs9ry62w@mail.gmail.com>
References: <1488461278-8870-1-git-send-email-climbbb.kim@gmail.com> <20170302140848.GM7064@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36605 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbdCCG5i (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Mar 2017 01:57:38 -0500
Received: by mail-it0-f65.google.com with SMTP id w185so1470116ita.3
        for <linux-input@vger.kernel.org>; Thu, 02 Mar 2017 22:57:13 -0800 (PST)
In-Reply-To: <20170302140848.GM7064@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org

Hi Benjamin

2017-03-02 23:08 GMT+09:00 Benjamin Tissoires <benjamin.tissoires@redhat.com>:
> On Mar 02 2017 or thereabouts, Jaejoong Kim wrote:
>> The cp2112 driver is working on hidraw not hiddev. So we need to use proper
>> hidraw name with hidraw's minor number.
>>
>> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
>> ---
>
> Looks good to me:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks for the review.

>
> However, this one should probably be sent in the series "[PATCH 0/2]
> HID: hiddev: move hiddev's minor number and refactoring" as it is a
> requirement for this series.
>
> I'd say resubmit this one in the v2 of the series (with my reviewed-by),
> so that the series is consistent and Jiri knows that this one needs to
> come before the rest of the series.

OK, I will resend v2 patchset with cp2112

Thanks,
jaejoong

>
> Cheers,
> Benjamin
>
>
>
>>  drivers/hid/hid-cp2112.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
>> index b22d0f8..078026f 100644
>> --- a/drivers/hid/hid-cp2112.c
>> +++ b/drivers/hid/hid-cp2112.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/gpio.h>
>>  #include <linux/gpio/driver.h>
>>  #include <linux/hid.h>
>> +#include <linux/hidraw.h>
>>  #include <linux/i2c.h>
>>  #include <linux/module.h>
>>  #include <linux/nls.h>
>> @@ -1297,7 +1298,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>       dev->adap.algo_data     = dev;
>>       dev->adap.dev.parent    = &hdev->dev;
>>       snprintf(dev->adap.name, sizeof(dev->adap.name),
>> -              "CP2112 SMBus Bridge on hiddev%d", hdev->minor);
>> +              "CP2112 SMBus Bridge on hidraw%d",
>> +              ((struct hidraw *)hdev->hidraw)->minor);
>>       dev->hwversion = buf[2];
>>       init_waitqueue_head(&dev->wait);
>>
>> --
>> 2.7.4
>>
