From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH] input: st1232: Add IRQF_NO_SUSPEND flag
Date: Wed, 27 Feb 2013 15:25:39 -0600
Message-ID: <CABYn4sygDEDQW3VvO9cr-GD+_73Jv+Ntz3LOSmZ2k=MbTqVAVg@mail.gmail.com>
References: <1360863132-11227-1-git-send-email-hechtb+renesas@gmail.com>
	<CANqRtoQzhfxaHJp+vj=GnAaR4NyD9U1F1B7EnRckdLqvJE=XEw@mail.gmail.com>
	<CABYn4syeX4VZ2HJZVg2_w0YUgxpE_fm0Zq-4oAFRnEJuwqnmuw@mail.gmail.com>
	<CANqRtoT+xUXkBp2m5Mr_5Pf0-AdG7iJc4UwAf_QPdU_rNVmg4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoT+xUXkBp2m5Mr_5Pf0-AdG7iJc4UwAf_QPdU_rNVmg4g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi Magnus,

2013/2/25 Magnus Damm <magnus.damm@gmail.com>:
> Hi Bastian,
>
> On Tue, Feb 19, 2013 at 12:48 AM, Bastian Hecht <hechtb@gmail.com> wrote:
>> Hi Magnus,
>>
>> 2013/2/14 Magnus Damm <magnus.damm@gmail.com>:
>>> Hi Bastian,
>>>
>>> On Fri, Feb 15, 2013 at 2:32 AM, Bastian Hecht <hechtb@gmail.com> wrote:
>>>> When registering the interrupt handler we add the IRQF_NO_SUSPEND flag
>>>> to save the IRQ line from being disabled during suspension. This way we
>>>> keep the ability to use the device as a wakeup source.
>>>>
>>>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>>> ---
>>>>  drivers/input/touchscreen/st1232.c |    2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
>>>> index d9d05e2..4f37199 100644
>>>> --- a/drivers/input/touchscreen/st1232.c
>>>> +++ b/drivers/input/touchscreen/st1232.c
>>>> @@ -180,7 +180,7 @@ static int st1232_ts_probe(struct i2c_client *client,
>>>>         input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
>>>>
>>>>         error = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
>>>> -                                    IRQF_ONESHOT, client->name, ts);
>>>> +                       IRQF_ONESHOT | IRQF_NO_SUSPEND, client->name, ts);
>>>
>>> Are you sure this is the correct way to handle this? Which platform
>>> have you tested this on? How about other boards?
>>>
>>> Usually wake up handling is dealt with separately from interrupts.
>>> Looks like something is missing in your interrupt controller code.
>>
>> I've got 2 different patterns happening on the KZM9G and the Armadillo800EVA.
>>
>> Armadillo:
>> I provoke a fail by using the touchscreen while suspending that
>> triggers the first "intc disable 10 10" (see below). The suspend code
>> disables all(?) IRQ lines and after
>> "PM: noirq suspend of devices complete after 4901.016 msecs"
>> the wakeup sources get reenabled. In fact I'm unsure if the IRQ line
>> 10 gets reenabled by the generic IRQ handling code when reenabling the
>> line after handling it or if it is done by code that sets up the
>> wakeup sources. IRQ 14 is a GPIO button that is marked as a wakeup
>> source in the board code:
>> GPIO_KEY(KEY_POWER,     GPIO_PORT99,    "SW3", .wakeup = 1),
>
> Thanks for giving more details. You write that you are unsure about
> some things, would it be possible for you to track down those things
> so we know for sure?

If I'd track down all things I'm unsure about, we'll meet in heaven
again next time...
In this case the final reenabling of the IRQ is done in
intc_suspend(), which sounds totally fine.

>> Now the strange thing here is that even after enabling IRQ line 10
>> ("intc write8: addr e0804064, h 2034a25, data 20" is the correct write
>> to unmask it) the touchscreen stays dead and I can't wake using it.
>> Even if I wake it using the GPIO key the st1232 stays dead and I don't
>> get any more interrupts from it.
>
> The sleep mode you are using is a plan "WFI" at this point, right? If
> you are controlling power domains then you may have to involve the
> SYSC hardware depending on which power domains you turn off.

Yes this is a shallow WFI sleep without power shutdowns.

>> When I suspend while not using the touchscreen I get the same sequence
>> without the inital "intc disable 10 10" and no i2c timeout happens and
>> I am able to wake from the st1232.
>
> Is it possible that the IRQ of the st1232 is in level trigger mode,
> and when you use the touch screen the IRQ gets asserted and remains
> asserted? If you read out the registers of the st1232 can you see if
> the IRQ is asserted?

Yes that's it. At least kind of inverted it's it. The INTCA is set to
edge trigger mode.

So what happens is this: The I2C bus shuts down and we still accept
st1232 IRQs. The st1232 registers its handler with the flag
IRQF_ONESHOT as the handler is threaded. This means the line gets
masked out until the handler finished. Now an IRQ arrives, the ack
fails because I2C is down and this makes the IRQ line stay asserted.
The IRQ handler thread gets frozen by suspend (this is my assumption)
but the INTC suspend code reactivates the IRQ line as a wakeup source
(verified). The INTC code triggers no IRQ now as we are in edge
detection mode. When I switch to low level detection the SoC wakes and
we don't get stuck.

Side note: The ICR2 register looks strange, it's: 0x4444. This sets
IRQ15 to IRQ12 to edge detection on both sides and IRQ11 to IRQ8 to
falling edge detection. To me this looks a bit arbitrary.

> Another alternative is that the INTC code is masking with priority
> instead of bitmap and something is lacking. It sounds more like an
> asserted interrupt though.
>
> Yet another option is that some piece of code is missing to
> acknowledge interrupts on resume.

Thanks for sharing these ideas.

>> Here my log:
...
>> intc write8: addr e0804064, h 2034a21, data 2
>
> That's exciting. =)

Yes sure, I will include more next time!

> For other people to help you it would be good if you could share more
> information, like for instance which git branch you are working
> against and also if you have done any modifications yourself.

For both test cases I used Linux 3.8-rc7 and coded directly on top of
it. Unfortunately I don't remember the oldest tag I've seen this bug
on.


>> KZM9G:
>>
>> Here even if I don't produce IRQs from the st1232 I can't wake without
>> the patch. The IRQ gets disabled as in the log above but there is no
>> reenabling at all. So my patch stops disabling the IRQ line in the
>> first place and we are able to use it as a wakeup source.
>>
>> # echo mem >/sys/power/state
>> PM: Syncing filesystems ... done.
>> PM: Preparing system for mem sleep
>> Freezing user space processes ... (elapsed 0.02 seconds) done.
>> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
>> PM: Entering mem sleep
>> PM: suspend of devices complete after 3.417 msecs
>> PM: late suspend of devices complete after 0.244 msecs
>> intc disable 568 568
>> intc write8: addr df00a044, h 2034a27, data 80
>> intc disable 444 444
>> intc write8: addr df004190, h 6074a20, data 1
>> intc disable 947 947
>> intc write8: addr df00a048, h 4054a24, data 10
>> intc disable 954 954
>> intc write8: addr df00a04c, h 6074a25, data 20
>> PM: noirq suspend of devices complete after 25.146 msecs
>> Disabling non-boot CPUs ...
>> CPU1: shutdown
>>
>> No wakeup possible here. Btw there is 1 more thing that confuses me:
>> The touchscreen IRQ line is 424 in /proc/interrupts: 424:         34
>>        0  INTCA-GIC-level     st1232-ts
>> but when using it I get
>> intc disable 568 568
>> intc write8: addr df00a044, h 2034a27, data 80
>> intc enable 568 568
>> intc write8: addr df00a064, h 2034a27, data 80
>>
>> But IRQ line 568 doesn't exist at all in /proc/interrupts. Can you explain that?
>
> I suppose you will have to decode how the different IRQs are mapped in
> intc-sh73a0.c.

Yep I'm close to understand the INTCA.

> One of the key differences between r8a7740 and sh73a0 is that r8a7740
> is using INTC only and sh73a0 is making use of the GIC. So for KZM9G
> you have to take the GIC into consideration. If you have not dived
> into that code yet then now is a good time.

So maybe code is missing that unmasks wakeup sources as it is done in INTCA.

> Also, regarding the external IRQ pins on sh73a0, perhaps the function
> sh73a0_set_wake() needs to be updated?
>
>> So you are probably right, there is something phony in the interrupt
>> controller code. And probably in 2 different spots.
>
> Why don't you focus on tracking down the r8a7740 external IRQ issue?
> Try to figure out if the IRQ is stuck asserted.
>
> As for sh73a0 External IRQ pins, I am about to post a v2 of my INTC
> external IRQ pin driver and will also include some platform data for
> sh73a0. You may want to give that a try.

> A good conclusion here is probably that this patch adding the
> IRQF_NO_SUSPEND flag is not the correct solution to these problems.
> You may have to do some modification about the drivers, but I believe
> they are likely to be rather fine as-is. In the case of the st1232
> driver it has been used on the sh7372 mackerel board and there we are
> (at least have been) able to use Suspend-to-RAM in various ways.
>

I'll take a look at the sh73a0 case later.

Cheers,

 Bastian
