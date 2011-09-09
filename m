From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: Driver support for TI's quadrature encoder module
Date: Fri, 09 Sep 2011 12:39:09 +0100
Message-ID: <4E69FADD.9050904@cam.ac.uk>
References: <B85A65D85D7EB246BE421B3FB0FBB593025743EEE8@dbde02.ent.ti.com> <20110908145407.GC5793@suse.de> <4E68F26A.8080008@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37906 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933654Ab1IILax (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2011 07:30:53 -0400
In-Reply-To: <4E68F26A.8080008@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg KH <gregkh@suse.de>, "AnilKumar, Chimata" <anilkumar@ti.com>, linux-kernel <linux-input@vger.kernel.org>, "daniel@caiaq.de" <daniel@caiaq.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "hjk@hansjkoch.de" <hjk@hansjkoch.de>

On 09/08/11 17:50, Jonathan Cameron wrote:
> On 09/08/11 15:54, Greg KH wrote:
>> On Thu, Sep 08, 2011 at 06:57:04PM +0530, AnilKumar, Chimata wrote:
>>> Hi All,
>>>
>>> I am developing a driver for TI's enhanced Quadrature Encoder Pulse
>>> (eQEP) module. Details of the module at
>>> http://www.ti.com/lit/ug/sprufu8/sprufu8.pdf
>>>
>>> Little description about the module:-
>>>
>>> This module is used for direct interface with a linear or rotary
>>> incremental encoder.
>>>
>>> Main features of the module:
>>> a. Provides the direction of the motor (clock or anti-clock)
>>> b. Provides position count values, which can be used to compute speed
>>>    of a machine (motor/generator)
>>> c. Generate a sync output from position compare sub-module
>>> d. Can be used for High & Low speed measurements
>>>
>>> This module has 4 inputs from external rotary/linear encoder.
>>> a. Input A (Input from external rotary encoder, a pulse train)
>>> b. Input B (Input from external rotary encoder, a pulse train)
>>> c. Index Event (Input from external rotary encoder, a index event.
>>>    This can be used as output, which can be generated after
>>>    position compare)
>>> d. Strobe Event (Input from external rotary encoder, a strobe event.
>>>    This can be used as output, which can be generated after
>>>    position compare)
>>>
>>> The module provides pre-analyzed data based on the above four input
>>> signals. We can use the data directly for knowing the position and
>>> direction details.
>>>
>>> I have few questions related to this:-
>>>
>>> 1. What subsystem this driver fit into? Input subsystem or UIO
>>> subsystem?
>>>
>>> Why I think it may fit into UIO subsystem?
>>> a. Same driver is used for lot of applications like motor control,
>>> volume control and menu navigation. This means we have to provide
>>> lot of flexibility to the user in configuring the hardware to work
>>> for different applications.
>>
>> Does it use the UIO interface to userspace?  If not, then it's not a UIO
>> driver.
>>
>>> Why I think it may fit into Input subsystem?
>>> a. The module is receiving the signals from external encoder. Based
>>> on the signals it will generate some events, which we have to handle
>>> at the user space.
>>> b. I found some encoder drivers are already present under input
>>> subsystem (example drivers/input/misc/rotary-encoder.c)
>>>
>>> But, the current rotary encoder drivers are developed for much simpler 
>>> hardware.
>>>
>>> It looks like we need some additional interfaces to cater to the
>>> hardware capabilities. I am thinking of sysfs interfaces which
>>> allow user to directly configure the hardware for position control,
>>> position compare, input source selection, capture timer period,
>>> speed and direction of rotation.
>>
>> That sounds like you want the IIO interface in drivers/staging/iio/
>> right?  That api handles all sorts of stuff like this.
> Certainly possible - always happy to support new device types.
> 
> We have some resolvers in there already, and based on a hundred mile view
> this is similar...  From what I recall those interfaces are pretty messy
> right now, but looking at it another way, that gives us more flexibility
> to mess around with them to ensure they cover your part as well.
I'll rephrase this having taken a look. The current resolver drivers conform
to our standard interface in now way whatsoever.  So whatever you do,
don't copy them!  Along with meters drivers, those are the areas we haven't
cleaned up at all yet (also a smattering of other drivers in terrible state
for one reason or another elsewhere)
> 
> Based on really quick scan of datasheet, looks like we have 
> * some basic readouts,
> * a couple of latches on them (handy for precisely timed data grabs),
> * periodic trigger,
> * watchdog on motor stalls - could be couched as a rate of change threshold?
> 
> Some shadow registers that may be a little fiddly, but other than it measuring
> something a bit different looks like a fairly standard IIO part.
> 
> Jonathan

