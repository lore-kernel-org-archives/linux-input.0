From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: Add suffix for HID_DG_TOUCHPAD
Date: Tue, 29 Sep 2015 05:05:20 -0400
Message-ID: <20150929090520.GB30386@mail.corp.redhat.com>
References: <1443450137-139724-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53570 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824AbbI2JFW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 05:05:22 -0400
Content-Disposition: inline
In-Reply-To: <1443450137-139724-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Sep 28 2015 or thereabouts, Mika Westerberg wrote:
> Instead of printing "UNKNOWN" as device suffix for HID_DG_TOUCHPAD call
> the device as "Touchpad".
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-multitouch.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 426b2f1a3450..661b4fce1a5d 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -968,6 +968,9 @@ static void mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  		case HID_DG_TOUCHSCREEN:
>  			/* we do not set suffix = "Touchscreen" */
>  			break;
> +		case HID_DG_TOUCHPAD:
> +			suffix = "Touchpad";
> +			break;
>  		case HID_GD_SYSTEM_CONTROL:
>  			suffix = "System Control";
>  			break;
> -- 
> 2.5.1
> 
