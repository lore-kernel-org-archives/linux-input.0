From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v3] HID: wacom: generic: add 5 tablet touch keys
Date: Sun, 18 Dec 2016 09:59:29 -0800
Message-ID: <CANRwn3TOhhcKiGtDG6AZT8h7XyqhAymZDzsxym7p6_D2s57_Kg@mail.gmail.com>
References: <1481930680-6023-1-git-send-email-pingc@wacom.com> <CANRwn3Qtf-gEXrUmU3BeFkJRbqarcT=gJFt5P-pJdKk65U=PVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33661 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbcLRR7a (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Dec 2016 12:59:30 -0500
Received: by mail-io0-f194.google.com with SMTP id p13so17016060ioi.0
        for <linux-input@vger.kernel.org>; Sun, 18 Dec 2016 09:59:30 -0800 (PST)
In-Reply-To: <CANRwn3Qtf-gEXrUmU3BeFkJRbqarcT=gJFt5P-pJdKk65U=PVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, benjamin.tissoires@redhat.com, jikos@kernel.org, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org, jason.gerecke@wacom.com

My apologies for this second message. I had an unexpected HTML mail
bounce from the list. My Reviewed-by still stands.

On 12/18/16, Jason Gerecke <killertofu@gmail.com> wrote:
> Thanks for the patch, Ping. This version looks good to me.
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
>
>
> --
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one /
> (That is to say, eight) to the two, /
> But you can=E2=80=99t take seven from three, /
> So you look at the sixty-fours....
>
> On Dec 16, 2016 3:26 PM, "Ping Cheng" <pinglinux@gmail.com> wrote:
>
>> Wacom Cintiq Pro [1] is a series of display tablets. They support
>> 5 touch keys on the tablet. Those keys represent specific functions.
>> They turn display off; bring up OSD; bring up On Screen Keyboard;
>> bring up desktop control panel; and turn touch on/off.
>>
>> The most left touch key, that turns display on/off, is controlled by
>> firmware. When the display is on, the mode is set. Otherwise, the
>> mode is off. So, it works like a switch. That's why we introduced a
>> new switch: SW_INDIRECT. The switch defauts to INDIRECT instead of DIREC=
T
>> was a request from useland, more specifically Gnome, developers.
>>
>> Other four touch keys are true software keys. We use the existing
>> KEY_BUTTONCONFIG and KEY_CONTROLPANEL for OSD and control panel. But,
>> we have to request two new keys: KEY_ONSCREEN_KEYBOARD and
>> KEY_MUTE_DEVICE
>> since none of the existing keys support those two actions.
>>
>> [1] http://www.wacom.com/en-us/products/pen-displays/wacom-cintiq-pro
>>
>> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
>> ---
>> v3: Since no one has followed up with v2, let's add some more comments
>> for
>> SW_INDIRECT so we keep the offlist decision public ;).
>> ---
>>  drivers/hid/wacom_wac.c                | 25 +++++++++++++++++++++++++
>>  drivers/hid/wacom_wac.h                |  5 +++++
>>  include/linux/mod_devicetable.h        |  2 +-
>>  include/uapi/linux/input-event-codes.h |  6 +++++-
>>  4 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index b1a9a3c..739c592 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -1578,6 +1578,26 @@ static void wacom_wac_pad_usage_mapping(struct
>> hid_device *hdev,
>>                 wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL,
>> 0);
>>                 features->device_type |=3D WACOM_DEVICETYPE_PAD;
>>                 break;
>> +       case WACOM_HID_WD_DIRECT:
>> +               wacom_map_usage(input, usage, field, EV_SW, SW_INDIRECT,
>> 0);
>> +               features->device_type |=3D WACOM_DEVICETYPE_PAD;
>> +               break;
>> +       case WACOM_HID_WD_BUTTONCONFIG:
>> +               wacom_map_usage(input, usage, field, EV_KEY,
>> KEY_BUTTONCONFIG, 0);
>> +               features->device_type |=3D WACOM_DEVICETYPE_PAD;
>> +               break;
>> +       case WACOM_HID_WD_ONSCREEN_KEYBOARD:
>> +               wacom_map_usage(input, usage, field, EV_KEY,
>> KEY_ONSCREEN_KEYBOARD, 0);
>> +               features->device_type |=3D WACOM_DEVICETYPE_PAD;
>> +               break;
>> +       case WACOM_HID_WD_CONTROLPANEL:
>> +               wacom_map_usage(input, usage, field, EV_KEY,
>> KEY_CONTROLPANEL, 0);
>> +               features->device_type |=3D WACOM_DEVICETYPE_PAD;
>> +               break;
>> +       case WACOM_HID_WD_MUTE_DEVICE:
>> +               wacom_map_usage(input, usage, field, EV_KEY,
>> KEY_MUTE_DEVICE, 0);
>> +               features->device_type |=3D WACOM_DEVICETYPE_PAD;
>> +               break;
>>         }
>>
>>         switch (equivalent_usage & 0xfffffff0) {
>> @@ -1629,6 +1649,11 @@ static void wacom_wac_pad_event(struct hid_device
>> *hdev, struct hid_field *field
>>         case WACOM_HID_WD_TOUCHRINGSTATUS:
>>                 break;
>>
>> +       case WACOM_HID_WD_DIRECT:
>> +               features->input_event_flag =3D true;
>> +               input_event(input, usage->type, usage->code, !value);
>> +               break;
>> +
>>         default:
>>                 features->input_event_flag =3D true;
>>                 input_event(input, usage->type, usage->code, value);
>> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>> index fb0e50a..7a7b0f1 100644
>> --- a/drivers/hid/wacom_wac.h
>> +++ b/drivers/hid/wacom_wac.h
>> @@ -105,6 +105,11 @@
>>  #define WACOM_HID_WD_ACCELEROMETER_Z    (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0403)
>>  #define WACOM_HID_WD_BATTERY_CHARGING   (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0404)
>>  #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x043b)
>> +#define WACOM_HID_WD_DIRECT             (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0980)
>> +#define WACOM_HID_WD_MUTE_DEVICE        (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0981)
>> +#define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0982)
>> +#define WACOM_HID_WD_ONSCREEN_KEYBOARD  (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0983)
>> +#define WACOM_HID_WD_BUTTONCONFIG       (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0986)
>>  #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0910)
>>  #define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0950)
>>  #define WACOM_HID_WD_BUTTONHOME         (WACOM_HID_UP_WACOMDIGITIZER |
>> 0x0990)
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_
>> devicetable.h
>> index ed84c07..342ddd6 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -291,7 +291,7 @@ struct pcmcia_device_id {
>>  #define INPUT_DEVICE_ID_LED_MAX                0x0f
>>  #define INPUT_DEVICE_ID_SND_MAX                0x07
>>  #define INPUT_DEVICE_ID_FF_MAX         0x7f
>> -#define INPUT_DEVICE_ID_SW_MAX         0x0f
>> +#define INPUT_DEVICE_ID_SW_MAX         0x1f
>>
>>  #define INPUT_DEVICE_ID_MATCH_BUS      1
>>  #define INPUT_DEVICE_ID_MATCH_VENDOR   2
>> diff --git a/include/uapi/linux/input-event-codes.h
>> b/include/uapi/linux/input-event-codes.h
>> index d6d071f..32ef894 100644
>> --- a/include/uapi/linux/input-event-codes.h
>> +++ b/include/uapi/linux/input-event-codes.h
>> @@ -641,6 +641,9 @@
>>   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
>>   */
>>  #define KEY_DATA                       0x275
>> +/* same as SW_MUTE_DEVICE but triggered by a key */
>> +#define KEY_MUTE_DEVICE                0x278
>> +#define KEY_ONSCREEN_KEYBOARD          0x279
>>
>>  #define BTN_TRIGGER_HAPPY              0x2c0
>>  #define BTN_TRIGGER_HAPPY1             0x2c0
>> @@ -781,7 +784,8 @@
>>  #define SW_LINEIN_INSERT       0x0d  /* set =3D inserted */
>>  #define SW_MUTE_DEVICE         0x0e  /* set =3D device disabled */
>>  #define SW_PEN_INSERTED                0x0f  /* set =3D pen inserted */
>> -#define SW_MAX                 0x0f
>> +#define SW_INDIRECT            0x10  /* set =3D not a direct input devi=
ce
>> */
>> +#define SW_MAX                 0x1f
>>  #define SW_CNT                 (SW_MAX+1)
>>
>>  /*
>> --
>> 1.8.3.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" i=
n
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


--=20

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
