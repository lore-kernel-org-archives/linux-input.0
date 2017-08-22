From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid: Fix system-control buttons on a multitouch
 interface not working
Date: Tue, 22 Aug 2017 11:00:31 +0200
Message-ID: <20170822090031.GB25370@mail.corp.redhat.com>
References: <20170817104848.4347-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbdHVJAl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Aug 2017 05:00:41 -0400
Content-Disposition: inline
In-Reply-To: <20170817104848.4347-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Aug 17 2017 or thereabouts, Hans de Goede wrote:
> Some laptops have system-control buttons (e.g. KEY_SLEEP) on the same
> interface as a hid-multitouch touch-pad.
> 
> This commit fixes these buttons not working.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
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

Looks like you resent it this morning as https://patchwork.kernel.org/patch/9914313/

We can discard this one then I guess.

Cheers,
Benjamin

> 
