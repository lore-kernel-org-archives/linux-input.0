From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led: ledtrig-transient: add support for hrtimer
Date: Wed, 27 Sep 2017 22:43:22 -0700
Message-ID: <744568EA-8FEE-4A0E-B431-F054B0827261@gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com> <20170913202032.GA30844@amd> <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com> <20170914205804.GA24339@amd> <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com> <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com> <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com> <CAPzFB+XZopNPTuOD-xttq-0dqEF2hSXLftQvzfDHLhJ+9ZuB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPzFB+XZopNPTuOD-xttq-0dqEF2hSXLftQvzfDHLhJ+9ZuB-Q@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: David Lin <dtwlin@google.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On September 27, 2017 10:03:28 PM PDT, David Lin <dtwlin@google=2Ecom> wrot=
e:
>Dmitry,
>
>On Fri, Sep 15, 2017 at 3:30 PM, Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> wrote:
>> On Fri, Sep 15, 2017 at 2:55 PM, Jacek Anaszewski
>> <jacek=2Eanaszewski@gmail=2Ecom> wrote:
>>> On 09/15/2017 08:34 PM, Dmitry Torokhov wrote:
>>>> On Thu, Sep 14, 2017 at 1:58 PM, Pavel Machek <pavel@ucw=2Ecz> wrote:
>>>>> On Thu 2017-09-14 21:31:31, Jacek Anaszewski wrote:
>>>>>> Hi David and Pavel,
>>>>>>
>>>>>> On 09/13/2017 10:20 PM, Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>> These patch series add the LED_BRIGHTNESS_FAST flag support for
>>>>>>>> ledtrig-transient to use hrtimer so that platforms with
>high-resolution timer
>>>>>>>> support can have better accuracy in the trigger duration
>timing=2E The need for
>>>>>>>> this support is driven by the fact that Android has removed the
>timed_ouput [1]
>>>>>>>> and is now using led-trigger for handling vibrator control
>which requires the
>>>>>>>> timer to be accurate up to a millisecond=2E However, this flag
>support would also
>>>>>>>> allow hrtimer to co-exist with the ktimer without causing
>warning to the
>>>>>>>> existing drivers [2]=2E
>>>>>>>
>>>>>>> NAK=2E
>>>>>>>
>>>>>>> LEDs do not need extra overhead, and vibrator control should not
>go
>>>>>>> through LED subsystem=2E
>>>>>>>
>>>>>>> Input subsystem includes support for vibrations and force
>>>>>>> feedback=2E Please use that instead=2E
>>>>>>
>>>>>> I think that most vital criterion here is the usability of the
>>>>>> interface=2E If it can be harnessed for doing the work seemingly
>>>>>> unrelated to the primary subsystem's purpose, that's fine=2E
>>>>>> Moreover, it is extremely easy to use in comparison to the force
>>>>>> feedback one=2E
>>>>>
>>>>> Well, no=2E
>>>>>
>>>>> Kernel is supposed to provide hardware abstraction, that means it
>>>>> should hide differences between different devices=2E
>>>>>
>>>>> And we already have devices using input as designed=2E We don't want
>to
>>>>> have situation where "on phones A, D and E, vibrations are handled
>via
>>>>> input, while on B, C and F, they are handled via /sys/class/leds"=2E
>>>>>
>>>>> If we want to have discussion "how to make vibrations in input
>>>>> easier to use", well that's fair=2E But I don't think it is
>particulary hard=2E
>>>>>
>>>>
>>>> I would like to know more about why you find the FF interface hard,
>>>
>>> led-transient trigger can be activated using only following bash
>>> commands:
>>>
>>> # echo 1 > state
>>> # echo 1000 > duration
>>> # while [ 1 ]; do echo 1 > activate; sleep 3; done
>>>
>>> Could you share sample sequence of commands to use ff driver?
>>
>> Cut what you need from this:
>> https://github=2Ecom/flosse/linuxconsole/blob/master/utils/fftest=2Ec
>>
>> If your objection is that FF is not easily engaged from the shell -
>> yes, but I do not think that actual users who want to do vibration do
>> that via shell either=2E On the other hand, can you drop privileges and
>> still allow a certain process control your vibrator via LED
>interface?
>> With FF you can pass an FD to whoever you deem worthy and later
>revoke
>> access=2E
>>
>> IOW sysfs interfaces are nice for quick hacks, but when you want to
>> use them in real frameworks, where you need to think about proper
>> namespaces, isolation, etc, etc, other kinds of interfaces might suit
>> better=2E
>>
>>>
>>>> given that for rumble you need calls - one ioctl to set up rumble
>>>> parameters, and a write to start the playback=2E The FF core should
>take
>>>> care of handling duration of the effect, ramping it up and
>decaying,
>>>> if desired, and we make sure to automatically stop effects when
>>>> userspace closes the fd (because of ordinary exit or crash or FD
>being
>>>> revoked)=2E
>>>>
>>>>> If we want to say "lets move all vibrations from input to LED
>>>>> subsystem"=2E=2E=2E I don't think that is good idea, but its a valid
>>>>> discussion=2E Some good reasons would be needed=2E
>>>>>
>>>>> But having half devices use one interface and half use different
>one
>>>>> is just bad=2E=2E=2E
>>>>
>>>> Completely agree here=2E I just merged PWM vibra driver from
>Sebastian
>>>> Reichel, we already had regulator-haptic driver, do we need
>gpio-based
>>>> one? Or make regulator-based one working with fixed regulators?
>>>
>>> Just to clarify: the background of this discussion is the question
>>> whether we should remove the following lines from
>>> Documentation/leds/ledtrig-transient=2Etxt:
>>>
>>> -As a specific example of this use-case, let's look at vibrate
>feature on
>>> -phones=2E Vibrate function on phones is implemented using PWM pins on
>SoC or
>>> -PMIC=2E There is a need to activate one shot timer to control the
>vibrate
>>> -feature, to prevent user space crashes leaving the phone in vibrate
>mode
>>> -permanently causing the battery to drain=2E
>>> whether we should remove the following use case example from
>>>
>>> In effect Pavel has objections to increasing ledtrig-transient
>>> interval accuracy by adding hr_timer support to it, because vibrate
>>> devices, as one of the use cases, can benefit from it=2E
>>>
>>> So there are two issues:
>>> 1=2E Addition of hr_timer support to LED trigger=2E
>>> 2=2E Removal of vibrate devices use case from ledtrig-transient doc=2E
>>>
>>> I am in favour of 1=2E and against 2=2E since we're not gaining anythi=
ng
>>> by hiding information about some kernel functionality when it will
>>> still be there=2E It also doesn't define the location of any vibrate
>>> device drivers, since sheer leds-gpio driver can be used for that
>>> purpose=2E
>>
>> I would say that while leds-gpio can be used to do whatever (you can
>> wire PS/2 mouse to a set of gpios and probably manage to drive it
>> through a set of leds-gpio devices) it does not make it right
>> interface for everything=2E We do have a standard interface for haptic
>> (via rumble FF), at this moment I see no reason why we need another
>> one=2E It just confuses userspace as it now needs to implement multiple
>> interfaces, depending on the system it runs=2E Android expects that HAL
>> will take care of hiding all of that from their upper layers and does
>> not really pay close attention to kernel ABIs, but I think we should=2E
>
>One thing I noticed is that input_ff_create_memless() also does not
>use high-resolution timer hence it also does not have the stop-time
>precision that I'm looking for=2E

I'll take patches for high resolution timers in ff memless, they should al=
so help with more accurate scheduling of ramping up and fading of events=2E

>
>Another thing is that ff_reply duration value is maxed-out at 32767 ms
>(u16) while the Android/userspace requires size long for performing
>long notification alert=2E
>

You need unattended vibrations lasting longer than 30 seconds? Anyway, rep=
lay=2Elength =3D=3D 0 means endless IIRC, so you only need to schedule stop=
ping=2E We still will clean up properly if your process crashes or exits or=
 closes the fd=2E


Thanks=2E

--=20
Dmitry
