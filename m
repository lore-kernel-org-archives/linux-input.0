From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 5/7] HID: N-trig MTM Driver fix And cleanup patch 5
Date: Mon, 08 Mar 2010 20:29:27 -0500
Message-ID: <4B95A477.7060104@seas.upenn.edu>
References: <1268082827-2680-1-git-send-email-micki@n-trig.com> <1268082827-2680-2-git-send-email-micki@n-trig.com> <1268082827-2680-3-git-send-email-micki@n-trig.com> <1268082827-2680-4-git-send-email-micki@n-trig.com> <1268082827-2680-5-git-send-email-micki@n-trig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268082827-2680-5-git-send-email-micki@n-trig.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mickib1@gmail.com
Cc: jkosina@suse.cz, chatty@enac.fr, peterhuewe@gmx.de, micki@n-trig.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rafi@seas.upenn.edu
List-Id: linux-input@vger.kernel.org

> -	if (id->driver_data)
> -		hdev->quirks |= HID_QUIRK_MULTI_INPUT;

This undoes the unfortunate merger of the pen and touch events.  Why 
would you want to remove that?  Is there any actual reason aside from 
that's the way you've done it so far?

I admit that if the user space is smart enough to distinguish the 
multiplexed streams, its not that big a deal.  But even then it 
complicates the user space and adds a few assumptions.

Also, splitting them gives the user the freedom to use different drivers 
for the different sensors.  I understand why you'd want to encourage 
users to use your stack for everything, but that also means you are 
potentially increasing your own support burden.

All in all, it just seems like a bad idea to me.
> -	list_for_each_entry(hidinput,&hdev->inputs, list) {
> -		input = hidinput->input;
> -		switch (hidinput->report->field[0]->application) {
> -		case HID_DG_PEN:
> -			input->name = "N-Trig Pen";
> -			break;
> -		case HID_DG_TOUCHSCREEN:
> -			__clear_bit(BTN_TOOL_PEN, input->keybit);
> -			/*
> -			 * A little something special to enable
> -			 * two and three finger taps.
> -			 */
> -			__set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
> -			__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
> -			__set_bit(BTN_TOOL_QUADTAP, input->keybit);
> -			/*
> -			 * The physical touchscreen (single touch)
> -			 * input has a value for physical, whereas
> -			 * the multitouch only has logical input
> -			 * fields.
> -			 */
> -			input->name =
> -				(hidinput->report->field[0]
> -				 ->physical) ?
> -				"N-Trig Touchscreen" :
> -				"N-Trig MultiTouch";
> -			break;
> -		}

Even if you want to argue that you need to pull the multi-input quirk, 
that doesn't justify pulling the names.  Perhaps you may wish to 
truncate the name to "N-Trig" or something.  But give them some name. 
Those names simplify driver correlation in user space.

Rafi
