From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH] input: st1232: Add IRQF_NO_SUSPEND flag
Date: Mon, 18 Feb 2013 09:48:33 -0600
Message-ID: <CABYn4syeX4VZ2HJZVg2_w0YUgxpE_fm0Zq-4oAFRnEJuwqnmuw@mail.gmail.com>
References: <1360863132-11227-1-git-send-email-hechtb+renesas@gmail.com>
	<CANqRtoQzhfxaHJp+vj=GnAaR4NyD9U1F1B7EnRckdLqvJE=XEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoQzhfxaHJp+vj=GnAaR4NyD9U1F1B7EnRckdLqvJE=XEw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi Magnus,

2013/2/14 Magnus Damm <magnus.damm@gmail.com>:
> Hi Bastian,
>
> On Fri, Feb 15, 2013 at 2:32 AM, Bastian Hecht <hechtb@gmail.com> wrote:
>> When registering the interrupt handler we add the IRQF_NO_SUSPEND flag
>> to save the IRQ line from being disabled during suspension. This way we
>> keep the ability to use the device as a wakeup source.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>>  drivers/input/touchscreen/st1232.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
>> index d9d05e2..4f37199 100644
>> --- a/drivers/input/touchscreen/st1232.c
>> +++ b/drivers/input/touchscreen/st1232.c
>> @@ -180,7 +180,7 @@ static int st1232_ts_probe(struct i2c_client *client,
>>         input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
>>
>>         error = request_threaded_irq(client->irq, NULL, st1232_ts_irq_handler,
>> -                                    IRQF_ONESHOT, client->name, ts);
>> +                       IRQF_ONESHOT | IRQF_NO_SUSPEND, client->name, ts);
>
> Are you sure this is the correct way to handle this? Which platform
> have you tested this on? How about other boards?
>
> Usually wake up handling is dealt with separately from interrupts.
> Looks like something is missing in your interrupt controller code.

I've got 2 different patterns happening on the KZM9G and the Armadillo800EVA.

Armadillo:
I provoke a fail by using the touchscreen while suspending that
triggers the first "intc disable 10 10" (see below). The suspend code
disables all(?) IRQ lines and after
"PM: noirq suspend of devices complete after 4901.016 msecs"
the wakeup sources get reenabled. In fact I'm unsure if the IRQ line
10 gets reenabled by the generic IRQ handling code when reenabling the
line after handling it or if it is done by code that sets up the
wakeup sources. IRQ 14 is a GPIO button that is marked as a wakeup
source in the board code:
GPIO_KEY(KEY_POWER,     GPIO_PORT99,    "SW3", .wakeup = 1),

Now the strange thing here is that even after enabling IRQ line 10
("intc write8: addr e0804064, h 2034a25, data 20" is the correct write
to unmask it) the touchscreen stays dead and I can't wake using it.
Even if I wake it using the GPIO key the st1232 stays dead and I don't
get any more interrupts from it.

When I suspend while not using the touchscreen I get the same sequence
without the inital "intc disable 10 10" and no i2c timeout happens and
I am able to wake from the st1232.

Here my log:
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
intc disable 10 10
intc write8: addr e0804044, h 2034a25, data 20
PM: suspend of devices complete after 243.854 msecs
PM: late suspend of devices complete after 0.327 msecs
intc disable 10 10
intc write8: addr e0804044, h 2034a25, data 20
intc disable 12 12
intc write8: addr e0804044, h 2034a23, data 8
intc disable 13 13
intc write8: addr e0804044, h 2034a22, data 4
intc disable 14 14
intc write8: addr e0804044, h 2034a21, data 2
intc disable 15 15
intc write8: addr e0804044, h 2034a20, data 1
intc disable 44 44
intc write8: addr e69400ac, h 16174a24, data 10
intc disable 45 45
intc write8: addr e69400ac, h 16174a25, data 20
intc disable 46 46
intc write8: addr e69400ac, h 16174a26, data 40
intc disable 47 47
intc write8: addr e69400ac, h 16174a27, data 80
intc disable 168 168
intc write8: addr e6950090, h 20214a27, data 80
intc disable 178 178
intc write8: addr e6950094, h 22234a25, data 20
intc disable 444 444
intc write8: addr e0806190, h 6074a20, data 1
intc disable 512 512
intc write8: addr e08061ac, h e0f4a24, data 10
intc disable 513 513
intc write8: addr e08061ac, h e0f4a25, data 20
intc disable 514 514
intc write8: addr e08061ac, h e0f4a26, data 40
intc disable 515 515
intc write8: addr e08061ac, h e0f4a27, data 80
intc disable 588 588
intc write8: addr e0808190, h 10114a23, data 8
i2c-sh_mobile i2c-sh_mobile.0: Transfer request timed out
i2c-sh_mobile i2c-sh_mobile.0: Polling timed out
PM: noirq suspend of devices complete after 4977.712 msecs
intc enable 10 10
intc write8: addr e0804064, h 2034a25, data 20
intc enable 14 14
intc write8: addr e0804064, h 2034a21, data 2


KZM9G:

Here even if I don't produce IRQs from the st1232 I can't wake without
the patch. The IRQ gets disabled as in the log above but there is no
reenabling at all. So my patch stops disabling the IRQ line in the
first place and we are able to use it as a wakeup source.

# echo mem >/sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
PM: Entering mem sleep
PM: suspend of devices complete after 3.417 msecs
PM: late suspend of devices complete after 0.244 msecs
intc disable 568 568
intc write8: addr df00a044, h 2034a27, data 80
intc disable 444 444
intc write8: addr df004190, h 6074a20, data 1
intc disable 947 947
intc write8: addr df00a048, h 4054a24, data 10
intc disable 954 954
intc write8: addr df00a04c, h 6074a25, data 20
PM: noirq suspend of devices complete after 25.146 msecs
Disabling non-boot CPUs ...
CPU1: shutdown

No wakeup possible here. Btw there is 1 more thing that confuses me:
The touchscreen IRQ line is 424 in /proc/interrupts: 424:         34
       0  INTCA-GIC-level     st1232-ts
but when using it I get
intc disable 568 568
intc write8: addr df00a044, h 2034a27, data 80
intc enable 568 568
intc write8: addr df00a064, h 2034a27, data 80

But IRQ line 568 doesn't exist at all in /proc/interrupts. Can you explain that?


So you are probably right, there is something phony in the interrupt
controller code. And probably in 2 different spots.

Thanks,

 Bastian


> Thanks,
>
> / magnus
