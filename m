From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: wacom: Add support for Cintiq Companion 2
Date: Mon, 12 Oct 2015 01:02:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510120059280.21100@pobox.suse.cz>
References: <CADvPr_5M_o46S_Y1qnWSmJVgTVeNaBo77x5fPgYdQhyKYG_gNg@mail.gmail.com> <1444328918-3157-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52389 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964821AbbJKXCY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Oct 2015 19:02:24 -0400
In-Reply-To: <1444328918-3157-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Clifford Jolly <expiredpopsicle@gmail.com>

On Thu, 8 Oct 2015, Jason Gerecke wrote:

> Adds support for the EMR (pen+pad) and touchscreen devices used by the
> Wacom Cintiq Companion 2. This applies both to using the device as a
> standalone system, as well as when operating in "Cintiq mode" (where
> the EMR/touchscreen are simply exposed as USB devices to the system
> its connected to).
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Clifford Jolly <expiredpopsicle@gmail.com>
[ ... snip ... ]
> @@ -2290,6 +2311,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
>  	case WACOM_27QHD:
>  	case DTK:
>  	case CINTIQ_HYBRID:
> +	case CINTIQ_COMPANION_2:
>  		sync = wacom_intuos_irq(wacom_wac);
>  		break;

This doesn't make any sense. You break here out after handling 
CINTIQ_COMPANION_2 in features->type switch ...

>  
> @@ -2543,6 +2565,7 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
>  	case CINTIQ:
>  	case WACOM_13HD:
>  	case CINTIQ_HYBRID:
> +	case CINTIQ_COMPANION_2:
>  		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
>  		input_abs_set_res(input_dev, ABS_Z, 287);
>  		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);

... here you break out of the switch case a few lines below again.


> @@ -2595,6 +2618,12 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
>  		__clear_bit(ABS_MISC, input_dev->absbit);
>  		/* fall through */
>  
> +	case CINTIQ_COMPANION_2:
> +		for (i = 0; i < 10; i++)

Where do you define this 'i'?

> +			__set_bit(BTN_0 + i, input_dev->keybit);
> +		__set_bit(BTN_A, input_dev->keybit);
> +		break;
> +

And here you break out of the same case again explicitly again.

-- 
Jiri Kosina
SUSE Labs

