From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/1] HID: multitouch: enable palm rejection if device
 implements confidence usage
Date: Mon, 23 Nov 2015 14:49:08 +0100
Message-ID: <CAN+gG=EK5dZ0nioaghzZgdsjjwUeytU8oG26FjaHxSsf5=UO9w@mail.gmail.com>
References: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36237 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbKWNtJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 08:49:09 -0500
In-Reply-To: <1448014866-25348-1-git-send-email-allen_hung@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Allen Hung <allen_hung@dell.com>
Cc: Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Fri, Nov 20, 2015 at 11:21 AM, Allen Hung <allen_hung@dell.com> wrote:
> The usage Confidence is mandary to Windows Precision Touchpad devices. The
> appearance of this usage is checked in hidinput_connect but the quirk
> MT_QUIRK_VALID_IS_CONFIDENCE is not applied to device accordingly.
> Apply this quirk and also remove quirk MT_QUIRK_ALWAYS_VALID to enable palm
> rejection for the WIN 8 touchpad devices which have implemented usage
> Confidence in its input reports.
>
> Tested on Dell XPS 13 laptop.
>
> Signed-off-by: Allen Hung <allen_hung@dell.com>
> ---

No side effects on non touchpads as reported by my tests.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-multitouch.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 426b2f1..13aeff9 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -448,6 +448,11 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                         mt_store_field(usage, td, hi);
>                         return 1;
>                 case HID_DG_CONFIDENCE:
> +                       if (cls->name == MT_CLS_WIN_8 &&
> +                               field->application == HID_DG_TOUCHPAD) {
> +                               cls->quirks &= ~MT_QUIRK_ALWAYS_VALID;
> +                               cls->quirks |= MT_QUIRK_VALID_IS_CONFIDENCE;
> +                       }
>                         mt_store_field(usage, td, hi);
>                         return 1;
>                 case HID_DG_TIPSWITCH:
> --
> 1.9.1
>
