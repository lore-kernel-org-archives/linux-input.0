From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid: thingm: remove not needed error message
Date: Mon, 25 Apr 2016 09:35:37 +0200
Message-ID: <20160425073537.GB23234@mail.corp.redhat.com>
References: <5717CB61.3080603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54702 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbcDYHfl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 03:35:41 -0400
Content-Disposition: inline
In-Reply-To: <5717CB61.3080603@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Apr 20 2016 or thereabouts, Heiner Kallweit wrote:
> LED core takes care of handling failed calls to thingm_let_set.
> - print error message in set_brightness_delayed or
> - pass error to caller in led_set_brightness_sync
> Also the error message here doesn't provide any hint what actually
> went wrong. Therefore remove it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Works for me:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@rehat.com>

> ---
>  drivers/hid/hid-thingm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> index 2507bbe..9ad9c6e 100644
> --- a/drivers/hid/hid-thingm.c
> +++ b/drivers/hid/hid-thingm.c
> @@ -148,13 +148,8 @@ static int thingm_led_set(struct led_classdev *ldev,
>  			  enum led_brightness brightness)
>  {
>  	struct thingm_led *led = container_of(ldev, struct thingm_led, ldev);
> -	int ret;
> -
> -	ret = thingm_write_color(led->rgb);
> -	if (ret)
> -		hid_err(led->rgb->tdev->hdev, "failed to write color\n");
>  
> -	return ret;
> +	return thingm_write_color(led->rgb);
>  }
>  
>  static int thingm_init_led(struct thingm_led *led, const char *color_name,
> -- 
> 2.8.0
> 
