From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/7] Input: synaptics-rmi4 - add a couple of debug
 lines
Date: Mon, 7 Nov 2016 17:49:07 -0800
Message-ID: <20161108014907.GD10133@dtor-ws>
References: <1477345917-25326-1-git-send-email-nick@shmanahar.org>
 <1477345917-25326-3-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477345917-25326-3-git-send-email-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 24, 2016 at 10:51:52PM +0100, Nick Dyer wrote:
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_bus.c    | 3 +++
>  drivers/input/rmi4/rmi_driver.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index ef8c747..3c6a1b5 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -230,6 +230,9 @@ int rmi_register_function(struct rmi_function *fn)
>  
>  void rmi_unregister_function(struct rmi_function *fn)
>  {
> +	rmi_dbg(RMI_DEBUG_CORE, &fn->dev, "Unregistering F%02X.\n",
> +			fn->fd.function_number);
> +
>  	device_del(&fn->dev);
>  	of_node_put(fn->dev.of_node);
>  	put_device(&fn->dev);
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 63c9e22..adb3ee8 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -722,6 +722,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
>  			return RMI_SCAN_DONE;
>  		}
>  
> +		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Sending reset\n");
>  		error = rmi_write_block(rmi_dev, cmd_addr, &cmd_buf, 1);
>  		if (error) {
>  			dev_err(&rmi_dev->dev,
> -- 
> 2.7.4
> 

-- 
Dmitry
