From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 3/9] Documentation: devicetree: thermal: da9062/61
 TJUNC temperature binding
Date: Wed, 9 Nov 2016 12:24:46 -0600
Message-ID: <20161109182446.2hdgqlcphxrris2b@rob-hp-laptop>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <318faafc8021e6adc683e62d57b8c031b9212e0f.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <318faafc8021e6adc683e62d57b8c031b9212e0f.1477929725.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 31, 2016 at 04:02:03PM +0000, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Device tree binding information for DA9062 and DA9061 thermal junction
> temperature monitor.
> 
> Binding descriptions for the DA9061 and DA9062 thermal TJUNC supervisor
> device driver, using a single THERMAL_TRIP_HOT trip-wire and allowing for
> a configurable polling period for over-temperature polling.
> 
> This patch also adds two examples, one for DA9062 and one for DA9061. The 
> DA9061 example uses a fall-back compatible string for the DA9062.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

Acked-by: Rob Herring <robh@kernel.org>
