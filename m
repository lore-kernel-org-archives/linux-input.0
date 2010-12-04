From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Sat, 04 Dec 2010 17:52:09 +0000
Message-ID: <4CFA7FC9.1040805@cam.ac.uk>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com> <20101202212223.GA9864@core.coreip.homeip.net> <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com> <20101203193224.GA21277@core.coreip.homeip.net> <AANLkTikw3HF7CUc-7Enw-SGXztmiZAPUYZEKT1ViDTic@mail.gmail.com> <20101203205643.GC21277@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37623 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab0LDRpf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Dec 2010 12:45:35 -0500
In-Reply-To: <20101203205643.GC21277@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bill Gatliff <bgat@billgatliff.com>, linux-input@vger.kernel.org

On 12/03/10 20:56, Dmitry Torokhov wrote:
> On Fri, Dec 03, 2010 at 01:50:08PM -0600, Bill Gatliff wrote:
>> Dmitry:
>>
>> On Fri, Dec 3, 2010 at 1:32 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> How would the driver know if application that is opened the device
>>> does not want to be aware of the events that happened before read as
>>> opposed to the application that simply choses to "batch" events and
>>> process them at once? The driver might not be able to retrieve the "old"
>>> state of the hardware. Lets say toggle WIFI button was pressed and
>>> released while application wasn't reading. Normally kernel would queue
>>> the events and when userspace read the FD they'd see events, whereas in
>>> your case events would be lost.
>>
>> Good question.
>>
>> What I'm proposing is really useful only for embedded work, where you
>> have absolute control (or at least understanding) over what the
>> hardware and driver stack looks like.  If one wanted to see all the
>> transitions of the WiFi button (to use your example), they'd bind the
>> hardware to a driver that worked that way.  The system integrator
>> would make the choice, not the application.
> 
> Signficant number of drivers work in different environments as do
> the applications. System integrator can not make this choice since _his_
> choice might be different from another system integrator's choice.
> 
>>
>> In situations where an application wanted the accumulating behavior
>> sometimes, and the stateless behavior at other times, then the system
>> integrator could provide for that by using two different event
>> interfaces, one for each personality.  I think...
> 
> Having a diffrent interface for certain class of devices is an option.
> Accelerometers, magnetometers and other not pure HID devices might make
> use of IIO and/or sysfs. In fact, most of accelerometer drivers attempt
> to provide their own sysfs interfaces and among them ways to fetch
> current device state. This kind of interface seems to suit your needs
> best.
> 
> Note that standardizing sysfs accelerometer inteface is under
> discussion and if you are interested you shoudl join it.
hmm. that discussion kind of died out as it got down to just Hemanth and I.
Guess we might want to restart it, particularly with new drivers from ST
etc having been posted...

I'm going to get increasingly fussy about changing the interfaces in IIO
as we are gaining at lot of drivers conforming to pretty much my last proposal.
For a little while I'll still be open to changes though so better now than
later.  Take into account that our requirements cover a much larger set of
devices than typically turn up in the discussions.  If you want to know
where we currently are, it's reasonably documented in drivers/staging/iio/Documentation
in linux-next or:

http://git.kernel.org/?p=linux/kernel/git/gregkh/staging-2.6.git;a=shortlog;h=refs/heads/staging-next

> 
>>
>>> I'd say applications that really want this behavior simply need to
>>> go through open/read/close cycles.
>>
>> Wow, that seems really, really expensive at a sampling rate of 100+Hz.
> 
> First of all - not really (this how much open is similar to your
> callback anyway) and second - if it gets expensive you stop doing this.
> 

