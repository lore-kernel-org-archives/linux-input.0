From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] psmouse - focaltech report finger width to userspace
Date: Fri, 29 May 2015 16:37:34 -0700
Message-ID: <20150529233734.GA20962@dtor-ws>
References: <1432940459-19828-1-git-send-email-hanipouspilot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34156 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbbE2Xhj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 May 2015 19:37:39 -0400
Content-Disposition: inline
In-Reply-To: <1432940459-19828-1-git-send-email-hanipouspilot@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Sat, May 30, 2015 at 02:00:59AM +0300, Dmitry Tunin wrote:
> Focaltech touchpads report finger width in packet[5] of absolute packet.
> Range for width in raw format is 0x10 - 0x70. Second half-byte is always 0.
> 0xff is reported, when a large contact area is detected.
> This can be handled in userspace.
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

Let's add a few people...

> ---
>  drivers/input/mouse/focaltech.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> index 23d2594..0c3b698 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -105,6 +105,16 @@ struct focaltech_hw_state {
>  
>  	/* True if the clickpad has been pressed. */
>  	bool pressed;
> +
> +	/*
> +	* Finger width 0-7 and 15 for a very big contact area.
> +	* 15 value stays until the finger is released.
> +	* Width is reported only in absolute packets.
> +	* Since hardware reports width only for last touching finger,
> +	* there is no need to store width for every specific finger, so 
> +	* we keep only last value reported.
> +	*/
> +	unsigned int width;
>  };
>  
>  struct focaltech_data {
> @@ -112,7 +122,7 @@ struct focaltech_data {
>  	struct focaltech_hw_state state;
>  };
>  
> -static void focaltech_report_state(struct psmouse *psmouse)
> +static void focaltech_report_state(struct psmouse *psmouse, bool abs)
>  {
>  	struct focaltech_data *priv = psmouse->private;
>  	struct focaltech_hw_state *state = &priv->state;
> @@ -137,6 +147,7 @@ static void focaltech_report_state(struct psmouse *psmouse)
>  			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
>  			input_report_abs(dev, ABS_MT_POSITION_Y,
>  					 priv->y_max - clamped_y);
> +			if (abs) input_report_abs(dev, ABS_TOOL_WIDTH, state->width);

I am not sure this condition and the change in focaltech_process_packet
are needed. The relative packets augment absolute one and we expect
width not change so we can always report state->width (either updated or
cached) and input core will drop dupes.

>  		}
>  	}
>  	input_mt_report_pointer_emulation(dev, true);
> @@ -187,6 +198,7 @@ static void focaltech_process_abs_packet(struct psmouse *psmouse,
>  
>  	state->fingers[finger].x = ((packet[1] & 0xf) << 8) | packet[2];
>  	state->fingers[finger].y = (packet[3] << 8) | packet[4];
> +	state->width = packet[5] >> 4;
>  	state->fingers[finger].valid = true;
>  }
>  
> @@ -228,22 +240,23 @@ static void focaltech_process_packet(struct psmouse *psmouse)
>  	switch (packet[0] & 0xf) {
>  	case FOC_TOUCH:
>  		focaltech_process_touch_packet(psmouse, packet);
> +		focaltech_report_state(psmouse, false);
>  		break;
>  
>  	case FOC_ABS:
>  		focaltech_process_abs_packet(psmouse, packet);
> +		focaltech_report_state(psmouse, true);
>  		break;
>  
>  	case FOC_REL:
>  		focaltech_process_rel_packet(psmouse, packet);
> +		focaltech_report_state(psmouse, false);
>  		break;
>  
>  	default:
>  		psmouse_err(psmouse, "Unknown packet type: %02x\n", packet[0]);
>  		break;
>  	}
> -
> -	focaltech_report_state(psmouse);
>  }
>  
>  static psmouse_ret_t focaltech_process_byte(struct psmouse *psmouse)
> @@ -331,6 +344,7 @@ static void focaltech_set_input_params(struct psmouse *psmouse)
>  	__set_bit(EV_ABS, dev->evbit);
>  	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
>  	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
> +	input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
>  	input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
>  	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
>  }
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
