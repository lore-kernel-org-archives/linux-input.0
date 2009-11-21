From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [SOLVED] kernel module loading does not work with binutils-gold
 (was Re: [Bug #14626] oops on boot starting udev)
Date: Sat, 21 Nov 2009 02:29:13 -0800
Message-ID: <4B07C0F9.4060702@gmail.com>
References: <GUZt44bIwCE.A.vLF.pSdALB@chimera>	 <xXQGFmujPl.A.fpF.zSdALB@chimera> <20091117011455.GA7977@kroah.com>	 <20091117020451.GA27967@core.coreip.homeip.net>	 <1258426743.9883.53.camel@no>	 <20091117040104.GA5792@core.coreip.homeip.net>	 <1258430807.12721.12.camel@no>	 <20091119025938.GB20172@core.coreip.homeip.net>	 <1258793809.4814.4.camel@no> <1258796110.6842.10.camel@no>	 <4B07B9BA.2070607@gmail.com> <1258798113.6842.16.camel@no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258798113.6842.16.camel@no>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soeren Sonnenburg <sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Soeren Sonnenburg wrote:
> On Sat, 2009-11-21 at 01:58 -0800, Justin P. Mattock wrote:
>    
>> Soeren Sonnenburg wrote:
>>      
>>> On Sat, 2009-11-21 at 09:56 +0100, Soeren Sonnenburg wrote:
>>>
>>>        
>>>> On Wed, 2009-11-18 at 18:59 -0800, Dmitry Torokhov wrote:
>>>>
>>>>          
>>>>> On Tue, Nov 17, 2009 at 05:06:47AM +0100, Soeren Sonnenburg wrote:
>>>>>
>>>>>            
>>>>>> On Mon, 2009-11-16 at 20:01 -0800, Dmitry Torokhov wrote:
>>>>>>
>>>>>>              
>>>>>>> On Tue, Nov 17, 2009 at 03:59:03AM +0100, Soeren Sonnenburg wrote:
>>>>>>>
>>>>>>>                
>>>>>>>> On Mon, 2009-11-16 at 18:04 -0800, Dmitry Torokhov wrote:
>>>>>>>>
>>>>>>>>                  
>>>>>>>>> On Mon, Nov 16, 2009 at 05:14:55PM -0800, Greg KH wrote:
>>>>>>>>>
>>>>>>>>>                    
>>>>>>>>>> On Mon, Nov 16, 2009 at 11:37:48PM +0100, Rafael J. Wysocki wrote:
>>>>>>>>>>
>>>>>>>>>>                      
>>>>>>>>>>> This message has been generated automatically as a part of a report
>>>>>>>>>>> of recent regressions.
>>>>>>>>>>>
>>>>>>>>>>> The following bug entry is on the current list of known regressions
>>>>>>>>>>> from 2.6.31.  Please verify if it still should be listed and let me know
>>>>>>>>>>> (either way).
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14626
>>>>>>>>>>> Subject		: oops on boot starting udev
>>>>>>>>>>> Submitter	: Soeren Sonnenburg<sonne-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
>>>>>>>>>>> Date		: 2009-11-14 10:16 (3 days old)
>>>>>>>>>>> References	: http://marc.info/?l=linux-kernel&m=125819380206800&w=4
>>>>>>>>>>>
>>>>>>>>>>>                        
>>>>>>>>>> This looks like an input core problem, as the evdev module was just
>>>>>>>>>> loaded and died.
>>>>>>>>>>
>>>>>>>>>> Any input developers have any ideas?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>                      
>>>>>>>>> Hmm, evdev does:
>>>>>>>>>
>>>>>>>>> 	dev_set_name(&evdev->dev, "event%d", minor);
>>>>>>>>>
>>>>>>>>> Not sure how it can go wrong...
>>>>>>>>>
>>>>>>>>>                    
>>>>>>>> Anything I should/could do to narrow it down a bit (apart from
>>>>>>>> bisecting?).
>>>>>>>>
>>>>>>>>
>>>>>>>>                  
>>>>>>> Umm, I looked through the changes between -rc6 and 7 but nothing jumped
>>>>>>> out at me... You don't happen to have any local changes in your tree?
>>>>>>>
>>>>>>>                
>>>>>> Well only the mouse button #1 emulation - though I don't see what could
>>>>>> go wrong there.
>>>>>>
>>>>>>
>>>>>>              
>>>>> I have been looking through the changes and I really don't see anything
>>>>> suspicious. I am also not hittign this oops on any of my boxes. Any
>>>>> chance you could bisect?
>>>>>
>>>>> Thanks.
>>>>>
>>>>>            
>>>> Alright so I tried to do a bisect when I noticed that building a knwon
>>>> to work -rc5 did no longer work either. Thought it might be a gcc
>>>> problem (gcc-4.3 here) so upgraded to 4.4 - same thing.
>>>> Then I recognized that it crashes on loading basically *any* module,
>>>> tried tun and applesmc. Attaching the crashes...
>>>>
>>>> I am starting to run out of ideas...
>>>>
>>>>          
>>> OK, I've found the culprit: binutils-gold
>>>
>>> I build all kernels upto and including -rc6 with the old binutils and
>>> since then have upgraded to binutils gold 2.20-4 which - in contrast to
>>> the old binutils - uses --no-add-needed per default.
>>>
>>> So I suspect it triggers an error(?) in the way how the kernel links
>>> modules: It is now required to provide all needed libraries to the
>>> linker when building the modules. I guess this problem could be worked
>>> around by adding --add-needed to the LDFLAGS_MODULE ...
>>>
>>> Soeren
>>>
>>>        
>> tough to say... some how your hitting
>>    __wait_status during your initial boot.
>>
>> by looking at the comment(in applesmc.c):
>> __wait_status - Wait up to 32ms for the status port to get a certain value
>>    * (masked with 0x0f), returning zero if the value is obtained.
>>
>> maybe your hitting a different value because of binutls.
>>      
>
> It could be anything missing...
>
>    
>> (keep in mind I have the latest binutils running on the macbook,
>> but nothing switched to gold during compilation time)
>>      
>
> Note that everything works fine with the old binutils here too.You will
> need binutils gold to see the problem and it is described here too
>
> http://wiki.debian.org/qa.debian.org/FTBFS#A2009-11-02Packagesfailingbecausebinutils-gold.2BAC8-indirectlinking
>
> Soeren
>    
Well I'd like to go into building
gcc with the switch of: --disable-multilib
but I cant because of the whole "gold factor"

maybe somebody else with this knowledge of(gold) gcc etc...
can assist you because I have no knowledge of that .
(I'll have to try building a system this way one day);

Justin P. Mattock
