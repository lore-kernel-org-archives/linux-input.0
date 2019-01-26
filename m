From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: dt-bindings: Add binding for bma150 sensor
Date: Fri, 25 Jan 2019 17:28:02 -0800
Message-ID: <20190126012802.GD212026@dtor-ws>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125184400.17669-4-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, xc-racer2@live.ca, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 25, 2019 at 07:44:00PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Add device tree bindings for Bosch BMA150 Accelerometer Sensor
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../bindings/input/bosch,bma150.txt           | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> new file mode 100644
> index 000000000000..290c60e38c70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> @@ -0,0 +1,20 @@
> +* Bosch BMA150 Accelerometer Sensor
> +
> +Also works for the SMB380 and BMA023 accelerometers
> +
> +Required properties:
> +- compatible : Should be "bosch,bma150"
> +- reg : The I2C address of the sensor
> +
> +Optional properties:
> +- interrupt-parent : should be the phandle for the interrupt controller
> +- interrupts : Interrupt mapping for IRQ.  If not present device will be polled
> +
> +Example:
> +
> +bma150@38 {
> +	compatible = "bosch,bma150";
> +	reg = <0x38>;
> +	interrupt-parent = <&gph0>;
> +	interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;

Hmm, here you say that IRQ_TYPE_LEVEL_HIGH, so it is level interrupts,
but the driver overrides to rising edge unconditionally. Since you are
the first to add DT support please make separate patch to driver to drop
the ORQ trigger from request_theraded_irq() leaving only IRQF_ONESHOT.

Also please create patch removing platform data support as noone is
using it upstream.

What about the rest of config parameters from bma150_cfg? They should be
handled as device properties too.

Thanks.

-- 
Dmitry
