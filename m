From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: Correct coordinate system of touchring and
 pen twist
Date: Tue, 29 Aug 2017 11:34:37 -0700
Message-ID: <CAF8JNhJggOk6ie-_75PoMvu=5mt=Tp+JaP96XoeM=t=MV5OOvw@mail.gmail.com>
References: <20170824230902.4381-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170824230902.4381-1-killertofu@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input <linux-input@vger.kernel.org>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 24, 2017 at 4:09 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> The MobileStudio Pro, Cintiq Pro, and 2nd-gen Intuos Pro devices use a
> different coordinate system for their touchring and pen twist than prior
> devices. Prior devices had zero aligned to the tablet's left and would
> increase clockwise. Userspace expects data from the kernel to be in this
> old coordinate space, so adjustments are necessary.
>
> While the coordinate system for pen twist is formally defined by the HID
> standard, no such definition existed for the touchring at the time these
> tablets were introduced. Future tablets are expected to report touchring
> data using the same "zero-up clockwise-increasing" coordinate system
> defined for twist.
>
> Fixes: 60a2218698 ("HID: wacom: generic: add support for touchring")
> Fixes: 50066a042d ("HID: wacom: generic: Add support for height, tilt, and twist usages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Thank you Jason for catching and correcting the issue.

Intuos Pro 2 series supports wireless/bluetooth connection, which was
implemented in its own routine. Should we also update that code path?
Except that, the patch is:

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> ---
>  drivers/hid/wacom_wac.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index bb17d7bbefd3..7f0b3d497ecb 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1616,6 +1616,20 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>         return 0;
>  }
>
> +static int wacom_offset_rotation(struct input_dev *input, struct hid_usage *usage,
> +                                int value, int num, int denom)
> +{
> +       struct input_absinfo *abs = &input->absinfo[usage->code];
> +       int range = (abs->maximum - abs->minimum + 1);
> +
> +       value += num*range/denom;
> +       if (value > abs->maximum)
> +               value -= range;
> +       else if (value < abs->minimum)
> +               value += range;
> +       return value;
> +}
> +
>  int wacom_equivalent_usage(int usage)
>  {
>         if ((usage & HID_USAGE_PAGE) == WACOM_HID_UP_WACOMDIGITIZER) {
> @@ -1898,6 +1912,7 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
>         unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
>         int i;
>         bool is_touch_on = value;
> +       bool do_report = false;
>
>         /*
>          * Avoid reporting this event and setting inrange_state if this usage
> @@ -1912,6 +1927,29 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
>         }
>
>         switch (equivalent_usage) {
> +       case WACOM_HID_WD_TOUCHRING:
> +               /*
> +                * Userspace expects touchrings to increase in value with
> +                * clockwise gestures and have their zero point at the
> +                * tablet's left. HID events "should" be clockwise-
> +                * increasing and zero at top, though the MobileStudio
> +                * Pro and 2nd-gen Intuos Pro don't do this...
> +                */
> +               if (hdev->vendor == 0x56a &&
> +                   (hdev->product == 0x34d || hdev->product == 0x34e ||  /* MobileStudio Pro */
> +                    hdev->product == 0x357 || hdev->product == 0x358)) { /* Intuos Pro 2 */
> +                       value = (field->logical_maximum - value);
> +
> +                       if (hdev->product == 0x357 || hdev->product == 0x358)
> +                               value = wacom_offset_rotation(input, usage, value, 3, 16);
> +                       else if (hdev->product == 0x34d || hdev->product == 0x34e)
> +                               value = wacom_offset_rotation(input, usage, value, 1, 2);
> +               }
> +               else {
> +                       value = wacom_offset_rotation(input, usage, value, 1, 4);
> +               }
> +               do_report = true;
> +               break;
>         case WACOM_HID_WD_TOUCHRINGSTATUS:
>                 if (!value)
>                         input_event(input, usage->type, usage->code, 0);
> @@ -1945,10 +1983,14 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
>                                          value, i);
>                  /* fall through*/
>         default:
> +               do_report = true;
> +               break;
> +       }
> +
> +       if (do_report) {
>                 input_event(input, usage->type, usage->code, value);
>                 if (value)
>                         wacom_wac->hid_data.pad_input_event_flag = true;
> -               break;
>         }
>  }
>
> @@ -2089,6 +2131,14 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
>                 wacom_wac->serial[0] = (wacom_wac->serial[0] & ~0xFFFFFFFFULL);
>                 wacom_wac->serial[0] |= (__u32)value;
>                 return;
> +       case HID_DG_TWIST:
> +               /*
> +                * Userspace expects pen twist to have its zero point when
> +                * the buttons/finger is on the tablet's left. HID values
> +                * are zero when buttons are toward the top.
> +                */
> +               value = wacom_offset_rotation(input, usage, value, 1, 4);
> +               break;
>         case WACOM_HID_WD_SENSE:
>                 wacom_wac->hid_data.sense_state = value;
>                 return;
> --
> 2.14.1
>
