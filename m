From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/9] dt-bindings: input: touchscreen: add pressure
 threshold touchscreen property
Date: Mon, 7 May 2018 15:38:32 -0700
Message-ID: <20180507223832.GB31301@dtor-ws>
References: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
 <1525084335-11276-4-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525084335-11276-4-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, robh@kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 30, 2018 at 01:32:09PM +0300, Eugen Hristev wrote:
> Add a common touchscreen optional property that will specify
> the minimum pressure applied to the screen that is needed
> such that the driver will report the touch event.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> index 537643e..c84047a 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> @@ -7,6 +7,9 @@ Optional properties for Touchscreens:
>  				  (in pixels)
>   - touchscreen-max-pressure	: maximum reported pressure (arbitrary range
>  				  dependent on the controller)
> + - touchscreen-threshold-pressure: minimum pressure on the touchscreen to be
> +				  achieved in order for the touchscreen
> +				  driver to report a touch event.

Why do we move from the pattern and call it trheshold and not
touchscreen-min-pressure?

>   - touchscreen-fuzz-x		: horizontal noise value of the absolute input
>  				  device (in pixels)
>   - touchscreen-fuzz-y		: vertical noise value of the absolute input
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
