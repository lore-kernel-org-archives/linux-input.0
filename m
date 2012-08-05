From: Daniel Mack <zonque@gmail.com>
Subject: Re: Emulating level IRQs
Date: Sun, 05 Aug 2012 19:56:21 +0200
Message-ID: <501EB3C5.1080501@gmail.com>
References: <1333777207-4151-1-git-send-email-olof@lixom.net> <20120407070206.GA17623@core.coreip.homeip.net> <4F8089A9.6080704@raumfeld.com> <20120503043651.GA11830@core.coreip.homeip.net> <20120713070102.GA2223@core.coreip.homeip.net> <500561AF.9090901@gmail.com> <5008296C.5070709@gmail.com> <20120723165120.GB26577@core.coreip.homeip.net> <500EE314.7040708@gmail.com> <501E9DDB.3020807@gmail.com> <CAN1soZy-_MdjqS3r3Tc1XET6tPzMxDqjYq3Tn0fYLBNNUkdVAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN1soZy-_MdjqS3r3Tc1XET6tPzMxDqjYq3Tn0fYLBNNUkdVAg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-input@vger.kernel.org

On 05.08.2012 18:56, Haojian Zhuang wrote:
> On Mon, Aug 6, 2012 at 12:22 AM, Daniel Mack <zonque@gmail.com> wrote:
>> On 24.07.2012 20:01, Daniel Mack wrote:
>>> On 23.07.2012 18:51, Dmitry Torokhov wrote:
>>>> On Thu, Jul 19, 2012 at 05:36:12PM +0200, Daniel Mack wrote:
>>>
>>>>> Ok, finally I found some time. In general, the patch works fine. The
>>>>> only detail I had to amend was the irqflags, which were changed from
>>>>> IRQF_TRIGGER_RISING/IRQF_TRIGGER_FALLING to
>>>>> IRQF_TRIGGER_HIGH/IRQF_TRIGGER_LOW, which doesn't work as the PXA can't
>>>>> deal with level-based IRQs. Changing this back to RISING/FALLING makes
>>>>> the driver work again.
>>>>
>>>> Hmm, but that would mean we need to restore reading the data in open()
>>>> to make sure we re-arm IRQ in case somebody touched the screen before it
>>>> was opened by userspace...
>>>
>>> I had another look at this and don't really know what to do here. We
>>> definitely need level interrupts for this device as the interrupt line's
>>> level is the only that tells us when we can stop reading from the
>>> device. So it's not just the start condition that bites us here.
>>>
>>> I copied some people that might help find a solution.
>>>
>>> To summarize the problem: The EETI touchscreen is a device that asserts
>>> a GPIO line when it has events to deliver and waits for I2C commands to
>>> empty its buffers. When there are no more buffered events, it will
>>> de-assert the line.
>>>
>>> This device is connected to a PXA GPIO that is only able to deliver edge
>>> IRQs, and the old implemenation was to wait for an interrupt and then
>>> read data as long as the IRQ's corresponding GPIO was asserted. However,
>>> expecting that an IRQ is mappable to a GPIO is not something we should
>>> do, so the only clean solution is to teach the PXA GPIO controller level
>>> IRQs.
>>>
>>> So it boils down to the question: Is there any easy and generic way to
>>> emulate level irq on chips that don't support that natively?
>>
>> Otherwise, we would need some sort of generic irq_to_gpio() again, and
>> the interrupt line the driver listens to must have support for that sort
>> of mapping.
>>
>> Any opinion on this, anyone?
>>
> Since you're using gpio as input, you need to call gpio_request() and set it
> as input direction. And you could also transfer the gpio number into touch
> driver via platform data. Is it OK for you?

No, that's not the point. What we get via the i2c runtime data is an
interrupt number. The driver is driven by that interrupt and doesn't
poll on a GPIO line, which is how it should be.

However, in order to know when to stop reading from the device, we need
to monitor the GPIO line after the interrupt has arrived, and read as
long as the line is asserted. Then we stop reading and wait for the next
interrupt to arrive.

Hence, what we need here is either a GPIO/IRQ controller that is able to
handle level-IRQs (which the PXA can't do), or we need to have a generic
way to map IRQ lines back to GPIOs.

Of course, I could pass the GPIO in the platform data and the IRQ in the
I2C data and leave it to the user of the driver to keep both values in
sync, but I wanted to avoid that.


Daniel
