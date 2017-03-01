From: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
Subject: Re: [v2] Input: pwm-beeper: support customized freq for SND_BELL
Date: Wed, 1 Mar 2017 06:05:11 +0100
Message-ID: <58B65687.3090801@denx.de>
References: <1487579863-7256-1-git-send-email-hs@denx.de>
 <06af466d-ac78-ea38-77d2-3bf32a6e157c@lechnology.com>
 <58B5084A.9000709@denx.de>
 <b08d4e74-c086-304a-d6cf-ace8d2a372f7@lechnology.com>
 <58B51517.4050003@denx.de> <F4017B97-7994-4F44-8345-A1A6C3A14777@gmail.com>
Reply-To: hs-ynQEQJNshbs@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F4017B97-7994-4F44-8345-A1A6C3A14777-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guan Ben <ben.guan-dUNdQdTMQaZWk0Htik3J/w@public.gmane.org>, Mark Jonas <mark.jonas-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Manfred Schlaegl <manfred.schlaegl-RbZlAiThDcE@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello Dimitry,

Am 28.02.2017 um 07:20 schrieb Dmitry Torokhov:
> On February 27, 2017 10:13:43 PM PST, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org> wrote:
>> Hello David,
>>
>> Am 28.02.2017 um 06:30 schrieb David Lechner:
>>> On 02/27/2017 11:19 PM, Heiko Schocher wrote:
>>>> Hello David,
>>>>
>>>> Am 27.02.2017 um 19:11 schrieb David Lechner:
>>>>> On 02/20/2017 02:37 AM, Heiko Schocher wrote:
>>>>>> From: Guan Ben <ben.guan-dUNdQdTMQaZWk0Htik3J/w@public.gmane.org>
>>>>>>
>>>>>> extend the pwm-beeper driver to support customized frequency
>>>>>> for SND_BELL from device tree.
>>>>>>
>>>>>> Signed-off-by: Guan Ben <ben.guan-dUNdQdTMQaZWk0Htik3J/w@public.gmane.org>
>>>>>> Signed-off-by: Mark Jonas <mark.jonas-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
>>>>>> [hs-ynQEQJNshbs@public.gmane.org: adapted to 4.10-rc7]
>>>>>> Signed-off-by: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - add comment from Rob Herring:
>>>>>>    rename property name "bell-frequency" to "beeper-hz"
>>>>>
>>>>> Is there a separate patch for the devicetree bindings
>> documentation?
>>>>
>>>> No, it is in this patch ... In the meantime I got an
>>>> Acked-by from Rob Herring ...
>>>>
>>>
>>> What I should have said is that, in general, I think it is preferred
>> to have the device tree
>>> bindings as a separate patch from the code changes.
>>
>> I can split this into 2 patches ...
>
> Don't - since Rob already asked DT change you don't need to post to device tree list again and I'll merge them back together since they do not make sense separately.

Ok, I post a v3 with the changes suggested from David and Rob soon,
without splitting.

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
