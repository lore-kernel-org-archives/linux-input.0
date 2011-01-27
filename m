From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC 2/2] input: evdev: Add EVIOC mechanism to extract the MT
 slot state
Date: Thu, 27 Jan 2011 13:09:45 +0100
Message-ID: <20110127120945.GC15626@polaris.bitmath.org>
References: <1296124547-3323-1-git-send-email-benjamin.tissoires@enac.fr>
 <1296124547-3323-3-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:44172 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243Ab1A0MJ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 07:09:28 -0500
Content-Disposition: inline
In-Reply-To: <1296124547-3323-3-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Jiri Kosina <jkosina@suse.cz>, Chris Bagwell <chris@cnpbagwell.com>, Rafi Rubin <rafi@seas.upenn.edu>, Stephane Chatty <chatty@lii-enac.fr>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 27, 2011 at 11:35:47AM +0100, Benjamin Tissoires wrote:
> This patch adds the ability to extract the MT slot state sequentially
> via EVIOCGABS. The slot parameter is first selected by calling
> EVIOCSABS with ABS_MT_SLOT as argument, followed by a set of EVIOCGABS
> calls. The slot selection is local to the evdev client handler, and
> does not affect the actual input state.

Ok - it seemed like a reasonable idea at the time, but..

> @@ -767,9 +769,10 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>  			if (size < sizeof(struct input_absinfo))
>  				abs.resolution = 0;
>  
> -			/* We can't change number of reserved MT slots */
> -			if (t == ABS_MT_SLOT)
> -				return -EINVAL;
> +			if (t == ABS_MT_SLOT) {
> +				client->slot = abs.value;
> +				return 0;
> +			}

...this just does not look right. Perhaps there should really be a
different ioctl to retrieve the slot values instead. Dmitry?

Thanks,
Henrik
