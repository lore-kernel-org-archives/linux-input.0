From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v5] i8042: Add unmask_kbd_data option
Date: Wed, 15 Jul 2015 11:28:17 -0400
Message-ID: <20150715152817.GA16611@mail.corp.redhat.com>
References: <20150627203543.GA31870@rhlx01.hs-esslingen.de>
 <1435852008-4509-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435852008-4509-1-git-send-email-cpaul@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cpaul@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andreas Mohr <andi@lisas.de>
List-Id: linux-input@vger.kernel.org

On Jul 02 2015 or thereabouts, cpaul@redhat.com wrote:
> From: Stephen Chandler Paul <cpaul@redhat.com>
> 
> A big problem with the current i8042 debugging option is that it outputs
> data going to and from the keyboard by default. As a result, many dmesg
> logs uploaded by users will unintentionally contain sensitive information
> such as their password, as such it's probably a good idea not to output
> data coming from the keyboard unless specifically enabled by the user.
> 
> Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
> ---

FWIW, in case you are missing my input Dmitry:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks everyone involved in this process!

Cheers,
Benjamin

> 				    Changes
> * Fix incorrect option name in MODULE_PARM_DESC() (I have no idea how that
>   happened in the first place)
> * Replaced the description with one of the suggestions given by Andreas
> * Rename debug_kbd to unmask_kbd_data
> * Improve description in Documentation/kernel-parameters.txt
> 
>  Documentation/kernel-parameters.txt |  4 ++++
>  drivers/input/serio/i8042.c         | 43 +++++++++++++++++++++++++++++++++----
>  drivers/input/serio/i8042.h         | 13 +++++++++++
>  drivers/input/serio/serio.c         |  4 +---
>  include/linux/serio.h               |  2 ++
>  5 files changed, 59 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index ae44749..352a5f1 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1304,6 +1304,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			     <bus_id>,<clkrate>
>  
>  	i8042.debug	[HW] Toggle i8042 debug mode
> +	i8042.unmask_kbd_data
> +			[HW] Enable printing of interrupt data from the KBD port
> +			     (disabled by default, and as a pre-condition
> +			     requires that i8042.debug=1 be enabled)
>  	i8042.direct	[HW] Put keyboard port into non-translated mode
>  	i8042.dumbkbd	[HW] Pretend that controller can only read data from
>  			     keyboard and cannot control its state
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index cb5ece7..e6d1529 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -88,6 +88,10 @@ MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
>  static bool i8042_debug;
>  module_param_named(debug, i8042_debug, bool, 0600);
>  MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
> +
> +static bool i8042_unmask_kbd_data;
> +module_param_named(unmask_kbd_data, i8042_unmask_kbd_data, bool, 0600);
> +MODULE_PARM_DESC(unmask_kbd_data, "Unconditional enable (may reveal sensitive data) of normally sanitize-filtered kbd data traffic debug log [pre-condition: i8042.debug=1 enabled]");
>  #endif
>  
>  static bool i8042_bypass_aux_irq_test;
> @@ -116,6 +120,7 @@ struct i8042_port {
>  	struct serio *serio;
>  	int irq;
>  	bool exists;
> +	bool driver_bound;
>  	signed char mux;
>  };
>  
> @@ -133,6 +138,7 @@ static bool i8042_kbd_irq_registered;
>  static bool i8042_aux_irq_registered;
>  static unsigned char i8042_suppress_kbd_ack;
>  static struct platform_device *i8042_platform_device;
> +static struct notifier_block i8042_kbd_bind_notifier_block;
>  
>  static irqreturn_t i8042_interrupt(int irq, void *dev_id);
>  static bool (*i8042_platform_filter)(unsigned char data, unsigned char str,
> @@ -528,10 +534,10 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
>  	port = &i8042_ports[port_no];
>  	serio = port->exists ? port->serio : NULL;
>  
> -	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)\n",
> -	    data, port_no, irq,
> -	    dfl & SERIO_PARITY ? ", bad parity" : "",
> -	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
> +	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
> +		   port_no, irq,
> +		   dfl & SERIO_PARITY ? ", bad parity" : "",
> +		   dfl & SERIO_TIMEOUT ? ", timeout" : "");
>  
>  	filtered = i8042_filter(data, str, serio);
>  
> @@ -1438,6 +1444,29 @@ static int __init i8042_setup_kbd(void)
>  	return error;
>  }
>  
> +static int i8042_kbd_bind_notifier(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +	struct serio *serio = to_serio_port(dev);
> +	struct i8042_port *port = serio->port_data;
> +
> +	if (serio != i8042_ports[I8042_KBD_PORT_NO].serio)
> +		return 0;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_BOUND_DRIVER:
> +		port->driver_bound = true;
> +		break;
> +
> +	case BUS_NOTIFY_UNBOUND_DRIVER:
> +		port->driver_bound = false;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init i8042_probe(struct platform_device *dev)
>  {
>  	int error;
> @@ -1507,6 +1536,10 @@ static struct platform_driver i8042_driver = {
>  	.shutdown	= i8042_shutdown,
>  };
>  
> +static struct notifier_block i8042_kbd_bind_notifier_block = {
> +	.notifier_call = i8042_kbd_bind_notifier,
> +};
> +
>  static int __init i8042_init(void)
>  {
>  	struct platform_device *pdev;
> @@ -1528,6 +1561,7 @@ static int __init i8042_init(void)
>  		goto err_platform_exit;
>  	}
>  
> +	bus_register_notifier(&serio_bus, &i8042_kbd_bind_notifier_block);
>  	panic_blink = i8042_panic_blink;
>  
>  	return 0;
> @@ -1543,6 +1577,7 @@ static void __exit i8042_exit(void)
>  	platform_driver_unregister(&i8042_driver);
>  	i8042_platform_exit();
>  
> +	bus_unregister_notifier(&serio_bus, &i8042_kbd_bind_notifier_block);
>  	panic_blink = NULL;
>  }
>  
> diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
> index fc080be..1db0a40 100644
> --- a/drivers/input/serio/i8042.h
> +++ b/drivers/input/serio/i8042.h
> @@ -73,6 +73,17 @@ static unsigned long i8042_start_time;
>  			printk(KERN_DEBUG KBUILD_MODNAME ": [%d] " format,	\
>  			       (int) (jiffies - i8042_start_time), ##arg);	\
>  	} while (0)
> +
> +#define filter_dbg(filter, data, format, args...)		\
> +	do {							\
> +		if (!i8042_debug)				\
> +			break;					\
> +								\
> +		if (!filter || i8042_unmask_kbd_data)		\
> +			dbg("%02x " format, data, ##args);	\
> +		else						\
> +			dbg("** " format, ##args);		\
> +	} while (0)
>  #else
>  #define dbg_init() do { } while (0)
>  #define dbg(format, arg...)							\
> @@ -80,6 +91,8 @@ static unsigned long i8042_start_time;
>  		if (0)								\
>  			printk(KERN_DEBUG pr_fmt(format), ##arg);		\
>  	} while (0)
> +
> +#define filter_dbg(filter, data, format, args...) do { } while (0)
>  #endif
>  
>  #endif /* _I8042_H */
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index a05a517..63422d2 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -49,8 +49,6 @@ static DEFINE_MUTEX(serio_mutex);
>  
>  static LIST_HEAD(serio_list);
>  
> -static struct bus_type serio_bus;
> -
>  static void serio_add_port(struct serio *serio);
>  static int serio_reconnect_port(struct serio *serio);
>  static void serio_disconnect_port(struct serio *serio);
> @@ -1017,7 +1015,7 @@ irqreturn_t serio_interrupt(struct serio *serio,
>  }
>  EXPORT_SYMBOL(serio_interrupt);
>  
> -static struct bus_type serio_bus = {
> +struct bus_type serio_bus = {
>  	.name		= "serio",
>  	.drv_groups	= serio_driver_groups,
>  	.match		= serio_bus_match,
> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index 9f779c7..df4ab5d 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -18,6 +18,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <uapi/linux/serio.h>
>  
> +extern struct bus_type serio_bus;
> +
>  struct serio {
>  	void *port_data;
>  
> -- 
> 2.4.3
> 
