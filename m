From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: do not blindly set EV_KEY or EV_ABS bits
Date: Wed, 12 Jul 2017 09:38:05 +0200
Message-ID: <20170712073805.GD22282@mail.corp.redhat.com>
References: <20170711170218.GA30175@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756657AbdGLHiS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 03:38:18 -0400
Content-Disposition: inline
In-Reply-To: <20170711170218.GA30175@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Matthias Fend <Matthias.Fend@wolfvision.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jul 11 2017 or thereabouts, Dmitry Torokhov wrote:
> Now that input core insists on having dev->absinfo when device claims to
> generate EV_ABS in its dev->evbit, we should not be blindly setting that
> bit.
> 
> The code in question might have been needed before input_set_abs_params()
> started setting EV_ABS in device's evbit, but not anymore, and is now
> breaking devices such as SMART SPNL-6075 Touchscreen.
> 
> Fixes: 6ecfe51b4082 ("Input: refuse to register absolute devices ...")
> Reported-by: Matthias Fend <Matthias.Fend@wolfvision.net>
> Tested-by: Matthias Fend <Matthias.Fend@wolfvision.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Jiri, Benjamin, I marked it for stable as it causes regressions in 4.12
> reported by users. Please take a look.

set_bit(usage->type, input->evbit); is called by hid-input.c when the
return code is positive, so we should be safe here.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
>  drivers/hid/hid-multitouch.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 24d5b6deb571..be5bea15ce52 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -595,16 +595,6 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  	return 0;
>  }
>  
> -static int mt_touch_input_mapped(struct hid_device *hdev, struct hid_input *hi,
> -		struct hid_field *field, struct hid_usage *usage,
> -		unsigned long **bit, int *max)
> -{
> -	if (usage->type == EV_KEY || usage->type == EV_ABS)
> -		set_bit(usage->type, hi->input->evbit);
> -
> -	return -1;
> -}
> -
>  static int mt_compute_slot(struct mt_device *td, struct input_dev *input)
>  {
>  	__s32 quirks = td->mtclass.quirks;
> @@ -905,8 +895,10 @@ static int mt_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>  		return 0;
>  
>  	if (field->application == HID_DG_TOUCHSCREEN ||
> -	    field->application == HID_DG_TOUCHPAD)
> -		return mt_touch_input_mapped(hdev, hi, field, usage, bit, max);
> +	    field->application == HID_DG_TOUCHPAD) {
> +		/* We own these mappings, tell hid-input to ignore them */
> +		return -1;
> +	}
>  
>  	/* let hid-core decide for the others */
>  	return 0;
> -- 
> 2.13.2.725.g09c95d1e9-goog
> 
> 
> -- 
> Dmitry
