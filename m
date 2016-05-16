From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 0/3] input: rmi4: Regulator supply support
Date: Mon, 16 May 2016 16:55:51 -0700
Message-ID: <573A5E07.4010500@synaptics.com>
References: <1462596008-21381-1-git-send-email-bjorn.andersson@linaro.org>
 <57312CFB.2040304@synaptics.com> <20160510154904.GI1256@tuxbot>
 <5733C088.1090700@synaptics.com> <20160512030524.GA1256@tuxbot>
 <57352536.7040909@synaptics.com> <20160513222948.GD1256@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160513222948.GD1256@tuxbot>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 05/13/2016 03:29 PM, Bjorn Andersson wrote:
> On Thu 12 May 17:52 PDT 2016, Andrew Duggan wrote:
>
>> On 05/11/2016 08:05 PM, Bjorn Andersson wrote:
>>> On Wed 11 May 16:30 PDT 2016, Andrew Duggan wrote:
>>>
>>>> Hi Bjorn,
>>>>
>>>> On 05/10/2016 08:49 AM, Bjorn Andersson wrote:
>>> [..]
>>>>> So either we duplicate the regulator support in spi/i2c or we make them
>>>>> optional in the core driver. Sounds like you prefer the prior, i.e. v1
>>>>> of my patch.
>>>> Yes, after all this I think it makes sense to put regulator support in the
>>>> spi/i2c transports like in your v1 patch. I essentially duplicated the irq
>>>> handling code in both transports so I would be ok with duplicating regulator
>>>> support too. It doesn't seem like that much code. But, if this is too much
>>>> duplication we could create some sort of common file and put the common irq
>>>> and regulator support functions which could be called in the transports.
>>>> Similar to how rmi_2d_sensor.c defines some common functions shared between
>>>> rmi_f11 and rmi_f12.
>>>>
>>> Sounds reasonable, I'm okay with this. Did you have any comments on the
>>> implementation I had in v1?
>> I tested on a device which has an always on regulators so I didn't add
>> anything to device tree for the device. But, it returned 0 when it didn't
>> find anything which seems to be the correct behavior. Is there an easy way
>> to avoid sleeping for 10ms when there are no regulators? Maybe check if both
>> the supplies .consumer pointer is null?
>>
> I did look at this as well, but unfortunately the regulators does not
> come back as NULL, but rather as dummy regulators.
>
> The delay matches Tpowerup (iirc) from the data sheet, which I assume is
> firmware/hardware dependant. Should we provide a knob for that and
> default the sleep to 0ms?

Making  the default 0 and then setting an appropriate time out for 
devices which need it sounds like a good idea to me.

Thanks,
Andrew

> Regards,
> Bjorn
