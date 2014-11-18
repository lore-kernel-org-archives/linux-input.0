From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom - Bamboo pen only tablet does not support PAD
Date: Mon, 17 Nov 2014 16:13:14 -0800
Message-ID: <CAF8JNh+m_x35isfBMeFjxrCwiSAUijEA13xJ5ua2jeanjAJ1vg@mail.gmail.com>
References: <1416260755-13635-1-git-send-email-pingc@wacom.com>
	<CAN+gG=Edu2JXSguJE0w710xnuQQP-vvi6wEG-hBTex=bfqS9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:60494 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbaKRANQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Nov 2014 19:13:16 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so18853481lbj.9
        for <linux-input@vger.kernel.org>; Mon, 17 Nov 2014 16:13:14 -0800 (PST)
In-Reply-To: <CAN+gG=Edu2JXSguJE0w710xnuQQP-vvi6wEG-hBTex=bfqS9DA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>

Hi Benjamin,

Thank you for the review. An updated version will be posted soon. Let
me know if you need us to capture data from more devices for your
testing.

Cheers,

Ping

On Mon, Nov 17, 2014 at 2:38 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi Ping,
>
> On Mon, Nov 17, 2014 at 4:45 PM, Ping Cheng <pinglinux@gmail.com> wrote:
>> Bamboo models do not support HID_DG_CONTACTMAX. We should not rely
>> on that description to decide touch_max for them. Plus, no Bamboo
>> device supports single touch.
>>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>>  drivers/hid/wacom_sys.c |  4 ++--
>>  drivers/hid/wacom_wac.c | 30 ++++++++++++++++++++++--------
>>  2 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 8593047..46147b4 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -192,8 +192,8 @@ static void wacom_usage_mapping(struct hid_device *hdev,
>>         if (!pen && !finger)
>>                 return;
>>
>> -       if (finger && !features->touch_max)
>> -               /* touch device at least supports one touch point */
>> +       if (finger && !features->touch_max && (features->type != BAMBOO_PT))
>> +               /* ISDv4 touch devices at least supports one touch point */
>
> Can you also explain here that the report descriptor of the Bamboos
> contains the touch even if the device itself has not the capability?
> IMO, it will help further readings when we will try to understand this
> particular case.
>
>>                 features->touch_max = 1;
>>
>>         switch (usage->hid) {
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index 586b240..fc9b492 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -2402,7 +2402,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
>>         case INTUOSPS:
>>                 /* touch interface does not have the pad device */
>>                 if (features->device_type != BTN_TOOL_PEN)
>> -                       return 1;
>> +                       goto no_pad;
>
> There is actually no need to clean up the pad on error.
> When an error is raised, the associated pad input device is simply
> freed, so the cleanup add superfluous steps.
>
> Maybe a cleaner way to handle that would be to return -ENODEV. This
> will show that this is an abort and that the pad input device will not
> be used anymore.
>
>>
>>                 for (i = 0; i < 7; i++)
>>                         __set_bit(BTN_0 + i, input_dev->keybit);
>> @@ -2447,22 +2447,36 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
>>         case BAMBOO_PT:
>>                 /* pad device is on the touch interface */
>>                 if (features->device_type != BTN_TOOL_FINGER)
>> -                       return 1;
>> +                       goto no_pad;
>>
>>                 __clear_bit(ABS_MISC, input_dev->absbit);
>>
>> -               __set_bit(BTN_LEFT, input_dev->keybit);
>> -               __set_bit(BTN_FORWARD, input_dev->keybit);
>> -               __set_bit(BTN_BACK, input_dev->keybit);
>> -               __set_bit(BTN_RIGHT, input_dev->keybit);
>> +               /* Bamboo Pen only tablet does not have pad */
>> +               if ((features->type != BAMBOO_PT) ||
>> +                   ((features->type == BAMBOO_PT) && features->touch_max)) {
>
> I would prefer keeping the standard path as it is, and add a special
> test above where you bail out. We will be able to add further special
> cases as needed, and not stack the parenthesis :)
>
> [looks like it is bikeshedding day for me... sorry]
>
>> +                       __set_bit(BTN_LEFT, input_dev->keybit);
>> +                       __set_bit(BTN_FORWARD, input_dev->keybit);
>> +                       __set_bit(BTN_BACK, input_dev->keybit);
>> +                       __set_bit(BTN_RIGHT, input_dev->keybit);
>> +               } else
>> +                       goto no_pad;
>>
>>                 break;
>>
>>         default:
>> -               /* no pad supported */
>> -               return 1;
>> +               goto no_pad;
>>         }
>>         return 0;
>> +
>> +no_pad:
>> +       input_dev->evbit[0] &= ~BIT_MASK(EV_KEY) & ~BIT_MASK(EV_ABS);
>> +       __clear_bit(ABS_MISC, input_dev->absbit);
>> +       __clear_bit(ABS_X, input_dev->absbit);
>> +       __clear_bit(ABS_Y, input_dev->absbit);
>> +       __clear_bit(BTN_STYLUS, input_dev->keybit);
>> +
>> +       return 1;
>> +
>>  }
>>
>>  static const struct wacom_features wacom_features_0x00 =
>> --
>> 1.9.1
>>
>
> FWIW, there is no regressions with this patch regarding the devices we
> have at Red Hat :)
> /me just updated hid-replay and played with it...
>
> Cheers,
> Benjamin
