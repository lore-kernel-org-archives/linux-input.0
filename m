From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: st1232 - add Martin as module author
Date: Mon, 28 Jan 2019 11:04:32 -0800
Message-ID: <20190128190432.GB34692@dtor-ws>
References: <20190128084449.16070-1-martink@posteo.de>
 <20190128084449.16070-3-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128084449.16070-3-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 28, 2019 at 09:44:49AM +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> This adds myself as an author of the st1232 driver module as Tony's
> email address doesn't seem to work anymore.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/st1232.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index 19a665d48dad..906b233970aa 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -346,5 +346,6 @@ static struct i2c_driver st1232_ts_driver = {
>  module_i2c_driver(st1232_ts_driver);
>  
>  MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>");
> +MODULE_AUTHOR("Martin Kepplinger <martin.kepplinger@ginzinger.com>");
>  MODULE_DESCRIPTION("SITRONIX ST1232 Touchscreen Controller Driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.20.1
> 

-- 
Dmitry
