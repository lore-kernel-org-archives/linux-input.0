From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH] HID: multitouch: Add suffix for HID_DG_TOUCHPAD
Date: Tue, 29 Sep 2015 08:37:29 +0200
Message-ID: <CADscph29v7vUKSazR=yfffcdsfQG6fWOzt6MFABxD1WwvbJCkQ@mail.gmail.com>
References: <1443450137-139724-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35956 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301AbbI2Gha (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 02:37:30 -0400
Received: by ykdt18 with SMTP id t18so204416062ykd.3
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2015 23:37:29 -0700 (PDT)
In-Reply-To: <1443450137-139724-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>

On 28 September 2015 at 16:22, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Instead of printing "UNKNOWN" as device suffix for HID_DG_TOUCHPAD call
> the device as "Touchpad".
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/hid/hid-multitouch.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 426b2f1a3450..661b4fce1a5d 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -968,6 +968,9 @@ static void mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
>                 case HID_DG_TOUCHSCREEN:
>                         /* we do not set suffix = "Touchscreen" */
>                         break;
> +               case HID_DG_TOUCHPAD:
> +                       suffix = "Touchpad";
> +                       break;
>                 case HID_GD_SYSTEM_CONTROL:
>                         suffix = "System Control";
>                         break;
> --

I will drop my locally pending patch for this. ;)

Reviewed-by: Daniel Martin <consume.noise@gmail.com>
