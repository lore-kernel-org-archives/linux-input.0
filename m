From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Wed, 20 Sep 2017 20:44:44 +0200
Message-ID: <4920a403-3cb3-f34e-12f4-909cb1e128bd@gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd> <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd> <ef3472a0-1e70-e64f-fe11-7fdfd768fc85@gmail.com>
 <20170916015809.GA5072@localhost>
 <9afbd987-b237-24d4-e16a-ddd7fa70766a@gmail.com> <20170917175013.GB13003@amd>
 <a17f76a4-9c9b-6154-6b5e-d30fd499efa7@gmail.com> <20170920111526.GA3097@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:47919 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdITSpj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 14:45:39 -0400
In-Reply-To: <20170920111526.GA3097@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org, David Lin <dtwlin@google.com>, corbet@lwn.net, rpurdie@rpsys.net, hdegoede@redhat.com, gregkh@linuxfoundation.org, robh@kernel.org, romlem@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org

Hi,

On 09/20/2017 01:15 PM, Pavel Machek wrote:
> On Mon 2017-09-18 22:43:40, Jacek Anaszewski wrote:
>> Hi,
>>
>> On 09/17/2017 07:50 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>> Do you think such an improvement could be harmful in some way,
>>>>>> even if it was made optional?
>>>>>
>>>>> Of course, we can make LED timing accurate down to microseconds. It will
>>>>> mean increased overhead -- for "improvement" human can not perceive.
>>>>>
>>>>> If someone has problems with LED delays not being accurate enough... we
>>>>> may want to fix it. But that is not the case here, is it?
>>>>
>>>> AFAIR David was mentioning that the hr_timer support is perceivable
>>>
>>> He said that hr_timer support is perceivable _when he is driving
>>> vibration motor_. Which he should not do in the first place.
>>>
>>> Yes, if the difference is perceivable with LED in non-crazy
>>> configuration (*), we can take the patch. Is it? Do we have someone
>>> not from Google observing it?
>>>
>>> (*) emulating PWM using blink trigger counts as "crazy" :-)
>>
>> How about adding CONFIG_LED_TRIGGERS_HR_TIMER_SUPPORT, guarding the
>> hr timer support in triggers (timer trigger could also benefit from it)
>> with it, and adding "(EXPERIMENTAL)" tag to the config description?
> 
> Why would we want to add code in the LED subsystem that is useless for
> LEDs?

It could be used for software pwm trigger, there has been at least one
an attempt to add such [0].

[0] https://lkml.org/lkml/2015/4/27/493
-- 
Best regards,
Jacek Anaszewski
