From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 4/4] HID: wacom: generic: Don't sync input on empty input packets
Date: Thu, 8 Dec 2016 11:39:12 -0800
Message-ID: <CANRwn3QB8X=j7HFxB9Gvh6qUEx9JcfeoDXe929_cpLxUvHtDnw@mail.gmail.com>
References: <1481156369-5403-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33503 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbcLHTjO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 14:39:14 -0500
Received: by mail-io0-f193.google.com with SMTP id p13so2148802ioi.0
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 11:39:13 -0800 (PST)
In-Reply-To: <1481156369-5403-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Wed, Dec 7, 2016 at 4:19 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> post input_sync only when there are input events posted
>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 86 +++++++++++++++++++++++++++++++++----------=
------
>  drivers/hid/wacom_wac.h |  1 +
>  2 files changed, 60 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 7a748a7..411ba2c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1591,18 +1591,13 @@ static void wacom_wac_pad_usage_mapping(struct hi=
d_device *hdev,
>         }
>  }
>
> -static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_fiel=
d *field,
> +static void wacom_wac_pad_battery_event(struct hid_device *hdev, struct =
hid_field *field,
>                 struct hid_usage *usage, __s32 value)
>  {
>         struct wacom *wacom =3D hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> -       struct input_dev *input =3D wacom_wac->pad_input;
>         unsigned equivalent_usage =3D wacom_equivalent_usage(usage->hid);
>
> -       if (wacom_equivalent_usage(field->physical) =3D=3D HID_DG_TABLETF=
UNCTIONKEY) {
> -               wacom_wac->hid_data.inrange_state |=3D value;
> -       }
> -
>         switch (equivalent_usage) {
>         case WACOM_HID_WD_BATTERY_LEVEL:
>                 wacom_wac->hid_data.battery_capacity =3D value;
> @@ -1614,11 +1609,29 @@ static void wacom_wac_pad_event(struct hid_device=
 *hdev, struct hid_field *field
>                 wacom_wac->hid_data.ps_connected =3D value;
>                 wacom_wac->hid_data.bat_connected =3D 1;
>                 break;
> +       }
> +}
> +
> +static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_fiel=
d *field,
> +               struct hid_usage *usage, __s32 value)
> +{
> +       struct wacom *wacom =3D hid_get_drvdata(hdev);
> +       struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> +       struct input_dev *input =3D wacom_wac->pad_input;
> +       struct wacom_features *features =3D &wacom_wac->features;
> +       unsigned equivalent_usage =3D wacom_equivalent_usage(usage->hid);
> +
> +       wacom_wac_pad_battery_event(hdev, field, usage, value);
> +       if (wacom_equivalent_usage(field->physical) =3D=3D HID_DG_TABLETF=
UNCTIONKEY) {
> +               wacom_wac->hid_data.inrange_state |=3D value;
> +       }
>
> +       switch (equivalent_usage) {
>         case WACOM_HID_WD_TOUCHRINGSTATUS:
>                 break;
>
>         default:
> +               features->input_event_flag =3D true;
>                 input_event(input, usage->type, usage->code, value);
>                 break;
>         }
> @@ -1633,6 +1646,25 @@ static void wacom_wac_pad_pre_report(struct hid_de=
vice *hdev,
>         wacom_wac->hid_data.inrange_state =3D 0;
>  }
>
> +static void wacom_wac_pad_battery_report(struct hid_device *hdev,
> +               struct hid_report *report)
> + {
> +       struct wacom *wacom =3D hid_get_drvdata(hdev);
> +       struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> +       struct wacom_features *features =3D &wacom_wac->features;
> +
> +       if (features->quirks & WACOM_QUIRK_BATTERY) {
> +               int capacity =3D wacom_wac->hid_data.battery_capacity;
> +               bool charging =3D wacom_wac->hid_data.bat_charging;
> +               bool connected =3D wacom_wac->hid_data.bat_connected;
> +               bool powered =3D wacom_wac->hid_data.ps_connected;
> +
> +               wacom_notify_battery(wacom_wac, capacity, charging,
> +                                    connected, powered);
> +       }
> +
> +}
> +
>  static void wacom_wac_pad_report(struct hid_device *hdev,
>                 struct hid_report *report)
>  {
> @@ -1642,24 +1674,18 @@ static void wacom_wac_pad_report(struct hid_devic=
e *hdev,
>         struct input_dev *input =3D wacom_wac->pad_input;
>         bool active =3D wacom_wac->hid_data.inrange_state !=3D 0;
>
> -       /*
> -        * don't report prox for events like accelerometer
> -        * or battery status
> -        */
> -       if (wacom_equivalent_usage(report->field[0]->physical) =3D=3D HID=
_DG_TABLETFUNCTIONKEY)
> -               input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_=
ID : 0);
> -
> -       if (features->quirks & WACOM_QUIRK_BATTERY) {
> -               int capacity =3D wacom_wac->hid_data.battery_capacity;
> -               bool charging =3D wacom_wac->hid_data.bat_charging;
> -               bool connected =3D wacom_wac->hid_data.bat_connected;
> -               bool powered =3D wacom_wac->hid_data.ps_connected;
> +       wacom_wac_pad_battery_report(hdev, report);
>
> -               wacom_notify_battery(wacom_wac, capacity, charging,
> -                                    connected, powered);
> +       /* report prox for expresskey events */
> +       if (wacom_equivalent_usage(report->field[0]->physical) =3D=3D HID=
_DG_TABLETFUNCTIONKEY) {
> +               features->input_event_flag =3D true;
> +               input_event(input, EV_ABS, ABS_MISC, active ? PAD_DEVICE_=
ID : 0);
>         }
>
> -       input_sync(input);
> +       if (features->input_event_flag) {
> +               features->input_event_flag =3D false;
> +               input_sync(input);
> +       }
>  }
>
>  static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
> @@ -2118,9 +2144,12 @@ void wacom_wac_event(struct hid_device *hdev, stru=
ct hid_field *field,
>         if (wacom->wacom_wac.features.type !=3D HID_GENERIC)
>                 return;
>
> -       if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
> -               wacom_wac_pad_event(hdev, field, usage, value);
> -       else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
> +       if (WACOM_PAD_FIELD(field)) {
> +               if (wacom->wacom_wac.pad_input)
> +                       wacom_wac_pad_event(hdev, field, usage, value);
> +               else
> +                       wacom_wac_pad_battery_event(hdev, field, usage, v=
alue);

Having this function call in the 'else' case is correct, but it
doesn't make much sense on its own. I think it might be clearer to
unconditionally call it here and then remove the call to it from
inside 'wacom_wac_pad_event'.

> +       } else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
>                 wacom_wac_pen_event(hdev, field, usage, value);
>         else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_inpu=
t)
>                 wacom_wac_finger_event(hdev, field, usage, value);
> @@ -2163,9 +2192,12 @@ void wacom_wac_report(struct hid_device *hdev, str=
uct hid_report *report)
>
>         wacom_report_events(hdev, report);
>
> -       if (WACOM_PAD_FIELD(field) && wacom->wacom_wac.pad_input)
> -               return wacom_wac_pad_report(hdev, report);
> -       else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
> +       if (WACOM_PAD_FIELD(field)) {
> +               if (wacom->wacom_wac.pad_input)
> +                       return wacom_wac_pad_report(hdev, report);
> +               else
> +                       return wacom_wac_pad_battery_report(hdev, report)=
;

Same comment as above.

These two tweaks aside, the series is Reviewed-By: Jason Gerecke
<jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> +       } else if (WACOM_PEN_FIELD(field) && wacom->wacom_wac.pen_input)
>                 return wacom_wac_pen_report(hdev, report);
>         else if (WACOM_FINGER_FIELD(field) && wacom->wacom_wac.touch_inpu=
t)
>                 return wacom_wac_finger_report(hdev, report);
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index a54a301..fb0e50a 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -232,6 +232,7 @@ struct wacom_features {
>         int pktlen;
>         bool check_for_hid_type;
>         int hid_type;
> +       bool input_event_flag;
>  };
>
>  struct wacom_shared {
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
