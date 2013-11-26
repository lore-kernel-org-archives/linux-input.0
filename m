From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4 v3] Input: wacom - add SW_TOUCH to
 include/uapi/linux/input.h
Date: Mon, 25 Nov 2013 18:59:29 -0800
Message-ID: <20131126025928.GD31517@core.coreip.homeip.net>
References: <1384545602-15549-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:58596 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3KZC7e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Nov 2013 21:59:34 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so7135313pbc.35
        for <linux-input@vger.kernel.org>; Mon, 25 Nov 2013 18:59:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1384545602-15549-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, chris@cnpbagwell.com, peter.hutterer@who-t.net, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Fri, Nov 15, 2013 at 12:00:02PM -0800, Ping Cheng wrote:
>> @@ -856,6 +856,7 @@ struct input_keymap_entry {
>  #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
>  #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
>  #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
> +#define SW_TOUCH		0x0e  /* set = touch switch turned on (touch events off) */

I do not think we should be adding this as is as it seems to be very
wacom-specific. I'd rather call it something else, like SW_MUTE_DEVICE
or similar.

I also wonder if this should really be a switch: can you query it's
state? What happen if user plugs in the device, engages the switch and
then [re]loads the driver? Will the state be still signalled properly?
What about suspend/resume or hibernation?

Thanks.

-- 
Dmitry
