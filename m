From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Sat, 3 May 2014 14:21:06 +0200
Message-ID: <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
	<1398947374-3115-9-git-send-email-carlo@caione.org>
	<20140503010936.GF4090@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBM56SONQKGQE3EAZSGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140503010936.GF4090@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, May 3, 2014 at 3:09 AM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi,
>
> On Thu, May 01, 2014 at 02:29:34PM +0200, Carlo Caione wrote:
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 58 ++++++++++++++++++++++
>>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 58 ++++++++++++++++++++++
>>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 64 ++++++++++++++++++++++++
>>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 58 ++++++++++++++++++++++
>>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 65 +++++++++++++++++++++++++
>>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 64 ++++++++++++++++++++++++
>>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 58 ++++++++++++++++++++++
>>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 59 ++++++++++++++++++++++
>>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 59 ++++++++++++++++++++++
>>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 ++++++++++++++++++++++
>>  10 files changed, 602 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> index fa746aea..57d3fb4 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> @@ -88,6 +88,56 @@
>>                       pinctrl-names = "default";
>>                       pinctrl-0 = <&i2c0_pins_a>;
>>                       status = "okay";
>> +
>> +                     axp209: pmic@34 {
>> +                             compatible = "x-powers,axp209";
>> +                             reg = <0x34>;
>> +                             interrupts = <0>;
>> +
>> +                             interrupt-controller;
>> +                             #interrupt-cells = <1>;
>> +
>> +                             acin-supply = <&reg_axp_ipsout>;
>> +                             vin2-supply = <&reg_axp_ipsout>;
>> +                             vin3-supply = <&reg_axp_ipsout>;
>> +                             ldo24in-supply = <&reg_axp_ipsout>;
>> +                             ldo3in-supply = <&reg_axp_ipsout>;
>> +                             ldo5in-supply = <&reg_axp_ipsout>;
>> +
>> +                             regulators {
>> +                                     x-powers,dcdc-freq = <1500>;
>> +
>> +                                     axp_vcore_reg: dcdc2 {
>> +                                             regulator-min-microvolt = <700000>;
>> +                                             regulator-max-microvolt = <2275000>;
>> +                                             regulator-always-on;
>> +                                     };
>> +
>> +                                     axp_ddr_reg: dcdc3 {
>> +                                             regulator-always-on;
>> +                                     };
>> +
>> +                                     axp_rtc_reg: ldo1 {
>> +                                             regulator-always-on;
>> +                                     };
>> +
>> +                                     axp_analog_reg: ldo2 {
>> +                                             regulator-always-on;
>> +                                     };
>> +
>> +                                     axp_pll_reg: ldo3 {
>> +                                             regulator-always-on;
>> +                                     };
>> +
>> +                                     axp_hdmi_reg: ldo4 {
>> +                                             regulator-always-on;
>> +                                     };
>> +
>> +                                     axp_mic_reg: ldo5 {
>> +                                             regulator-always-on;
>
> Do all these regulators need to be always on? It makes sense for the
> pll and vcore, but I don't get why the mic and hdmi regulators need
> this.

I did this way because I don't have the schematics for all the board
so I thought it was safer to leave all the regulators enabled

-- 
Carlo Caione
