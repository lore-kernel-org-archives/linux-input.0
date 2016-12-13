From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: generic: add 5 tablet touch keys
Date: Tue, 13 Dec 2016 14:55:32 -0800
Message-ID: <CAF8JNhJVLUbtmh7b72LctajSqH1vPV552fDcxhpxzaDToX_dtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35802 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbcLMWzz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 17:55:55 -0500
Received: by mail-qk0-f193.google.com with SMTP id n204so220744qke.2
        for <linux-input@vger.kernel.org>; Tue, 13 Dec 2016 14:55:54 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jason Gerecke <killertofu@gmail.com>

On Mon, Dec 12, 2016 at 5:34 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Hi Dmitry,
>
> On Mon, Dec 12, 2016 at 4:45 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> Hi Ping,
>>
>> On Mon, Dec 12, 2016 at 03:46:25PM -0800, Ping Cheng wrote:
>> > Wacom Cintiq Pro [1] is a series of display tablets. They support
>> > 5 touch keys on the tablet. Those keys represent specific functions.
>> > They turn display off; bring up OSD; bring up On Screen Keyboard;
>> > bring up desktop control panel; and turn touch on/off.
>> >
>> > The most left touch key, that turns display on/off, is controlled by
>> > firmware. When the display is off, the mode is on. Otherwise, the
>> > mode is off. So, it works like a switch. That's why we introduced a
>> > new switch: SW_INDIRECT.
>>
>> This seems looks notification of already performed action, not input
>> event that requires handling.
>
> That's a good point. I'll think about it and do some more testing to
> see if we have a solution or not. Basically, we need to tell userland
> if it is a PROP_DIRECT device or not. With the same product ID, it is
> hard for libinput to distinguish the device between absolute and
> relative touch, without an event from kernel.

I did more testing with the device. As I described above, the mode
change event has to be passed to useland from the kernel since the
tablet stays connected while display turned off. There is no other
notification from wacom.ko to tell userland the device has been
changed from DIRECT to INDIRECT. We can not change PROP_DIRECT in
wacom.ko since it has already finished the probe call.

>> Is there a better way to communicate this
>> fact to the kernel and user?

I am afraid there isn't, unless you have secret functions up your sleeve ;).

>> > Other four touch keys are true software keys. We use the existing
>> > KEY_BUTTONCONFIG and KEY_CONTROLPANEL for OSD and control panel. But,
>> > we have to request two new keys: KEY_ONSCREEN_KEYBOARD
>>
>> Is there existing HID usage for this?
>
>
> No, I didn't find anything for ONSCREEN_KEYBOARD in the defines. tbh,
> I was surprised too.
>
>>
>> > and KEY_MUTE_DEVICE
>> > since none of the existing keys support those two actions.
>>
>> Hm, so it matches SW_MUTE_DEVICE. Is the action carried in software or
>> firmware (on device)?
>
>
> Will be implemented in software/userland. The key only reports an
> input event, which represents if it is pressed or released. However,
> there is a LED image to indicate each key's function. The images are
> static. That is, they do not change once the tablet is powered up
> (refer to the link for details).

With the above said, I did find a typo (just call it a typo :) in the patch.

+#define KEY_MUTE_DEVICE                      0x278 /* set = device disabled */

The comment is inappropriate since there is no set state for a key.
I'll remove the comment and post a v2 in a moment. Please review that
one and give me your comments/permission.

Cheers,
Ping

>> >
>> > [1] http://www.wacom.com/en-us/products/pen-displays/wacom-cintiq-pro
>> >
>> > Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
>> > ---
>> >  drivers/hid/wacom_wac.c                | 20 ++++++++++++++++++++
>> >  drivers/hid/wacom_wac.h                |  5 +++++
>> >  include/linux/mod_devicetable.h        |  2 +-
>> >  include/uapi/linux/input-event-codes.h |  6 +++++-
>> >  4 files changed, 31 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> > index b1a9a3c..f47be36 100644
>> > --- a/drivers/hid/wacom_wac.c
>> > +++ b/drivers/hid/wacom_wac.c
>> > @@ -1578,6 +1578,26 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
>> >               wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
>> >               features->device_type |= WACOM_DEVICETYPE_PAD;
>> >               break;
>> > +     case WACOM_HID_WD_INDIRECT:
>> > +             wacom_map_usage(input, usage, field, EV_SW, SW_INDIRECT, 0);
>> > +             features->device_type |= WACOM_DEVICETYPE_PAD;
>> > +             break;
>> > +     case WACOM_HID_WD_BUTTONCONFIG:
>> > +             wacom_map_usage(input, usage, field, EV_KEY, KEY_BUTTONCONFIG, 0);
>> > +             features->device_type |= WACOM_DEVICETYPE_PAD;
>> > +             break;
>> > +     case WACOM_HID_WD_ONSCREEN_KEYBOARD:
>> > +             wacom_map_usage(input, usage, field, EV_KEY, KEY_ONSCREEN_KEYBOARD, 0);
>> > +             features->device_type |= WACOM_DEVICETYPE_PAD;
>> > +             break;
>> > +     case WACOM_HID_WD_CONTROLPANEL:
>> > +             wacom_map_usage(input, usage, field, EV_KEY, KEY_CONTROLPANEL, 0);
>> > +             features->device_type |= WACOM_DEVICETYPE_PAD;
>> > +             break;
>> > +     case WACOM_HID_WD_MUTE_DEVICE:
>> > +             wacom_map_usage(input, usage, field, EV_KEY, KEY_MUTE_DEVICE, 0);
>> > +             features->device_type |= WACOM_DEVICETYPE_PAD;
>> > +             break;
>> >       }
>> >
>> >       switch (equivalent_usage & 0xfffffff0) {
>> > diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>> > index fb0e50a..a96184f 100644
>> > --- a/drivers/hid/wacom_wac.h
>> > +++ b/drivers/hid/wacom_wac.h
>> > @@ -105,6 +105,11 @@
>> >  #define WACOM_HID_WD_ACCELEROMETER_Z    (WACOM_HID_UP_WACOMDIGITIZER | 0x0403)
>> >  #define WACOM_HID_WD_BATTERY_CHARGING   (WACOM_HID_UP_WACOMDIGITIZER | 0x0404)
>> >  #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
>> > +#define WACOM_HID_WD_INDIRECT           (WACOM_HID_UP_WACOMDIGITIZER | 0x0980)
>> > +#define WACOM_HID_WD_MUTE_DEVICE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0981)
>> > +#define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER | 0x0982)
>> > +#define WACOM_HID_WD_ONSCREEN_KEYBOARD  (WACOM_HID_UP_WACOMDIGITIZER | 0x0983)
>> > +#define WACOM_HID_WD_BUTTONCONFIG       (WACOM_HID_UP_WACOMDIGITIZER | 0x0986)
>> >  #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
>> >  #define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
>> >  #define WACOM_HID_WD_BUTTONHOME         (WACOM_HID_UP_WACOMDIGITIZER | 0x0990)
>> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> > index ed84c07..342ddd6 100644
>> > --- a/include/linux/mod_devicetable.h
>> > +++ b/include/linux/mod_devicetable.h
>> > @@ -291,7 +291,7 @@ struct pcmcia_device_id {
>> >  #define INPUT_DEVICE_ID_LED_MAX              0x0f
>> >  #define INPUT_DEVICE_ID_SND_MAX              0x07
>> >  #define INPUT_DEVICE_ID_FF_MAX               0x7f
>> > -#define INPUT_DEVICE_ID_SW_MAX               0x0f
>> > +#define INPUT_DEVICE_ID_SW_MAX               0x1f
>> >
>> >  #define INPUT_DEVICE_ID_MATCH_BUS    1
>> >  #define INPUT_DEVICE_ID_MATCH_VENDOR 2
>> > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
>> > index d6d071f..c9633c8 100644
>> > --- a/include/uapi/linux/input-event-codes.h
>> > +++ b/include/uapi/linux/input-event-codes.h
>> > @@ -641,6 +641,9 @@
>> >   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
>> >   */
>> >  #define KEY_DATA                     0x275
>> > +/* same as SW_MUTE_DEVICE but triggered by a key */
>> > +#define KEY_MUTE_DEVICE                      0x278 /* set = device disabled */
>> > +#define KEY_ONSCREEN_KEYBOARD                0x279
>> >
>> >  #define BTN_TRIGGER_HAPPY            0x2c0
>> >  #define BTN_TRIGGER_HAPPY1           0x2c0
>> > @@ -781,7 +784,8 @@
>> >  #define SW_LINEIN_INSERT     0x0d  /* set = inserted */
>> >  #define SW_MUTE_DEVICE               0x0e  /* set = device disabled */
>> >  #define SW_PEN_INSERTED              0x0f  /* set = pen inserted */
>> > -#define SW_MAX                       0x0f
>> > +#define SW_INDIRECT          0x10  /* set = not a direct input device */
>> > +#define SW_MAX                       0x1f
>> >  #define SW_CNT                       (SW_MAX+1)
>> >
>> >  /*
>> > --
>> > 2.7.4
>> >
>>
>> --
>> Dmitry
