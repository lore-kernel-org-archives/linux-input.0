From: David Lechner <david@lechnology.com>
Subject: Re: [v2] Input: pwm-beeper: support customized freq for SND_BELL
Date: Mon, 27 Feb 2017 23:30:21 -0600
Message-ID: <b08d4e74-c086-304a-d6cf-ace8d2a372f7@lechnology.com>
References: <1487579863-7256-1-git-send-email-hs@denx.de>
 <06af466d-ac78-ea38-77d2-3bf32a6e157c@lechnology.com>
 <58B5084A.9000709@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58B5084A.9000709@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: hs@denx.de
Cc: linux-input@vger.kernel.org, Guan Ben <ben.guan@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On 02/27/2017 11:19 PM, Heiko Schocher wrote:
> Hello David,
>
> Am 27.02.2017 um 19:11 schrieb David Lechner:
>> On 02/20/2017 02:37 AM, Heiko Schocher wrote:
>>> From: Guan Ben <ben.guan@cn.bosch.com>
>>>
>>> extend the pwm-beeper driver to support customized frequency
>>> for SND_BELL from device tree.
>>>
>>> Signed-off-by: Guan Ben <ben.guan@cn.bosch.com>
>>> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
>>> [hs@denx.de: adapted to 4.10-rc7]
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>> ---
>>>
>>> Changes in v2:
>>> - add comment from Rob Herring:
>>>   rename property name "bell-frequency" to "beeper-hz"
>>
>> Is there a separate patch for the devicetree bindings documentation?
>
> No, it is in this patch ... In the meantime I got an
> Acked-by from Rob Herring ...
>

What I should have said is that, in general, I think it is preferred to 
have the device tree bindings as a separate patch from the code changes.
