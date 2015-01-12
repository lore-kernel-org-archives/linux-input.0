From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 4/9] ARM: dts: sun7i: cubieboard2: add axp209 regulator nodes
Date: Mon, 12 Jan 2015 17:38:12 +0800
Message-ID: <CAGb2v66r6EG2F1-=Gaig7ZW58Z1KteQ5nDPfW5niisv7dCjY0Q@mail.gmail.com>
References: <1421037249-28461-1-git-send-email-wens@csie.org>
 <1421037249-28461-5-git-send-email-wens@csie.org> <20150112090603.GE4891@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150112090603.GE4891@lukather>
Sender: linux-pm-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, Jan 12, 2015 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Mon, Jan 12, 2015 at 12:34:04PM +0800, Chen-Yu Tsai wrote:
>> This patch adds the regulator nodes for the axp209 by including
>> the axp209 dtsi. As the inputs of these regulators are from the
>> axp209's PS output, which is basically just a mux over the 2
>> inputs, it is considered to be unregulated. Thus we do not provide
>> input supply properties for them.
>>
>> The regulator names and constraints are based on the board
>> schematics and the SoC datasheet.
>>
>> DCDC2 is used as the cpu power supply. This patch also references
>> it from the cpu node.
>>
>> Also get rid of axp209 properties already set in axp209.dtsi.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> changes since v2
>>
>>     none
>>
>> changes since v1:
>>
>>     - Use preprocessor include for axp209.dtsi
>>     - Remove incorrectly squashed axp209.dtsi patch
>>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 35 +++++++++++++++++++++++++----
>>  1 file changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> index 18fc5db9c976..ec1fc2c8b3e3 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
>> @@ -88,13 +88,9 @@
>>                       status = "okay";
>>
>>                       axp209: pmic@34 {
>> -                             compatible = "x-powers,axp209";
>>                               reg = <0x34>;
>>                               interrupt-parent = <&nmi_intc>;
>>                               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> -
>> -                             interrupt-controller;
>> -                             #interrupt-cells = <1>;
>>                       };
>>               };
>>
>> @@ -145,3 +141,34 @@
>>               status = "okay";
>>       };
>>  };
>> +
>> +#include "axp209.dtsi"
>> +
>> +&cpu0 {
>> +     cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>> +&reg_dcdc2 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <1000000>;
>> +     regulator-max-microvolt = <1450000>;
>> +     regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc3 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <1000000>;
>> +     regulator-max-microvolt = <1400000>;
>> +     regulator-name = "vdd-int-dll";
>> +};
>> +
>> +&reg_ldo1 {
>> +     regulator-name = "vdd-rtc";
>> +};
>> +
>> +&reg_ldo2 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <3000000>;
>> +     regulator-max-microvolt = <3000000>;
>> +     regulator-name = "avcc";
>> +};
>
> How do reg_vcc3v3 and the other reg used in this DT (ahci, USB) fit
> into that?

The following applies to boards that use AXP209.

reg_vcc3v3 or reg_vcc3v0 is an external buck regulator with it's
enable pin tied to EXTEN on the AXP. This pin is controllable,
but we do not have the driver for it. It is possible that multiple
regulators are tied to this pin. I suggest not touching it without
the correct schematics.

The source for usb and ahci regulators, or reg_vcc5v if you will,
is either the unregulated 5v from the power supply or the usb otg
port. For the Cubietruck, there's an additional uncontrollable
boost regulator that boosts the lipo battery's power up to 5v.

On some of the Olimex boards that use higher input voltages, they
use an uncontrollable buck regulator to step down the voltage to
5v. The Olinuxino-Micro also has a boost regulator for the battery,
tied to EXTEN.

The AXP209 simply does not have enough outputs for all the needed
voltages.

You could probably chain the regulators in the DT via xxx-supply
if it helps. But beyond that, it is hard to do anything meaningful
at this point. Modeling them as fixed regulators beyond our control
is simpler. We also do not have an IPSOUT regulator for the AXP.

> Eventually, I think we would be able to remove
> sunxi-common-regulators.dtsi, or at least, expose the proper regulator
> hierarchy.

The USB and SATA regulators are just GPIO enabled switches (MOSFETs)
or current limiters. I think these will always exist because of the
reference designs. Or do you want to move them back into the board
dts files? FWIW, I like it the way it is now. Not that I don't like
it to be accurate.


ChenYu
