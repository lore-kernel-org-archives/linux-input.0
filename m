From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] psmouse - focaltech report finger width to userspace
Date: Sun, 31 May 2015 11:31:20 -0700
Message-ID: <20150531183120.GA6814@dtor-ws>
References: <20150529233734.GA20962@dtor-ws>
 <1432995045-15969-1-git-send-email-hanipouspilot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36797 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758477AbbEaSbY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 May 2015 14:31:24 -0400
Content-Disposition: inline
In-Reply-To: <1432995045-15969-1-git-send-email-hanipouspilot@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Sat, May 30, 2015 at 05:10:45PM +0300, Dmitry Tunin wrote:
> Focaltech touchpads report finger width in packet[5] of absolute packet.
> Range for width in raw format is 0x10 - 0x70. Second half-byte is always 0.
> 0xff is reported, when a large contact area is detected.
> This can be handled in userspace.
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/focaltech.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> index 23d2594..ed2ec3b 100644
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
> @@ -137,6 +147,7 @@ static void focaltech_report_state(struct psmouse *psmouse)
>  			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
>  			input_report_abs(dev, ABS_MT_POSITION_Y,
>  					 priv->y_max - clamped_y);
> +			input_report_abs(dev, ABS_TOOL_WIDTH, state->width);
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
> @@ -331,6 +343,7 @@ static void focaltech_set_input_params(struct psmouse *psmouse)
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

-- 
Dmitry
