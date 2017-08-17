From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042: constify pnp_device_id
Date: Wed, 16 Aug 2017 17:43:36 -0700
Message-ID: <20170817004336.GD25491@dtor-ws>
References: <5b0366a4ca5786168a4ef8e80e7125f7afbd51c6.1502861813.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5b0366a4ca5786168a4ef8e80e7125f7afbd51c6.1502861813.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tglx@linutronix.de, marcos.souza.org@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 16, 2017 at 11:11:42AM +0530, Arvind Yadav wrote:
> pnp_device_id are not supposed to change at runtime. All functions
> working with pnp_device_id provided by <linux/pnp.h> work with
> const pnp_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index f932a83..ae81e57 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -927,7 +927,7 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
>  	return 0;
>  }
>  
> -static struct pnp_device_id pnp_kbd_devids[] = {
> +static const struct pnp_device_id pnp_kbd_devids[] = {
>  	{ .id = "PNP0300", .driver_data = 0 },
>  	{ .id = "PNP0301", .driver_data = 0 },
>  	{ .id = "PNP0302", .driver_data = 0 },
> @@ -957,7 +957,7 @@ static struct pnp_driver i8042_pnp_kbd_driver = {
>  	},
>  };
>  
> -static struct pnp_device_id pnp_aux_devids[] = {
> +static const struct pnp_device_id pnp_aux_devids[] = {
>  	{ .id = "AUI0200", .driver_data = 0 },
>  	{ .id = "FJC6000", .driver_data = 0 },
>  	{ .id = "FJC6001", .driver_data = 0 },
> -- 
> 2.7.4
> 

-- 
Dmitry
