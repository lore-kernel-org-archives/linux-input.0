From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH v2 2/2] Input: wacom - add support for three new Intuos devices
Date: Mon, 11 Nov 2013 20:50:34 -0600
Message-ID: <CAGzDe_ZFYV1RmzB=5fBLts0vJmjQ1-W0X-nz9Yt7S6g_zHfBsw@mail.gmail.com>
References: <1381439866-1161-1-git-send-email-pingc@wacom.com>
	<CAGzDe_a_VF7697u66LsWoV+C6+VLRzQJ8FWnct9SGK6DQurULQ@mail.gmail.com>
	<CAF8JNh+Vh3FswdDYPffi603iJmnnSgQDtfiJVfP=mqCqTW8dXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:41326 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab3KLCui (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 21:50:38 -0500
Received: by mail-wg0-f54.google.com with SMTP id y10so1806243wgg.21
        for <linux-input@vger.kernel.org>; Mon, 11 Nov 2013 18:50:37 -0800 (PST)
In-Reply-To: <CAF8JNh+Vh3FswdDYPffi603iJmnnSgQDtfiJVfP=mqCqTW8dXQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Fri, Nov 8, 2013 at 1:13 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Thu, Nov 7, 2013 at 6:25 PM, Chris Bagwell <chris@cnpbagwell.com> wrote:
>> On Thu, Oct 10, 2013 at 4:17 PM, Ping Cheng <pinglinux@gmail.com> wrote:
>>> This series of models added a hardware switch to turn touch
>>> data on/off. To report the state of the switch, SW_TOUCH
>>> is added in include/uapi/linux/input.h.
>>
>> So I guess the big point is this patch can't go in until a SW_TOUCH
>> goes in first.
>>
>> Since the 1/2 or this 2/2 series has already gone in, would you mind
>> breaking this
>> remaining patch up into the basic support for new Intuos (without the
>> SW_TOUCH) and
>> then a separate patch to add SW_TOUCH support on top of that?  Then
>> the basic support can go in ASAP.
>
> Chris, thank you for pushing the process forward.
>
> SW_TOUCH is truly part of the basic support for the new series. The
> main new feature of this series is touch switch. If we do not report
> its status in the same patch, it means we are not reporting a complete
> set of data.
>
>> I only have comments on this patch related to the SW_TOUCH part... things like:
>>
>>  * should the SW_TOUCH be reported against the wireless interface or
>> the touch interface... userland apps may have an opinion on which is
>> best.
>
> We can not report SW_TOUCH status from touch interface since once
> touch is turned off (by end users), no events can go on touch
> interface. Plus, we do not know when a user may switch touch on.
> That's why SW_TOUCH are regularly updated and reported through
> wireless interface for wireless connection.

I think I made wrong assumption of HW.  Does HW stop sending touch
events when switch is toggled or is switch an indication to ignore
touch events in either driver or userland?

I was thinking it was for later case.  When userland has to ignore, it
is not easy to know switch value on /dev/input/foo really means what
to do related to events on /dev/input/bar.  So thats were my thoughts
were about moving it to input that needs to be disabled.  In former
case, it just status so not so important to decide which input to
report over.

>
>>  * the part with updating SW_TOUCH from unrelated interfaces could use
>
> It is not unrelated interface. It is how it works.
>
>> a review by someone like Dmitry for possible issues.

I meant any issues with parsing data in context of /dev/input/foo but
doing an input_sync(/dev/input/bar) in that same context.  Probably no
issue but I don't know kernel internals to be sure.

>>  * It would be better if you didn't add that EV_SW for HW that will
>> not report the SW_TOUCH.
>
> I can consider that in the next version.
>
>> If you break the patch into 2, you can add my line for the basic
>
> I'd like to know your opinion about my comments before updating the
> patch. IMO, using two patches to process one set of raw data
> complicates the support.

Assuming SW_TOUCH for this device is only for status reporting, I
don't have much opinion.  If it because a request to disable touch
events in userland then I think it should move to device its related
to.

Chris

>
> Ping
>
>> support without SW_TOUCH:
>>
>> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
>>
>> Chris
>>
>>>
>>> The driver is also updated to process wireless devices that do
>>> not support touch interface.
>>>
>>> Tested-by: Jason Gerecke <killertofu@gmail.com>
>>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>>> ---
>>> v2: Change SW_TOUCH_ENABLED to SW_TOUCH and clear BTN_TOUCH bit
>>> for button only interfaces as suggested by Peter Hutterer.
>>> ---
>>>  drivers/input/tablet/wacom_sys.c | 16 +++++++-
>>>  drivers/input/tablet/wacom_wac.c | 87 ++++++++++++++++++++++++++++++++--------
>>>  drivers/input/tablet/wacom_wac.h |  7 ++++
>>>  include/uapi/linux/input.h       |  1 +
>>>  4 files changed, 93 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
>>> index 7bdb5e9..efd9729 100644
>>> --- a/drivers/input/tablet/wacom_sys.c
>>> +++ b/drivers/input/tablet/wacom_sys.c
>>> @@ -1190,12 +1190,15 @@ static void wacom_wireless_work(struct work_struct *work)
>>>                 wacom_wac1->features.device_type = BTN_TOOL_PEN;
>>>                 snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
>>>                          wacom_wac1->features.name);
>>> +               wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
>>> +               wacom_wac1->shared->type = wacom_wac1->features.type;
>>>                 error = wacom_register_input(wacom1);
>>>                 if (error)
>>>                         goto fail;
>>>
>>>                 /* Touch interface */
>>> -               if (wacom_wac1->features.touch_max) {
>>> +               if (wacom_wac1->features.touch_max ||
>>> +                   wacom_wac1->features.type == INTUOS_HT) {
>>>                         wacom_wac2->features =
>>>                                 *((struct wacom_features *)id->driver_info);
>>>                         wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
>>> @@ -1210,6 +1213,10 @@ static void wacom_wireless_work(struct work_struct *work)
>>>                         error = wacom_register_input(wacom2);
>>>                         if (error)
>>>                                 goto fail;
>>> +
>>> +                       if (wacom_wac1->features.type == INTUOS_HT &&
>>> +                           wacom_wac1->features.touch_max)
>>> +                               wacom_wac->shared->touch_input = wacom_wac2->input;
>>>                 }
>>>
>>>                 error = wacom_initialize_battery(wacom);
>>> @@ -1318,7 +1325,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
>>>          * HID descriptor. If this is the touch interface (wMaxPacketSize
>>>          * of WACOM_PKGLEN_BBTOUCH3), override the table values.
>>>          */
>>> -       if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
>>> +       if (features->type >= INTUOS5S && features->type <= INTUOS_HT) {
>>>                 if (endpoint->wMaxPacketSize == WACOM_PKGLEN_BBTOUCH3) {
>>>                         features->device_type = BTN_TOOL_FINGER;
>>>                         features->pktlen = WACOM_PKGLEN_BBTOUCH3;
>>> @@ -1390,6 +1397,11 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
>>>                 }
>>>         }
>>>
>>> +       if (wacom_wac->features.type == INTUOS_HT && wacom_wac->features.touch_max) {
>>> +               if (wacom_wac->features.device_type == BTN_TOOL_FINGER)
>>> +                       wacom_wac->shared->touch_input = wacom_wac->input;
>>> +       }
>>> +
>>>         return 0;
>>>
>>>   fail5: wacom_destroy_leds(wacom);
>>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
>>> index 9c8eded..4cbea85 100644
>>> --- a/drivers/input/tablet/wacom_wac.c
>>> +++ b/drivers/input/tablet/wacom_wac.c
>>> @@ -1176,10 +1176,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
>>>  static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
>>>  {
>>>         struct input_dev *input = wacom->input;
>>> +       struct wacom_features *features = &wacom->features;
>>>
>>> -       input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
>>> +       if (features->type == INTUOS_HT) {
>>> +               input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
>>> +               input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
>>> +       } else {
>>> +
>>> +               input_report_key(input, BTN_BACK, (data[1] & 0x02) != 0);
>>> +               input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
>>> +       }
>>>         input_report_key(input, BTN_FORWARD, (data[1] & 0x04) != 0);
>>> -       input_report_key(input, BTN_BACK, (data[1] & 0x02) != 0);
>>>         input_report_key(input, BTN_RIGHT, (data[1] & 0x01) != 0);
>>>  }
>>>
>>> @@ -1213,13 +1220,23 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
>>>
>>>  static int wacom_bpt_pen(struct wacom_wac *wacom)
>>>  {
>>> +       struct wacom_features *features = &wacom->features;
>>>         struct input_dev *input = wacom->input;
>>>         unsigned char *data = wacom->data;
>>>         int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
>>>
>>> -       if (data[0] != 0x02)
>>> +       if (data[0] != WACOM_REPORT_PENABLED && data[0] != WACOM_REPORT_USB_MODE)
>>>             return 0;
>>>
>>> +       if (data[0] == WACOM_REPORT_USB_MODE) {
>>> +               if ((features->type == INTUOS_HT) && features->touch_max) {
>>> +                       input_report_switch(wacom->shared->touch_input,
>>> +                                           SW_TOUCH, data[8] & 0x40);
>>> +                       input_sync(wacom->shared->touch_input);
>>> +               }
>>> +               return 0;
>>> +       }
>>> +
>>>         prox = (data[1] & 0x20) == 0x20;
>>>
>>>         /*
>>> @@ -1297,13 +1314,20 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
>>>         unsigned char *data = wacom->data;
>>>         int connected;
>>>
>>> -       if (len != WACOM_PKGLEN_WIRELESS || data[0] != 0x80)
>>> +       if (len != WACOM_PKGLEN_WIRELESS || data[0] != WACOM_REPORT_WL_MODE)
>>>                 return 0;
>>>
>>>         connected = data[1] & 0x01;
>>>         if (connected) {
>>>                 int pid, battery;
>>>
>>> +               if ((wacom->shared->type == INTUOS_HT) &&
>>> +                               wacom->shared->touch_max) {
>>> +                       input_report_switch(wacom->shared->touch_input,
>>> +                                       SW_TOUCH, data[5] & 0x40);
>>> +                       input_sync(wacom->shared->touch_input);
>>> +               }
>>> +
>>>                 pid = get_unaligned_be16(&data[6]);
>>>                 battery = data[5] & 0x3f;
>>>                 if (wacom->pid != pid) {
>>> @@ -1391,6 +1415,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
>>>                 break;
>>>
>>>         case BAMBOO_PT:
>>> +       case INTUOS_HT:
>>>                 sync = wacom_bpt_irq(wacom_wac, len);
>>>                 break;
>>>
>>> @@ -1459,7 +1484,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
>>>
>>>         /* these device have multiple inputs */
>>>         if (features->type >= WIRELESS ||
>>> -           (features->type >= INTUOS5S && features->type <= INTUOSPL) ||
>>> +           (features->type >= INTUOS5S && features->type <= INTUOS_HT) ||
>>>             (features->oVid && features->oPid))
>>>                 features->quirks |= WACOM_QUIRK_MULTI_INPUT;
>>>
>>> @@ -1531,7 +1556,8 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>>>         struct wacom_features *features = &wacom_wac->features;
>>>         int i;
>>>
>>> -       input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>>> +       input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) |
>>> +                              BIT_MASK(EV_SW);
>>>
>>>         __set_bit(BTN_TOUCH, input_dev->keybit);
>>>         __set_bit(ABS_MISC, input_dev->absbit);
>>> @@ -1771,33 +1797,48 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>>>                 __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>>>                 break;
>>>
>>> +       case INTUOS_HT:
>>> +               if (features->touch_max &&
>>> +                   (features->device_type == BTN_TOOL_FINGER))
>>> +                       __set_bit(SW_TOUCH, input_dev->swbit);
>>> +               /* fall through */
>>> +
>>>         case BAMBOO_PT:
>>>                 __clear_bit(ABS_MISC, input_dev->absbit);
>>>
>>> -               __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>>> -
>>>                 if (features->device_type == BTN_TOOL_FINGER) {
>>> -                       unsigned int flags = INPUT_MT_POINTER;
>>>
>>>                         __set_bit(BTN_LEFT, input_dev->keybit);
>>>                         __set_bit(BTN_FORWARD, input_dev->keybit);
>>>                         __set_bit(BTN_BACK, input_dev->keybit);
>>>                         __set_bit(BTN_RIGHT, input_dev->keybit);
>>>
>>> -                       if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
>>> -                               input_set_abs_params(input_dev,
>>> +                       if (features->touch_max) {
>>> +                               /* touch interface */
>>> +                               unsigned int flags = INPUT_MT_POINTER;
>>> +
>>> +                               __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>>> +                               if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
>>> +                                       input_set_abs_params(input_dev,
>>>                                                      ABS_MT_TOUCH_MAJOR,
>>>                                                      0, features->x_max, 0, 0);
>>> -                               input_set_abs_params(input_dev,
>>> +                                       input_set_abs_params(input_dev,
>>>                                                      ABS_MT_TOUCH_MINOR,
>>>                                                      0, features->y_max, 0, 0);
>>> +                               } else {
>>> +                                       __set_bit(BTN_TOOL_FINGER, input_dev->keybit);
>>> +                                       __set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
>>> +                                       flags = 0;
>>> +                               }
>>> +                               input_mt_init_slots(input_dev, features->touch_max, flags);
>>>                         } else {
>>> -                               __set_bit(BTN_TOOL_FINGER, input_dev->keybit);
>>> -                               __set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
>>> -                               flags = 0;
>>> +                               /* buttons/keys only interface */
>>> +                               __clear_bit(ABS_X, input_dev->absbit);
>>> +                               __clear_bit(ABS_Y, input_dev->absbit);
>>> +                               __clear_bit(BTN_TOUCH, input_dev->keybit);
>>>                         }
>>> -                       input_mt_init_slots(input_dev, features->touch_max, flags);
>>>                 } else if (features->device_type == BTN_TOOL_PEN) {
>>> +                       __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>>>                         __set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
>>>                         __set_bit(BTN_TOOL_PEN, input_dev->keybit);
>>>                         __set_bit(BTN_STYLUS, input_dev->keybit);
>>> @@ -2194,6 +2235,17 @@ static const struct wacom_features wacom_features_0x300 =
>>>  static const struct wacom_features wacom_features_0x301 =
>>>         { "Wacom Bamboo One M",    WACOM_PKGLEN_BBPEN,    21648, 13530, 1023,
>>>           31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>>> +static const struct wacom_features wacom_features_0x302 =
>>> +       { "Wacom Intuos PT S",     WACOM_PKGLEN_BBPEN,    15200,  9500, 1023,
>>> +         31, INTUOS_HT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
>>> +         .touch_max = 16 };
>>> +static const struct wacom_features wacom_features_0x303 =
>>> +       { "Wacom Intuos PT M",     WACOM_PKGLEN_BBPEN,    21600, 13500, 1023,
>>> +         31, INTUOS_HT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
>>> +         .touch_max = 16 };
>>> +static const struct wacom_features wacom_features_0x30E =
>>> +       { "Wacom Intuos S",        WACOM_PKGLEN_BBPEN,    15200,  9500, 1023,
>>> +         31, INTUOS_HT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>>>  static const struct wacom_features wacom_features_0x6004 =
>>>         { "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
>>>           0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>>> @@ -2329,6 +2381,9 @@ const struct usb_device_id wacom_ids[] = {
>>>         { USB_DEVICE_WACOM(0x10D) },
>>>         { USB_DEVICE_WACOM(0x300) },
>>>         { USB_DEVICE_WACOM(0x301) },
>>> +       { USB_DEVICE_WACOM(0x302) },
>>> +       { USB_DEVICE_DETAILED(0x303, USB_CLASS_HID, 0, 0) },
>>> +       { USB_DEVICE_DETAILED(0x30E, USB_CLASS_HID, 0, 0) },
>>>         { USB_DEVICE_WACOM(0x304) },
>>>         { USB_DEVICE_DETAILED(0x314, USB_CLASS_HID, 0, 0) },
>>>         { USB_DEVICE_DETAILED(0x315, USB_CLASS_HID, 0, 0) },
>>> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
>>> index fd23a37..ba9e335 100644
>>> --- a/drivers/input/tablet/wacom_wac.h
>>> +++ b/drivers/input/tablet/wacom_wac.h
>>> @@ -54,6 +54,8 @@
>>>  #define WACOM_REPORT_TPCST             16
>>>  #define WACOM_REPORT_TPC1FGE           18
>>>  #define WACOM_REPORT_24HDT             1
>>> +#define WACOM_REPORT_WL_MODE           128
>>> +#define WACOM_REPORT_USB_MODE          192
>>>
>>>  /* device quirks */
>>>  #define WACOM_QUIRK_MULTI_INPUT                0x0001
>>> @@ -81,6 +83,7 @@ enum {
>>>         INTUOSPS,
>>>         INTUOSPM,
>>>         INTUOSPL,
>>> +       INTUOS_HT,
>>>         WACOM_21UX2,
>>>         WACOM_22HD,
>>>         DTK,
>>> @@ -129,6 +132,10 @@ struct wacom_features {
>>>  struct wacom_shared {
>>>         bool stylus_in_proximity;
>>>         bool touch_down;
>>> +       /* for wireless device to access USB interfaces */
>>> +       unsigned touch_max;
>>> +       int type;
>>> +       struct input_dev *touch_input;
>>>  };
>>>
>>>  struct wacom_wac {
>>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>>> index d08abf9..70e53e8 100644
>>> --- a/include/uapi/linux/input.h
>>> +++ b/include/uapi/linux/input.h
>>> @@ -855,6 +855,7 @@ struct input_keymap_entry {
>>>  #define SW_FRONT_PROXIMITY     0x0b  /* set = front proximity sensor active */
>>>  #define SW_ROTATE_LOCK         0x0c  /* set = rotate locked/disabled */
>>>  #define SW_LINEIN_INSERT       0x0d  /* set = inserted */
>>> +#define SW_TOUCH               0x0e  /* set = touch switch turned on (touch events off) */
>>>  #define SW_MAX                 0x0f
>>>  #define SW_CNT                 (SW_MAX+1)
>>>
>>> --
>>> 1.8.1.2
>>>
