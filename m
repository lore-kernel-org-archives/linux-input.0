From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/3] HID: wacom: Remove useless conditions from 'wacom_query_tablet_data'
Date: Mon, 2 Nov 2015 17:40:09 -0800
Message-ID: <CAF8JNhKX0hk_Ozsyur1mv=NVP23cr5z7nLTNYmfWNJYNQpMAzg@mail.gmail.com>
References: <1446507673-4458-1-git-send-email-killertofu@gmail.com> <1446507673-4458-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34295 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbKCBk3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 20:40:29 -0500
Received: by oies66 with SMTP id s66so1261178oie.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 17:40:29 -0800 (PST)
In-Reply-To: <1446507673-4458-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, Nov 2, 2015 at 3:41 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> When support for the Cintiq Companion Hybrid and Cintiq Companion 2 was
> added (36d3c51 and f7acb55), the 'wacom_query_tablet_data' function was
> updated to include references to CINTIQ_HYBRID and CINTIQ_COMPANION_2
> with the thought that they were necessary to switch the touch interface
> into the proper mode. This is unnecessary, however, since those types
> are only ever associated with the pen interface -- the touch interfaces
> are either CINTIQ_24HDT or HID_GENERIC. To avoid confusion in the future,
> we remove the unnecessary CINTIQ_HYBRID and CINTIQ_COMPANION_2 conditions.
>
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

for this patch and the 3/3 of this set.

Ping

> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 45656e8..69ff5b5 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -422,7 +422,7 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
>                         /* MT Tablet PC touch */
>                         return wacom_set_device_mode(hdev, 3, 4, 4);
>                 }
> -               else if (features->type == WACOM_24HDT || features->type == CINTIQ_HYBRID || features->type == CINTIQ_COMPANION_2) {
> +               else if (features->type == WACOM_24HDT) {
>                         return wacom_set_device_mode(hdev, 18, 3, 2);
>                 }
>                 else if (features->type == WACOM_27QHDT) {
> --
> 2.6.2
>
