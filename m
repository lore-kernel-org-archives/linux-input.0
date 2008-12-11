From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Wed, 10 Dec 2008 20:08:02 -0800
Message-ID: <200812102008.02858.david-b@pacbell.net>
References: <200812071159.50267.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:27147 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751027AbYLKEIH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Dec 2008 23:08:07 -0500
In-Reply-To: <200812071159.50267.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Felipe Balbi <felipebalbi@users.sourceforge.net>

I have a question for the Input folk, see below ...

On Sunday 07 December 2008, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Simple input driver support for the events reported by the
> MSP430 firmware on the DM355 EVM.  Verified using the remote
> included with the kit; docs weren't quite right.  Some of
> the keycode selections might need improvement; I'm hoping
> I implemented the remapping support right, so there's at
> least a runtime workaround.
> 
> Keys on the remote seem to repeat undesirably.  Someone might
> want to see what's up with that, and fix it; it might just
> be an issue of tracking RC5 state and using the toggle.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Depends on the patch for the parent MFD driver, and won't work
> without the patch making GPIO IRQs work on dm355.
> 
> NOTE:  not suitable for mainline until the dm355evm board support
> (and parent MFD driver) is in the merge queue.
> 
>  drivers/input/keyboard/Kconfig         |    8 
>  drivers/input/keyboard/Makefile        |    1 
>  drivers/input/keyboard/dm355evm_keys.c |  303 +++++++++++++++++++++++++++++++
>  3 files changed, 312 insertions(+)
> 
> 	...

It seems this RC5 coding is used by a fair number of devices.
Is this the first one to get Linux support?

I kind of get the impression that some more generic support for
this might be useful at some point.  Along the lines of a module
to map (and remap?) RC5 codes to what Linux uses.

Maybe the *next* remote control driver can worry about that.  :)

- Dave


> +	/*
> +	 * IR buttons ... codes assigned to match the universal remote
> +	 * provided with the EVM (Philips PM4S) using DVD code 0020.
> +	 *
> +	 * These event codes match firmware documentation, but other
> +	 * remote controls could easily send more RC5-encoded events.
> +	 * The PM4S manual was used in several cases to help select
> +	 * a keycode reflecting the intended usage.
> +	 *
> +	 * RC5 codes are 14 bits, with two start bits (0x3 prefix)
> +	 * and a toggle bit (masked out below).
> +	 */
> +	{ 0x300c, KEY_POWER, },		/* NOTE: docs omit this */
> +	{ 0x3000, KEY_NUMERIC_0, },
> +	{ 0x3001, KEY_NUMERIC_1, },
> +	{ 0x3002, KEY_NUMERIC_2, },
> +	{ 0x3003, KEY_NUMERIC_3, },
> +	{ 0x3004, KEY_NUMERIC_4, },
> +	{ 0x3005, KEY_NUMERIC_5, },
> +	{ 0x3006, KEY_NUMERIC_6, },
> +	{ 0x3007, KEY_NUMERIC_7, },
> +	{ 0x3008, KEY_NUMERIC_8, },
> +	{ 0x3009, KEY_NUMERIC_9, },
> +	{ 0x3022, KEY_ENTER, },
> +	{ 0x30ec, KEY_MODE, },		/* "tv/vcr/..." */
> +	{ 0x300f, KEY_SELECT, },	/* "info" */
> +	{ 0x3020, KEY_CHANNELUP, },	/* "up" */
> +	{ 0x302e, KEY_MENU, },		/* "in/out" */
> +	{ 0x3011, KEY_VOLUMEDOWN, },	/* "left" */
> +	{ 0x300d, KEY_MUTE, },		/* "ok" */
> +	{ 0x3010, KEY_VOLUMEUP, },	/* "right" */
> +	{ 0x301e, KEY_SUBTITLE, },	/* "cc" */
> +	{ 0x3021, KEY_CHANNELDOWN, },	/* "down" */
> +	{ 0x3022, KEY_PREVIOUS, },
> +	{ 0x3026, KEY_SLEEP, },
> +	{ 0x3172, KEY_REWIND, },	/* NOTE: docs wrongly say 0x30ca */
> +	{ 0x3175, KEY_PLAY, },
> +	{ 0x3174, KEY_FASTFORWARD, },
> +	{ 0x3177, KEY_RECORD, },
> +	{ 0x3176, KEY_STOP, },
> +	{ 0x3169, KEY_PAUSE, },
> +};

