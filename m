From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 2/3] dt-bindings: input: Add document bindings for
 DA7280
Date: Mon, 20 Aug 2018 14:36:07 -0500
Message-ID: <20180820193607.GA17298@bogus>
References: <cover.1534743380.git.Roy.Im@diasemi.com>
 <131d4b001d1da69fc8d82029a91e77a0a126a09b.1534743380.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <131d4b001d1da69fc8d82029a91e77a0a126a09b.1534743380.git.Roy.Im@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 20, 2018 at 02:36:20PM +0900, Roy Im wrote:
> 
> from: Roy Im <roy.im.opensource@diasemi.com>

Looks like this needs to be removed. You should only have 'From' line 
show up when the sender and author emails are different.

> 
> Add device tree binding information for DA7280 haptic driver.
> Example bindings for DA7280 are added.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> v3: Fixed subject format.
> 
> v2: No changes
> 
> 
>  .../devicetree/bindings/input/dlg,da7280.txt       |   91 ++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/dlg,da7280.txt b/Documentation/devicetree/bindings/input/dlg,da7280.txt
> new file mode 100644
> index 0000000..759bcfe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/dlg,da7280.txt
> @@ -0,0 +1,91 @@
> +Dialog Semiconductor DA7280 Haptics bindings
> +
> +Required properties:
> +- compatible: Should be "dlg,da7280".
> +- reg: Specifies the I2C slave address.
> +
> +- interrupt-parent : Specifies the phandle of the interrupt controller to
> +  which the IRQs from DA7280 are delivered to.

interrupt-parent is implied, so you don't need it here.

> +- interrupts: IRQ line info for DA7280.
> +  (See Documentation/devicetree/bindings/interrupt-controller/
> +   interrupts.txt for further information relating to interrupt properties)
> +- dlg,vib-mode:
> +  "LRA-MODE" - Linear Resonance Actuator mode.
> +  "ERM-BAR" - Bar type Eccentric Rotating Mass mode.
> +  "ERM-COIN" - Coin type Eccentric Rotating Mass mode.
> +- dlg,play-mode: choose one in below five modes.
> +  "DRO-MODE" - Direct register override mode.
> +  "PWM-MODE" - PWM data source mode.
> +	In this case, user is able to set duty to 0 ~ 0xffff(0% ~ 100%)
> +  "RTWM-MODE" - Register triggered waveform memory mode.
> +	In this case, when enable this mode the pattern assigned
> +	to the PS_SEQ_ID will be played as much times as PS_SEQ_LOOP.
> +  "ETWM-MODE" - Edge triggered waveform memory mode.
> +	In this case, external GPI(N) control are required to enable/disable
> +	and it needs to keep device enabled by sending magnitude (X > 0)
> +	the pattern assigned to the GPI(N)_SEQUENCE_ID below.
> +	For more details, please see the datasheet.

'-MODE' is redundant

If these modes correspond to a register field, then using the numerical 
values would be simpler.

> +- dlg,nom-microvolt: Nominal actuator voltage rating.
> +- dlg,abs-max-microvolt: Absolute actuator maximum voltage rating.
> +- dlg,imax-microamp: Actuator max current rating.
> +- dlg,impd-micro-ohms: the impedance of the actuator in micro ohm,
> +  as read from its datasheet.
> +
> +Optional properties:
> +- pwms : phandle to the physical PWM(Pulse Width Modulation) device.
> +  PWM properties should be named "pwms". And number of cell is different
> +  for each pwm device.
> +  (See Documentation/devicetree/bindings/pwm/pwm.txt
> +   for further information relating to pwm properties)
> +- dlg,ps-seq-id: the PS_SEQ_ID(pattern ID in waveform memory inside chip)
> +  to play back when RTWM-MODE is enabled.

What's the range of valid values?

> +- dlg,ps-seq-loop: the PS_SEQ_LOOP, Number of times the pre-stored sequence
> +  pointed to	by PS_SEQ_ID or GPI(N)_SEQUENCE_ID is repeated.
> +- dlg,gpiN-seq-id: the GPI(N)_SEQUENCE_ID, pattern to play
> +  when gpi0 is triggered, 'N' must be 0~2.
> +- dlg,gpiN-mode: the pattern mode which can select either
> +  "Single-pattern" or "Multi-pattern", 'N' must be 0~2.
> +- dlg,gpiN-polarity: gpiN polarity which can be chosen among "Rising-edge",
> +  "Falling-edge" and "Both-edge", 'N' must be 0~2.
> +  Haptic will work by this edge option in case of ETWM-MODE.
> +
> +- dlg,resonant-freq-hz: use in case of LRA-MODE, default 205Hz.
> +  the freq range: 50Hz ~ 300Hz.
> +  It will be set to 205Hz if the value is out of range.
> +- dlg,bemf-sens-enable: Enable for internal loop computations.
> +- dlg,freq-track-enable: Enable for resonant frequency tracking.
> +- dlg,acc-enable: Enable for active acceleration.
> +- dlg,rapid-stop-enable: Enable for rapid stop.
> +- dlg,amp-pid-enable: Enable for the amplitude PID.
> +- dlg,mem-array: use in case that memory registers should be updated,
> +  Please fill the whole buffers(100 bytes) to avoid any error in driver.
> +  For example,
> +	dlg,mem-array = <
> +		0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0A
> +		...
> +		0x71 0x72 0x73 0x74 0x75 0x76 0x77 0x78 0x79 0x7A
> +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> +	>;
> +
> +For further information, see device datasheet.
> +
> +======
> +
> +Example:
> +
> +	haptics: da7280-haptics@4A {

Use lowercase hex for unit-address.

> +		compatible = "dlg,da7280";
> +		reg = <0x4A>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		dlg,vib-mode = "LRA-MODE";
> +		dlg,play-mode = "DRO-MODE";
> +		dlg,nom-microvolt = <2000000>;
> +		dlg,abs-max-microvolt = <2000000>;
> +		dlg,imax-microamp = <170000>;
> +		dlg,resonant-freq-hz = <180>;
> +		dlg,impd-micro-ohms = <10500000>;
> +		dlg,freq-track-enable;
> +		dlg,rapid-stop-enable;
> +	};
> -- 
> end-of-patch for PATCH V3
> 
