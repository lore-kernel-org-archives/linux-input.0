From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [PATCH] generic driver for rotary encoders on GPIOs
Date: Fri, 27 Feb 2009 15:15:23 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901349253@mi8nycmail19.Mi8.com>
References: <20090227064314.GB32470@buzzloop.caiaq.de> <1235757652-16514-1-git-send-email-daniel@caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349198@mi8nycmail19.Mi8.com> <20090227183449.GD8855@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og110.obsmtp.com ([64.18.1.25]:47204 "HELO
	exprod6og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753748AbZB0UQO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 15:16:14 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20090227183449.GD8855@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Friday, February 27, 2009 11:35 AM, Daniel Mack wrote:
> On Fri, Feb 27, 2009 at 01:30:15PM -0500, hartleys wrote:
>> On Friday, February 27, 2009 11:01 AM, Daniel Mack wrote:
>>> This patch adds a generic driver for rotary encoders connected
>>> to GPIO pins of a system. It relies on gpiolib and generic
>>> hardware irqs. The documentation that also comes with this patch
>>> explains the concept and how to use the driver.
>>>
>>> Signed-off-by: Daniel Mack <daniel@caiaq.de>
>>> ---
>>>  new version as discussed on linux-input.
>> 
>> Works great now on the ep93xx with no changes.
>
> Glad to hear that :)

Not sure if it matters but you can add my Tested-by if you like.

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>

>> I have a minor patch to it that allows the platform init to
>> configure the absolute/relative axis to report the encoder on.
>> If you would like to see it I can put together a patch.
>
> Yes, and probably just post it as follow-up as soon as this one
> has been commited. I'm new to this list, so I don't know who
> can/will/wants to do this?

Dmitry Torokhov is listed as the maintainer of the input drivers.  I
think he needs to Ack the driver in order for it to be accepted and then
committed to the kernel.

You also might try posting the patch to linux-kernel to get some more
eyes on it.

>> Also, any ideas if the driver could be modified to support more that
>> one rotary encoder?
>>
>> It might be possible to load driver multiple times, once for
>> each encoder, but then all the events show up in different
>> /dev/input/event* places.
>
> That would have been my idea as well. It doesn't really matter how
> many input devices you listen to from user space and as the number
> of encoders on a certain board is not dynamic, I don't see much
> reason to put any efford in this ;)

For right now the current driver looks ok.

I do think handling multiple encoders would be handy.  Having all the
encoders report with one /dev/input/event* is easier to handle in
userspace.  You could still load the driver multiple times in order to
"group" logical collections of encoders.

Regards,
Hartley
