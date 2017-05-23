From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: synaptics - keep PS/2 around when RMI4_SMB is
 not compiled in
Date: Tue, 23 May 2017 14:18:23 -0700
Message-ID: <20170523211823.GB34299@dtor-ws>
References: <20170523083657.11148-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523083657.11148-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, May 23, 2017 at 10:36:55AM +0200, Benjamin Tissoires wrote:
> Or the user might have the touchpad unbound from PS/2 but never picked
> up by rmi-smbus.ko
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/mouse/synaptics.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 131df9d..58ff388 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1687,7 +1687,11 @@ enum {
>  	SYNAPTICS_INTERTOUCH_ON,
>  };
>  
> +#if IS_ENABLED(CONFIG_RMI4_SMB)
>  static int synaptics_intertouch = SYNAPTICS_INTERTOUCH_NOT_SET;
> +#else /* CONFIG_RMI4_SMB */
> +static int synaptics_intertouch = SYNAPTICS_INTERTOUCH_OFF;
> +#endif /* CONFIG_RMI4_SMB */

The benefit of IS_ENABLED is that it can be used in C code:

static int synaptics_intertouch = IS_ENABLED(CONFIG_RMI4_SMB) ?
		SYNAPTICS_INTERTOUCH_NOT_SET : SYNAPTICS_INTERTOUCH_OFF;

>  module_param_named(synaptics_intertouch, synaptics_intertouch, int, 0644);
>  MODULE_PARM_DESC(synaptics_intertouch, "Use a secondary bus for the Synaptics device.");
>  
> -- 
> 2.9.4
> 

Thanks.

-- 
Dmitry
