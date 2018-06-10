From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v7 3/9] dt-bindings: input: touchscreen: add minimum
 pressure touchscreen property
Date: Sun, 10 Jun 2018 13:31:31 +0100
Message-ID: <20180610133131.2ec1ddae@archlinux>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-4-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526975559-18966-4-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 22 May 2018 10:52:33 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add a common touchscreen optional property that will specify
> the minimum pressure applied to the screen that is needed
> such that the driver will report the touch event.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied, Thanks,

Jonathan
> ---
> Changes in v5:
>  - Modified property name to touchscreen-min-pressure from
> touchscreen-threshold-property
> 
>  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> index 537643e..d092d5d 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> @@ -7,6 +7,9 @@ Optional properties for Touchscreens:
>  				  (in pixels)
>   - touchscreen-max-pressure	: maximum reported pressure (arbitrary range
>  				  dependent on the controller)
> + - touchscreen-min-pressure	: minimum pressure on the touchscreen to be
> +				  achieved in order for the touchscreen
> +				  driver to report a touch event.
>   - touchscreen-fuzz-x		: horizontal noise value of the absolute input
>  				  device (in pixels)
>   - touchscreen-fuzz-y		: vertical noise value of the absolute input
