From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: Re: [PATCH v7 1/6] mfd: AXP20x: Add bindings documentation
Date: Wed, 3 Dec 2014 18:05:56 +0800
Message-ID: <CAGb2v67dMVFgNjU95vaQ842BuNSK2AzhTiYTn_EoKjFEn5g1kA@mail.gmail.com>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
 <1404066237-20234-2-git-send-email-carlo@caione.org> <20140630094854.GY7262@leverpostej>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBGOB7ORQKGQEQGDJ3YI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140630094854.GY7262@leverpostej>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Mark,

I'm (hopefully) picking up the work for this series.

On Mon, Jun 30, 2014 at 5:48 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Sun, Jun 29, 2014 at 07:23:52PM +0100, Carlo Caione wrote:
>> Bindings documentation for the AXP20x driver. In this file also
>> sub-nodes are documented.
>>
>> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/axp20x.txt | 93 ++++++++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
>> new file mode 100644
>> index 0000000..cc9e01b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
>> @@ -0,0 +1,93 @@
>> +AXP202/AXP209 device tree bindings
>> +
>> +The axp20x family current members :-
>> +axp202 (X-Powers)
>> +axp209 (X-Powers)
>> +
>> +Required properties:
>> +- compatible: "x-powers,axp202" or "x-powers,axp209"
>> +- reg: The I2C slave address for the AXP chip
>> +- interrupt-parent: The parent interrupt controller
>> +- interrupts: Interrupt specifiers for interrupt sources
>
> How many, what are they?

Now reads: SoC external interrupt / NMI connected to the PMIC's IRQ pin

>> +- interrupt-controller: axp20x has its own internal IRQs
>> +- #interrupt-cells: Should be set to 1
>> +- acin-supply: The input supply for LDO1
>> +- vin2-supply: The input supply for DCDC2
>> +- vin3-supply: The input supply for DCDC3
>> +- ldo24in-supply: The input supply for LDO2, LDO4
>> +- ldo3in-supply: The input supply for LDO3
>> +- ldo5in-supply: The input supply for LDO5
>> +
>> +- regulators: A node that houses a sub-node for each regulator. The regulators are
>> +           bound using their name as listed here: dcdc2, dcdc3, ldo1, ldo2,
>> +           ldo3, ldo4, ldo5.  The bindings details of individual regulator
>> +           device can be found in:
>> +           Documentation/devicetree/bindings/regulator/regulator.txt with
>> +           the exception of x-powers,dcdc-freq
>> +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
>> +                   (range: 750-1875). Default: 1.5MHz
>> +
>> +Optional properties for DCDCs:
>> +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
>> +                       Default: AUTO mode
>
> When would I want to select PWM mode, and why should this be in the DT?

Expanded description:

"""
The DCDC regulators work in a mixed PWM/PFM mode,
using PFM under light loads and switching to PWM
for heavier loads. Forcing PWM mode trades efficiency
under light loads for lower output noise. This
probably makes sense for HiFi audio related
applications that aren't battery constrained.
"""

As I'm not an electronics person, I really can't say under
what circumstances one would force the PMIC into PWM mode.
The expanded description is an educated guess based on
research on the internet about PWM and PFM.

I think it makes sense to put this in the DT. The vendor
building the board/DT is in the best position to know the
constraints and requirements of the board, and can decide
whether the trade off makes sense. As for the boards/DTs
already out there, we can just leave it in auto mode.


Regards
ChenYu
