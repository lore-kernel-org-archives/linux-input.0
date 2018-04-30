From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx
 vibrator documentation
Date: Mon, 30 Apr 2018 16:06:18 +0800
Message-ID: <CAMz4kuJfjMkGSOU_E6eO0TV3mK7UZhfA0yQPqYa6Ffa0K+xp8Q@mail.gmail.com>
References: <e2f85ec0b1fb66baa41dd85bb31e8113e23c704b.1524733425.git.baolin.wang@linaro.org>
 <20180427145116.rhjs5vqg6czdexee@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427145116.rhjs5vqg6czdexee@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, xiaotong.lu@spreadtrum.com
List-Id: linux-input@vger.kernel.org

Hi Rob,

On 27 April 2018 at 22:51, Rob Herring <robh@kernel.org> wrote:
> On Thu, Apr 26, 2018 at 05:12:33PM +0800, Baolin Wang wrote:
>> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>
>> This patch adds the binding documentation for Spreadtrum SC27xx series
>> vibrator device.
>>
>> Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v2:
>>  - No updates.
>>
>> Changes since v1:
>>  - No updates.
>> ---
>>  .../bindings/input/sprd,sc27xx-vibra.txt           |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
>> new file mode 100644
>> index 0000000..92ead29
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
>> @@ -0,0 +1,12 @@
>> +Spreadtrum SC27xx PMIC Vibrator
>> +
>> +Required properties:
>> +- compatible: should be "sprd,sc27xx-vibrator".
>> +- reg: address of vibrator control register.
>> +
>> +Example :
>> +
>> +vibrator@eb4 {
>> +     compatible = "sprd,sc27xx-vibrator";
>> +     reg = <0xeb4>;
>
> What bus is this on? A mmio bus needs a length. Is this part of some
> other block?
>

It's on one PMIC bus mapped by regmap-spi. Will add the PMIC part in
next version:

sc2731_pmic: pmic@0 {
        compatible = "sprd,sc2731";
        reg = <0>;
        spi-max-frequency = <26000000>;
        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
        interrupt-controller;
        #interrupt-cells = <2>;
        #address-cells = <1>;
        #size-cells = <0>;

        vibrator@eb4 {
                compatible = "sprd,sc27xx-vibrator";
                reg = <0xeb4>;
        };
};

Is that OK for you? Thanks.

-- 
Baolin.wang
Best Regards
