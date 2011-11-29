From: Daniel Manrique <daniel.manrique@canonical.com>
Subject: Re: Bug: touchpad unresponsive after resume from S3 (psmouse driver)
Date: Tue, 29 Nov 2011 14:43:35 -0500
Message-ID: <4ED535E7.5030108@canonical.com>
References: <4ED507AB.6040905@canonical.com> <20111129175333.GE4241@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35395 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab1K2Tni (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 14:43:38 -0500
In-Reply-To: <20111129175333.GE4241@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 11-11-29 12:53 PM, Dmitry Torokhov wrote:
> Hi Daniel,
> 
> On Tue, Nov 29, 2011 at 11:26:19AM -0500, Daniel Manrique wrote:
>> Hello,
>>
>> I apologize for sending this bug report directly; with the kernel.org bugtracker
>> down I was told this was the best option for the time being. If this is not
>> correct, could you please let me know of a good place to submit this bug report?
>>
>> I have several Dell laptops with Synaptics touchpads, particularly a group of
>> Vostro V13 systems. On these, after a suspend/resume cycle, the touchpad
>> (Synaptics) is unresponsive; a workaround is to rmmod psmouse; modprobe psmouse.
>>
>> This was first reported on kernel 2.6.38, although I think the issue has been
>> present from as early as 2.6.32. I verified it for sure with Ubuntu 2.6.38
>> kernels, 3.0.0 kernels, and a 3.2.0 kernel from the development release, as well
>> as a "mainline" 3.1.0-rc10 kernel.
>>
>> Since this problem was seen on Ubuntu, it's filed on the Launchpad bug tracker.
>> The first report I can find is this one:
>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/715267
>>
>> This includes a series of log messages I don't see on my systems. I then filed
>> this other bug:
>>
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/879650
>>
>> The last one contains specific information from one of my systems (a Vostro V13).
>>
>> I'd really appreciate any help or guidance on how to solve this problem. If you
>> need me to collect any information or run any tests on these machines, please
>> don't hesitate to ask, these systems are primarily used for testing.
>>
> 
> Please do:
> 
>  - enable i8042 debug (echo 1 > /sys/module/i8042/parameters/debug)
>  - rmmod psmouse;
>  - suspend/resume;
>  - collect dmesg;
>  - suspend/resume;
>  - collect dmesg again
> 
> and we'll have to try and find what we do differently.
> 
> Thanks.
> 

Hi Dmitry,

Thanks so much for the quick reply!

I just ran the tests you requested with some extra steps which I hope won't
confuse things. Here's the sequence I followed:

- Enabled i8042 debug
- sudo rmmod psmouse. Touchpad of course becomes unresponsive.
- sudo pm-suspend
- Wake the machine by pressing power
- At this point touchpad is unresponsive.
- Collected dmesg-1.txt
- sudo pm-suspend
- wake the machine by pressing power
- At this point touchpad is still unresponsive.
- Collected dmesg-2.txt
- sudo modprobe psmouse. Touchpad begins responding.
- Collected dmesg-3.txt
- sudo pm-suspend
- wake the machine by pressing power
- At this point touchpad is again unresponsive.
- Collected dmesg-4.txt

To avoid attaching largish files to this email, I put the logs on a
publically-accessible http server at:
http://people.canonical.com/~roadmr/lp715267/. Please let me know if you prefer
something else.

Thanks in advance for your help!

- Daniel Manrique




