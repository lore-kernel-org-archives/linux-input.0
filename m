From: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] input: pwm-beeper: add feature to set volume level
Date: Fri, 17 Feb 2017 11:01:47 +0100
Message-ID: <4e1df881-0183-933e-4443-601729700f0c@exceet.de>
References: <0e2dec4d-7550-9495-f12a-020391183304@exceet.de>
 <cover.1484838551.git.frieder.schrempf@exceet.de>
 <20170119213700.GC13542@dtor-ws>
 <43679b65-8710-4255-2006-8c47dd755497@lechnology.com>
 <fddaa3de-81a3-1078-65ac-29503419f1e6@exceet.de>
 <5fc04e9d-7a92-2a34-e9cc-679106481e32@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5fc04e9d-7a92-2a34-e9cc-679106481e32-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 16.02.2017 22:44, David Lechner wrote:
> On 02/16/2017 03:15 PM, Frieder Schrempf wrote:
>> Hello David,
>>
>> On 20.01.2017 20:11, David Lechner wrote:
>>> On 01/19/2017 03:37 PM, Dmitry Torokhov wrote:
>>>> On Thu, Jan 19, 2017 at 04:24:07PM +0100, Frieder Schrempf wrote:
>>>>> Make the driver accept switching volume levels via sysfs.
>>>>> This can be helpful if the beep/bell sound intensity needs
>>>>> to be adapted to the environment of the device.
>>>>>
>>>>> The number of volume levels available and their values can
>>>>> be specified via device tree (similar to pwm-backlight).
>>>>>
>>>>> The volume adjustment is done by changing the duty cycle of
>>>>> the pwm signal.
>>>>
>>>> I wonder how this all will mesh up with beepers that have dedicated
>>>> amplifiers (support is being added by David Lechner).
>>>
>>> This will work very well with it. I fact, it is a feature I would like
>>> to have but I was not sure about a good way to implement it. Please Cc:
>>> me on future revisions of this series and I will be glad to test it.
>>
>> I have just send v4.
>>>
>>> One thing that would be nice would be for a more generic way to change
>>> the volume from userspace. Having a sysfs attribute on the platform
>>> device will work, but it requires very specific knowledge from any
>>> userspace program that wants to control the volume. Would it be possible
>>> to add an alsa mixer volume control or something like that?
>>
>> An alsa mixer control for the pwm-beeper volume sounds nice, but
>> unfortunately I have no idea how one would implement this, or if this is
>> even possible.
>>>
>
>
> I know it is possible because I have done it. ;-)
>
> https://github.com/ev3dev/lego-linux-drivers/blob/master/evb/evb_sound.c
>
> The driver in the link above does PCM playback using PWM. But, it also
> included an input device similar to pwm-beeper and it includes an ALSA
> volume control specifically for the beeper.

Aha, thanks. Doesn't look too complicated. I think I will play with this 
a bit, when I have time. So maybe the sysfs volume control can be 
replaced with a proper volume mixer control at some point.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
