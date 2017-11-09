From: Szymon Janc <szymon.janc@codecoup.pl>
Subject: Re: [PATCH] HID: sony: Fix SHANWAN pad rumbling on USB
Date: Thu, 09 Nov 2017 09:24:21 +0100
Message-ID: <2042668.WNNEdIESQl@ix>
References: <20171107142447.11810-1-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43694 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753058AbdKIIYY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 03:24:24 -0500
Received: by mail-wr0-f195.google.com with SMTP id 4so4809070wrt.0
        for <linux-input@vger.kernel.org>; Thu, 09 Nov 2017 00:24:24 -0800 (PST)
In-Reply-To: <20171107142447.11810-1-hadess@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>

Hi,

On Tuesday, 7 November 2017 15:24:47 CET Bastien Nocera wrote:
> The SHANWAN PS3 clone joypad will start its rumble motors as soon as
> it is plugged in via USB. As the additional USB interrupt does nothing on
> the original PS3 Sixaxis joypads, and makes a number of other
> clone joypads actually start sending data, disable that call for
> the SHANWAN so the rumble motors aren't started on plug.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/hid/hid-sony.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index d03203a82e8f..b9dc3ac4d4aa 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1439,10 +1439,16 @@ static int sixaxis_set_operational_usb(struct
> hid_device *hdev) goto out;
>  	}
> 
> -	ret = hid_hw_output_report(hdev, buf, 1);
> -	if (ret < 0) {
> -		hid_info(hdev, "can't set operational mode: step 3, ignoring\n");
> -		ret = 0;
> +	/*
> +	 * But the USB interrupt would cause SHANWAN controllers to
> +	 * start rumbling non-stop.
> +	 */
> +	if (strcmp(hdev->name, "SHANWAN PS3 GamePad")) {
> +		ret = hid_hw_output_report(hdev, buf, 1);
> +		if (ret < 0) {
> +			hid_info(hdev, "can't set operational mode: step 3, ignoring\n");
> +			ret = 0;
> +		}
>  	}
> 
>  out:

Works for me!

Tested-by: Szymon Janc <szymon.janc@codecoup.pl>

-- 
pozdrawiam
Szymon Janc
