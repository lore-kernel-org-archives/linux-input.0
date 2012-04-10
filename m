From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Tue, 10 Apr 2012 10:21:13 -0500
Message-ID: <20120410152113.GC21994@thinkpad-t410>
References: <1364401.K99JIOKFyb@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44236 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab2DJPVS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Apr 2012 11:21:18 -0400
Content-Disposition: inline
In-Reply-To: <1364401.K99JIOKFyb@vaio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Pantalos <gpantalos@gmail.com>
Cc: linux-input@vger.kernel.org

Hi George,

Thanks for the patch. I've got some specific comments inline below, but
here are some general comments.

The reason I've never followed through with the v4 semi-MT support is
that I lost access to the hardware before I could complete it. When I
had the hardware the thing I struggled with was how to handle receiving
only one full set of MT data for every 3 sets of ST data. It looks like
you've opted to only report every third ST data point (if the previous
MT packet showed more than 1 touch, more on that below), when you also
have a complete set of MT data. That's one possible approach, but I'm
not sure that it's the best. Hopefully some of the input gurus on the
list can comment. As I recall the main difficulty with reporting all ST
points was not knowing the finger count until the third packet of the
sequence, so I was leaning towards accumulating the data and processing
it all in one go after the third packet in the sequence arrived.

I definitely think your state processing could be improved. My
suggestion would be to treat multi_packet as a counter. Reset it to 0
when you see the sync bit is set, and increment it for each packet until
you have a full set of MT data. That way you know for sure which section
of the MT data you're working with for any given packet. But be prepared
to handle an incomplete packet sequence as well (I'm pretty sure I saw
some of these when I was working with a v4 touchpad).

On Tue, Apr 10, 2012 at 05:02:41PM +0300, George Pantalos wrote:
> --- drivers/input/mouse/alps.c	2012-03-19 01:15:34.000000000 +0200
> +++ drivers/input/mouse/alps.c.new	2012-04-09 17:14:25.193621808 +0300
> @@ -604,11 +604,59 @@
>  
>  static void alps_process_packet_v4(struct psmouse *psmouse)
>  {
> +        struct alps_data *priv = psmouse->private;

Should be a tab instead of spaces. You've got spaces for indentation at
some other places as well. Try running checkpatch.pl (in the scripts
directory of the kernel source tree) to catch these types of problems.

>  	unsigned char *packet = psmouse->packet;
>  	struct input_dev *dev = psmouse->dev;
>  	int x, y, z;
>  	int left, right;
> +	int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
> +	int fingers = 0, bmap_fingers;
> +	unsigned int x_bitmap, y_bitmap;
> +
> +	if (priv->multi_packet) {
> +          if (packet[6] != 0x00) { 

This condition may not work all the time. Based on the documentaiton I
wrote at least it looks like byte 6 in the second packet of the sequence
could be zero, but I can't remember for sure.

> +		priv->multi_data_v4[2] = packet[6];
> +		priv->multi_data_v4[3] = packet[7];
> +		priv->multi_packet = 1;
> +		if (priv->last_fingers > 1)
> +		return;

The body of if statements needs to be indented.

> +          } else {
> +		priv->multi_data_v4[4] = packet[6];
> +		priv->multi_data_v4[5] = packet[7];
> +
> +		fingers = 0;
> +		priv->multi_packet = 0;
> +		x_bitmap = ((priv->multi_data_v4[2] & 0x1f) << 10) | /*0x1f*/
> +			   ((priv->multi_data_v4[3] & 0x60) << 3) |
> +			   ((priv->multi_data_v4[0] & 0x3f) << 2) |
> +			   ((priv->multi_data_v4[1] & 0x60) >> 5);
> +		y_bitmap = ((priv->multi_data_v4[5] & 0x01) << 10) |
> +			   ((priv->multi_data_v4[3] & 0x1f) << 5) |
> +			    (priv->multi_data_v4[1] & 0x1f);
> +	  
> +		bmap_fingers = alps_process_bitmap(x_bitmap, y_bitmap,
> +						  &x1, &y1, &x2, &y2);
> +		if (bmap_fingers > 1) {
> +			fingers = bmap_fingers;
> +		}

Braces aren't needed when there's only a single line in the body of an
if statement.

> +	  
> +		priv->last_fingers = fingers;
>  
> +          /*packet = priv->multi_data;*/
> +          /*packet = packet;*/

Delete the commented out lines if they aren't needed.

> +	  }
> +	}
> +
> +	if (!priv->multi_packet && (packet[6] & 0x40)) {
> +		priv->multi_packet = 1;
> +		priv->multi_data_v4[0] = packet[6];
> +		priv->multi_data_v4[1] = packet[7];
> +		if (priv->last_fingers > 1)
> +		return;

So you're deciding how to handle the current packet sequence based on
the number of touch points in the previous sequence. You lose a couple
of ST points then each time you transition from multiple touches to a
single touch. That might be okay, depending on what kind of feedback is
received on how to handle the packet sequences.

> +	}
> +	
> +        /*priv->multi_packet = 0;*/

Again, if this isn't needed just delete it.

> +        
>  	left = packet[4] & 0x01;
>  	right = packet[4] & 0x02;
>  
> @@ -617,21 +665,33 @@
>  	y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
>  	z = packet[5] & 0x7f;
>  
> +	if (!fingers) {
> +		x1 = x;
> +		y1 = y;
> +		fingers = z > 0 ? 1 : 0;
> +	}
> +
>  	if (z >= 64)
>  		input_report_key(dev, BTN_TOUCH, 1);
>  	else
>  		input_report_key(dev, BTN_TOUCH, 0);
>  
> +	alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
> +
> +	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
> +	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
> +	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
> +	input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
> +
> +	input_report_key(dev, BTN_LEFT, left);
> +	input_report_key(dev, BTN_RIGHT, right);
> +
>  	if (z > 0) {
>  		input_report_abs(dev, ABS_X, x);
>  		input_report_abs(dev, ABS_Y, y);
>  	}
>  	input_report_abs(dev, ABS_PRESSURE, z);
>  
> -	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
> -	input_report_key(dev, BTN_LEFT, left);
> -	input_report_key(dev, BTN_RIGHT, right);
> -
>  	input_sync(dev);
>  }
>  
> @@ -1567,8 +1627,18 @@
>  		set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
>  		/* fall through */
>  	case ALPS_PROTO_V4:
> -		input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
> -		input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
> +		set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
> +		input_mt_init_slots(dev1, 2);
> +                input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
> +                input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
> +
> +		input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, 
> ALPS_V3_X_MAX, 0, 0);
> +		input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, 
> ALPS_V3_Y_MAX, 0, 0);
> +
> +		set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
> +		set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
> +		set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
> +		/* fall through */
>  		break;
>  	}
>  
> --- drivers/input/mouse/alps.h	2012-03-19 01:15:34.000000000 +0200
> +++ drivers/input/mouse/alps.h.new	2012-04-09 17:17:32.733618703 +0300
> @@ -39,6 +39,8 @@
>  	int prev_fin;			/* Finger bit from previous packet */
>  	int multi_packet;		/* Multi-packet data in progress */
>  	unsigned char multi_data[6];	/* Saved multi-packet data */
> +	unsigned char multi_data_v4[6];

Why do you need multi_data_v4? You should be able to use multi_data.

> +	int last_fingers;
>  	u8 quirks;
>  	struct timer_list timer;
>  };
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
