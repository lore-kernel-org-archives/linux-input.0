From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Mon, 18 Sep 2017 22:50:06 +0200
Message-ID: <9d5d045e-5019-e132-9449-7fb40b1b7895@gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd> <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd>
 <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com> <20170917182251.GA15328@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20170917182251.GA15328@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 09/17/2017 08:22 PM, Pavel Machek wrote:
> Hi!
> 
>>> If your objection is that FF is not easily engaged from the shell -
>>> yes, but I do not think that actual users who want to do vibration do
>>> that via shell either. On the other hand, can you drop privileges and
>>> still allow a certain process control your vibrator via LED interface?
>>> With FF you can pass an FD to whoever you deem worthy and later revoke
>>> access.
>>>
>>> IOW sysfs interfaces are nice for quick hacks, but when you want to
>>> use them in real frameworks, where you need to think about proper
>>> namespaces, isolation, etc, etc, other kinds of interfaces might suit
>>> better.
>>
>> I'd leave the decision to the user. We could add a note to the
>> Documentation/leds/ledtrig-transient.txt that force feedback interface
>> should be preferable choice for driving vibrate devices.
> 
> We don't want to leave decision to the user; because then we'll end up
> with userland applications having to support _both_ interfaces.

This state has lasted for five years now. I don't recall any
complaints. Do you?

> Plus, it is not really your decision. Dmitry is maintainer of input
> subsystem, input was doing force feedback for 10+ years, and he
> already made a decision.

It seems that you applied a fait accompli method here.

Actually could you share what the decision is? AFAIK we're not
discussing here any patch for the input subsystem?

>> However only if following conditions are met:
>> - force feedback driver supports gpio driven devices
>> - there is sample application in tools/input showing how to
>>   setup gpio driven vibrate device with use of ff interface
>> - it will be possible to setup vibrate interval with 1ms accuracy,
>>   similarly to what the discussed patch allows to do
> 
> I agree these would be nice. Interested parties are welcome to help
> there. But I don't think this should have any impact on LED
> susbystem. Force feedback just does not belong to LED subsystem.

You cut off important piece of my text from the beginning of this
paragraph. It was:

> I'd leave the decision to the user. We could add a note to the
> Documentation/leds/ledtrig-transient.txt that force feedback interface
> should be preferable choice for driving vibrate devices.
> However only if following conditions are met:

What I meant is that it is my decision, as a LED subsystem maintainer,
to accept the addition of a note about some other subsystem offering
an equivalent or even better substitute of the feature being available
in the subsystem I am responsible for. And I will accept such a patch
only if mentioned conditions are met.

-- 
Best regards,
Jacek Anaszewski
