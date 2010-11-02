From: William Sherman <shermanw@indiana.edu>
Subject: Re: usbhid: HP LD4200tm touchscreen ALMOST works
Date: Tue, 02 Nov 2010 09:46:21 -0400
Message-ID: <4CD0162D.1000800@indiana.edu>
References: <4CC61731.1080100@indiana.edu> <20101101211456.GA30692@core.coreip.homeip.net> <alpine.LNX.2.00.1011011717460.15851@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1011011717460.15851@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, William Sherman <shermanw@indiana.edu>
List-Id: linux-input@vger.kernel.org

On 11/1/10 5:22 PM, Jiri Kosina wrote:
> On Mon, 1 Nov 2010, Dmitry Torokhov wrote:
>
>>> I'm looking to dig into the usbhid driver code to get me the last
>>> mile and get my HP LD4200tm touchscreen working on my Linux system.
>>> [NOTE: I posted about this elsewhere, but as I think about it more,
>>> this is more of a linux-kernel issue than anything else, so I'm
>>> reprising that note here.]
>>
>> I think you'll have better luck on linux-input...
>
> Thanks for CC, Dmitry.

Yes, thanks from me too for pointing this thread in the right direction.
I also sent a revised (updated) post to the linux-kernel list, but was
not aware of the linux-input list.

> Thanks a lot for the detailed analysis. What would actually be interesting
> to see would be the HID debugfs output. Namely
>
> 1) mount debugfs
> 2) cat /sys/kernel/debug/<device>/rdesc
> 3) obtain output of /sys/kernel/debug/<device>/events and annotate it as
> you did for your previous output (i.e. "this happens when I do one-finger
> move", "this happens when I do two-finger trick to make it work").
>
> This way, it'd be much easier to see what is actually hapenning on HID
> level.

Great.  I will do that as soon as I can -- which is when I arrive at
SuperComputing to setup our system.  The display (our only one) is currently
on a truck bound for New Orleans.

In the meantime, I wrote a very simple application that parses the
data directly from /dev/hidrawN, does a simple parse, and then
creates X events with the Xtest API.  Of course, I'm only doing
single touch, since that's all I need for the moment.

I also have a Dell SX2210T touch screen with the NextWindow interface.
We made some partial progress on our Ubuntu 10.10 system with the nwfermi
driver, but again, not quite all the way -- of course now that computer
is on the road, and I'm not having as much luck with that touchscreen
on my Fedora 13 system.

> Thanks,

	Thank you both, and more to come,
	Bill

--
Bill Sherman
Sr. Technology Advisor
Advanced Visualization Lab
Pervasive Technologies Inst
Indiana University
shermanw@indiana.edu
