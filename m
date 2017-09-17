From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Sun, 17 Sep 2017 18:41:33 +0200
Message-ID: <9afbd987-b237-24d4-e16a-ddd7fa70766a@gmail.com>
References: <20170913175400.42744-1-dtwlin@google.com>
 <20170913202032.GA30844@amd> <9c75c3a9-4123-c7f3-7725-45ba752d672a@gmail.com>
 <20170914205804.GA24339@amd> <ef3472a0-1e70-e64f-fe11-7fdfd768fc85@gmail.com>
 <20170916015809.GA5072@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20170916015809.GA5072@localhost>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org, David Lin <dtwlin@google.com>, corbet@lwn.net, rpurdie@rpsys.net, hdegoede@redhat.com, gregkh@linuxfoundation.org, robh@kernel.org, romlem@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 09/16/2017 03:58 AM, Pavel Machek wrote:
> Hi!
> 
>>>>>> These patch series add the LED_BRIGHTNESS_FAST flag support for
>>>>>> ledtrig-transient to use hrtimer so that platforms with high-resolution timer
>>>>>> support can have better accuracy in the trigger duration timing. The need for
> ...
>>> If we want to say "lets move all vibrations from input to LED
>>> subsystem"... I don't think that is good idea, but its a valid
>>> discussion. Some good reasons would be needed.
>>>
>>> But having half devices use one interface and half use different one
>>> is just bad... especially when only reason to do it that way is
>>> "David wants to do it that way, android library made a mistake and he
>>> now wants it to propagate to whole world".
>>
>> This is not the only reason. Adding hr_timer support to
>> ledtrig-transient (and similarly to ledtrig-timer) would allow
>> to increase the accuracy and stability of delay_on/delay_off
>> intervals at low values.
>>
>> Do you think such an improvement could be harmful in some way,
>> even if it was made optional?
> 
> Of course, we can make LED timing accurate down to microseconds. It will
> mean increased overhead -- for "improvement" human can not perceive.
> 
> If someone has problems with LED delays not being accurate enough... we
> may want to fix it. But that is not the case here, is it?

AFAIR David was mentioning that the hr_timer support is perceivable

-- 
Best regards,
Jacek Anaszewski
