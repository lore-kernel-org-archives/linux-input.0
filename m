From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] HID: wacom: Fix wacom_probe error handling
Date: Mon, 17 Sep 2012 16:39:44 +0800
Message-ID: <CAF+7xW=Vky_6G3Z0rEj-Ski+fFPk-02g0EEaGB2kQOKakJEqvA@mail.gmail.com>
References: <1347848940.20002.1.camel@phoenix> <6b8f36c5518404598ba8c60eea6005d6.squirrel@webmail.firszt.eu>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45932 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab2IQIkF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 04:40:05 -0400
Received: by oago6 with SMTP id o6so4483594oag.19
        for <linux-input@vger.kernel.org>; Mon, 17 Sep 2012 01:40:04 -0700 (PDT)
In-Reply-To: <6b8f36c5518404598ba8c60eea6005d6.squirrel@webmail.firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: przemo@firszt.eu
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

2012/9/17 Przemo Firszt <przemo@firszt.eu>:
>
> Dnia 17 Wrze=B6nia 2012, 3:29 am, Pn, Axel Lin napisa=B3(a):
>> In the case of goto destroy_leds, we also need to call hid_hw_stop(h=
dev)
>> and
>> remove sysfs attribute files we created for speed and oleds.
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> ---
>>  drivers/hid/hid-wacom.c |   12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
>> index a0fafac..fae7fd7 100644
>> --- a/drivers/hid/hid-wacom.c
>> +++ b/drivers/hid/hid-wacom.c
>> @@ -902,10 +902,18 @@ OLED_INIT(7);
>>  err_ac:
>>       power_supply_unregister(&wdata->battery);
>>  err_battery:
>> -     device_remove_file(&hdev->dev, &dev_attr_speed);
>> -     hid_hw_stop(hdev);
>>  destroy_leds:
>>       wacom_destroy_leds(hdev);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled0_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled1_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled2_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled3_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled4_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled5_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled6_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_oled7_img);
>> +     device_remove_file(&hdev->dev, &dev_attr_speed);
>> +     hid_hw_stop(hdev);
>>  err_free:
>>       kfree(wdata);
>>       return ret;
>> --
>> 1.7.9.5
> Hi Alex,
It's Axel.

> The initial idea was that the OLEDs/LED are not critical for tablet
> functioning and that's why there was no call of hid_stop_hw if the
> OLED/LED initialisation faild.

Since it is not critical, current code ignore checking return value whe=
n
device_create_file for speed and oleds.

But current code does goto destroy_leds if wacom_initialize_leds fails.
Which means it returns error code in wacom_probe() and thus it should
clean up all the allocated resources in the error patch.

If you want to ignore wacom_initialize_leds() failure, you should not
call goto destroy_leds.

Comment?

Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
