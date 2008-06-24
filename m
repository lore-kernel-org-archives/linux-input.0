From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] serio driver: speed up resume
Date: Tue, 24 Jun 2008 10:02:58 +0800
Message-ID: <1214272978.29380.2.camel@sli10-desk.sh.intel.com>
References: <1213607375.31950.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1213607375.31950.2.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Len Brown <lenb@kernel.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2008-06-16 at 17:09 +0800, Shaohua Li wrote:
> serio_resume will call into psmouse_extensions(). In my test, the
> routine is very slow, it blocks resume about 1 sec. Below patch (move
> resume to kseriod, just like boot time probe) cures the issue in my
> test, and seems no side effect. I'm no familiar with serio driver, so
> please check.
Any comments from input guys?

Thanks,
Shaohua


> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 7f52938..7dad33f 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -163,6 +163,7 @@ enum serio_event_type {
>         SERIO_RECONNECT_PORT,
>         SERIO_REGISTER_PORT,
>         SERIO_ATTACH_DRIVER,
> +       SERIO_RESUME_PORT,
>  };
> 
>  struct serio_event {
> @@ -287,6 +288,13 @@ static struct serio_event *serio_get_event(void)
>         return event;
>  }
> 
> +#ifdef CONFIG_PM
> +static void serio_resume_port(struct device *dev);
> +#else
> +static inline void serio_resume_port(struct device *dev)
> +{
> +}
> +#endif /* CONFIG_PM */
>  static void serio_handle_event(void)
>  {
>         struct serio_event *event;
> @@ -319,6 +327,10 @@ static void serio_handle_event(void)
>                                 serio_attach_driver(event->object);
>                                 break;
> 
> +                       case SERIO_RESUME_PORT:
> +                               serio_resume_port(event->object);
> +                               break;
> +
>                         default:
>                                 break;
>                 }
> @@ -922,21 +934,26 @@ static int serio_suspend(struct device *dev,
> pm_message_t state)
>         return 0;
>  }
> 
> -static int serio_resume(struct device *dev)
> +static void serio_resume_port(struct device *dev)
>  {
>         struct serio *serio = to_serio_port(dev);
> 
> -       if (dev->power.power_state.event != PM_EVENT_ON &&
> -           serio_reconnect_driver(serio)) {
> -               /*
> -                * Driver re-probing can take a while, so better let
> kseriod
> -                * deal with it.
> -                */
> -               serio_rescan(serio);
> +       if (serio_reconnect_driver(serio)) {
> +               serio_disconnect_port(serio);
> +               serio_find_driver(serio);
>         }
> 
>         dev->power.power_state = PMSG_ON;
> +}
> 
> +static int serio_resume(struct device *dev)
> +{
> +       /*
> +        * Driver reconnect can take a while, so better let kseriod
> +        * deal with it.
> +        */
> +       if (dev->power.power_state.event != PM_EVENT_ON)
> +               serio_queue_event(dev, NULL, SERIO_RESUME_PORT);
>         return 0;
>  }
>  #endif /* CONFIG_PM */
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

