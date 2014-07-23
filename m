From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 5/5] hid: huion: Handle tablets with UC-Logic vendor ID
Date: Wed, 23 Jul 2014 10:43:59 -0400
Message-ID: <CAN+gG=GS6mTvcouzn+-nhvnUy3R2xbqigb4heLYN1XohrZo4hQ@mail.gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
	<1406119378-24551-6-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:37862 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757032AbaGWOoA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 10:44:00 -0400
Received: by mail-la0-f43.google.com with SMTP id hr17so1006946lab.16
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 07:43:59 -0700 (PDT)
In-Reply-To: <1406119378-24551-6-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Wed, Jul 23, 2014 at 8:42 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Add handling of Huion tablets with UC-Logic vendor ID, but the same
> product ID to hid-huion driver. A Huion H580 was seen using it.
>
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-huion.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
> index e6f5338..1006c2a 100644
> --- a/drivers/hid/hid-huion.c
> +++ b/drivers/hid/hid-huion.c
> @@ -247,6 +247,7 @@ static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
>
>  static const struct hid_device_id huion_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_HUION_TABLET) },
>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, huion_devices);
> --
> 2.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
