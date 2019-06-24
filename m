From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: input: Add support for the MPR121
 without interrupt line
Date: Mon, 24 Jun 2019 14:56:35 +0200
Message-ID: <69302603-f1a3-8955-7d90-74a290071794@ysoft.com>
References: <1558098773-47416-1-git-send-email-michal.vokac@ysoft.com>
 <1558098773-47416-2-git-send-email-michal.vokac@ysoft.com>
 <20190613223945.GA938@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613223945.GA938@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On 14. 06. 19 0:39, Rob Herring wrote:
> On Fri, May 17, 2019 at 03:12:50PM +0200, Michal Vokáč wrote:
>> Normally, the MPR121 controller uses separate interrupt line to notify
>> the I2C host that a key was touched/released. To support platforms that
>> can not use the interrupt line, polling of the MPR121 registers can be
>> used.
> 
> 'separate' from what?

"Separate" here is meant like "additional to the standard set of SCL
and SDA I2C lines". Looks like inappropriately used word by
a non-native speaker that can be omitted.

>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>> Changes since v1:
>> - Document the polled binding in the original file, do not create a new one.
>>    (Rob)
>>
>>   Documentation/devicetree/bindings/input/mpr121-touchkey.txt | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/mpr121-touchkey.txt b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
>> index b7c61ee5841b..97f55273d473 100644
>> --- a/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
>> +++ b/Documentation/devicetree/bindings/input/mpr121-touchkey.txt
>> @@ -1,9 +1,14 @@
>> -* Freescale MPR121 Controllor
>> +* Freescale MPR121 Controller
>>   
>>   Required Properties:
>> -- compatible:		Should be "fsl,mpr121-touchkey"
>> +- compatible:		Should be one of:
>> +			- "fsl,mpr121-touchkey" - MPR121 with interrupt line
>> +			- "fsl,mpr121-touchkey-polled" - MPR121 with polling
>>   - reg:			The I2C slave address of the device.
>>   - interrupts:		The interrupt number to the cpu.
>> +			In case of "fsl,mpr121-touchkey-polled" the interrupt
>> +			line is not used and hence the interrupts property is
>> +			not required.
> 
> Absence of the interrupts property is enough to determine polled mode
> and you don't need a separate compatible string.

Would not this work only if the polled mode was implemented as
part of the current driver? I raised this question in the cover letter.
I do not really know how this should be done.

So I implemented the polled mode in a new driver (taking the
gpio-keys-polled as an example). Having separate compatible string is
the only option I know of to match the right driver.

Anyway, Dmitry already commented that his addition of input_polled_dev
for creating polled input devices was not the best choice. He would
rather like to implement polling mode for all regular input devices
and that would allow to enable polling mode in existing drivers.

Since I do not know how to help with that work I am stuck with the
separate driver/compatible string solution.
