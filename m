From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Fri, 15 Sep 2017 23:55:37 +0200
Message-ID: <ef3472a0-1e70-e64f-fe11-7fdfd768fc85@gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd> <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20170914205804.GA24339@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org
Cc: David Lin <dtwlin@google.com>, corbet@lwn.net, rpurdie@rpsys.net, hdegoede@redhat.com, gregkh@linuxfoundation.org, robh@kernel.org, romlem@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 09/14/2017 10:58 PM, Pavel Machek wrote:
> On Thu 2017-09-14 21:31:31, Jacek Anaszewski wrote:
>> Hi David and Pavel,
>>
>> On 09/13/2017 10:20 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>> These patch series add the LED_BRIGHTNESS_FAST flag support for
>>>> ledtrig-transient to use hrtimer so that platforms with high-resolution timer
>>>> support can have better accuracy in the trigger duration timing. The need for
>>>> this support is driven by the fact that Android has removed the timed_ouput [1]
>>>> and is now using led-trigger for handling vibrator control which requires the
>>>> timer to be accurate up to a millisecond. However, this flag support would also
>>>> allow hrtimer to co-exist with the ktimer without causing warning to the
>>>> existing drivers [2].
>>>
>>> NAK.
>>>
>>> LEDs do not need extra overhead, and vibrator control should not go
>>> through LED subsystem.
>>>
>>> Input subsystem includes support for vibrations and force
>>> feedback. Please use that instead.
>>
>> I think that most vital criterion here is the usability of the
>> interface. If it can be harnessed for doing the work seemingly
>> unrelated to the primary subsystem's purpose, that's fine.
>> Moreover, it is extremely easy to use in comparison to the force
>> feedback one.
> 
> Well, no.
> 
> Kernel is supposed to provide hardware abstraction, that means it
> should hide differences between different devices.
> 
> And we already have devices using input as designed. We don't want to
> have situation where "on phones A, D and E, vibrations are handled via
> input, while on B, C and F, they are handled via /sys/class/leds".
> 
> If we want to have discussion "how to make vibrations in input
> easier to use", well that's fair. But I don't think it is particulary hard.
> 
> If we want to say "lets move all vibrations from input to LED
> subsystem"... I don't think that is good idea, but its a valid
> discussion. Some good reasons would be needed.
> 
> But having half devices use one interface and half use different one
> is just bad... especially when only reason to do it that way is
> "David wants to do it that way, android library made a mistake and he
> now wants it to propagate to whole world".

This is not the only reason. Adding hr_timer support to
ledtrig-transient (and similarly to ledtrig-timer) would allow
to increase the accuracy and stability of delay_on/delay_off
intervals at low values.

Do you think such an improvement could be harmful in some way,
even if it was made optional?

-- 
Best regards,
Jacek Anaszewski
