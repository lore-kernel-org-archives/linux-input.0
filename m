From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input : Optimize joydev_connect function
Date: Tue, 10 Mar 2015 18:44:04 -0700
Message-ID: <20150311014404.GB22959@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1426012577-921-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:45116 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbCKBoJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 21:44:09 -0400
Received: by igjz20 with SMTP id z20so8749888igj.4
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2015 18:44:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426012577-921-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

Hi Anshul,

On Tue, Mar 10, 2015 at 11:36:17AM -0700, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> In joydev_connect function added check for event type before
> setting properties for that event. This will avoid dummy
> loop iterations which checks for event code even if event type
> is not set.

I do not think you'll find a device that would fit joydev's matching
rules that would benefit from this.

> 
> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
> ---
>  drivers/input/joydev.c |   44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index f362883..a37a26c 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -797,27 +797,31 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
>  	joydev->handle.name = dev_name(&joydev->dev);
>  	joydev->handle.handler = handler;
>  	joydev->handle.private = joydev;
> +
> +	if (test_bit(EV_ABS, dev->evbit)) {
> +		for (i = 0; i < ABS_CNT; i++)
> +			if (test_bit(i, dev->absbit)) {
> +				joydev->absmap[i] = joydev->nabs;
> +				joydev->abspam[joydev->nabs] = i;
> +				joydev->nabs++;
> +			}
> +	}
>  
> -	for (i = 0; i < ABS_CNT; i++)
> -		if (test_bit(i, dev->absbit)) {
> -			joydev->absmap[i] = joydev->nabs;
> -			joydev->abspam[joydev->nabs] = i;
> -			joydev->nabs++;
> -		}
> -
> -	for (i = BTN_JOYSTICK - BTN_MISC; i < KEY_MAX - BTN_MISC + 1; i++)
> -		if (test_bit(i + BTN_MISC, dev->keybit)) {
> -			joydev->keymap[i] = joydev->nkey;
> -			joydev->keypam[joydev->nkey] = i + BTN_MISC;
> -			joydev->nkey++;
> -		}
> -
> -	for (i = 0; i < BTN_JOYSTICK - BTN_MISC; i++)
> -		if (test_bit(i + BTN_MISC, dev->keybit)) {
> -			joydev->keymap[i] = joydev->nkey;
> -			joydev->keypam[joydev->nkey] = i + BTN_MISC;
> -			joydev->nkey++;
> -		}
> +	if (test_bit(EV_KEY, dev->evbit)) {
> +		for (i = BTN_JOYSTICK - BTN_MISC; i < KEY_MAX - BTN_MISC + 1; i++)
> +			if (test_bit(i + BTN_MISC, dev->keybit)) {
> +				joydev->keymap[i] = joydev->nkey;
> +				joydev->keypam[joydev->nkey] = i + BTN_MISC;
> +				joydev->nkey++;
> +			}
> +
> +		for (i = 0; i < BTN_JOYSTICK - BTN_MISC; i++)
> +			if (test_bit(i + BTN_MISC, dev->keybit)) {
> +				joydev->keymap[i] = joydev->nkey;
> +				joydev->keypam[joydev->nkey] = i + BTN_MISC;
> +				joydev->nkey++;
> +			}
> +	}
>  
>  	for (i = 0; i < joydev->nabs; i++) {
>  		j = joydev->abspam[i];
> -- 
> 1.7.9.5
> 
> 
> ---
> This email has been checked for viruses by Avast antivirus software.
> http://www.avast.com
> 

-- 
Dmitry
