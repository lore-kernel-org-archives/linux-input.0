From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: GPen 340 Pen Tablet input
Date: Thu, 20 Mar 2008 10:29:53 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803201028410.30831@jikos.suse.cz>
References: <alpine.LNX.1.00.0803161918260.15404@localhost>
 <Pine.LNX.4.64.0803161957010.19269@twin.jikos.cz> <alpine.LNX.1.00.0803162005320.32475@localhost>
 <Pine.LNX.4.64.0803162244180.30831@jikos.suse.cz> <alpine.LNX.1.00.0803170006240.22151@localhost>
 <Pine.LNX.4.64.0803181409200.30831@jikos.suse.cz> <alpine.LNX.1.00.0803181518200.3013@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47969 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754787AbYCTJ34 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2008 05:29:56 -0400
In-Reply-To: <alpine.LNX.1.00.0803181518200.3013@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrej Gelenberg <andrej.gelenberg@googlemail.com>
Cc: linux-input@vger.kernel.org

On Tue, 18 Mar 2008, Andrej Gelenberg wrote:

[ restored linux-input CC again, please don't drop it ]

> i think the Problem is the evdev driver in xorg. But /dev/input/event 
> report code, that are not to codes in linux/input.h. For example in 
> input.h: #define ABS_X 0x00 and there is code 0x02. For Y-axis in 
> input.h ist 0x01 and 0x03 received. Pressure is corecct, Buttons can be 
> simple remaped, but it is not very good. And hid-driver report all 
> right.

Are you sure that kernel driver reports the values correctly through 
evdev? Could you please send me the debugging output that appears in dmesg 
for example when you perform movement on the X-axis?

Thanks,

-- 
Jiri Kosina
SUSE Labs
