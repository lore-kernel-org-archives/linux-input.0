From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom:fix spelling mistake: "exising" -> "existing"
Date: Tue, 27 Jun 2017 09:35:00 +0200
Message-ID: <20170627073500.GY26073@mail.corp.redhat.com>
References: <20170626193538.5562-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751538AbdF0HfF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Jun 2017 03:35:05 -0400
Content-Disposition: inline
In-Reply-To: <20170626193538.5562-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 26 2017 or thereabouts, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> trivial fix to spelling mistake in hid_warn warning message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/wacom_wac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 1992bb0732c2..9f940293ede4 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2110,28 +2110,28 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
>  		return;
>  	case WACOM_HID_WD_OFFSETLEFT:
>  		if (features->offset_left && value != features->offset_left)
> -			hid_warn(hdev, "%s: overriding exising left offset "
> +			hid_warn(hdev, "%s: overriding existing left offset "
>  				 "%d -> %d\n", __func__, value,
>  				 features->offset_left);
>  		features->offset_left = value;
>  		return;
>  	case WACOM_HID_WD_OFFSETRIGHT:
>  		if (features->offset_right && value != features->offset_right)
> -			hid_warn(hdev, "%s: overriding exising right offset "
> +			hid_warn(hdev, "%s: overriding existing right offset "
>  				 "%d -> %d\n", __func__, value,
>  				 features->offset_right);
>  		features->offset_right = value;
>  		return;
>  	case WACOM_HID_WD_OFFSETTOP:
>  		if (features->offset_top && value != features->offset_top)
> -			hid_warn(hdev, "%s: overriding exising top offset "
> +			hid_warn(hdev, "%s: overriding existing top offset "
>  				 "%d -> %d\n", __func__, value,
>  				 features->offset_top);
>  		features->offset_top = value;
>  		return;
>  	case WACOM_HID_WD_OFFSETBOTTOM:
>  		if (features->offset_bottom && value != features->offset_bottom)
> -			hid_warn(hdev, "%s: overriding exising bottom offset "
> +			hid_warn(hdev, "%s: overriding existing bottom offset "
>  				 "%d -> %d\n", __func__, value,
>  				 features->offset_bottom);
>  		features->offset_bottom = value;
> -- 
> 2.11.0
> 
