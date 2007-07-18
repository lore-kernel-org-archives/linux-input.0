From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HP Jornada 7xx keyboard support
Date: Wed, 18 Jul 2007 11:00:06 -0400
Message-ID: <d120d5000707180800k5e4d6538p7df9be9e134609fc@mail.gmail.com>
References: <20070718163259.2565fb8c.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070718163259.2565fb8c.Kristoffer.Ericson@Gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

Hi Kristoffer,

On 7/18/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> Greetings,
>

Thank you for your patch, I have a couple of comments.

> Couldnt find any mailinglist, but please CC this there if there is one.
>

CCing linus-input...

> +       /* Lets drag them out one at a time */
> +       while (count-- > 0) {
> +               /* Exchange TxDummy for a real key */
> +               key = kbd_data = jornada_ssp_inout(TxDummy);
> +
> +               if (key < 0) { /* whoops, no more waiting */

key is declared as "unsigned char", how can this condition ever trigger?

> +                   jornada_ssp_end(); /* End transmission */
> +                   return IRQ_HANDLED;
> +               }
> +
> +               if (key > 128) /* Key released */
> +                       key = key - 128;
> +
> +               keycode = jornada_normal_keymap[key];
> +
> +               /* A key pressed down */
> +               if (kbd_data < 128) {
> +                       input_report_key(input_dev,keycode, 1);
> +                       input_sync(input_dev);
> +               }
> +               else { /* Key released */
> +                       input_report_key(input_dev, keycode, 0);
> +                       input_sync(input_dev);
> +               }

All of this can be probably written as:
        input_report_key(input_dev,
                jornada_normal_keymap[kbd_data & 0x7f],
                !(kbd_data & 0x80));
       input_sync(input_dev);

> +       }
> +       jornada_ssp_end(); /* End Transmission */
> +       return IRQ_HANDLED;
> +};
> +
> +static int jornada720_kbd_probe(struct platform_device *pdev)

__devinit?

> +{
> +       int i, ret;
> +
> +       input_dev = input_allocate_device();
> +       if (!input_dev) {
> +               return -ENOMEM;
> +       };
> +
> +       input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
> +       input_dev->keybit[LONG(KEY_SUSPEND)] |= BIT(KEY_SUSPEND);

Why special treatment of KEY_SUSPEND?

> +
> +       input_dev->name = "HP Jornada 720 keyboard";
> +       input_dev->phys = "jornadakbd/input0";

please add "input_dev->dev.parent = &pdev->dev;" to place input device
into proper place in sysfs.

> +
> +       for (i=0 ; i<=128 ; i++) {
> +               if (jornada_normal_keymap[i])
> +                       set_bit(jornada_normal_keymap[i], input_dev->keybit);
> +       }


Please allocate a copy of keymap and assign keycode, keycodemax and
keycodesize in input_dev so that keymap can be adjusted at runtime.

> +
> +       ret = request_irq(IRQ_GPIO0,
> +                       jornada720_kbd_interrupt,
> +                       IRQF_DISABLED | IRQF_TRIGGER_FALLING,
> +                       "jornadakbd", input_dev);
> +       if (ret) {
> +               printk(KERN_INFO "Unable to grab IRQ for %s: %d\n", "jornadakbd", ret);
> +               input_free_device(input_dev);
> +               return ret;
> +       }
> +
> +       input_register_device(input_dev);

Error hanling please.

> +
> +       return 0;
> +};
> +
> +static int jornada720_kbd_remove(struct platform_device *pdev)

__devexit?

> +{
> +       free_irq(IRQ_GPIO0, input_dev);
> +       input_unregister_device(input_dev);
> +       return 0;
> +}
> +
> +static struct platform_driver jornada720_kbd_driver = {
> +        .driver  = {
> +                  .name    = "jornada720_kbd",
> +                },
> +       .probe   = jornada720_kbd_probe,
> +       .remove  = jornada720_kbd_remove,
> +};
> +
> +static int __devinit jornada720_kbd_init(void)
> +{
> +        printk(KERN_INFO "HP Jornada 720 keyboard driver initialized\n");

I'd lose this printk - input core will print appropriate message when
input device is registered.

> +       return platform_driver_register(&jornada720_kbd_driver);
> +}
> +
> +static void __exit jornada720_kbd_exit(void)
> +{
> +       platform_driver_unregister(&jornada720_kbd_driver);
> +}
> +
> +module_init(jornada720_kbd_init);
> +module_exit(jornada720_kbd_exit);
>

Kconfig and Makefile changes seem to be missing..?

-- 
Dmitry
