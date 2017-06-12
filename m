From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: joydev - ignore accelerometer devices
Date: Mon, 12 Jun 2017 09:09:53 +0200
Message-ID: <20170612070953.GA29589@mail.corp.redhat.com>
References: <20170609203547.17691-1-roderick@gaikai.com>
 <20170609203547.17691-2-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbdFLHKA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Jun 2017 03:10:00 -0400
Content-Disposition: inline
In-Reply-To: <20170609203547.17691-2-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Jun 09 2017 or thereabouts, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
> sensors on a separate evdev node. Joydev is picking these devices
> up as well, but they don't make sense for the joydev interface.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---

Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/joydev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 29d677c..a5ceaaf 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -819,6 +819,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
>  	if (joydev_dev_is_absolute_mouse(dev))
>  		return false;
>  
> +	/* Avoid accelerometers */
> +	if (test_bit(INPUT_PROP_ACCELEROMETER, dev->propbit))
> +		return false;
> +
>  	return true;
>  }
>  
> -- 
> 2.9.3
> 
