From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/3] HID: cp2112: fix broken gpio_direction_input callback
Date: Mon, 6 Nov 2017 09:11:20 +0100
Message-ID: <20171106081120.GC9728@mail.corp.redhat.com>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
 <1509621164-28830-3-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdKFIL2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Nov 2017 03:11:28 -0500
Content-Disposition: inline
In-Reply-To: <1509621164-28830-3-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Julien Boibessot <julien.boibessot@armadeus.com>

On Nov 02 2017 or thereabouts, Sébastien Szymanski wrote:
> When everything goes smoothly, ret is set to 0 which makes the function
> to return EIO error.
> 
> Fixes: 8e9faa15469e ("HID: cp2112: fix gpio-callback error handling")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  drivers/hid/hid-cp2112.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 28e3c18..f7754a6 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -205,12 +205,13 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
>  				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
>  				 HID_REQ_SET_REPORT);
> -	if (ret < 0) {
> +	if (ret != CP2112_GPIO_CONFIG_LENGTH) {

Ack for this.

>  		hid_err(hdev, "error setting GPIO config: %d\n", ret);
>  		goto exit;
>  	}
>  
> -	ret = 0;
> +	mutex_unlock(&dev->lock);
> +	return 0;

Wouldn't it be better to just turn
- return ret < 0 ? ret : -EIO;
into
+ return ret <= 0 ? ret : -EIO;
at the end of the function?

I'd rather keep the same exit path in both cases, error or success.

Cheers,
Benjamin


>  
>  exit:
>  	mutex_unlock(&dev->lock);
> -- 
> 2.7.3
> 
