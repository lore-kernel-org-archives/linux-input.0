From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] Input: tsc2004 - Document ts2004 dt bindings
Date: Tue, 3 Nov 2015 09:31:10 -0600
Message-ID: <CAL_JsqKb0ms5syf6oTkEw6BGt0nUeqg6=Sm4Zd-5pH9JPrqLiQ@mail.gmail.com>
References: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
 <1446252086-24334-5-git-send-email-mwelling@ieee.org> <CAL_JsqKpbrWcHj4eubWMAjtVRHE8TTN_qC5S=J7qzcf8khpzng@mail.gmail.com>
 <20151102205028.GA2571@deathstar> <20151103072124.GA33601@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151103072124.GA33601@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Nov 3, 2015 at 1:21 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Nov 02, 2015 at 02:50:29PM -0600, Michael Welling wrote:
>> On Mon, Nov 02, 2015 at 09:19:50AM -0600, Rob Herring wrote:
>> > > +Required properties:
>> > > + - compatible                : "ti,tsc2004"
>> > > + - interrupts                : IRQ specifier
>> > > + - vio-supply                 : Regulator specifier
>> >
>> > reg property?
>>
>> Rob,
>>
>> It appears that I missed this in the description.
>>
>> Probably because I was following the lead of the ts2005 description.
>>
>> How does this look:
>> - reg                 : I2C address. 0x48 - 0x4b based on the voltage applied to
>>                         the AD1 and AD0 inputs on the IC.
>>
>
> How about the version below?
>
> Thanks.
>
> --
> Dmitry
>
>
> Input: tsc2004 - document ts2004 dt bindings
>
> From: Michael Welling <mwelling@ieee.org>
>
> Adds documentation for the devicetree bindings of the new tsc2004 driver.
>
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/input/touchscreen/tsc2005.txt         |   34 ++++++++++++++++----
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> index 09089a6..b80c04b 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt
> @@ -1,14 +1,15 @@
> -* Texas Instruments tsc2005 touchscreen controller
> +* Texas Instruments tsc2004 and tsc2005 touchscreen controllers
>
>  Required properties:
> - - compatible                : "ti,tsc2005"
> - - reg                       : SPI device address
> - - spi-max-frequency         : Maximal SPI speed
> + - compatible                : "ti,tsc2004" or "ti,tsc2005"
> + - reg                       : Device address
>   - interrupts                : IRQ specifier
> - - reset-gpios               : GPIO specifier
> - - vio-supply                 : Regulator specifier
> + - spi-max-frequency         : Maximum SPI clocking speed of the device
> +                               (for tsc2005)
>
>  Optional properties:
> + - vio-supply                : Regulator specifier
> + - reset-gpios               : GPIO specifier for the controller reset line
>   - ti,x-plate-ohms           : integer, resistance of the touchscreen's X plates
>                                 in ohm (defaults to 280)
>   - ti,esd-recovery-timeout-ms : integer, if the touchscreen does not respond after
> @@ -18,6 +19,27 @@ Optional properties:
>
>  Example:
>
> +&i2c3 {
> +       tsc2004@48 {
> +               compatible = "ti,tsc2004";
> +               reg = <0x48>;
> +               vio-supply = <&vio>;
> +
> +               reset-gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;
> +               interrupts-extended = <&gpio1 27 IRQ_TYPE_EDGE_RISING>;
> +
> +               touchscreen-fuzz-x = <4>;
> +               touchscreen-fuzz-y = <7>;
> +               touchscreen-fuzz-pressure = <2>;
> +               touchscreen-size-x = <4096>;
> +               touchscreen-size-y = <4096>;
> +               touchscreen-max-pressure = <2048>;
> +
> +               ti,x-plate-ohms = <280>;
> +               ti,esd-recovery-timeout-ms = <8000>;
> +       };
> +}
> +
>  &mcspi1 {
>         tsc2005@0 {
>                 compatible = "ti,tsc2005";
