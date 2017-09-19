From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Tue, 19 Sep 2017 22:45:08 +0200
Message-ID: <4226b524-35e1-16c0-f6ca-e339dd2eab1d@gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd> <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com> <20170917182251.GA15328@amd>
 <9d5d045e-5019-e132-9449-7fb40b1b7895@gmail.com>
 <CAKdAkRRsn+bV34yq9=Qqnp3D+DjWtGfrLAmF6pJCgvbyBqz2Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRRsn+bV34yq9=Qqnp3D+DjWtGfrLAmF6pJCgvbyBqz2Cw@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 09/19/2017 12:29 AM, Dmitry Torokhov wrote:
> On Mon, Sep 18, 2017 at 1:50 PM, Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> Hi,
>>
>> On 09/17/2017 08:22 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> If your objection is that FF is not easily engaged from the shell -
>>>>> yes, but I do not think that actual users who want to do vibration do
>>>>> that via shell either. On the other hand, can you drop privileges and
>>>>> still allow a certain process control your vibrator via LED interface?
>>>>> With FF you can pass an FD to whoever you deem worthy and later revoke
>>>>> access.
>>>>>
>>>>> IOW sysfs interfaces are nice for quick hacks, but when you want to
>>>>> use them in real frameworks, where you need to think about proper
>>>>> namespaces, isolation, etc, etc, other kinds of interfaces might suit
>>>>> better.
>>>>
>>>> I'd leave the decision to the user. We could add a note to the
>>>> Documentation/leds/ledtrig-transient.txt that force feedback interface
>>>> should be preferable choice for driving vibrate devices.
>>>
>>> We don't want to leave decision to the user; because then we'll end up
>>> with userland applications having to support _both_ interfaces.
>>
>> This state has lasted for five years now. I don't recall any
>> complaints. Do you?
> 
> I was telling Shuah 5 years ago that using LED for what she wanted was
> not the right idea. I even made a patch for her implementing the
> functionality they were after: https://lkml.org/lkml/2012/4/10/41
> 
> Unfortunately this still somehow made it into the kernel. I guess the
> angle of having LEDs auto-shutoff makes sense still; using it for
> haptics does not.

Thanks for the pointer.

>>
>>> Plus, it is not really your decision. Dmitry is maintainer of input
>>> subsystem, input was doing force feedback for 10+ years, and he
>>> already made a decision.
>>
>> It seems that you applied a fait accompli method here.
>>
>> Actually could you share what the decision is? AFAIK we're not
>> discussing here any patch for the input subsystem?
> 
> No, we are discussing if it makes sense encouraging 2nd interface for
> haptic. We are also discussing whether it makes sense to implement new
> features in LED subsystem that seem to be only beneficial for this
> interface (I assume the "normal" LEDs do not need that kind of
> precision?).

As you noticed in one of the previous messages, thanks to the leds-gpio
driver we can drive a wide range of devices from the level of
LED subsystem. LED trigger mechanism makes it even more versatile,
and, in this area, even somehow akin to the GPIO subsystem. In the
future we could think of making this trigger mechanism accessible by
the two and thus any initiative aiming at enhancing it shouldn't be
discouraged.

>>>> However only if following conditions are met:
>>>> - force feedback driver supports gpio driven devices
>>>> - there is sample application in tools/input showing how to
>>>>   setup gpio driven vibrate device with use of ff interface
>>>> - it will be possible to setup vibrate interval with 1ms accuracy,
>>>>   similarly to what the discussed patch allows to do
>>>
>>> I agree these would be nice. Interested parties are welcome to help
>>> there. But I don't think this should have any impact on LED
>>> susbystem. Force feedback just does not belong to LED subsystem.
>>
>> You cut off important piece of my text from the beginning of this
>> paragraph. It was:
>>
>>> I'd leave the decision to the user. We could add a note to the
>>> Documentation/leds/ledtrig-transient.txt that force feedback interface
>>> should be preferable choice for driving vibrate devices.
>>> However only if following conditions are met:
>>
>> What I meant is that it is my decision, as a LED subsystem maintainer,
>> to accept the addition of a note about some other subsystem offering
>> an equivalent or even better substitute of the feature being available
>> in the subsystem I am responsible for. And I will accept such a patch
>> only if mentioned conditions are met.
> 
> Having the wording in documentation does not in any way stops Android
> folks from continuing [ab]using the transient trigger. But this is
> their choice. The purpose of documentation is to document the best
> practices, not all possible crazy solutions one can come up with.

Yes. but if the information has been in place for years, we can't
just remove it without giving an instruction on how to use the
substitute.

-- 
Best regards,
Jacek Anaszewski
