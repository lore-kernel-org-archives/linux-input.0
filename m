From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/3] Input: edt-ft5x06 - Set wake/reset values on
 resume/suspend
Date: Wed, 25 Jul 2018 17:52:12 -0700
Message-ID: <20180726005212.GE80336@dtor-ws>
References: <20180725073410.730-1-mylene.josserand@bootlin.com>
 <20180725073410.730-3-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180725073410.730-3-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@bootlin.com
List-Id: linux-input@vger.kernel.org

Hi Mylène,

On Wed, Jul 25, 2018 at 09:34:09AM +0200, Mylène Josserand wrote:
> On resume and suspend, set the value of wake and reset gpios
> to be sure that we are in a know state after suspending/resuming.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index dcde719094f7..dad2f1f8bf89 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1158,6 +1158,12 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  	else
>  		regulator_disable(tsdata->vcc);
>  
> +	if (tsdata->wake_gpio)
> +		gpiod_set_value(tsdata->wake_gpio, 0);
> +
> +	if (tsdata->reset_gpio)
> +		gpiod_set_value(tsdata->reset_gpio, 1);

Ondřej mentioned in previous review that if you power off the controller
it will not be able to wake up the system, and you had to move call to
regulator_disable() into "else" branch of check whether the controller
is a wakeup device. Guess what happens if you unconditionally put the
device into reset state?

Thanks.

-- 
Dmitry
