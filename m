From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: Fix system-control buttons not working
Date: Tue, 22 Aug 2017 10:59:20 +0200
Message-ID: <20170822085920.GA25370@mail.corp.redhat.com>
References: <20170822063752.3235-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbdHVI70 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2017 04:59:26 -0400
Content-Disposition: inline
In-Reply-To: <20170822063752.3235-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Aug 22 2017 or thereabouts, Hans de Goede wrote:
> Some laptops have system-control buttons (e.g. KEY_SLEEP) on the same
> interface as a hid-multitouch touch-pad.
> 
> This commit fixes these buttons not working.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-multitouch.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0a8689bb08e9..53d1413cd435 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -930,6 +930,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  	    field->application != HID_DG_PEN &&
>  	    field->application != HID_DG_TOUCHPAD &&
>  	    field->application != HID_GD_KEYBOARD &&
> +	    field->application != HID_GD_SYSTEM_CONTROL &&
>  	    field->application != HID_CP_CONSUMER_CONTROL &&
>  	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
>  	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
> -- 
> 2.13.4
> 
