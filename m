From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH] bcm5974: report ABS_MT_PRESSURE
Date: Thu, 14 Dec 2017 20:37:51 -0500 (EST)
Message-ID: <alpine.LNX.2.21.1712142031530.16728@adam>
References: <alpine.LNX.2.21.1712011208150.14154@adam>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1695955835-1513301886=:16728"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vicky.finemachine.org ([45.79.146.116]:60226 "EHLO
        vicky.finemachine.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754538AbdLOBiG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Dec 2017 20:38:06 -0500
In-Reply-To: <alpine.LNX.2.21.1712011208150.14154@adam>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@bitmath.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1695955835-1513301886=:16728
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

Hi, gentle ping? No rush on the review but it would be nice to know if I 
followed the right submission procedure and wasn't mistaken for a spammer.

At 2017-12-01 12:13-0500, Ryan Hendrickson <ryan.hendrickson@alum.mit.edu> sent:

> Report ABS_MT_PRESSURE in the bcm5974 driver with the same data used for
> ABS_PRESSURE.
>
> Some touchpad improvements in recent versions of libinput, such as
> pressure-based palm detection, will only work if ABS_MT_PRESSURE is
> reported.
>
> Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
>
> ---
>
> Please treat all of this with an extra grain of salt; this is my first real
> foray into both evdev/libinput internals and kernel development. That said,
> I have been running this patch on my daily-use MacBookPro5,1 for several
> months, so I have reason to believe it's stable. It might not be the
> ¡right¢ way to do this though; I mostly just copied the corresponding code
> for ABS_PRESSURE, which from this[1] blog post I've inferred should have
> the same values and range.
>
> [1]: http://who-t.blogspot.com/2016/09/understanding-evdev.html
>
> Patch was originally submitted as bug 197909[2], which can be closed if
> this is accepted.
>
> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=197909
>
> --- linux-4.13/drivers/input/mouse/bcm5974.c.orig	2017-12-01 
> 11:36:35.258890243 -0500
> +++ linux-4.13/drivers/input/mouse/bcm5974.c	2017-12-01 11:48:55.187342210 
> -0500
> @@ -548,6 +548,8 @@ static void setup_events_to_report(struc
> 	 set_abs(input_dev, ABS_MT_POSITION_X, &cfg->x);
> 	 set_abs(input_dev, ABS_MT_POSITION_Y, &cfg->y);
>
> +	set_abs(input_dev, ABS_MT_PRESSURE, &cfg->p);
> +
> 	 __set_bit(EV_KEY, input_dev->evbit);
> 	 __set_bit(BTN_LEFT, input_dev->keybit);
>
> @@ -575,10 +577,14 @@ static int report_bt_state(struct bcm597
>  	return 0;
>  }
>
> -static void report_finger_data(struct input_dev *input, int slot,
> +static void report_finger_data(struct input_dev *input,
> +			       const struct bcm5974_config *cfg,
> +			       int slot,
> 			        const struct input_mt_pos *pos,
> 			        const struct tp_finger *f)
> {
> +	int abs_p;
> +
> 	 input_mt_slot(input, slot);
> 	 input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
>
> @@ -594,6 +600,9 @@ static void report_finger_data(struct in
> 	 		 MAX_FINGER_ORIENTATION - raw2int(f->orientation));
> 	 input_report_abs(input, ABS_MT_POSITION_X, pos->x);
> 	 input_report_abs(input, ABS_MT_POSITION_Y, pos->y);
> +
> +	abs_p = clamp_val(256 * raw2int(f->touch_major) / cfg->p.max, 0, 
> 255);
> +	input_report_abs(input, ABS_MT_PRESSURE, abs_p);
>  }
>
> static void report_synaptics_data(struct input_dev *input,
> @@ -640,7 +649,7 @@ static int report_tp_state(struct bcm597
> 	 input_mt_assign_slots(input, dev->slots, dev->pos, n, 0);
>
> 	for (i = 0; i < n; i++)
> -		report_finger_data(input, dev->slots[i],
> +		report_finger_data(input, c, dev->slots[i],
> 				    &dev->pos[i], dev->index[i]);
>
> 	input_mt_sync_frame(input);
>
--8323328-1695955835-1513301886=:16728--
