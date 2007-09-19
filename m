From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [HP7XX/PATCH] - HP720 Jornada Touchscreen (Updated, please use this one)
Date: Wed, 19 Sep 2007 15:19:36 -0400
Message-ID: <d120d5000709191219u46aca089u5a00107b848fff30@mail.gmail.com>
References: <20070919204926.b29e3884.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070919204926.b29e3884.Kristoffer.ericson@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Kristoffer,

On 9/19/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> Greetings,
>
> Dmitry, I had some issues with the last patch I sent you. Something with the init sequence of devices, it basicly made it kernel panic. I've re-coded the driver to instead work as a platform driver, that way I have more control of which gets started first.

Yes, that's better. I guess the issue with the other driver was that
you did not setup driver->bus and the kernel blew up in
driver_register().

> +
> +       /* start ssp and do a spinlock */
> +       jornada_ssp_start();
> +
> +       /* request x & y data */
> +       if(jornada_ssp_inout(GETTOUCHSAMPLES) != TXDUMMY) {
> +               jornada_ssp_end();
> +               return IRQ_HANDLED;
> +       }
> +
...
> +       /* end ssp communication and release spinlock */
> +       jornada_ssp_end();

I really prefer acquire/release type of functions to be in pairs. I.e.
I'd prefer something like:

+       /* start ssp and do a spinlock */
+       jornada_ssp_start();
+
+       /* request x & y data */
+       if (jornada_ssp_inout(GETTOUCHSAMPLES) != TXDUMMY) {
+               jornada_parse_data(...);
+               jornada_post_data(...)
+       }
+       jornada_ssp_end();
+       return IRQ_HANDLED;

> +       /* report pen down */
> +       input_report_key(jornada_ts->dev, BTN_TOUCH, 1);
> +       input_report_abs(jornada_ts->dev, ABS_X, jornada_ts->x);
> +       input_report_abs(jornada_ts->dev, ABS_Y, jornada_ts->y);
> +       input_report_abs(jornada_ts->dev, ABS_PRESSURE, 1);

The device does not really report pressure value, so I'd not report
ABS_PRESSURE. BTN_TOUCH should be enogh.

> +
> +static int __init jornada720_ts_probe(struct platform_device *pdev)

__devinit.

> +{
> +       struct jornada_ts *jornada_ts;
> +       struct input_dev *input_dev;
> +       int ret;
> +
> +       input_dev = input_allocate_device();
> +       if (!input_dev)
> +           return -ENODEV;
> +
> +       jornada_ts = kzalloc(sizeof(struct jornada_ts), GFP_KERNEL);
> +       if (!jornada_ts)
> +           goto failed1;
> +
> +       platform_set_drvdata(pdev, jornada_ts);
> +
> +       jornada_ts->dev = input_dev;
> +
> +       input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
> +       input_dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
> +       input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
> +
> +       input_dev->absmin[ABS_X] = 270;
> +       input_dev->absmin[ABS_Y] = 180;
> +       input_dev->absmax[ABS_X] = 3900;
> +       input_dev->absmax[ABS_Y] = 3700;

I like using input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0); ...

> +
> +       input_dev->name = "HP Jornada 710/720/728 Touchscreen driver";
> +
> +       ret = request_irq(IRQ_GPIO9,
> +                       jornada720_ts_interrupt,
> +                       IRQF_DISABLED | IRQF_TRIGGER_RISING,
> +                       "HP7XX Touchscreen driver", jornada_ts);
> +       if (ret) {
> +               printk(KERN_INFO "HP7XX TS : Unable to aquire irq!\n");
> +               goto failed2;
> +       }
> +
> +       input_register_device(input_dev);
> +       return 0;

Error handling please.

> +
> +failed1:
> +       input_free_device(input_dev);
> +       return -ENOMEM;
> +failed2:
> +       kfree(jornada_ts);
> +       input_free_device(input_dev);

This leaves invalid pointer in platform data structure. I'd recommend
calling platform_set_drvdata(pdev, jornada_ts); ony after making sure
that input_register_device() was successfull.

> +       return -ENODEV;

If you use out-of-line error handling path please make it have single
return point. Btw, if you allocate all memity that is needed first and
then check for success you can fold the erro handling path somewhat.

> +}
> +
> +static int jornada720_ts_remove(struct platform_device *pdev)

__devexit.

> +{
> +       struct jornada_ts *jornada_ts = platform_get_drvdata(pdev);
> +
> +       free_irq(IRQ_GPIO9, pdev);
> +       input_unregister_device(jornada_ts->dev);
> +       kfree(jornada_ts);
> +       return 0;
> +}
> +
> +static struct platform_driver jornada720_ts_driver = {
> +       .probe          = jornada720_ts_probe,
> +       .remove         = jornada720_ts_remove,

__devexit_p(jornada720_ts_remove)

> +       .driver         = {
> +               .name   = "jornada_ts_driver",

I don't think platform code will match on this name. I'd expect simply
"jornada_ts" but it really depends on how you create the platform
device.

> +       },
> +};
> +
> +static int __devinit jornada720_ts_init(void)

This one should be simply __init.

> +{
> +       return platform_driver_register(&jornada720_ts_driver);
> +}
> +
> +static void __exit jornada720_ts_exit(void)
> +{
> +       platform_driver_unregister(&jornada720_ts_driver);
> +}
> +
> +module_init(jornada720_ts_init);
> +module_exit(jornada720_ts_exit);
>
>


-- 
Dmitry
