From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] Input: pwm-beeper: support customized freq for SND_BELL
Date: Mon, 13 Feb 2017 07:12:09 +0100
Message-ID: <58A14E39.40905@denx.de>
References: <1486444894-18321-1-git-send-email-hs@denx.de>
 <20170210154833.lefb7m4gnxnvvcxo@rob-hp-laptop>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170210154833.lefb7m4gnxnvvcxo@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-input@vger.kernel.org, Guan Ben <ben.guan@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

Hello Rob,

Am 10.02.2017 um 16:48 schrieb Rob Herring:
> On Tue, Feb 07, 2017 at 06:21:34AM +0100, Heiko Schocher wrote:
>> From: Guan Ben <ben.guan@cn.bosch.com>
>>
>> extend the pwm-beeper driver to support customized frequency
>> for SND_BELL from device tree.
>>
>> Signed-off-by: Guan Ben <ben.guan@cn.bosch.com>
>> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
>> [hs@denx.de: adapted to 4.10-rc7]
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>
>> ---
>>
>>   .../devicetree/bindings/input/pwm-beeper.txt       |  3 ++
>>   drivers/input/misc/pwm-beeper.c                    | 36 ++++++++++++++++------
>>   2 files changed, 30 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>> index be332ae..438c6e0 100644
>> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
>> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
>> @@ -5,3 +5,6 @@ Registers a PWM device as beeper.
>>   Required properties:
>>   - compatible: should be "pwm-beeper"
>>   - pwms: phandle to the physical PWM device
>> +
>> +optional properties:
>> +- bell-frequency:  bell frequency in Hz
>
> Needs a unit suffix:
> bell-frequency-hz or just bell-hz as hz implies frequency.
>
> Or maybe beeper-hz would be more consistant.

Ok, I change it to "beeper-hz". Are this all issues with this patch?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
