From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: Vibrations in input vs. LED was Re: [PATCH v2 0/3] led:
 ledtrig-transient: add support for hrtimer
Date: Fri, 6 Oct 2017 22:57:45 +0200
Message-ID: <96525800-9dcf-da40-c4c8-a1e86da2c52f@gmail.com>
References: <CAKdAkRTJTYsJuAsjOt2Bgutsg6zwhU0LHmNOH9UXsHB3PkLCbw@mail.gmail.com>
 <7a611993-ebaa-08bb-b10c-ebe4fb9ca33a@gmail.com>
 <CAKdAkRT4MBKq-g9BfMVRENcTeoYRL+nvWfEtf578ySXmxap-Cg@mail.gmail.com>
 <0076adca-f843-f99f-09ce-b9839b3e7706@gmail.com> <20170917182251.GA15328@amd>
 <9d5d045e-5019-e132-9449-7fb40b1b7895@gmail.com>
 <CAKdAkRRsn+bV34yq9=Qqnp3D+DjWtGfrLAmF6pJCgvbyBqz2Cw@mail.gmail.com>
 <4226b524-35e1-16c0-f6ca-e339dd2eab1d@gmail.com> <20170920112940.GB4283@amd>
 <78217fe0-b61d-249c-bf30-787642317255@gmail.com> <20171006114859.GE9497@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171006114859.GE9497@amd>
Sender: linux-doc-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Lin <dtwlin@google.com>, Jonathan Corbet <corbet@lwn.net>, Richard Purdie <rpurdie@rpsys.net>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 10/06/2017 01:48 PM, Pavel Machek wrote:
> On Wed 2017-09-20 22:08:42, Jacek Anaszewski wrote:
>> On 09/20/2017 01:29 PM, Pavel Machek wrote:
>>>>>>> I'd leave the decision to the user. We could add a note to the
>>>>>>> Documentation/leds/ledtrig-transient.txt that force feedback interface
>>>>>>> should be preferable choice for driving vibrate devices.
>>>>>>> However only if following conditions are met:
>>>>>>
>>>>>> What I meant is that it is my decision, as a LED subsystem maintainer,
>>>>>> to accept the addition of a note about some other subsystem offering
>>>>>> an equivalent or even better substitute of the feature being available
>>>>>> in the subsystem I am responsible for. And I will accept such a patch
>>>>>> only if mentioned conditions are met.
>>>>>
>>>>> Having the wording in documentation does not in any way stops Android
>>>>> folks from continuing [ab]using the transient trigger. But this is
>>>>> their choice. The purpose of documentation is to document the best
>>>>> practices, not all possible crazy solutions one can come up with.
>>>>
>>>> Yes. but if the information has been in place for years, we can't
>>>> just remove it without giving an instruction on how to use the
>>>> substitute.
>>>
>>> I gave you information how to use the substitute.
>>
>> That information was quite vague. I'd like to see a sample application
>> in tools/input.
> 
> So please write it.

This is my demand as a reviewer. I've already laid out the conditions
under which I'll accept the patch. It seems that you're proficient
in the subject enough to cope with this task.

>>> I already suggested patch to documentation. If you do the same, maybe
>>> we can agree on documentation update.
>>
>> Your patch was just removing few lines of documentation. I'd expect more
>> empathic approach to the current users, i.e.:
>>
>> - pointer to the sample application in tools/input showing how to
>>   setup gpio driven vibrate device with use of ff interface with
>>   1kHz vibration frequency.
> 
> Yes, my patch is removing dangerously misleading documentation about
> LED subsystem.

It's neither dangerous nor misleading.

> Please apply it.

Right after I'll get the patch with the tool showing how to use
input subsystem to achieve the same effect as with use of
ledtrig-transient.

-- 
Best regards,
Jacek Anaszewski
