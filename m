From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 07/15] Input: synaptics-rmi4 - remove remaining debugfs
 code
Date: Tue, 4 Feb 2014 15:09:54 -0800
Message-ID: <52F17342.7050502@synaptics.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com> <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:43718 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbaBDXJ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 18:09:56 -0500
In-Reply-To: <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> As most of this code was already removed, the remainder does nothing.
> Remove it.

Actually, the code does something.  The functionality that it supports 
is not currently being submitted as patches in order to keep the working 
set size down.  We're trying to keep the submitted code consistent with 
the production, since that makes it easier to develop the patches and 
keeps the patches similar to the code that is used in production.

>
> Cc: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> ---
>   drivers/input/rmi4/Kconfig      |   1 -
>   drivers/input/rmi4/rmi_bus.c    | 103 ----------------------------------------
>   drivers/input/rmi4/rmi_bus.h    |  12 -----
>   drivers/input/rmi4/rmi_driver.c |   3 --
>   drivers/input/rmi4/rmi_driver.h |  12 -----
>   drivers/input/rmi4/rmi_f11.c    |   2 +-
>   include/linux/rmi.h             |   7 ++-
>   7 files changed, 4 insertions(+), 136 deletions(-)
>
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index d0c7b6e..22d5599 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -14,7 +14,6 @@ config RMI4_CORE
>   config RMI4_DEBUG
>   	bool "RMI4 Debugging"
>   	depends on RMI4_CORE
> -	select DEBUG_FS
>   	help
>   	  Say Y here to enable debug feature in the RMI4 driver.
>
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index fd14acb..a51e6b4 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -15,14 +15,9 @@
>   #include <linux/rmi.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> -#include <linux/debugfs.h>
>   #include "rmi_bus.h"
>   #include "rmi_driver.h"
>
> -#ifdef CONFIG_RMI4_DEBUG
> -static struct dentry *rmi_debugfs_root;
> -#endif
> -
>   /*
>    * RMI Physical devices
>    *
> @@ -47,34 +42,6 @@ bool rmi_is_physical_device(struct device *dev)
>   	return dev->type == &rmi_device_type;
>   }
>
> -#ifdef CONFIG_RMI4_DEBUG
> -
> -static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
> -{
> -	rmi_dev->debugfs_root = debugfs_create_dir(dev_name(&rmi_dev->dev),
> -						   rmi_debugfs_root);
> -	if (!rmi_dev->debugfs_root)
> -		dev_warn(&rmi_dev->dev, "Failed to create debugfs root.\n");
> -}
> -
> -static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
> -{
> -	if (rmi_dev->debugfs_root)
> -		debugfs_remove_recursive(rmi_dev->debugfs_root);
> -}
> -
> -#else
> -
> -static void rmi_physical_setup_debugfs(struct rmi_device *rmi_dev)
> -{
> -}
> -
> -static void rmi_physical_teardown_debugfs(struct rmi_device *rmi_dev)
> -{
> -}
> -
> -#endif
> -
>   /**
>    * rmi_register_transport_device - register a transport device connection
>    * on the RMI bus.  Transport drivers provide communication from the devices
> @@ -108,8 +75,6 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
>
>   	xport->rmi_dev = rmi_dev;
>
> -	rmi_physical_setup_debugfs(rmi_dev);
> -
>   	error = device_register(&rmi_dev->dev);
>   	if (error) {
>   		put_device(&rmi_dev->dev);
> @@ -132,7 +97,6 @@ void rmi_unregister_transport_device(struct rmi_transport_dev *xport)
>   {
>   	struct rmi_device *rmi_dev = xport->rmi_dev;
>
> -	rmi_physical_teardown_debugfs(rmi_dev);
>   	device_unregister(&rmi_dev->dev);
>   }
>   EXPORT_SYMBOL(rmi_unregister_transport_device);
> @@ -156,37 +120,6 @@ bool rmi_is_function_device(struct device *dev)
>   	return dev->type == &rmi_function_type;
>   }
>
> -#ifdef CONFIG_RMI4_DEBUG
> -
> -static void rmi_function_setup_debugfs(struct rmi_function *fn)
> -{
> -	char dirname[12];
> -
> -	snprintf(dirname, sizeof(dirname), "F%02X", fn->fd.function_number);
> -	fn->debugfs_root = debugfs_create_dir(dirname,
> -					      fn->rmi_dev->debugfs_root);
> -	if (!fn->debugfs_root)
> -		dev_warn(&fn->dev, "Failed to create debugfs dir.\n");
> -}
> -
> -static void rmi_function_teardown_debugfs(struct rmi_function *fn)
> -{
> -	if (fn->debugfs_root)
> -		debugfs_remove_recursive(fn->debugfs_root);
> -}
> -
> -#else
> -
> -static void rmi_function_setup_debugfs(struct rmi_function *fn)
> -{
> -}
> -
> -static void rmi_function_teardown_debugfs(struct rmi_function *fn)
> -{
> -}
> -
> -#endif
> -
>   static int rmi_function_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct rmi_function_handler *handler = to_rmi_function_handler(drv);
> @@ -234,8 +167,6 @@ int rmi_register_function(struct rmi_function *fn)
>   	fn->dev.type = &rmi_function_type;
>   	fn->dev.bus = &rmi_bus_type;
>
> -	rmi_function_setup_debugfs(fn);
> -
>   	error = device_register(&fn->dev);
>   	if (error) {
>   		dev_err(&rmi_dev->dev,
> @@ -250,13 +181,11 @@ int rmi_register_function(struct rmi_function *fn)
>   	return 0;
>
>   error_exit:
> -	rmi_function_teardown_debugfs(fn);
>   	return error;
>   }
>
>   void rmi_unregister_function(struct rmi_function *fn)
>   {
> -	rmi_function_teardown_debugfs(fn);
>   	device_unregister(&fn->dev);
>   }
>
> @@ -325,34 +254,6 @@ struct bus_type rmi_bus_type = {
>   	.name		= "rmi",
>   };
>
> -#ifdef CONFIG_RMI4_DEBUG
> -
> -static void rmi_bus_setup_debugfs(void)
> -{
> -	rmi_debugfs_root = debugfs_create_dir(rmi_bus_type.name, NULL);
> -	if (!rmi_debugfs_root)
> -		pr_err("%s: Failed to create debugfs root\n",
> -		       __func__);
> -}
> -
> -static void rmi_bus_teardown_debugfs(void)
> -{
> -	if (rmi_debugfs_root)
> -		debugfs_remove_recursive(rmi_debugfs_root);
> -}
> -
> -#else
> -
> -static void rmi_bus_setup_debugfs(void)
> -{
> -}
> -
> -static void rmi_bus_teardown_debugfs(void)
> -{
> -}
> -
> -#endif
> -
>   static int __init rmi_bus_init(void)
>   {
>   	int error;
> @@ -364,8 +265,6 @@ static int __init rmi_bus_init(void)
>   		return error;
>   	}
>
> -	rmi_bus_setup_debugfs();
> -
>   	error = rmi_register_f01_handler();
>   	if (error) {
>   		pr_err("%s: error registering the RMI F01 handler: %d\n",
> @@ -385,7 +284,6 @@ static int __init rmi_bus_init(void)
>   err_unregister_f01:
>   	rmi_unregister_f01_handler();
>   err_unregister_bus:
> -	rmi_bus_teardown_debugfs();
>   	bus_unregister(&rmi_bus_type);
>   	return error;
>   }
> @@ -400,7 +298,6 @@ static void __exit rmi_bus_exit(void)
>
>   	rmi_unregister_physical_driver();
>   	rmi_unregister_f01_handler();
> -	rmi_bus_teardown_debugfs();
>   	bus_unregister(&rmi_bus_type);
>   }
>   module_exit(rmi_bus_exit);
> diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
> index 2bad2ed..62fd544 100644
> --- a/drivers/input/rmi4/rmi_bus.h
> +++ b/drivers/input/rmi4/rmi_bus.h
> @@ -19,7 +19,6 @@
>   #include <linux/stat.h>
>   #include <linux/types.h>
>   #include <linux/wait.h>
> -#include <linux/debugfs.h>
>   #include <linux/rmi.h>
>
>   struct rmi_device;
> @@ -39,7 +38,6 @@ struct rmi_device;
>    * @data: Private data pointer
>    *
>    * @node: entry in device's list of functions
> - * @debugfs_root: used during debugging
>    */
>   struct rmi_function {
>   	struct rmi_function_descriptor fd;
> @@ -50,10 +48,6 @@ struct rmi_function {
>   	unsigned long *irq_mask;
>   	void *data;
>   	struct list_head node;
> -
> -#ifdef CONFIG_RMI4_DEBUG
> -	struct dentry *debugfs_root;
> -#endif
>   };
>
>   #define to_rmi_function(d)	container_of(d, struct rmi_function, dev)
> @@ -208,8 +202,6 @@ struct rmi_transport_ops {
>    * @number: Unique number for the device on the bus.
>    * @driver: Pointer to associated driver
>    * @xport: Pointer to the transport interface
> - * @debugfs_root: base for this particular sensor device.
> - *
>    */
>   struct rmi_device {
>   	struct device dev;
> @@ -217,10 +209,6 @@ struct rmi_device {
>
>   	struct rmi_driver *driver;
>   	struct rmi_transport_dev *xport;
> -
> -#ifdef CONFIG_RMI4_DEBUG
> -	struct dentry *debugfs_root;
> -#endif
>   };
>
>   #define to_rmi_device(d) container_of(d, struct rmi_device, dev)
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 691b6fb..e44eff7 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -16,7 +16,6 @@
>
>   #include <linux/kernel.h>
>   #include <linux/bitmap.h>
> -#include <linux/debugfs.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/fs.h>
> @@ -42,8 +41,6 @@
>
>   #define DEFAULT_POLL_INTERVAL_MS	13
>
> -#define IRQ_DEBUG(data) (IS_ENABLED(CONFIG_RMI4_DEBUG) && data->irq_debug)
> -
>   static irqreturn_t rmi_irq_thread(int irq, void *p)
>   {
>   	struct rmi_transport_dev *xport = p;
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index f28166f..eafbdb3 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -38,7 +38,6 @@ struct rmi_driver_data {
>   	bool f01_bootloader_mode;
>
>   	u32 attn_count;
> -	u32 irq_debug;	/* Should be bool, but debugfs wants u32 */
>   	int irq;
>   	int num_of_irq_regs;
>   	int irq_count;
> @@ -54,17 +53,6 @@ struct rmi_driver_data {
>
>   	bool enabled;
>
> -#ifdef CONFIG_RMI4_DEBUG
> -	struct dentry *debugfs_delay;
> -	struct dentry *debugfs_xport;
> -	struct dentry *debugfs_reg_ctl;
> -	struct dentry *debugfs_reg;
> -	struct dentry *debugfs_irq;
> -	struct dentry *debugfs_attn_count;
> -	u16 reg_debug_addr;
> -	u8 reg_debug_size;
> -#endif
> -
>   	void *data;
>   };
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 553afd8..87d85ab 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -515,7 +515,7 @@ struct f11_2d_sensor {
>   	u8 *data_pkt;
>   	int pkt_size;
>   	u8 sensor_index;
> -	u32 type_a;	/* boolean but debugfs API requires u32 */
> +	bool type_a;
>   	enum rmi_f11_sensor_type sensor_type;
>   	struct input_dev *input;
>   	struct input_dev *mouse_input;
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index 41c2c04..f3775eb 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -21,7 +21,6 @@
>   #include <linux/stat.h>
>   #include <linux/types.h>
>   #include <linux/wait.h>
> -#include <linux/debugfs.h>
>
>   /**
>    * struct rmi_f11_axis_alignment - target axis alignment
> @@ -42,9 +41,9 @@
>    *               automatically enabled for this sensor.
>    */
>   struct rmi_f11_2d_axis_alignment {
> -	u32 swap_axes;	/* boolean, but u32 is needed by debugfs API */
> -	u32 flip_x;	/* boolean */
> -	u32 flip_y;	/* boolean */
> +	bool swap_axes;
> +	bool flip_x;
> +	bool flip_y;
>   	u16 clip_x_low;
>   	u16 clip_y_low;
>   	u16 clip_x_high;
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
