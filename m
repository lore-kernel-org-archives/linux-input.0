From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 4/4] HID: logitech: Support WirelessDeviceStatus
 connect events
Date: Fri, 11 Oct 2019 10:51:22 +0200
Message-ID: <CAO-hwJL=j_toocbX2qqjt7JJdZS9CswPBo2fXich-7yYgKyd0A@mail.gmail.com>
References: <GOPSiaLYzQc3Hi9-MvdMQOmiF6O9whCeVYWavirKdm-9VHGb37VtawOPII8FEdYAOWZYFvk3oSQcHkPGazJKZNx8DEwBO7JfrRjLjWA84UI=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <GOPSiaLYzQc3Hi9-MvdMQOmiF6O9whCeVYWavirKdm-9VHGb37VtawOPII8FEdYAOWZYFvk3oSQcHkPGazJKZNx8DEwBO7JfrRjLjWA84UI=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 2:58 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> On Saturday, October 5, 2019 9:05 PM, Mazin Rezk <mnrzk@protonmail.com> w=
rote:
>
> > This patch makes WirelessDeviceStatus (0x1d4b) events get detected as
> > connection events on devices with HIDPP_QUIRK_WIRELESS_DEVICE_STATUS.
> >
> > This quirk is currently an alias for HIDPP_QUIRK_CLASS_BLUETOOTH since
> > the added Bluetooth devices do not support regular connect events.
>
> No changes have been made to this patch in v4.
>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 2062be922c08..b2b5fe2c74db 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -84,6 +84,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
>
>  /* Just an alias for now, may possibly be a catch-all in the future */
>  #define HIDPP_QUIRK_MISSING_SHORT_REPORTS      HIDPP_QUIRK_CLASS_BLUETOO=
TH
> +#define HIDPP_QUIRK_WIRELESS_DEVICE_STATUS     HIDPP_QUIRK_CLASS_BLUETOO=
TH

Hmm, I don't like the idea of aliasing quirks on a class. Either it's
a class of devices, and you use it as such in the code, either you
want to use individual quirks, and so each one of those needs its own
bit definition.

If you take my advice in 2/4, please assign a new bit for
HIDPP_QUIRK_WIRELESS_DEVICE_STATUS (0x1f IIRC), and logically and it
on the HIDPP_QUIRK_CLASS_BLUETOOTH here.



>
>  #define HIDPP_QUIRK_DELAYED_INIT               HIDPP_QUIRK_NO_HIDINPUT
>
> @@ -406,9 +407,22 @@ static inline bool hidpp_match_error(struct hidpp_re=
port *question,
>             (answer->fap.params[0] =3D=3D question->fap.funcindex_clienti=
d);
>  }
>
> -static inline bool hidpp_report_is_connect_event(struct hidpp_report *re=
port)
> +#define HIDPP_PAGE_WIRELESS_DEVICE_STATUS              0x1d4b
> +
> +static inline bool hidpp_report_is_connect_event(struct hidpp_device *hi=
dpp,
> +                                                struct hidpp_report *rep=
ort)
>  {
> -       return (report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) &&
> +       if (hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS) {
> +               /* If feature is invalid, skip array check */
> +               if (report->fap.feature_index > hidpp->feature_count)
> +                       return false;

This should probably be merged with the next return (if bool0, return
false else return bool1 can easily be transformed into return !bool0
&& bool1)

> +
> +               return (hidpp->features[report->fap.feature_index] =3D=3D
> +                        HIDPP_PAGE_WIRELESS_DEVICE_STATUS);

Oh, so that's why you need the feature enumeration.

Though, it's a costly operation when you could simply:
- add a wireless_feature_index in struct hidpp_device,
- gets this feature index at probe with a single call to
hidpp_root_get_feature()
- and check here if this feature index of the report is not null and
equal to wireless_feature_index.

Cheers,
Benjamin

> +       }
> +
> +       return ((report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) ||
> +               (hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)) &&
>                 (report->rap.sub_id =3D=3D 0x41);
>  }
>
> @@ -3157,7 +3171,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_devic=
e *hidpp, u8 *data,
>                 }
>         }
>
> -       if (unlikely(hidpp_report_is_connect_event(report))) {
> +       if (unlikely(hidpp_report_is_connect_event(hidpp, report))) {
>                 atomic_set(&hidpp->connected,
>                                 !(report->rap.params[0] & (1 << 6)));
>                 if (schedule_work(&hidpp->work) =3D=3D 0)
> --
> 2.23.0
