From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] HID: multitouch: Fix system-control buttons not working
Date: Thu, 31 Aug 2017 17:35:10 +0200
Message-ID: <dc4a4a3d-f8be-2436-7959-2c9b34179586@redhat.com>
References: <20170822063752.3235-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36663 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbdHaPfR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 31 Aug 2017 11:35:17 -0400
In-Reply-To: <20170822063752.3235-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

Hi,

On 22-08-17 08:37, Hans de Goede wrote:
> Some laptops have system-control buttons (e.g. KEY_SLEEP) on the same
> interface as a hid-multitouch touch-pad.
> 
> This commit fixes these buttons not working.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

What is the status of this patch ? It would be nice to get this
bug-fix into 4.14.

Regards,

Hans



> ---
>   drivers/hid/hid-multitouch.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0a8689bb08e9..53d1413cd435 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -930,6 +930,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>   	    field->application != HID_DG_PEN &&
>   	    field->application != HID_DG_TOUCHPAD &&
>   	    field->application != HID_GD_KEYBOARD &&
> +	    field->application != HID_GD_SYSTEM_CONTROL &&
>   	    field->application != HID_CP_CONSUMER_CONTROL &&
>   	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
>   	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
> 
