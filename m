From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Lost events in older kernels
Date: Sat, 22 May 2010 12:27:15 +0200
Message-ID: <4BF7B183.2050801@euromail.se>
References: <4BF7825F.2030405@seas.upenn.edu> <20100522074249.GA25143@core.coreip.homeip.net> <4BF7A247.5090307@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:38941 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744Ab0EVKb2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 May 2010 06:31:28 -0400
In-Reply-To: <4BF7A247.5090307@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>

Rafi Rubin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 05/22/10 03:42, Dmitry Torokhov wrote:
>> On Sat, May 22, 2010 at 03:06:07AM -0400, Rafi Rubin wrote:
>>> I'm playing with a project with a 2.6.29 kernel, and the userspace application
>>> seems to miss some events.  Is there a particular fix that improved the handling?
>>>
>>> Also tried catting the dev to a file while testing, and the dump also is missing
>>> some events.
>>>
>> No "interesting" patches went into evdev for a few release now...
>>
>> Hm, could it be that event queue is overflowing before userspace gets a
>> chance to empty it. What kind of event rate are we talking here?
>>
> 
> Quite possibly.  It is a multitouch device and we know Henrik's been concerned
> with the load for a while.
> 
> So to put some numbers behind his fears:
> 
> 146668 hid events processed
> 24952 evdev events captured with a cat
> 30 seconds (give or take).
> 
> This is for a mix of different numbers of fingers, but continuous use for those
> 30 seconds.  And X was running and reading the dev node too.

Others have experienced this too. Mika has a patch for this, increasing the
(kernel) evdev buffer quite a bit, from 64 to 256. I believe the reason it is
not sent upstream is because it increases the footprint by 3 Kb. Perhaps a
dynamic solution could work here.

Henrik

