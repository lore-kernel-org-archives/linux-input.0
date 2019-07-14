From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - remove the exporting of
 rmi_2d_sensor_set_input_params
Date: Sun, 14 Jul 2019 11:26:56 -0700
Message-ID: <20190714182656.GA190835@dtor-ws>
References: <20190708172138.31009-1-efremov@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190708172138.31009-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denis Efremov <efremov@linux.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 08, 2019 at 08:21:38PM +0300, Denis Efremov wrote:
> The function rmi_2d_sensor_set_input_params is declared static and marked
> EXPORT_SYMBOL_GPL, which is at best an odd combination. Because the
> function is not used outside of the drivers/input/rmi4/rmi_2d_sensor.c
> file it is defined in, this commit removes the EXPORT_SYMBOL_GPL() marking.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_2d_sensor.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
> index ea549efe4bc4..b7fe6eb35a4e 100644
> --- a/drivers/input/rmi4/rmi_2d_sensor.c
> +++ b/drivers/input/rmi4/rmi_2d_sensor.c
> @@ -204,7 +204,6 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
>  	if (sensor->topbuttonpad)
>  		set_bit(INPUT_PROP_TOPBUTTONPAD, input->propbit);
>  }
> -EXPORT_SYMBOL_GPL(rmi_2d_sensor_set_input_params);
>  
>  int rmi_2d_sensor_configure_input(struct rmi_function *fn,
>  					struct rmi_2d_sensor *sensor)
> -- 
> 2.21.0
> 

-- 
Dmitry
