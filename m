From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 0/3] input: rmi4: Regulator supply support
Date: Wed, 11 May 2016 16:30:16 -0700
Message-ID: <5733C088.1090700@synaptics.com>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
 <57312CFB.2040304@synaptics.com> <20160510154904.GI1256@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:44693 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbcEKXaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2016 19:30:17 -0400
In-Reply-To: <20160510154904.GI1256@tuxbot>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Bjorn,

On 05/10/2016 08:49 AM, Bjorn Andersson wrote:
> On Mon 09 May 17:36 PDT 2016, Andrew Duggan wrote:
>
>> Hi Bjorn,
>>
>> On 05/06/2016 09:40 PM, Bjorn Andersson wrote:
>>> The first version of the regulator support patch suffered from being
>>> implemented in the transport driver, as a work around for resource availability
>>> racing (EPROBE_DEFER of the core driver) with the interrupt handler.
>>>
>>> After reconsidering the solutions discussed following that I concluded that the
>>> interrupt management is not really part of the transport, neither conceptually
>>> or electrically. I therefor here suggest (patch 1/3) to move the interrupt
>>> registration and handling to the core rmi driver.
>> My concern with moving interrupt processing to the core is that not all
>> transports report attn to the rmi core using an irq. The HID and SMBus
>> transports which are currently in development, reside a little higher in the
>> stack and attention is reported using different mechanisms. We moved
>> interrupt handling to the transport drivers so that they could handle the
>> differences in how attn is reported.
>>
> I suspected that to be the case.
>
>> This message has some of the previous discussion regarding interrupt
>> processing:
>> https://lkml.org/lkml/2015/11/28/123
>>
>> Similarly, not all transports will need support for regulators. Implementing
>> both in the transport drivers avoids the EPROBE_DEFER racing and avoids
>> adding checks in the core to see if it needs to handle interrupts and manage
>> regulators.
>>
> So either we duplicate the regulator support in spi/i2c or we make them
> optional in the core driver. Sounds like you prefer the prior, i.e. v1
> of my patch.

Yes, after all this I think it makes sense to put regulator support in 
the spi/i2c transports like in your v1 patch. I essentially duplicated 
the irq handling code in both transports so I would be ok with 
duplicating regulator support too. It doesn't seem like that much code. 
But, if this is too much duplication we could create some sort of common 
file and put the common irq and regulator support functions which could 
be called in the transports. Similar to how rmi_2d_sensor.c defines some 
common functions shared between rmi_f11 and rmi_f12.


Thanks,
Andrew

> Regards,
> Bjorn

