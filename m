From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC v2] input: Introduce device information ioctl
Date: Thu, 16 Dec 2010 15:18:17 +0100
Message-ID: <4D0A1FA9.5030005@euromail.se>
References: <1292440807-18502-1-git-send-email-rydberg@euromail.se> <20101216002941.GC4952@salty.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:43618 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756090Ab0LPOSd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 09:18:33 -0500
In-Reply-To: <20101216002941.GC4952@salty.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


>>  /*
>> + * Device properties and quirks
>> + */
>> +
>> +#define INPUT_PROP_POINTER		0x00	/* needs a pointer */
>> +#define INPUT_PROP_DIRECT		0x01	/* direct object manipulation */
> 
> fwiw, I think the common term for these is "direct input devices", at least
> that's how a lot of the research literature refers to them. Might be good to
> use the same term.


Changed, thanks.


> either way, not sure about this one.  I've worked with devices that were
> indirect by nature but used directly. e.g. the magic touchpad could quite
> easily be used as direct input device with an top-down projector. the
> decision to use it as an indirect device is a UI decision.
> Likewise, some mountable direct-touch touchscreens can be used indirectly if
> the touchscreen isn't mounted straight on the display. This is very much a
> setup-specific property and I'm not sure about the value of this
> information.


As Dmitry stated already, this is foremost for automatic setup. The idea to
elevate these properties to the main configuration source is also interesting.

Thanks,
Henrik
