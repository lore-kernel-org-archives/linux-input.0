From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/6] Input: evdev - Enable runtime PM of the evdev input
 handler
Date: Tue, 31 Mar 2015 13:31:38 -0700
Message-ID: <20150331203138.GB29015@dtor-ws>
References: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
 <1427818501-10201-6-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427818501-10201-6-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 31, 2015 at 06:14:49PM +0200, Tomeu Vizoso wrote:
> So ancestor devices can remain runtime-suspended when the system goes
> into a sleep state, they and all of their descendant devices need to
> have runtime PM enabled.

I am confused. Input devices are not runtime-PM-enabled, so what
enabling this on evdev handler buys us? And what about joydev and
mousedev? Other handlers that might be attached?

The stubbing of prepare also feels wrong: we do want to suspend/resume
input devices since we want to shut off and restore their leds even if
device (keyboard) happens to be sleeping.

Thanks.

> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/input/evdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index a18f41b..3d60c20 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -26,6 +26,7 @@
>  #include <linux/major.h>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
> +#include <linux/pm_runtime.h>
>  #include "input-compat.h"
>  
>  enum evdev_clock_type {
> @@ -1201,6 +1202,8 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
>  	if (error)
>  		goto err_cleanup_evdev;
>  
> +	pm_runtime_enable(&evdev->dev);
> +
>  	return 0;
>  
>   err_cleanup_evdev:
> -- 
> 2.3.4
> 

-- 
Dmitry
