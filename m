From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [PATCH] generic driver for rotary encoders on GPIOs
Date: Wed, 4 Mar 2009 12:02:47 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901349B98@mi8nycmail19.Mi8.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <1236074367-23172-1-git-send-email-daniel@caiaq.de> <20090304084851.GB7394@dtor-d630.eng.vmware.com> <20090304095053.GA6098@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og104.obsmtp.com ([64.18.1.187]:43646 "HELO
	exprod6og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753074AbZCDRDA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 12:03:00 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20090304095053.GA6098@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wednesday, March 04, 2009 2:51 AM, Daniel Mack wrote:
> On Wed, Mar 04, 2009 at 12:48:52AM -0800, Dmitry Torokhov wrote:
>> On Tue, Mar 03, 2009 at 10:59:27AM +0100, Daniel Mack wrote:
>>> This patch adds a generic driver for rotary encoders connected to
GPIO
>>> pins of a system. It relies on gpiolib and generic hardware irqs.
The
>>> documentation that also comes with this patch explains the concept
and
>>> how to use the driver.
>>> 
>>> Signed-off-by: Daniel Mack <daniel@caiaq.de>
>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
>>> ---
>>>  New version with Dmitry's change requests included:
>>> 
>>>   * calling input_free_device() in case input_register_device()
fails
>>>   * calling input_unregister_device() in all other cases
>>>   * made the axis information part of the platform data
>>> 
>> 
>> I fiddled with the driver a little bit more changing formatting,
please
>> take a look and if you are still OK with it I will apply to 'next'.

Couple of comments, none should hold up committing this driver.

1) For an absolute encoder shouldn't the position clamp to the
minimum/maximum values?  Currently the driver is setup to report the
events going from 0 to 'steps' then the count rolls over (in both
directions).  Maybe this should be a platform optional flag?  Also,
maybe the minimum/maximum of the axis should be platform configurable
instead of just having the 'steps' of the encoder?

2) I have a patch to the driver that allows the axis to be a REL_* type.
I will post this patch for review after the driver is committed.

3) Are both 'inverted_*' flags really needed?  It appears that the end
effect of these just reverses the logical direction of the encoder.

	inverted_a	inverted_b	result
	0		0		normal encoder
	0		1		backwards encoder
	1		0		backwards encoder
	1		1		normal encoder

The same effect should be attainable with one flag to reverse the
direction, or just reverse the wires on the encoder.

3) It might be possible to reconstruct the interrupt handler so that
only one gpio needs to be interrupt capable.

Looking at the phase diagram you could consider one of the channel
inputs as a 'step' interrupt and the other as the 'direction' of the
step.  On the positive edge of any 'step' if the 'direction' is low it's
going one way, high it's going the other way.

This would double the effective number of encoders that could be
connected.  And it removes the added overhead of the extra interrupt
handler and needing to keep track of the 'armed' and 'dir' states.
Actually with both interrupts sharing the same handler the 'armed' and
'dir' variables seem a little bit racy.

Once the driver is committed I will mess with the interrupt code and see
if this is possible.

Regards,
Hartley
