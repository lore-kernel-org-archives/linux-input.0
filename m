From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v2] HID: asus: support backlight on USB keyboards
Date: Thu, 6 Apr 2017 11:22:04 +0200
Message-ID: <CAL9uMOGM_06C7b-a4Jp0vocAHoy0hbDS1H-yRirZPwQktszMcg@mail.gmail.com>
References: <20170405144049.19876-1-carlo@caione.org> <20170406091114.GA10306@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33168 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbdDFJWG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Apr 2017 05:22:06 -0400
Received: by mail-vk0-f43.google.com with SMTP id d188so33544776vka.0
        for <linux-input@vger.kernel.org>; Thu, 06 Apr 2017 02:22:05 -0700 (PDT)
In-Reply-To: <20170406091114.GA10306@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Carlo Caione <carlo@caione.org>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

On Thu, Apr 6, 2017 at 11:11 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Carlo,

Hi Benjamin,

[cut]
>> +static int asus_kbd_get_report(struct hid_device *hdev, u8 *buf, size_t buf_size)
>
> Nitpick: should be asus_kbd_set_report()

right :)

[cut]
>> +static void asus_kbd_backlight_work(struct work_struct *work)
>> +{
>> +     struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds, work);
>> +     u8 buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
>> +     int ret;
>> +
>
> You should probably protect leds->removed by a mutex here to avoid
> having it set to false right after the test. (or not, see asus_remove())

Yeah, makes sense.

[cut]
>> +     /* Initialize keyboard */
>> +     if (asus_kbd_init(hdev) < 0)
>> +             return -ENODEV;
>
> Don't hide the returned error code please. I know it'll be dropped in
> the end, but better not hiding it with an other one. (same for the next
> 2)

ok for the next one but when checking the bit field in kbd_func I
think we still want to return -ENODEV.

>>       struct input_dev *input = hi->input;
>> @@ -178,7 +326,6 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>
>>       if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
>>               int ret;
>> -
>
> Leftover from the previous patch, but please don't remove this empty
> line, it's the coding style policy.

yeah, this slipped through

>>               input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X, 0, 0);
>>               input_set_abs_params(input, ABS_MT_POSITION_Y, 0, MAX_Y, 0, 0);
>>               input_set_abs_params(input, ABS_TOOL_WIDTH, 0, MAX_TOUCH_MAJOR, 0, 0);
>> @@ -198,6 +345,10 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>
>>       drvdata->input = input;
>>
>> +     if (drvdata->enable_backlight)
>> +             if (asus_kbd_register_leds(hdev))
>
> could be changed into:
> if (drvdata->enable_backlight && asus_kbd_register_leds(hdev))

OK

[cut]
>> +static void asus_remove(struct hid_device *hdev)
>> +{
>> +     struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> +
>> +     if (drvdata->kbd_backlight)
>> +             drvdata->kbd_backlight->removed = true;
>
> Add a cancel_work_sync() here too to terminate currently working
> workers. Bonus point, you don't need the mutex if you call
> cancel_work_sync().

I'll do.

Thanks for the quick review.

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
