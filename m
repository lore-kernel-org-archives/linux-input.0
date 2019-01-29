From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH v2 4/8] Input: sx8654 - add sx8655 and sx8656 to
 compatibles
Date: Mon, 28 Jan 2019 16:26:27 -0800
Message-ID: <20190129002627.GK34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218083606.25795-5-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218083606.25795-5-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: mark.rutland@arm.com, robh+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 18, 2018 at 09:36:02AM +0100, Richard Leitner wrote:
> As the sx865[456] share the same datasheet and differ only in the
> presence of a "capacitive proximity detection circuit" and a "haptics
> motor driver for LRA/ERM" add them to the compatbiles. As the driver
> doesn't implement these features it should be no problem.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/sx8654.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index 238f56b1581b..afa4da138fe9 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -293,6 +293,8 @@ static int sx8654_probe(struct i2c_client *client,
>  #ifdef CONFIG_OF
>  static const struct of_device_id sx8654_of_match[] = {
>  	{ .compatible = "semtech,sx8654", },
> +	{ .compatible = "semtech,sx8655", },
> +	{ .compatible = "semtech,sx8656", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, sx8654_of_match);
> @@ -300,6 +302,8 @@ MODULE_DEVICE_TABLE(of, sx8654_of_match);
>  
>  static const struct i2c_device_id sx8654_id_table[] = {
>  	{ "semtech_sx8654", 0 },
> +	{ "semtech_sx8655", 0 },
> +	{ "semtech_sx8656", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, sx8654_id_table);
> -- 
> 2.11.0
> 

-- 
Dmitry
