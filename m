From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V1 08/10] Documentation: dt: thermal: da9062/61 TJUNC
 temperature binding
Date: Mon, 10 Oct 2016 08:38:52 -0500
Message-ID: <20161010133852.GA19127@rob-hp-laptop>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <3a643792408aa4a15cbf89c4ac9e61a63e443981.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3a643792408aa4a15cbf89c4ac9e61a63e443981.1475743411.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 06, 2016 at 09:43:31AM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Device tree binding information for DA9062 and DA9061 thermal junction
> temperature monitor.
> 
> Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
> device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for a
> configurable polling period for over-temperature polling.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> Hi,
> 
> This patch depends on the acceptance of the main code for the onkey:
>   [PATCH V1 5/10] thermal: da9061: TJUNC temperature driver
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  .../devicetree/bindings/thermal/da9062-thermal.txt | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt

Acked-by: Rob Herring <robh@kernel.org>
