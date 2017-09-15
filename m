From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Fri, 15 Sep 2017 23:55:44 +0200
Message-ID: <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd> <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 09/15/2017 08:34 PM, Dmitry Torokhov wrote:
> On Thu, Sep 14, 2017 at 1:58 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Thu 2017-09-14 21:31:31, Jacek Anaszewski wrote:
>>> Hi David and Pavel,
>>>
>>> On 09/13/2017 10:20 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> These patch series add the LED_BRIGHTNESS_FAST flag support for
>>>>> ledtrig-transient to use hrtimer so that platforms with high-resolution timer
>>>>> support can have better accuracy in the trigger duration timing. The need for
>>>>> this support is driven by the fact that Android has removed the timed_ouput [1]
>>>>> and is now using led-trigger for handling vibrator control which requires the
>>>>> timer to be accurate up to a millisecond. However, this flag support would also
>>>>> allow hrtimer to co-exist with the ktimer without causing warning to the
>>>>> existing drivers [2].
>>>>
>>>> NAK.
>>>>
>>>> LEDs do not need extra overhead, and vibrator control should not go
>>>> through LED subsystem.
>>>>
>>>> Input subsystem includes support for vibrations and force
>>>> feedback. Please use that instead.
>>>
>>> I think that most vital criterion here is the usability of the
>>> interface. If it can be harnessed for doing the work seemingly
>>> unrelated to the primary subsystem's purpose, that's fine.
>>> Moreover, it is extremely easy to use in comparison to the force
>>> feedback one.
>>
>> Well, no.
>>
>> Kernel is supposed to provide hardware abstraction, that means it
>> should hide differences between different devices.
>>
>> And we already have devices using input as designed. We don't want to
>> have situation where "on phones A, D and E, vibrations are handled via
>> input, while on B, C and F, they are handled via /sys/class/leds".
>>
>> If we want to have discussion "how to make vibrations in input
>> easier to use", well that's fair. But I don't think it is particulary hard.
>>
> 
> I would like to know more about why you find the FF interface hard,

led-transient trigger can be activated using only following bash
commands:

# echo 1 > state
# echo 1000 > duration
# while [ 1 ]; do echo 1 > activate; sleep 3; done

Could you share sample sequence of commands to use ff driver?

> given that for rumble you need calls - one ioctl to set up rumble
> parameters, and a write to start the playback. The FF core should take
> care of handling duration of the effect, ramping it up and decaying,
> if desired, and we make sure to automatically stop effects when
> userspace closes the fd (because of ordinary exit or crash or FD being
> revoked).
> 
>> If we want to say "lets move all vibrations from input to LED
>> subsystem"... I don't think that is good idea, but its a valid
>> discussion. Some good reasons would be needed.
>>
>> But having half devices use one interface and half use different one
>> is just bad...
> 
> Completely agree here. I just merged PWM vibra driver from Sebastian
> Reichel, we already had regulator-haptic driver, do we need gpio-based
> one? Or make regulator-based one working with fixed regulators?

Just to clarify: the background of this discussion is the question
whether we should remove the following lines from
Documentation/leds/ledtrig-transient.txt:

-As a specific example of this use-case, let's look at vibrate feature on
-phones. Vibrate function on phones is implemented using PWM pins on SoC or
-PMIC. There is a need to activate one shot timer to control the vibrate
-feature, to prevent user space crashes leaving the phone in vibrate mode
-permanently causing the battery to drain.
whether we should remove the following use case example from

In effect Pavel has objections to increasing ledtrig-transient
interval accuracy by adding hr_timer support to it, because vibrate
devices, as one of the use cases, can benefit from it.

So there are two issues:
1. Addition of hr_timer support to LED trigger.
2. Removal of vibrate devices use case from ledtrig-transient doc.

I am in favour of 1. and against 2. since we're not gaining anything
by hiding information about some kernel functionality when it will
still be there. It also doesn't define the location of any vibrate
device drivers, since sheer leds-gpio driver can be used for that
purpose.

-- 
Best regards,
Jacek Anaszewski
