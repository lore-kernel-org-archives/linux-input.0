From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] tca8418: fix loading this driver as a module from a
 device tree
Date: Thu, 24 Apr 2014 23:52:29 -0700
Message-ID: <20140425065229.GG10433@core.coreip.homeip.net>
References: <8CC80032-D358-4643-B3AD-95C280525EAC@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8CC80032-D358-4643-B3AD-95C280525EAC@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 10, 2014 at 11:29:58AM +0200, Dr. H. Nikolaus Schaller wrote:
> Loading the tca8418 driver as a module on a device tree based system needs
> a MODULE_ALIAS because the driver name does not match the automatic
> name generation rules of a 'compatible' entry on i2c bus.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/tca8418_keypad.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 55c1530..3556360 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -392,6 +392,11 @@ static const struct of_device_id tca8418_dt_ids[] = {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
> +/* the device tree based i2c loader looks for
> + * "i2c:" + second_component_of(property("compatible"))
> + * and therefore we need an alias to be found.
> + */
> +MODULE_ALIAS("i2c:tca8418");
>  #endif
>  
>  static struct i2c_driver tca8418_keypad_driver = {
> -- 
> 1.9.1
> 
> 

-- 
Dmitry
