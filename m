From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/1] HID: multitouch: enable palm rejection if device
 implements confidence usage
Date: Wed, 18 Nov 2015 11:10:05 +0100
Message-ID: <CAN+gG=HaDC9kVtGLKh_=xqnrq==HKN+WxdroPEQ=K1PwRDOoKQ@mail.gmail.com>
References: <1447839706-3192-1-git-send-email-allen_hung@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447839706-3192-1-git-send-email-allen_hung@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Allen Hung <allen_hung@dell.com>
Cc: Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 18, 2015 at 10:41 AM, Allen Hung <allen_hung@dell.com> wrote:
> The usage Confidence is mandary to Windows Precision Touchpad devices. The
> appearance of this usage is checked in hidinput_connect but the quirk
> MT_QUIRK_VALID_IS_CONFIDENCE is not applied to the device accordingly.
> Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable the
> palm rejection for the devices which implement the usage confidence in its
> input reports.
>
> Tested on Dell XPS 13 laptop.
>
> Signed-off-by: Allen Hung <allen_hung@dell.com>
> ---
>  drivers/hid/hid-multitouch.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 426b2f1..661de1d 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -448,6 +448,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                         mt_store_field(usage, td, hi);
>                         return 1;
>                 case HID_DG_CONFIDENCE:
> +                       cls->quirks &= ~MT_QUIRK_ALWAYS_VALID;
> +                       cls->quirks |= MT_QUIRK_VALID_IS_CONFIDENCE;

NACK: you are going to break a *lot* of multitouch panels with this change.

Please target the modification to only touchpads that are following
the Precision Touchpad spec. Even there, I will need to be sure that
there will be no side effect, but we will have a much thiner spectre
than blindly enabling this.

For the record, Windows 7 touchscreens used to put any meaning in the
confidence tag.

Cheers,
Benjamin

>                         mt_store_field(usage, td, hi);
>                         return 1;
>                 case HID_DG_TIPSWITCH:
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
