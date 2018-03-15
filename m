From: Tirupathi Reddy T <tirupath@codeaurora.org>
Subject: Re: [PATCH V2] Input: pm8941-pwrkey: add resin key capabilities
Date: Thu, 15 Mar 2018 13:40:07 +0530
Message-ID: <6caabfde-6b90-555e-9afe-240bf35dfc9d@codeaurora.org>
References: <1520930158-5854-1-git-send-email-tirupath@codeaurora.org>
 <20180314024048.GA11034@tuxbook-pro> <20180314164346.GA74407@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314164346.GA74407@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,


On 3/14/2018 10:13 PM, Dmitry Torokhov wrote:
> On Tue, Mar 13, 2018 at 07:40:48PM -0700, Bjorn Andersson wrote:
>> On Tue 13 Mar 01:35 PDT 2018, Tirupathi Reddy wrote:
>>
>>> Add resin key support to handle different types of key events
>>> defined in different platforms.
>>>
>>> Signed-off-by: Tirupathi Reddy <tirupath@codeaurora.org>
>>> ---
>>>   .../bindings/input/qcom,pm8941-pwrkey.txt          | 20 ++++++-
>>>   drivers/input/misc/pm8941-pwrkey.c                 | 65 +++++++++++++++++++++-
>>>   2 files changed, 83 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>>> index 07bf55f..f499cf8 100644
>>> --- a/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>>> @@ -20,6 +20,14 @@ PROPERTIES
>>>   		    defined by the binding document describing the node's
>>>   		    interrupt parent.
>>>   
>>> +- interrupt-names:
>>> +	Usage: required
>>> +	Value type: <stringlist>
>>> +	Definition: Interrupt names.  This list must match up 1-to-1 with the
>>> +		    interrupts specified in the 'interrupts' property. "kpdpwr"
>>> +		    must be specified and should be the first entry of the list.
>>> +		    "resin" may be specified for some platforms.
>>> +
>>>   - debounce:
>>>   	Usage: optional
>>>   	Value type: <u32>
>>> @@ -32,12 +40,22 @@ PROPERTIES
>>>   	Definition: presence of this property indicates that the KPDPWR_N pin
>>>   		    should be configured for pull up.
>>>   
>>> +- linux,code:
>>> +	Usage: required for "resin" key
>>> +	Value type: <u32>
>>> +	Definition: The input key-code associated with the resin key.
>>> +		    Use the linux event codes defined in
>>> +		    include/dt-bindings/input/linux-event-codes.h
>> For completeness sake I think this should list both the key code for the
>> power key and for the RESIN key.
Then it breaks existing DT nodes.
Since pwrkey functionality is fixed across platforms, "linux,code"
specification through device tree is not required for it.
>>> +
>>>   EXAMPLE
>>>   
>>>   	pwrkey@800 {
>>>   		compatible = "qcom,pm8941-pwrkey";
>>>   		reg = <0x800>;
>>> -		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>>> +		interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>,
>>> +			     <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
>>> +		interrupt-names = "kpdpwr", "resin";
>>>   		debounce = <15625>;
>>>   		bias-pull-up;
>> Do we need to support defining the bias for the resin as well?
Good point, will add this support in Patch V3. Also, the debounce 
configuration
in HW is common across power-key and resin.
>>
>> Perhaps it makes more sense to describe the RESIN key with a separate
>> compatible and define that in a node of its own (we can still implement
>> this in the same driver - if there's any chance of reuse...).
The PMIC peripheral/module called PON(Power  on) generates these key events.
Pwrkey(KPDPWR_N) is the primary supported key by this module, the others are
optional. The resin may be supported a "defined" key. How about using 
the below
logic for resin key without breaking the existing DTs as shown below:

     pwrkey@800 {
            compatible = "qcom,pm8941-pwrkey";
            reg = <0x800>;
            interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
            debounce = <15625>;
            bias-pull-up;

            resin {
                    interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
                    linux,code = <KEY_VOLUMEDOWN>;
                    bias-pull-up;
            };
     };

>>> +		linux,code = <KEY_VOLUMEDOWN>;
>>>   	};
>>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>>> index 18ad956..2fffc7c 100644
>>> --- a/drivers/input/misc/pm8941-pwrkey.c
>>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>>> @@ -28,6 +28,7 @@
>>>   
>>>   #define PON_RT_STS			0x10
>>>   #define  PON_KPDPWR_N_SET		BIT(0)
>>> +#define  PON_RESIN_N_SET		BIT(1)
>>>   
>>>   #define PON_PS_HOLD_RST_CTL		0x5a
>>>   #define PON_PS_HOLD_RST_CTL2		0x5b
>>> @@ -46,6 +47,7 @@
>>>   struct pm8941_pwrkey {
>>>   	struct device *dev;
>>>   	int irq;
>>> +	u32 resin_key_code;
>>>   	u32 baseaddr;
>>>   	struct regmap *regmap;
>>>   	struct input_dev *input;
>>> @@ -130,6 +132,24 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
>>>   	return IRQ_HANDLED;
>>>   }
>>>   
>>> +static irqreturn_t pm8941_resinkey_irq(int irq, void *_data)
>>> +{
>>> +	struct pm8941_pwrkey *pwrkey = _data;
>>> +	unsigned int sts;
>>> +	int error;
>>> +
>>> +	error = regmap_read(pwrkey->regmap,
>>> +			    pwrkey->baseaddr + PON_RT_STS, &sts);
>> This needs to be broken because the line is 81 chars long, if you use a
>> shorter name for the return value (e.g. "ret") you don't need to do
>> this.
> I prefer keeping it as "error" please.
Okay. I will keep it as "error".
>>> +	if (error)
>>> +		return IRQ_HANDLED;
>>> +
>>> +	input_report_key(pwrkey->input, pwrkey->resin_key_code,
>>> +			 !!(sts & PON_RESIN_N_SET));
>> Put pwrkey->resin_key_code in a local variable named "key" (or even
>> key_code) and you don't need to line wrap this one.
Okay. I will address it in Patch V3.
>>> +	input_sync(pwrkey->input);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>> Regards,
>> Bjorn
