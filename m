From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 3/3] Add support for Cintiq 27QHD and 27QHD touch
Date: Thu, 26 Mar 2015 15:57:14 +1000
Message-ID: <20150326055714.GA14141@jelly.bne.redhat.com>
References: <1422394203-15146-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:64594 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbCZF5c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 01:57:32 -0400
Content-Disposition: inline
In-Reply-To: <1422394203-15146-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, Jan 27, 2015 at 01:30:03PM -0800, Ping Cheng wrote:
> These devices have accelerometers. To report accelerometer coordinates,
> a new property, INPUT_PROP_ACCELEROMETER, is added.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---

[...]

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index a1d7e93..b0a8130 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -166,6 +166,7 @@ struct input_keymap_entry {
>  #define INPUT_PROP_SEMI_MT		0x03	/* touch rectangle only */
>  #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
>  #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
> +#define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */
>  
>  #define INPUT_PROP_MAX			0x1f
>  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
> -- 
> 1.9.1

I just ran into this and have a few questions:
what is the intended meaning of INPUT_PROP_ACCELEROMETER? For all the other
props it's obvious what they mean but here there it is a bit more ambiguous.

Specifically, if a device is tagged as accelerometer, which axes have
accelerometer data? just ABS_X/Y/Z and/or REL_X/Y/Z? or do we have a
requirement that _all_ axes on that device must reflect accelerometer data
(because realistically ABS_RX could be an accelerometer while x and y is a
normal axis). Or is it up for grabs and you need other information
to know which axes exported are accelerometers?

I know what it does on the 27QHD, but this is a generic tag so we need to
define this for all devices.

Cheers,
   Peter
 
