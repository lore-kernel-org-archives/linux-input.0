From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] HID: update PenMount USB report descriptor so that
 only one button is reported
Date: Tue, 13 Oct 2015 10:08:01 -0400
Message-ID: <CAN+gG=F0Aq-qFBGaMFsv=PCeJCb8gOJ3XatjQPx8FdkRWKoShA@mail.gmail.com>
References: <1437394064-13881-1-git-send-email-andrew.shadura@collabora.co.uk>
	<1437668415-14569-1-git-send-email-andrew.shadura@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38688 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbbJMOIC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 10:08:02 -0400
Received: by wieq12 with SMTP id q12so34652503wie.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 07:08:01 -0700 (PDT)
In-Reply-To: <1437668415-14569-1-git-send-email-andrew.shadura@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Shadura <andrew.shadura@collabora.co.uk>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>

Hi Andrew,

[resurrecting this following a ping from Andrew]

On Thu, Jul 23, 2015 at 12:20 PM, Andrew Shadura
<andrew.shadura@collabora.co.uk> wrote:
> PenMount USB resistive touchscreen reports it has three buttons, while in reality
> it doesn't have any and doesn't support active styli, and only generates touch
> events.
>
> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
> ---
>  drivers/hid/hid-penmount.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
> index c11dce8..98ea1c12 100644
> --- a/drivers/hid/hid-penmount.c
> +++ b/drivers/hid/hid-penmount.c
> @@ -30,6 +30,23 @@ static int penmount_input_mapping(struct hid_device *hdev,
>         return 0;
>  }
>
> +static __u8 *penmount_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +        unsigned int *rsize)
> +{
> +       if (*rsize == 76 &&
> +               rdesc[2] == 0x09 && rdesc[3] == 0x02 /* mouse */ &&
> +               rdesc[22] == 0x05 && rdesc[23] == 0x09 /* button */ &&
> +               rdesc[26] == 0x29 && rdesc[27] == 0x03 /* maximum */ &&
> +               rdesc[32] == 0x95 && rdesc[33] == 0x02 /* report count */) {
> +               hid_info(hdev,
> +                       "fixing up PenMount USB touchscreen report descriptor\n");
> +
> +               rdesc[27] = 0x01; /* just one button */
> +               rdesc[33] = 0x01; /* just one report */

This is wrong. Changing this value shifts all the parsing of the rest
of the report descriptor. So if this is the last field in the current
report, then it might work. If not, then you are screwing the rest of
the report.

You can have 2 solutions to fix that:
- either you still use a report fixup and you add an extra const field
with a vendor usage page after this one (but that means allocating a
new report descriptor slightly larger)
- either you don't use a report fixup at all and ignore the extra
buttons in .input_mapping().

Cheers,
Benjamin

> +       }
> +       return rdesc;
> +}
> +
>  static const struct hid_device_id penmount_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
>         { }
> @@ -39,6 +56,7 @@ MODULE_DEVICE_TABLE(hid, penmount_devices);
>  static struct hid_driver penmount_driver = {
>         .name = "hid-penmount",
>         .id_table = penmount_devices,
> +       .report_fixup = penmount_report_fixup,
>         .input_mapping = penmount_input_mapping,
>  };
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
