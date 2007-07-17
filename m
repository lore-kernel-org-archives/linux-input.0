From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] leds-clevo-mail: driver for Clevo mail LED
Date: Tue, 17 Jul 2007 09:20:34 -0400
Message-ID: <d120d5000707170620y31b8351dkb904312445f3f6e3@mail.gmail.com>
References: <469C978A.5060809@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469C978A.5060809@freemail.hu>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Rodrigo Pereira <rodripe@gmail.com>
List-Id: linux-input@vger.kernel.org

On 7/17/07, N=E9meth M=E1rton <nm127@freemail.hu> wrote:
> +
> +#define TRUE                   1
> +#define FALSE                  0
> +
> +#define CLEVO_MAIL_LED_OFF             0x0084
> +#define CLEVO_MAIL_LED_BLINK_1HZ       0x008A
> +#define CLEVO_MAIL_LED_BLINK_0_5HZ     0x0083
> +
> +#define MODULE_FNAME   "leds-clevo-mail.c"
> +#define DRVNAME                        "clevo-mail-led"
> +#define NO_RESOURCES           NULL
> +
> +#define printk_hint(fmt, args...)                       \
> +       printk(KERN_ERR MODULE_FNAME ": " fmt, ## args)
> +
> +
> +#define printk_dmi(field)                               \
> +       printk(KERN_ERR MODULE_FNAME                    \
> +              ":    " # field "=3D\"%s\"\n",             \
> +              dmi_get_system_info(field))
> +
> +
> +MODULE_AUTHOR("M=E1rton N=E9meth <nm127@freemail.hu>");
> +MODULE_DESCRIPTION("Clevo mail LED driver");
> +MODULE_LICENSE("GPL");
> +
> +static unsigned int __initdata nodetect;
> +module_param_named(nodetect, nodetect, bool, 0);
> +MODULE_PARM_DESC(nodetect, "Skip DMI hardware detection");
> +
> +
> +static struct platform_device *pdev;
> +
> +
> +static int __init led_dmi_callback(struct dmi_system_id *id) {

Functions are not statements (opening brace placement).

> +       printk(KERN_INFO MODULE_FNAME ": '%s' found\n", id->ident);
> +       return 1;
> +}
> +
> +/**
> + * struct mail_led_whitelist - List of known good models
> + *
> + * Contains the known good models this driver is compatible with.
> + * When adding a new model try to be as strict as possible. This
> + * makes it possible to keep the false positives (the model is
> + * detected as working, but in reality it is not) as low as
> + * possible.
> + */
> +static struct dmi_system_id __initdata mail_led_whitelist[] =3D {
> +       {
> +               .callback =3D led_dmi_callback,
> +               .ident =3D "Clevo D410J",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "VIA"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "K8N800"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "VT8204B")
> +               }
> +       },
> +       {
> +               .callback =3D led_dmi_callback,
> +               .ident =3D "Clevo M5x0N",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "CLEVO Co."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "M5x0N")
> +               }
> +       },
> +       {
> +               .callback =3D led_dmi_callback,
> +               .ident =3D "Positivo Mobile",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "CLEVO Co. "),
> +                       DMI_MATCH(DMI_BOARD_NAME, "M5X0V "),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Positivo Mobile"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "VT6198")
> +               }
> +       },
> +       {
> +               .callback =3D led_dmi_callback,
> +               .ident =3D "Clevo D410V",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Clevo, Co."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "D400V/D470V"),
> +                       DMI_MATCH(DMI_BOARD_VERSION, "SS78B"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Rev. A1")
> +               }
> +       },
> +       { }
> +};
> +
> +
> +static void clevo_mail_led_set(struct led_classdev *led_cdev,
> +                               enum led_brightness value)
> +{
> +       if (value =3D=3D LED_OFF) {
> +               i8042_command(NULL, CLEVO_MAIL_LED_OFF);
> +       } else if (value <=3D LED_HALF) {
> +               i8042_command(NULL, CLEVO_MAIL_LED_BLINK_0_5HZ);
> +       } else {
> +               i8042_command(NULL, CLEVO_MAIL_LED_BLINK_1HZ);
> +       }
> +

I think general preference is not to use braces for single-line bodies.

> +}
> +
> +static int clevo_mail_led_blink(struct led_classdev *led_cdev,
> +                               int delay_on, int delay_off)
> +{
> +       int supported =3D 0;
> +
> +       if (delay_on =3D=3D 500 /* ms */ && delay_off =3D=3D 500 /* ms */=
) {
> +               /* blink the led with 1Hz */
> +               i8042_command(NULL, CLEVO_MAIL_LED_BLINK_1HZ);
> +               supported =3D 1;
> +
> +       } else if (delay_on =3D=3D 1000 /* ms */ && delay_off =3D=3D 1000=
 /* ms */) {
> +               /* blink the led with 0.5Hz */
> +               i8042_command(NULL, CLEVO_MAIL_LED_BLINK_0_5HZ);
> +               supported =3D 1;
> +
> +       } else {
> +               printk(KERN_DEBUG MODULE_FNAME
> +                      ": clevo_mail_led_blink(..., %u, %u),"
> +                      " returning 0 (unsupported)\n", delay_on, delay_of=
f);
> +       }
> +
> +       return supported;

Please return 0/-EINVAL.

> +}
> +
> +
> +static struct led_classdev clevo_mail_led =3D {
> +       .name                   =3D "clevo::mail",
> +       .brightness_set         =3D clevo_mail_led_set,
> +       .blink_set              =3D clevo_mail_led_blink,
> +};
> +
> +static int __init clevo_mail_led_probe(struct platform_device *pdev)
> +{
> +       int error;
> +
> +       printk(KERN_DEBUG MODULE_FNAME ": probe()\n");
> +

Use pr_debug here or just kill it - it will litter users dmesgs.

> +       error =3D led_classdev_register(&pdev->dev, &clevo_mail_led);
> +       return error;
> +}
> +
> +static int clevo_mail_led_remove(struct platform_device *pdev)
> +{
> +
> +       printk(KERN_DEBUG MODULE_FNAME ": remove()\n");
> +
> +       led_classdev_unregister(&clevo_mail_led);
> +       return 0;
> +}
> +
> +
> +
> +#ifdef CONFIG_PM
> +static int clevo_mail_led_suspend(struct platform_device *dev,
> +                                 pm_message_t state)
> +{
> +       led_classdev_suspend(&clevo_mail_led);
> +       return 0;
> +}
> +
> +static int clevo_mail_led_resume(struct platform_device *dev)
> +{
> +       led_classdev_resume(&clevo_mail_led);
> +       return 0;
> +}
> +#endif
> +
> +static struct platform_driver clevo_mail_led_driver =3D {
> +       .probe          =3D clevo_mail_led_probe,
> +       .remove         =3D clevo_mail_led_remove,
> +#ifdef CONFIG_PM
> +       .suspend        =3D clevo_mail_led_suspend,
> +       .resume         =3D clevo_mail_led_resume,
> +#endif
> +       .driver         =3D {
> +               .name           =3D DRVNAME,
> +       },
> +};
> +
> +
> +static __init void print_hints(void)
> +{
> +       if (!nodetect) {
> +               printk_hint("Current hardware not supported:\n");
> +       } else {
> +               printk_hint("Current hardware is:\n");
> +       }
> +       printk_dmi(DMI_BIOS_VENDOR);
> +       printk_dmi(DMI_BIOS_VERSION);
> +       printk_dmi(DMI_BIOS_DATE);
> +       printk_dmi(DMI_SYS_VENDOR);
> +       printk_dmi(DMI_PRODUCT_NAME);
> +       printk_dmi(DMI_PRODUCT_VERSION);
> +       printk_dmi(DMI_PRODUCT_SERIAL);
> +       printk_dmi(DMI_BOARD_VENDOR);
> +       printk_dmi(DMI_BOARD_NAME);
> +       printk_dmi(DMI_BOARD_VERSION);
> +       if (!nodetect) {
> +               printk_hint("Try 'nodetect' module parameter.\n");
> +       }
> +       printk_hint("If this driver is working with your hardware, report=
\n");
> +       printk_hint("it through the Tracker at\n");
> +       printk_hint("http://sourceforge.net/projects/clevo-mailled/ in\n"=
);
> +       printk_hint("order your laptop model can be added to the detectio=
n.\n");
> +       printk_hint("Please make sure to include in the report\n");
> +       printk_hint("    - all lines starting with \"%s\"\n", MODULE_FNAM=
E);
> +       printk_hint("    - the product model of the laptop and\n");
> +       printk_hint("    - the color of the mail led.\n");
> +}
> +
> +static int __init led_init(void)

clevo_led_init just to be consistent with the rest of the driver?

> +{
> +       int error =3D 0;
> +       int count =3D 0;
> +
> +       /* Check with the help of DMI if we are running on supported hard=
ware */
> +       if (!nodetect) {
> +               count =3D dmi_check_system(mail_led_whitelist);
> +       }
> +       if (!count) {
> +               print_hints();

I really don't want to see that dissertation on my box. Normally we
silently return if DMI data does not match. User has an option to
'force' loading the module. In that case I'd say something like
'Forcing module load. If the driver works on your hardware please
report in tracker at http://sourceforge.net/projects/clevo-mailled/"

--=20
Dmitry
