From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 3/4] HID: logitech: Add feature 0x0001: FeatureSet
Date: Fri, 11 Oct 2019 10:33:17 +0200
Message-ID: <CAO-hwJ+AMmNUOhas+vq6K4sRcCspyJuAefKO8oomAH4=CDHoJw@mail.gmail.com>
References: <jCmT1QOunDmSu59iO1T1xj2-WfFeGhMn_i5knEWTCoph9VH1oxjpYf3Q6CWH7BRrq1NTVYBsAVJcIgu8azAEmFZJA8PzLfH3bHBcWNbFqeY=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <jCmT1QOunDmSu59iO1T1xj2-WfFeGhMn_i5knEWTCoph9VH1oxjpYf3Q6CWH7BRrq1NTVYBsAVJcIgu8azAEmFZJA8PzLfH3bHBcWNbFqeY=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 2:57 AM Mazin Rezk <mnrzk@protonmail.com> wrote:
>
> On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <mnrzk@protonmail.com> w=
rote:
>
> > This patch adds support for the 0x0001 (FeatureSet) feature. This featu=
re
> > is used to look up the feature ID of a feature index on a device and li=
st
> > the total count of features on the device.
> >
> > I also added the hidpp20_get_features function which iterates through a=
ll
> > feature indexes on the device and stores a map of them in features an
> > hidpp_device struct. This function runs when an HID++ 2.0 device is pro=
bed.
>
> Changes in the version:
>  - Renamed hidpp20_featureset_get_feature to
>    hidpp20_featureset_get_feature_id.
>
>  - Re-ordered hidpp20_featureset_get_count and
>    hidpp20_featureset_get_feature_id based on their command IDs.
>
>  - Made feature_count initialize to 0 before running hidpp20_get_features=
.

I still need to decide whether or not we need to take this one. We
historically did not do this to mimic the Windows driver at the time.
However, the driver is full of quirks that could be detected instead
of hardcoded thanks to this functions. So we might want to switch to
auto-detection of those quirks so we can keep 'quirks' for actual
defects that can't be auto-detected.

But, if we want to go this route, we need to actually make use of it.
So this patch should be part of a series where we use it, not added by
its own.

Can you drop it from the series?
And maybe possibly work on a cleanup of some of the auto detection,
like the HIDPP_QUIRK_HI_RES_SCROLL_X2121 which you can easily test?
But this would need to happen in a second series, once this one gets
merged in.

Cheers,
Benjamin

>
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 90 ++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index a0efa8a43213..2062be922c08 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -190,6 +190,9 @@ struct hidpp_device {
>
>         struct hidpp_battery battery;
>         struct hidpp_scroll_counter vertical_wheel_counter;
> +
> +       u16 *features;
> +       u8 feature_count;
>  };
>
>  /* HID++ 1.0 error codes */
> @@ -911,6 +914,82 @@ static int hidpp_root_get_protocol_version(struct hi=
dpp_device *hidpp)
>         return 0;
>  }
>
> +/* ---------------------------------------------------------------------=
----- */
> +/* 0x0001: FeatureSet                                                   =
      */
> +/* ---------------------------------------------------------------------=
----- */
> +
> +#define HIDPP_PAGE_FEATURESET                          0x0001
> +
> +#define CMD_FEATURESET_GET_COUNT                       0x00
> +#define CMD_FEATURESET_GET_FEATURE                     0x11
> +
> +static int hidpp20_featureset_get_count(struct hidpp_device *hidpp,
> +       u8 feature_index, u8 *count)
> +{
> +       struct hidpp_report response;
> +       int ret;
> +
> +       ret =3D hidpp_send_fap_command_sync(hidpp, feature_index,
> +               CMD_FEATURESET_GET_COUNT, NULL, 0, &response);
> +
> +       if (ret)
> +               return ret;
> +
> +       *count =3D response.fap.params[0];
> +
> +       return ret;
> +}
> +
> +static int hidpp20_featureset_get_feature_id(struct hidpp_device *hidpp,
> +       u8 featureset_index, u8 feature_index, u16 *feature_id)
> +{
> +       struct hidpp_report response;
> +       int ret;
> +
> +       ret =3D hidpp_send_fap_command_sync(hidpp, featureset_index,
> +               CMD_FEATURESET_GET_FEATURE, &feature_index, 1, &response)=
;
> +
> +       if (ret)
> +               return ret;
> +
> +       *feature_id =3D (response.fap.params[0] << 8) | response.fap.para=
ms[1];
> +
> +       return ret;
> +}
> +
> +static int hidpp20_get_features(struct hidpp_device *hidpp)
> +{
> +       int ret;
> +       u8 featureset_index, featureset_type;
> +       u8 i;
> +
> +       ret =3D hidpp_root_get_feature(hidpp, HIDPP_PAGE_FEATURESET,
> +                                    &featureset_index, &featureset_type)=
;
> +
> +       if (ret =3D=3D -ENOENT) {
> +               hid_warn(hidpp->hid_dev, "Unable to retrieve feature set.=
");
> +               return 0;
> +       }
> +
> +       if (ret)
> +               return ret;
> +
> +       ret =3D hidpp20_featureset_get_count(hidpp, featureset_index,
> +               &hidpp->feature_count);
> +
> +       if (ret)
> +               return ret;
> +
> +       hidpp->features =3D devm_kzalloc(&hidpp->hid_dev->dev,
> +                       hidpp->feature_count * sizeof(u16), GFP_KERNEL);
> +
> +       for (i =3D 0; i < hidpp->feature_count && !ret; i++)
> +               ret =3D hidpp20_featureset_get_feature_id(hidpp, features=
et_index,
> +                               i, &(hidpp->features[i]));
> +
> +       return ret;
> +}
> +
>  /* ---------------------------------------------------------------------=
----- */
>  /* 0x0005: GetDeviceNameType                                            =
      */
>  /* ---------------------------------------------------------------------=
----- */
> @@ -3625,6 +3704,17 @@ static int hidpp_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>                 hidpp_overwrite_name(hdev);
>         }
>
> +       /* Cache feature indexes and IDs to check reports faster */
> +       hidpp->feature_count =3D 0;
> +
> +       if (hidpp->protocol_major >=3D 2) {
> +               if (hidpp20_get_features(hidpp)) {
> +                       hid_err(hdev, "%s:hidpp20_get_features returned e=
rror\n",
> +                               __func__);
> +                       goto hid_hw_init_fail;
> +               }
> +       }
> +
>         if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
>                 ret =3D wtp_get_config(hidpp);
>                 if (ret)
> --
> 2.23.0
