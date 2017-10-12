From: Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH v5] HID: hid-multitouch: support fine-grain orientation reporting
Date: Thu, 12 Oct 2017 14:30:41 +0800
Message-ID: <CABicQ-WpyOmU3=vpOg0i1V=KWXFCDqPO9EiJtLyYfsb7q2x34g@mail.gmail.com>
References: <20171012062143.39785-1-wnhuang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012062143.39785-1-wnhuang@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Sorry I forgot to remove the S-o-b of my Google email.
Henrik can you help me remove that line if you pick it? Thanks.

Wei-Ning

On Thu, Oct 12, 2017 at 2:21 PM, Wei-Ning Huang <wnhuang@chromium.org> wrot=
e:
> From: Wei-Ning Huang <wnhuang@chromium.org>
>
> The current hid-multitouch driver only allow the report of two
> orientations, vertical and horizontal. We use the Azimuth orientation
> usage 0x3F under the Digitizer usage page to report orientation if the
> device supports it.
>
> Changelog:
>   v1 -> v2:
>    - Fix commit message.
>    - Remove resolution reporting for ABS_MT_ORIENTATION.
>   v2 -> v3:
>    - Fix commit message.
>   v3 -> v4:
>    - Fix ABS_MT_ORIENTATION ABS param range.
>    - Don't set ABS_MT_ORIENTATION in ABS_DG_HEIGHT when it is already
>      set by ABS_DG_AZIMUTH.
>   v4 -> v5:
>    - Improve multi-touch-protocol.rst documentation.
>
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  Documentation/input/multi-touch-protocol.rst |  9 ++---
>  drivers/hid/hid-multitouch.c                 | 52 ++++++++++++++++++++++=
+++---
>  include/linux/hid.h                          |  1 +
>  3 files changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/input/multi-touch-protocol.rst b/Documentation=
/input/multi-touch-protocol.rst
> index 8035868c56bc..b51751a0cd5d 100644
> --- a/Documentation/input/multi-touch-protocol.rst
> +++ b/Documentation/input/multi-touch-protocol.rst
> @@ -269,10 +269,11 @@ ABS_MT_ORIENTATION
>      The orientation of the touching ellipse. The value should describe a=
 signed
>      quarter of a revolution clockwise around the touch center. The signe=
d value
>      range is arbitrary, but zero should be returned for an ellipse align=
ed with
> -    the Y axis of the surface, a negative value when the ellipse is turn=
ed to
> -    the left, and a positive value when the ellipse is turned to the
> -    right. When completely aligned with the X axis, the range max should=
 be
> -    returned.
> +    the Y axis (north) of the surface, a negative value when the ellipse=
 is
> +    turned to the left, and a positive value when the ellipse is turned =
to the
> +    right. When aligned with the X axis in the positive direction, the r=
ange
> +    max should be returned; when aligned with the X axis in the negative
> +    direction, the range -max should be returned.
>
>      Touch ellipsis are symmetrical by default. For devices capable of tr=
ue 360
>      degree orientation, the reported orientation must exceed the range m=
ax to
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 440b999304a5..3317dae64ef7 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -84,11 +84,12 @@ MODULE_LICENSE("GPL");
>  #define MT_IO_FLAGS_PENDING_SLOTS      2
>
>  struct mt_slot {
> -       __s32 x, y, cx, cy, p, w, h;
> +       __s32 x, y, cx, cy, p, w, h, a;
>         __s32 contactid;        /* the device ContactID assigned to this =
slot */
>         bool touch_state;       /* is the touch valid? */
>         bool inrange_state;     /* is the finger in proximity of the sens=
or? */
>         bool confidence_state;  /* is the touch made by a finger? */
> +       bool has_azimuth;       /* the contact reports azimuth */
>  };
>
>  struct mt_class {
> @@ -571,8 +572,15 @@ static int mt_touch_input_mapping(struct hid_device =
*hdev, struct hid_input *hi,
>                         if (!(cls->quirks & MT_QUIRK_NO_AREA)) {
>                                 set_abs(hi->input, ABS_MT_TOUCH_MINOR, fi=
eld,
>                                         cls->sn_height);
> -                               input_set_abs_params(hi->input,
> -                                       ABS_MT_ORIENTATION, 0, 1, 0, 0);
> +
> +                               /*
> +                                * Only set ABS_MT_ORIENTATION if it is n=
ot
> +                                * already set by the HID_DG_AZIMUTH usag=
e.
> +                                */
> +                               if (!test_bit(ABS_MT_ORIENTATION,
> +                                               hi->input->absbit))
> +                                       input_set_abs_params(hi->input,
> +                                               ABS_MT_ORIENTATION, 0, 1,=
 0, 0);
>                         }
>                         mt_store_field(usage, td, hi);
>                         return 1;
> @@ -591,6 +599,21 @@ static int mt_touch_input_mapping(struct hid_device =
*hdev, struct hid_input *hi,
>                         td->cc_index =3D field->index;
>                         td->cc_value_index =3D usage->usage_index;
>                         return 1;
> +               case HID_DG_AZIMUTH:
> +                       hid_map_usage(hi, usage, bit, max,
> +                               EV_ABS, ABS_MT_ORIENTATION);
> +                       /*
> +                        * Azimuth has the range of [0, MAX) representing=
 a full
> +                        * revolution. Set ABS_MT_ORIENTATION to a quarte=
r of
> +                        * MAX according the definition of ABS_MT_ORIENTA=
TION
> +                        */
> +                       input_set_abs_params(hi->input, ABS_MT_ORIENTATIO=
N,
> +                               -field->logical_maximum / 4,
> +                               field->logical_maximum / 4,
> +                               cls->sn_move ?
> +                               field->logical_maximum / cls->sn_move : 0=
, 0);
> +                       mt_store_field(usage, td, hi);
> +                       return 1;
>                 case HID_DG_CONTACTMAX:
>                         /* we don't set td->last_slot_field as contactcou=
nt and
>                          * contact max are global to the report */
> @@ -683,6 +706,10 @@ static void mt_complete_slot(struct mt_device *td, s=
truct input_dev *input)
>                         int wide =3D (s->w > s->h);
>                         int major =3D max(s->w, s->h);
>                         int minor =3D min(s->w, s->h);
> +                       int orientation =3D wide;
> +
> +                       if (s->has_azimuth)
> +                               orientation =3D s->a;
>
>                         /*
>                          * divided by two to match visual scale of touch
> @@ -699,7 +726,8 @@ static void mt_complete_slot(struct mt_device *td, st=
ruct input_dev *input)
>                         input_event(input, EV_ABS, ABS_MT_TOOL_Y, s->cy);
>                         input_event(input, EV_ABS, ABS_MT_DISTANCE,
>                                 !s->touch_state);
> -                       input_event(input, EV_ABS, ABS_MT_ORIENTATION, wi=
de);
> +                       input_event(input, EV_ABS, ABS_MT_ORIENTATION,
> +                               orientation);
>                         input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p)=
;
>                         input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, ma=
jor);
>                         input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, mi=
nor);
> @@ -789,6 +817,22 @@ static void mt_process_mt_event(struct hid_device *h=
id, struct hid_field *field,
>                         break;
>                 case HID_DG_CONTACTCOUNT:
>                         break;
> +               case HID_DG_AZIMUTH:
> +                       /*
> +                        * Azimuth is counter-clockwise and ranges from [=
0, MAX)
> +                        * (a full revolution). Convert it to clockwise r=
anging
> +                        * [-MAX/2, MAX/2].
> +                        *
> +                        * Note that ABS_MT_ORIENTATION require us to rep=
ort
> +                        * the limit of [-MAX/4, MAX/4], but the value ca=
n go
> +                        * out of range to [-MAX/2, MAX/2] to report an u=
pside
> +                        * down ellipsis.
> +                        */
> +                       if (value > field->logical_maximum / 2)
> +                               value -=3D field->logical_maximum;
> +                       td->curdata.a =3D -value;
> +                       td->curdata.has_azimuth =3D true;
> +                       break;
>                 case HID_DG_TOUCH:
>                         /* do nothing */
>                         break;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ab05a86269dc..d81b9b6fd83a 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -281,6 +281,7 @@ struct hid_item {
>
>  #define HID_DG_DEVICECONFIG    0x000d000e
>  #define HID_DG_DEVICESETTINGS  0x000d0023
> +#define HID_DG_AZIMUTH         0x000d003f
>  #define HID_DG_CONFIDENCE      0x000d0047
>  #define HID_DG_WIDTH           0x000d0048
>  #define HID_DG_HEIGHT          0x000d0049
> --
> 2.12.2
>



--=20
Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 | Software Engineer, Google Inc=
., Taiwan |
wnhuang@google.com | Cell: +886 910-380678
