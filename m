From: Charles Mooney <charliemooney@google.com>
Subject: Re: [PATCH] Input: elants_i2c: Append hw_version to FW file
Date: Wed, 11 Mar 2015 10:09:18 -0700
Message-ID: <CAJ34Pp6FdTX+eDwRrHKqkqo+HyGaMLH3YBcghjX0kXPLTbBfYw@mail.gmail.com>
References: <1426017423-26249-1-git-send-email-charliemooney@chromium.org> <20150311014132.GA22959@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:37251 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbbCKRJ7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 13:09:59 -0400
Received: by oigi138 with SMTP id i138so9080856oig.4
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2015 10:09:58 -0700 (PDT)
In-Reply-To: <20150311014132.GA22959@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?B?5YqJ5ZiJ6ae/IOWKieWYiemnvw==?= <scott.liu@emc.com.tw>, fabf@skynet.be

On Tue, Mar 10, 2015 at 6:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Charlie,
>
> On Tue, Mar 10, 2015 at 12:57:03PM -0700, Charlie Mooney wrote:
>> Currently the elants_i2c driver simply requests a static filename
>> /lib/firmware/elants_i2c.bin when it gets firmware updates.  This is
>> a problem if you have two Elan touchscreens using the same driver.
>> If both touchscreens have different firmwares, you would need to move
>> the files around in your filesystem when you're updating them so that
>> they don't get updated with the other's FW.  If you have a read-only
>> filesystem then this is impossible, even.
>>
>> This patch changes the elants_i2c driver to automatically append the
>> four-hex-digit hw_version of the device onto the name of the FW file
>> it's requesting for update.  Since different touchscreens should have
>> a different hw_version's this means the user needs to append the hw
>> version of the touchscreen he or she intends to update onto the end
>> of the firmware filename and then the driver will do the rest.
>>
>> The firmware filenames it looks for now are of the form:
>>
>>   elants_i2c_${HW_VERSION}.bin
>>
>>   eg:
>>
>>   elants_i2c_2a44.bin
>>
>> Signed-off-by: Charlie Mooney <charliemooney@chromium.org>
>> ---
>>  drivers/input/touchscreen/elants_i2c.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
>> index 926c58e..d34ba57 100644
>> --- a/drivers/input/touchscreen/elants_i2c.c
>> +++ b/drivers/input/touchscreen/elants_i2c.c
>> @@ -98,7 +98,10 @@
>>  #define MAX_FW_UPDATE_RETRIES        30
>>
>>  #define ELAN_FW_PAGESIZE     132
>> -#define ELAN_FW_FILENAME     "elants_i2c.bin"
>> +#define      ELAN_FW_BASE_FILENAME   "elants_i2c"
>> +#define ELAN_FW_EXTENSION    "bin"
>> +#define ELAN_FW_FILENAME_MAX_LEN     (ARRAY_SIZE(ELAN_FW_BASE_FILENAME) + \
>> +                                      ARRAY_SIZE(ELAN_FW_EXTENSION) + 5)
>
> Looked at this again and I don't really like how we need to maintain the
> MAX_LEN and make sure it is in sync with the format string. How about
> the patch below instead?
>
> Thanks.
>
> --
> Dmitry
>
>
> Input: elants_i2c - append hw_version to FW file
>
> From: Charlie Mooney <charliemooney@chromium.org>
>
> Currently the elants_i2c driver simply requests a static filename
> /lib/firmware/elants_i2c.bin when it gets firmware updates.  This is a
> problem if you have two Elan touchscreens using the same driver.  If both
> touchscreens have different firmwares, you would need to move the files
> around in your filesystem when you're updating them so that they don't get
> updated with the other's FW.  If you have a read-only filesystem then this
> is impossible, even.
>
> This patch changes the elants_i2c driver to automatically append the
> four-hex-digit hw_version of the device onto the name of the FW file it's
> requesting for update.  Since different touchscreens should have a
> different hw_version's this means the user needs to append the hw version
> of the touchscreen he or she intends to update onto the end of the firmware
> filename and then the driver will do the rest.
>
> The firmware filenames it looks for now are of the form:
>
>   elants_i2c_${HW_VERSION}.bin
>
>   eg:
>
>   elants_i2c_2a44.bin
>
> Signed-off-by: Charlie Mooney <charliemooney@chromium.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/elants_i2c.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 926c58e..43b3c9c 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -98,7 +98,6 @@
>  #define MAX_FW_UPDATE_RETRIES  30
>
>  #define ELAN_FW_PAGESIZE       132
> -#define ELAN_FW_FILENAME       "elants_i2c.bin"
>
>  /* calibration timeout definition */
>  #define ELAN_CALI_TIMEOUT_MSEC 10000
> @@ -697,12 +696,19 @@ static int elants_i2c_fw_update(struct elants_data *ts)
>  {
>         struct i2c_client *client = ts->client;
>         const struct firmware *fw;
> +       char *fw_name;
>         int error;
>
> -       error = request_firmware(&fw, ELAN_FW_FILENAME, &client->dev);
> +       fw_name = kasprintf(GFP_KERNEL, "elants_i2c_%4x.bin", ts->hw_version);
> +       if (!fw_name)
> +               return -ENOMEM;
> +
> +       dev_info(&client->dev, "requesting fw name = %s\n", fw_name);
> +       error = request_firmware(&fw, fw_name, &client->dev);
> +       kfree(fw_name);
>         if (error) {
> -               dev_err(&client->dev, "failed to request firmware %s: %d\n",
> -                       ELAN_FW_FILENAME, error);
> +               dev_err(&client->dev, "failed to request firmware: %d\n",
> +                       error);
>                 return error;
>         }
>

I agree, that does indeed look better.  kasprintf() is a smart choice.
