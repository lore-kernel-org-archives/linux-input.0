From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [Bug #14626] oops on boot starting udev
Date: Sat, 21 Nov 2009 01:30:24 -0800
Message-ID: <4B07B330.4030300@gmail.com>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera>	 <xXQGFmujPl.A.fpF.zSdALB@chimera> <20091117011455.GA7977@kroah.com>	 <20091117020451.GA27967@core.coreip.homeip.net>	 <1258426743.9883.53.camel@no>	 <20091117040104.GA5792@core.coreip.homeip.net>	 <1258430807.12721.12.camel@no>	 <20091119025938.GB20172@core.coreip.homeip.net> <1258793809.4814.4.camel@no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45606 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZKUJ3a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Nov 2009 04:29:30 -0500
In-Reply-To: <1258793809.4814.4.camel@no>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Soeren Sonnenburg <sonne@debian.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>

Soeren Sonnenburg wrote:
> On Wed, 2009-11-18 at 18:59 -0800, Dmitry Torokhov wrote:
>    
>> On Tue, Nov 17, 2009 at 05:06:47AM +0100, Soeren Sonnenburg wrote:
>>      
>>> On Mon, 2009-11-16 at 20:01 -0800, Dmitry Torokhov wrote:
>>>        
>>>> On Tue, Nov 17, 2009 at 03:59:03AM +0100, Soeren Sonnenburg wrote:
>>>>          
>>>>> On Mon, 2009-11-16 at 18:04 -0800, Dmitry Torokhov wrote:
>>>>>            
>>>>>> On Mon, Nov 16, 2009 at 05:14:55PM -0800, Greg KH wrote:
>>>>>>              
>>>>>>> On Mon, Nov 16, 2009 at 11:37:48PM +0100, Rafael J. Wysocki wrote:
>>>>>>>                
>>>>>>>> This message has been generated automatically as a part of a report
>>>>>>>> of recent regressions.
>>>>>>>>
>>>>>>>> The following bug entry is on the current list of known regressions
>>>>>>>> from 2.6.31.  Please verify if it still should be listed and let me know
>>>>>>>> (either way).
>>>>>>>>
>>>>>>>>
>>>>>>>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14626
>>>>>>>> Subject		: oops on boot starting udev
>>>>>>>> Submitter	: Soeren Sonnenburg<sonne@debian.org>
>>>>>>>> Date		: 2009-11-14 10:16 (3 days old)
>>>>>>>> References	: http://marc.info/?l=linux-kernel&m=125819380206800&w=4
>>>>>>>>                  
>>>>>>> This looks like an input core problem, as the evdev module was just
>>>>>>> loaded and died.
>>>>>>>
>>>>>>> Any input developers have any ideas?
>>>>>>>
>>>>>>>                
>>>>>> Hmm, evdev does:
>>>>>>
>>>>>> 	dev_set_name(&evdev->dev, "event%d", minor);
>>>>>>
>>>>>> Not sure how it can go wrong...
>>>>>>              
>>>>> Anything I should/could do to narrow it down a bit (apart from
>>>>> bisecting?).
>>>>>
>>>>>            
>>>> Umm, I looked through the changes between -rc6 and 7 but nothing jumped
>>>> out at me... You don't happen to have any local changes in your tree?
>>>>          
>>> Well only the mouse button #1 emulation - though I don't see what could
>>> go wrong there.
>>>
>>>        
>> I have been looking through the changes and I really don't see anything
>> suspicious. I am also not hittign this oops on any of my boxes. Any
>> chance you could bisect?
>>
>> Thanks.
>>      
>
> Alright so I tried to do a bisect when I noticed that building a knwon
> to work -rc5 did no longer work either. Thought it might be a gcc
> problem (gcc-4.3 here) so upgraded to 4.4 - same thing.
> Then I recognized that it crashes on loading basically *any* module,
> tried tun and applesmc. Attaching the crashes...
>
> I am starting to run out of ideas...
>
> Soeren
>    
from what I remember wait status failed debug message was
removed from the kernel(but could be wrong).
could you maybe have some type of userspace thing going on
causing this? i.g. running the latest git(on a macbook)
  with a from scratch system with nothing of that sort,
or at least cant reproduce your error.

Justin P. Mattock
