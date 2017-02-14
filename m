From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] Input: pwm-beeper: support customized freq for SND_BELL
Date: Tue, 14 Feb 2017 06:02:22 +0100
Message-ID: <58A28F5E.1020401@denx.de>
References: <1486444894-18321-1-git-send-email-hs@denx.de>
 <20170207181309.GC38092@dtor-ws>
 <850c2508720a41b3bfb95cd7093433a4@SI-MBX1030.de.bosch.com>
 <20170214042748.GC19688@dtor-ws>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170214042748.GC19688@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "GUAN Ben (ST-FIR/ENG1-Zhu)" <Ben.Guan-dUNdQdTMQaZWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Manfred Schlaegl <manfred.schlaegl-RbZlAiThDcE@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

Am 14.02.2017 um 05:27 schrieb Dmitry Torokhov:
> On Wed, Feb 08, 2017 at 10:11:21AM +0000, Jonas Mark (ST-FIR/ENG1) wrote:
>> Hello Dmitry,
>>
>>>> extend the pwm-beeper driver to support customized frequency
>>>> for SND_BELL from device tree.
>>>
>>> No, SND_BELL is literally SND_TONE @1000Hz. There should be no
>>> customizing. If applications want to use different frequency then should
>>> be using SND_TONE.
>>
>> We are not aiming for an application shortcut here. Instead, changing
>> the bell frequency shall be a system setting. That is, every
>> application which wants to make a bell sound shall use the alternative
>> frequency.
>>
>> The reason why we are deviating from the default 1000 Hz is that on
>> our hardware we are using a loudspeaker which is rated for 2.7 kHz.
>> That is, it will only sound at the specified volume and frequency if
>> you feed it with a 2.7 kHz square wave. If you deviate from it, e.g.
>> by using 1000 Hz, the output will be dim and squeaky. Worst case,
>> SND_BELL would be completely silent on our system. So the only bell
>> sound we can reliably generate on our system has 2.7 kHz.
>
> OK, fair enough. Please address Rob's comments on binding and resend.

Done already, just waited for more comments before sending v2.

> Also I am not sure why you needed to change the switch statement around,
> you only need to replace 1000 with value from the attribute.

Hmm.. the resulting code looks cleaner to me ... First we check all
the reasons for returning an error code, after that, we can do
the functions work ... but I can revert this part ... should I ?

> Oh, and please use device_property_*() API instead of of_*().

Thanks! Good tip, changed.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
