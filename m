From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH v2 1/1] Input: gpio_keys - add device tree support for
 interrupt only keys
Date: Thu, 13 Nov 2014 16:47:06 +0530
Message-ID: <54649332.7050001@nvidia.com>
References: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com> <1763965.yCxTDubTPH@wuerfel> <54648EF6.10402@nvidia.com> <1587930.UcHkd3vGmk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1587930.UcHkd3vGmk@wuerfel>
Sender: linux-gpio-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 13 November 2014 04:35 PM, Arnd Bergmann wrote:
> On Thursday 13 November 2014 16:29:02 Laxman Dewangan wrote:
>>
>> Yes, I posted patch for interrupt key on context on key connected to
>> PMIC-Onkey.
>> On PMIC, there is onkey pin input which generates interrupt only when it
>> toggles. So if we have key (power key on our platforms) connected to
>> this pin then we will only get interrupt from PMIC.
>> Instead of implementing full interrupt key driver, I added this support
>> on existing gpio keys.
> So is this code still in place, and do you think it's worthwhile to
> have a DT binding for it?
>
> Could the PMIC register a gpio controller instead?
>
>

This pin is not supported as GPIO and so exporting the functionality 
through GPIO is not feasible until we treat the onkey as GPIO pin 
without actual gpio functionality i..e only interrupt functionality.



