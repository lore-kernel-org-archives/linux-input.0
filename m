From: hl <hl@rock-chips.com>
Subject: Re: [PATCH v2 2/2] devicetree: i2c-hid: Add reset property
Date: Mon, 6 Nov 2017 09:00:52 +0800
Message-ID: <183df5b3-8e69-4170-eaea-b5d05c5b2c0c@rock-chips.com>
References: <1509418996-25348-1-git-send-email-hl@rock-chips.com>
 <1509418996-25348-2-git-send-email-hl@rock-chips.com>
 <CA+ASDXOG1HA2zS9uEi0n2Tza1iGvM0x1cntCy1haOf01Wb__3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+ASDXOG1HA2zS9uEi0n2Tza1iGvM0x1cntCy1haOf01Wb__3Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org, robh@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On Saturday, November 04, 2017 12:35 PM, Brian Norris wrote:
> On Mon, Oct 30, 2017 at 8:03 PM, Lin Huang <hl@rock-chips.com> wrote:
>> Document a "reset" and "assert-reset-us", it can be used for
>> driver control reset property. And reuse post-power-on-delay-ms
>> for deassert reset delay.
>>
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/input/hid-over-i2c.txt | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
>> index 28e8bd8..6ab0eed 100644
>> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
>> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
>> @@ -31,7 +31,9 @@ device-specific compatible properties, which should be used in addition to the
>>
>>   - vdd-supply: phandle of the regulator that provides the supply voltage.
>>   - post-power-on-delay-ms: time required by the device after enabling its regulators
>> -  before it is ready for communication. Must be used with 'vdd-supply'.
>> +  or deassert reset pin before it is ready for communication.
>> +- reset: phandle of the gpio that provides for hid reset pin.
>> +- assert-reset-us: the device require reset assert time.
> If there was any point in adding the device-specific description
> around "wacom,w9013"...then you should probably mention these
> properties there too. The idea was to document possible properties
> here (where you're adding them already), and to note the property
> names under the devices (or so far, just 1 device) that support them.
> Or IOW, you need an addition like this:
>
>   - compatible:
>     * "wacom,w9013" (Wacom W9013 digitizer). Supports:
>       - vdd-supply
>       - post-power-on-delay-ms
> +    - reset-gpios
> +    - assert-reset-us
  Okay, got it, will fix it next version.
>
> Brian
>
>
>
