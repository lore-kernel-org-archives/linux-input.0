From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 12/41] Documentation: dt: input: fix spelling mistakes
Date: Mon, 25 Apr 2016 08:49:52 -0500
Message-ID: <20160425134952.GA8393@rob-hp-laptop>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-13-git-send-email-eric@engestrom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461543878-3639-13-git-send-email-eric@engestrom.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Engestrom <eric@engestrom.ch>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Markus Pargmann <mpa@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 25, 2016 at 01:24:09AM +0100, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/input/ads7846.txt                  | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
> index c6cfe2e..9fc47b0 100644
> --- a/Documentation/devicetree/bindings/input/ads7846.txt
> +++ b/Documentation/devicetree/bindings/input/ads7846.txt
> @@ -29,7 +29,7 @@ Optional properties:
>  	ti,vref-delay-usecs		vref supply delay in usecs, 0 for
>  					external vref (u16).
>  	ti,vref-mv			The VREF voltage, in millivolts (u16).
> -					Set to 0 to use internal refernce
> +					Set to 0 to use internal references
>  					(ADS7846).
>  	ti,keep-vref-on			set to keep vref on for differential
>  					measurements as well
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> index cdf05f9..abfcab3 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> @@ -15,7 +15,7 @@ Optional properties:
>   - fsl,pen-debounce-ns: Pen debounce time in nanoseconds.
>   - fsl,pen-threshold: Pen-down threshold for the touchscreen. This is a value
>     between 1 and 4096. It is the ratio between the internal reference voltage
> -   and the measured voltage after the plate was precharged. Resistence between
> +   and the measured voltage after the plate was precharged. Resistance between
>     plates and therefore the voltage decreases with pressure so that a smaller
>     value is equivalent to a higher pressure.
>   - fsl,settling-time-ns: Settling time in nanoseconds. The settling time is before
> -- 
> 2.8.0
> 
