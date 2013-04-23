From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: eGalax touchscreen regression
Date: Tue, 23 Apr 2013 08:40:07 -0700
Message-ID: <20130423154007.GB4104@core.coreip.homeip.net>
References: <1366708088.9823.16.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366708088.9823.16.camel@sauron.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Hui Wang <jason77.wang@gmail.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hofemeier, Ulf" <ulf.hofemeier@intel.com>
List-Id: linux-input@vger.kernel.org

Hi Artem,

On Tue, Apr 23, 2013 at 12:08:08PM +0300, Artem Bityutskiy wrote:
> Hi Dmitry,
> 
> in the below commit
> 
> commit ae495e844a77344fdaedbb2ad97d925d096e9f0d
> Author: Hui Wang <jason77.wang@gmail.com>
> Date:   Thu Oct 25 00:38:01 2012 -0700
> 
>     Input: egalax_ts - get gpio from devicetree
>     
>     The irq_to_gpio() is old, most platforms use GENERIC_GPIO framework
>     and don't support this API anymore.
>     
>     The i.MX6q sabrelite platform equips an egalax touchscreen controller,
>     and this platform already transfered to GENERIC_GPIO framework, to
>     support this driver, we use a more generic way to get gpio.
>     
>     Add a return value checking for waking up the controller in the probe
>     function, this guarantee only a workable device can pass init.
>     
>     [dmitry.torokhov@gmail.com: Make driver depend on CONFIG_OF as it is
>      now required.]
>     
>     Acked-by Zhang Jiejing <jiejing.zhang@freescale.com>
>     Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
>     Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> the eGalax driver now requires OF. For us this is a regression because
> we do not have OF: https://bugs.tizen.org/jira/browse/TIVI-740

I see. In this case we need to come up with a platform data to pass
wakeup gpio in case platform does not support OF. irq_to_gpio() is not
supported on many platforms, causing compilation errors.

Is the platform that you are trying to use the touchscreen upstream?

Thanks.

-- 
Dmitry
