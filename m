From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V1 09/10] Documentation: dt: mfd: da9062/61 MFD binding
Date: Mon, 10 Oct 2016 08:42:35 -0500
Message-ID: <20161010134235.GA20577@rob-hp-laptop>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <7a21f22bd62817b63ba64e11eecadfb78338ee46.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7a21f22bd62817b63ba64e11eecadfb78338ee46.1475743411.git.stwiss.opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 06, 2016 at 09:43:31AM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Extend existing DA9062 binding information to include the DA9061 PMIC for
> MFD core and regulators.
> 
> Add a da9062-onkey link to the existing onkey binding file.
> 
> Add a da9062-thermal link to the new temperature monitoring binding file
> found in [PATCH V1 8/10].
> 
> Delete the da9062-watchdog section and replace it with a link to the new
> DA9061/62 binding information file added by [PATCH V1 7/10].
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> Hi,
> 
> This patch depends on acceptance of the main code for the DA9061 MFD:
> 
> - [PATCH V1 1/10] mfd: da9061: MFD core support
> 
> and also from the following binding file changes:
> 
> - [PATCH V1 6/10] Binding for onkey
> - [PATCH V1 7/10] Binding for watchdog
> - [PATCH V1 8/10] Binding for thermal
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  Documentation/devicetree/bindings/mfd/da9062.txt | 45 +++++++++++++++++-------
>  1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
> index 38802b5..38ba5e2 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt

[...]

>  Example:
> @@ -64,10 +89,6 @@ Example:
>  			compatible = "dlg,da9062-rtc";
>  		};
>  
> -		watchdog {
> -			compatible = "dlg,da9062-watchdog";
> -		};
> -

I don't understand why this is removed?

>  		regulators {
>  			DA9062_BUCK1: buck1 {
>  				regulator-name = "BUCK1";
> -- 
> end-of-patch for PATCH V1
> 
