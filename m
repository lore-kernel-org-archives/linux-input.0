From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3/4] Input: Synaptics: Some touchpads can sense the
 complete locations of two fingers rather than just the bounding box, so for
 these pads, report the co-ordinates directly.
Date: Fri, 10 Jun 2011 23:07:30 +0200
Message-ID: <20110610210730.GC5925@polaris.bitmath.org>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
 <1307735704-30673-4-git-send-email-derek.foreman@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:33374 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904Ab1FJVAr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 17:00:47 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 75252EA526
	for <linux-input@vger.kernel.org>; Fri, 10 Jun 2011 23:00:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307735704-30673-4-git-send-email-derek.foreman@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derek Foreman <derek.foreman@collabora.co.uk>
Cc: linux-input@vger.kernel.org

Hi Derek,

> From: Daniel Stone <daniel.stone@collabora.co.uk>
> 
> 
> Signed-off-by: Derek Foreman <derek.foreman@collabora.co.uk>
> ---
>  drivers/input/mouse/synaptics.c |   35 ++++++++++++++++++++++++++---------
>  drivers/input/mouse/synaptics.h |    2 ++
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 40748e3..3c68663 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -162,6 +162,11 @@ static int synaptics_capability(struct psmouse *psmouse)
>  		} else {
>  			priv->ext_cap = (cap[0] << 16) | (cap[1] << 8) | cap[2];
>  
> +			if (priv->model_id == 0x1e2b1)
> +				priv->use_bounding_box = 0;
> +			else
> +				priv->use_bounding_box = 1;
> +
>  			/*
>  			 * if nExtBtn is greater than 8 it should be considered
>  			 * invalid and treated as 0
> @@ -485,7 +490,8 @@ static int synaptics_parse_hw_state(const unsigned char buf[],
>  	return 0;
>  }
>  
> -static void set_slot(struct input_dev *dev, int slot, bool active, int x, int y)
> +static void set_slot(struct input_dev *dev, int slot, bool active, int x, int y,
> +		     int z)

This part adds logic for pressure information, which is separate from
the main objective of the patch. Please split the patch accordingly.

>  {
>  	input_mt_slot(dev, slot);
>  	input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
> @@ -493,23 +499,30 @@ static void set_slot(struct input_dev *dev, int slot, bool active, int x, int y)
>  		input_report_abs(dev, ABS_MT_POSITION_X, x);
>  		input_report_abs(dev, ABS_MT_POSITION_Y,
>  				 YMAX_NOMINAL + YMIN_NOMINAL - y);
> +		input_report_abs(dev, ABS_MT_PRESSURE, z);
>  	}
>  }
>  
>  static void synaptics_report_semi_mt_data(struct input_dev *dev,
> +					  struct synaptics_data *priv,
>  					  const struct synaptics_hw_state *a,
>  					  const struct synaptics_hw_state *b,
>  					  int num_fingers)
>  {
> -	if (num_fingers >= 2) {
> -		set_slot(dev, 0, true, min(a->x, b->x), min(a->y, b->y));
> -		set_slot(dev, 1, true, max(a->x, b->x), max(a->y, b->y));
> +	if (num_fingers >= 2 && priv->use_bounding_box) {
> +		set_slot(dev, 0, true, min(a->x, b->x), min(a->y, b->y),
> +			 min(a->z, b->z));
> +		set_slot(dev, 1, true, max(a->x, b->x), max(a->y, b->y),
> +			 max(a->z, b->z));
> +	} else if (num_fingers >= 2) {
> +		set_slot(dev, 0, true, a->x, a->y, a->z);
> +		set_slot(dev, 1, true, b->x, b->y, b->z);
>  	} else if (num_fingers == 1) {
> -		set_slot(dev, 0, true, a->x, a->y);
> -		set_slot(dev, 1, false, 0, 0);
> +		set_slot(dev, 0, true, a->x, a->y, a->z);
> +		set_slot(dev, 1, false, 0, 0, 0);
>  	} else {
> -		set_slot(dev, 0, false, 0, 0);
> -		set_slot(dev, 1, false, 0, 0);
> +		set_slot(dev, 0, false, 0, 0, 0);
> +		set_slot(dev, 1, false, 0, 0, 0);
>  	}
>  }
>  

Please simplify this hunk further, to only show the additional logic
based on !use_bounding_box.

> @@ -573,7 +586,8 @@ static void synaptics_process_packet(struct psmouse *psmouse)
>  	}
>  
>  	if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c))
> -		synaptics_report_semi_mt_data(dev, &hw, &priv->mt, num_fingers);
> +		synaptics_report_semi_mt_data(dev, priv, &hw, &priv->mt,
> +					      num_fingers);
>  
>  	/* Post events
>  	 * BTN_TOUCH has to be first as mousedev relies on it when doing
> @@ -702,6 +716,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
>  				     priv->x_max ?: XMAX_NOMINAL, 0, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_Y, YMIN_NOMINAL,
>  				     priv->y_max ?: YMAX_NOMINAL, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
>  	}

Separate patch, please.

>  
>  	if (SYN_CAP_PALMDETECT(priv->capabilities))
> @@ -736,6 +751,8 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
>  
>  	input_abs_set_res(dev, ABS_X, priv->x_res);
>  	input_abs_set_res(dev, ABS_Y, priv->y_res);
> +	input_abs_set_res(dev, ABS_MT_POSITION_X, priv->x_res);
> +	input_abs_set_res(dev, ABS_MT_POSITION_Y, priv->y_res);

These seem off-topic to this patch, please move to separate patch.

>  
>  	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
>  		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> index 7453938..9a2b0a7 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -136,6 +136,8 @@ struct synaptics_data {
>  	unsigned char mode;			/* current mode byte */
>  	int scroll;
>  
> +	unsigned int use_bounding_box:1;        /* report bounding box for MT */
> +

Please use bool.

>  	struct serio *pt_port;			/* Pass-through serio port */
>  
>  	struct synaptics_hw_state mt;		/* current gesture packet */
> -- 
> 1.7.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Henrik
