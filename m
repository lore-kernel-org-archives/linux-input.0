From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] input/mouse/elantech.c: Remove trackpoint related label
Date: Mon, 25 Jul 2016 11:53:56 +0200
Message-ID: <20160725095356.GI19383@mail.corp.redhat.com>
References: <1469281960-27572-1-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbcGYJyC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 05:54:02 -0400
Content-Disposition: inline
In-Reply-To: <1469281960-27572-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulrik De Bie <ulrik.debie-os@e2big.org>, Takashi Iwai <tiwai@suse.de>, Duson Lin <dusonlin@emc.com.tw>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN),
	linux-kernel@vger.kernel.org (open list)" <linux-input@vger.kernel.org>

Hi,

On Jul 23 2016 or thereabouts, Marcos Paulo de Souza wrote:
> by rearranging the code to release the trackpoint resource when some error
> happens.

Is there any advantage of doing so beside trying to remove one goto?
Because if not, that's the kernel failure style and this is much better
given that if somebody needs to add other commands after initializing the
trackstick, and if those command fail, we can then remove the
trackstick.

Cheers,
Benjamin

> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/input/mouse/elantech.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index be5b399..8c53a17 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1725,8 +1725,10 @@ int elantech_init(struct psmouse *psmouse)
>  		__set_bit(INPUT_PROP_POINTING_STICK, tp_dev->propbit);
>  
>  		error = input_register_device(etd->tp_dev);
> -		if (error < 0)
> -			goto init_fail_tp_reg;
> +		if (error < 0) {
> +			input_free_device(tp_dev);
> +			goto init_fail_tp_alloc;
> +		}
>  	}
>  
>  	psmouse->protocol_handler = elantech_process_byte;
> @@ -1735,8 +1737,6 @@ int elantech_init(struct psmouse *psmouse)
>  	psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
>  
>  	return 0;
> - init_fail_tp_reg:
> -	input_free_device(tp_dev);
>   init_fail_tp_alloc:
>  	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
>  			   &elantech_attr_group);
> -- 
> 2.7.4
> 
