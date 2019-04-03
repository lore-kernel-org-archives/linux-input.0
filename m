From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [BUG REPORT] linux-input: keyboard: gpio_keys: False Button
 Press Event on Wake
Date: Wed, 3 Apr 2019 11:16:43 -0700
Message-ID: <20190403181643.GC53104@dtor-ws>
References: <BL0PR07MB41151EC4B770F6A7396C152EAD570@BL0PR07MB4115.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BL0PR07MB41151EC4B770F6A7396C152EAD570@BL0PR07MB4115.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ken Sloat <KSloat@aampglobal.com>
Cc: "josephl@nvidia.com" <josephl@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Ken,

On Wed, Apr 03, 2019 at 05:50:09PM +0000, Ken Sloat wrote:
> Hello Dmitry,
> 
> I may have found a potential bug in the "gpio_keys" driver. FYI, I am
> running the 4.14 LTS kernel on my system, but from my understanding of
> the issue, it seems that this would still occur in the latest version
> of the kernel.
> 
> The problem: In the 4.14 LTS kernel, both key press and release events
> can generate a wake event. In the 5.x kernel, wake events are
> configurable for press only, release only or "both" (see
> "wakeup-event-action" binding). The issue can occur in the "both" case
> or release/deasserted case. Let's imagine that a system is suspended
> when a gpio key button is pressed, and subsequently resumed when the
> button is released. If we look at the sequence of actions and events
> reported by the input system, we can see the potential problem:
> 
> Button Pressed
> Event Value 1
> System Suspend
> Button Released
> System Wake & Resume
> Event Value 0
> Event Value 1
> Event Value 0
> 
> As you can see the input system will report an extra button
> event/press. This appears to be caused in gpio_keys_gpio_isr by the
> following statement:
> 
> if (bdata->suspended  &&
>     (button->type == 0 || button->type == EV_KEY)) {
>         /*
>          * Simulate wakeup key press in case the key has
>          * already released by the time we got interrupt
>          * handler to run.
>          */
>         input_report_key(bdata->input, button->code, 1);
> }
> 
> This code does not seem to take into account that the wake event may
> have been caused by a button release action, and just assumes we must
> have a button press.
> 
> This can obviously be problematic in the use case I mentioned, as the
> system would be put in a constant loop between waking and sleeping.
> While there are other ways to deal with or react to this issue in the
> userspace, it seems that the driver should probably take this into
> account.
> 

I believe the expectation is that we do not go to sleep with button
still pressed, as we expect it to be released momentarily. Given that we
do not know which edge woke us it is not clear if we can avoid
simulating the keypress event, as this definitely causes "missed press",
at least on some Android devices, where by the time we get to run this
ISR user has already released the button.

Thanks.

-- 
Dmitry
