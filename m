From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] Input: LEDs - skip unnamed LEDs
Date: Fri, 24 Jul 2015 10:22:04 +0200
Message-ID: <55B1F5AC.3080702@suse.cz>
References: <20150722220202.GG14875@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55086 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbbGXIWI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jul 2015 04:22:08 -0400
In-Reply-To: <20150722220202.GG14875@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Jiri Kosina <jkosina@suse.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On 07/23/2015 12:02 AM, Dmitry Torokhov wrote:
> Devices may declare more LEDs than what is known to input-leds
> (HID does this for some devices). Instead of showing ugly warnings
> on connect and, even worse, oopsing on disconnect, let's simply
> ignore LEDs that are not known to us.
>
> Reported-by: Vlastimil Babka <vbabka@suse.cz>

No more warnings and oopses, so:

Reported-and-tested-by: Vlastimil Babka <vbabka@suse.cz>

FTR, it now looks like this:
gusiac:/sys/bus/hid/devices/0003:046D:C50E.0004/input/input15 # ls -1 | 
grep input15
input15::charging
input15::mail
input15::misc

All three have max_brightness of 1, but echo 1 > brightness does 
nothing. Clearly the leds are indeed autonomous only and the mouse 
shouldn't even report them.

Thanks,
Vlastimil
