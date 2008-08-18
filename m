From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Mon, 18 Aug 2008 17:14:11 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0808181712280.18058@jikos.suse.cz>
References: <200808080702.24969.aivils@latnet.lv> <200808100408.37473.aivils@latnet.lv> <20080814184948.093d2cad.rdunlap@xenotime.net> <200808181642.49489.aivils@latnet.lv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:56822 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752774AbYHRPOM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 11:14:12 -0400
In-Reply-To: <200808181642.49489.aivils@latnet.lv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aivils Stoss <aivils@latnet.lv>
Cc: Randy Dunlap <rdunlap@xenotime.net>, lud <linux-usb@vger.kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net

On Mon, 18 Aug 2008, Aivils Stoss wrote:

>> I finally got 5 USB keyboards together along with 2 hubs. I 
>> daisy-chained the hubs and connected 1 keyboard to the hub that is on 
>> the notebook computer USB port, then I connected 4 keyboards to the 
>> second hub.  They all worked for me, meaning that I can type on all of 
>> them and have their characters show up on my console.
>> I'm testing with 2.6.7-rc2. 'usbtree' output of the USB subsystem is 
>> attached.
> Yeah! 2.6.7 is a bit obsolete.

I think that Randy really meant 2.6.27-rc2.

> At my end 2.6.15 support more than 4 keyboards per PC port , but mess up 
> input when is plugged more than 9 keyboards. 10th is capable to send 
> keypress events, but last pressed key will be repeated until ctrl-c . 
> 10th keyboard disturb an auto repeat of all keyboards.

Could you please verify with any more recent kernel than 2.6.15 and report 
back whether the issue is still present, please?

Also, is this bug specific to USB keyboards? i.e. if you for example plug 
in USB flash sticks instead of keyboards, do they all work correctly?

Thanks,

-- 
Jiri Kosina
SUSE Labs
