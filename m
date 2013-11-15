From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/4 v3] Input: wacom - add SW_TOUCH to include/uapi/linux/input.h
Date: Fri, 15 Nov 2013 13:59:14 -0800
Message-ID: <CAF8JNh+w8yMweY5fLFgLhqNZ7vO2UEx27eeoZ=pHzKY_rKiFyA@mail.gmail.com>
References: <1384545602-15549-1-git-send-email-pingc@wacom.com>
	<CAGzDe_Z8HjejCN8Hh3ABaTEwGWhauGHbprVKYuJAoOXuMumBxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43591 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab3KOV7Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 16:59:16 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so3155875lbh.36
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 13:59:14 -0800 (PST)
In-Reply-To: <CAGzDe_Z8HjejCN8Hh3ABaTEwGWhauGHbprVKYuJAoOXuMumBxg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Ping Cheng <pingc@wacom.com>

On Fri, Nov 15, 2013 at 1:28 PM, Chris Bagwell <chris@cnpbagwell.com> wrote:
> Thanks for breaking out... Its easier to review now as well.
>
> Small question below.
>
> On Fri, Nov 15, 2013 at 2:00 PM, Ping Cheng <pinglinux@gmail.com> wrote:
>> New Intuos series models added a hardware switch to turn touch
>> data on/off. To report the state of the switch, SW_TOUCH
>> is added in include/uapi/linux/input.h.
>>
>> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
>> Tested-by: Jason Gerecke <killertofu@gmail.com>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>>  drivers/input/tablet/wacom_sys.c | 12 ++++++++++++
>>  drivers/input/tablet/wacom_wac.c | 30 +++++++++++++++++++++++++++---
>>  drivers/input/tablet/wacom_wac.h |  5 +++++
>>  include/uapi/linux/input.h       |  1 +
>>  4 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
>> index 3a7d99c..bb72fa3 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -1193,6 +1193,8 @@ static void wacom_wireless_work(struct work_struct *work)
>>                 wacom_wac1->features.device_type = BTN_TOOL_PEN;
>>                 snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
>>                          wacom_wac1->features.name);
>> +               wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
>> +               wacom_wac1->shared->type = wacom_wac1->features.type;
>>                 error = wacom_register_input(wacom1);
>>                 if (error)
>>                         goto fail;
>> @@ -1214,6 +1216,10 @@ static void wacom_wireless_work(struct work_struct *work)
>>                         error = wacom_register_input(wacom2);
>>                         if (error)
>>                                 goto fail;
>> +
>> +                       if (wacom_wac1->features.type == INTUOSHT &&
>> +                           wacom_wac1->features.touch_max)
>> +                               wacom_wac->shared->touch_input = wacom_wac2->input;
>>                 }
>>
>>                 error = wacom_initialize_battery(wacom);
>> @@ -1392,6 +1398,12 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
>>                         goto fail5;
>>                 }
>>         }
>> +
>> +       if (wacom_wac->features.type == INTUOSHT && wacom_wac->features.touch_max) {
>> +               if (wacom_wac->features.device_type == BTN_TOOL_FINGER)
>> +                       wacom_wac->shared->touch_input = wacom_wac->input;
>> +       }
>> +
>>         return 0;
>>
>>   fail5: wacom_destroy_leds(wacom);
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
>> index c0cd85d..70beca8 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -1220,13 +1220,23 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
>>
>>  static int wacom_bpt_pen(struct wacom_wac *wacom)
>>  {
>> +       struct wacom_features *features = &wacom->features;
>>         struct input_dev *input = wacom->input;
>>         unsigned char *data = wacom->data;
>>         int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
>>
>> -       if (data[0] != WACOM_REPORT_PENABLED)
>> +       if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_USB)
>>             return 0;
>>
>> +       if (data[0] == WACOM_REPORT_USB) {
>> +               if ((features->type == INTUOSHT) && features->touch_max) {
>> +                       input_report_switch(wacom->shared->touch_input,
>> +                                           SW_TOUCH, data[8] & 0x40);
>> +                       input_sync(wacom->shared->touch_input);
>> +               }
>> +               return 0;
>> +       }
>> +
>>         prox = (data[1] & 0x20) == 0x20;
>>
>>         /*
>> @@ -1259,8 +1269,8 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
>>                  * touching and applying pressure; do not report negative
>>                  * distance.
>>                  */
>> -               if (data[8] <= wacom->features.distance_max)
>> -                       d = wacom->features.distance_max - data[8];
>> +               if (data[8] <= features->distance_max)
>> +                       d = features->distance_max - data[8];
>>
>>                 pen = data[1] & 0x01;
>>                 btn1 = data[1] & 0x02;
>> @@ -1311,6 +1321,13 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
>>         if (connected) {
>>                 int pid, battery;
>>
>> +               if ((wacom->shared->type == INTUOSHT) &&
>> +                               wacom->shared->touch_max) {
>> +                       input_report_switch(wacom->shared->touch_input,
>> +                                       SW_TOUCH, data[5] & 0x40);
>> +                       input_sync(wacom->shared->touch_input);
>> +               }
>
> Earlier in patch, SW_TOUCH is read from pen interface and this time
> its read from wireless interface.  Is this to handle a HW model
> difference or wired/wireless difference?

Thank you, Chris, for your review and comments.

Nothing has changed for this chunk of code between this patch and any
of those earlier versions.

I think you mixed 3/4 and 4/4.

There are two kinds of connection we support with Intuos: USB and Wireless.

For USB connection. SW_TOUCH is reported on pen interface. For
wireless, it is reported through wireless interface. It is by design
in the hardware/firmware. I can not change that;-).

> I assume for wired case, it has to come from pen interface... no
> telling what wireless mode does different.
>
> Anyways, maybe a small comment is worthwhile to let people know why
> its needed twice?

It's not twice. They deal with different connections. Anyone has a
device to work on or read the code in whole, not in patches, should
understand that logic easily.

> I see now that its next to impossible to get rid of
> shared->touch_input... which means my old comments were invalid. So:
>
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

Thank you for the Reviewed-by. Hope these months' old patches will
find their home soon.

Ping

>
>> +
>>                 pid = get_unaligned_be16(&data[6]);
>>                 battery = data[5] & 0x3f;
>>                 if (wacom->pid != pid) {
>> @@ -1780,6 +1797,13 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>>                 break;
>>
>>         case INTUOSHT:
>> +               if (features->touch_max &&
>> +                   (features->device_type == BTN_TOOL_FINGER)) {
>> +                       input_dev->evbit[0] |= BIT_MASK(EV_SW);
>> +                       __set_bit(SW_TOUCH, input_dev->swbit);
>> +               }
>> +               /* fall through */
>> +
>>         case BAMBOO_PT:
>>                 __clear_bit(ABS_MISC, input_dev->absbit);
>>
>> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
>> index 854cceb..3600cf7 100644
>> --- a/drivers/input/tablet/wacom_wac.h
>> +++ b/drivers/input/tablet/wacom_wac.h
>> @@ -55,6 +55,7 @@
>>  #define WACOM_REPORT_TPC1FGE           18
>>  #define WACOM_REPORT_24HDT             1
>>  #define WACOM_REPORT_WL                        128
>> +#define WACOM_REPORT_USB               192
>>
>>  /* device quirks */
>>  #define WACOM_QUIRK_MULTI_INPUT                0x0001
>> @@ -131,6 +132,10 @@ struct wacom_features {
>>  struct wacom_shared {
>>         bool stylus_in_proximity;
>>         bool touch_down;
>> +       /* for wireless device to access USB interfaces */
>> +       unsigned touch_max;
>> +       int type;
>> +       struct input_dev *touch_input;
>>  };
>>
>>  struct wacom_wac {
>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>> index a372627..fcddcb1 100644
>> --- a/include/uapi/linux/input.h
>> +++ b/include/uapi/linux/input.h
>> @@ -856,6 +856,7 @@ struct input_keymap_entry {
>>  #define SW_FRONT_PROXIMITY     0x0b  /* set = front proximity sensor active */
>>  #define SW_ROTATE_LOCK         0x0c  /* set = rotate locked/disabled */
>>  #define SW_LINEIN_INSERT       0x0d  /* set = inserted */
>> +#define SW_TOUCH               0x0e  /* set = touch switch turned on (touch events off) */
>>  #define SW_MAX                 0x0f
>>  #define SW_CNT                 (SW_MAX+1)
>>
>> --
>> 1.8.3.2
>>
