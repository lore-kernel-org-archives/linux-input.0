From: Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [RESEND PATCH v2 8/8] Input: sx8654 - convert #defined flags to
 BIT(x)
Date: Tue, 29 Jan 2019 12:23:01 +0100
Message-ID: <50c0a3a5-7039-abc0-9b9e-4314504bcb6f@skidata.com>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218084002.19454-1-richard.leitner@skidata.com>
 <20190129002518.GH34692@dtor-ws>
 <533e48bd35d360cec8d749f3b70425c1eb5e6e9d.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <533e48bd35d360cec8d749f3b70425c1eb5e6e9d.camel@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mark.rutland@arm.com, robh+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Joe,

On 29/01/2019 06:40, Joe Perches wrote:
> On Mon, 2019-01-28 at 16:25 -0800, Dmitry Torokhov wrote:
>> On Tue, Dec 18, 2018 at 09:40:02AM +0100, Richard Leitner wrote:
>>> Some of the #defined register values are one-bit flags. Convert them to
>>> use the BIT(x) macro instead of 1 byte hexadecimal values. This improves
>>> readability and clarifies the intent.
>>>
>>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>>
>> Applied, thank you.
> 
> Not so sure this should be applied.
> 
>>> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> []
>>> @@ -46,7 +47,7 @@
> []
>>>   /* bits for I2C_REG_IRQSRC */
>>> -#define IRQ_PENTOUCH_TOUCHCONVDONE	0x08
>>> -#define IRQ_PENRELEASE			0x04
>>> +#define IRQ_PENTOUCH_TOUCHCONVDONE	BIT(7)
>>> +#define IRQ_PENRELEASE			BIT(6)
> 
> Shouldn't this be BIT(3) and BIT(2)
> or did you mean to change the values too?
> 
> If so, this change should be noted in the commit message.
> 

That's true, those values should stay the same. Thanks for the catch!

@Dimitry: Should I send an updated version or do you fix it yourself?

regards;Richard.L
