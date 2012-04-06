From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 2/2] Input: elantech - v4 is clickpad, with only one button
Date: Fri, 06 Apr 2012 07:13:26 -0700
Message-ID: <4F7EFA06.7050905@canonical.com>
References: <1333611981-8641-1-git-send-email-jj_ding@emc.com.tw> <1333611981-8641-2-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:32795 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab2DFONW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Apr 2012 10:13:22 -0400
In-Reply-To: <1333611981-8641-2-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 04/05/2012 12:46 AM, JJ Ding wrote:
> Add pointer and buttonpad properties for v4 hardware.
> 
> Also, Jachiet reported that on Asus UX31, right button has no effect. It
> turns out v4 has only one button, the right-button effect is implemented
> with software when Windows driver is installed, or in firmware when touchpad
> is in relative mode. So remove BTN_RIGHT while at it.
> 
> Reported-by: Jachiet Louis <louis@jachiet.com>
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 21c68a8..4790110 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -486,7 +486,6 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
>  	unsigned char *packet = psmouse->packet;
>  
>  	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
> -	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
>  	input_mt_report_pointer_emulation(dev, true);
>  	input_sync(dev);
>  }
> @@ -967,6 +966,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>  	if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
>  		return -1;
>  
> +	__set_bit(INPUT_PROP_POINTER, dev->propbit);
>  	__set_bit(EV_KEY, dev->evbit);
>  	__set_bit(EV_ABS, dev->evbit);
>  	__clear_bit(EV_REL, dev->evbit);
> @@ -1017,7 +1017,9 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>  			 */
>  			psmouse_warn(psmouse, "couldn't query resolution data.\n");
>  		}
> -
> +		/* v4 is clickpad, with only one button. */
> +		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
> +		__clear_bit(BTN_RIGHT, dev->keybit);
>  		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
>  		/* For X to recognize me as touchpad. */
>  		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);

Looks good to me :).

Reviewed-by: Chase Douglas <chase.douglas@canonical.com>

Thanks JJ!
