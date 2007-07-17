From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: [PATCH 3/3] leds-clevo-mail: driver for Clevo mail LED
Date: Tue, 17 Jul 2007 12:18:50 +0200
Message-ID: <469C978A.5060809@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932901AbXGQKT1@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Rodrigo Pereira <rodripe@gmail.com>
List-Id: linux-input@vger.kernel.org

=46rom: M=E1rton N=E9meth <nm127@freemail.hu>

The driver supports the mail LED commonly found on different Clevo note=
books.
The driver access the LED through the i8042 hardware and implements the=
 support for
hardware accelerated blink function.

Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>
---
diff -uprN linux-2.6.22.orig/drivers/leds/Kconfig linux-2.6.22/drivers/=
leds/Kconfig
--- linux-2.6.22.orig/drivers/leds/Kconfig	2007-07-09 01:32:17.00000000=
0 +0200
+++ linux-2.6.22/drivers/leds/Kconfig	2007-07-16 20:54:36.000000000 +02=
00
@@ -95,6 +95,26 @@ config LEDS_COBALT
  	help
  	  This option enables support for the front LED on Cobalt Server

+config LEDS_CLEVO_MAIL
+	tristate "Mail LED on Clevo notebook (EXPERIMENTAL)"
+	depends on LEDS_CLASS && X86 && SERIO_I8042 && DMI && EXPERIMENTAL
+	help
+	  This driver makes the mail LED accessible from userspace
+	  programs through the leds subsystem. This LED can blink at
+	  about 0.5Hz and 1Hz.
+
+	  This module can drive the mail LED for the following notebooks:
+
+		Clevo D410J
+		Clevo D410V
+		Clevo D400V/D470V (not tested, but might work)
+		Clevo M540N
+		Clevo M5x0N (not tested, but might work)
+		Positivo Mobile (Clevo M5x0V)
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called leds-clevo-mail.
+
  comment "LED Triggers"

  config LEDS_TRIGGERS
diff -uprN linux-2.6.22.orig/drivers/leds/leds-clevo-mail.c linux-2.6.2=
2/drivers/leds/leds-clevo-mail.c
--- linux-2.6.22.orig/drivers/leds/leds-clevo-mail.c	1970-01-01 01:00:0=
0.000000000 +0100
+++ linux-2.6.22/drivers/leds/leds-clevo-mail.c	2007-07-17 10:47:13.000=
000000 +0200
@@ -0,0 +1,269 @@
+
+#include <linux/module.h>
+
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+
+#include <linux/io.h>
+#include <linux/dmi.h>
+
+#include <linux/i8042.h>
+
+
+#define TRUE 			1
+#define FALSE			0
+
+#define CLEVO_MAIL_LED_OFF		0x0084
+#define CLEVO_MAIL_LED_BLINK_1HZ	0x008A
+#define CLEVO_MAIL_LED_BLINK_0_5HZ	0x0083
+
+#define MODULE_FNAME	"leds-clevo-mail.c"
+#define DRVNAME			"clevo-mail-led"
+#define NO_RESOURCES		NULL
+
+#define printk_hint(fmt, args...)                       \
+	printk(KERN_ERR MODULE_FNAME ": " fmt, ## args)
+
+
+#define printk_dmi(field)                               \
+	printk(KERN_ERR MODULE_FNAME                    \
+	       ":    " # field "=3D\"%s\"\n",             \
+	       dmi_get_system_info(field))
+
+
+MODULE_AUTHOR("M=E1rton N=E9meth <nm127@freemail.hu>");
+MODULE_DESCRIPTION("Clevo mail LED driver");
+MODULE_LICENSE("GPL");
+
+static unsigned int __initdata nodetect;
+module_param_named(nodetect, nodetect, bool, 0);
+MODULE_PARM_DESC(nodetect, "Skip DMI hardware detection");
+
+
+static struct platform_device *pdev;
+
+
+static int __init led_dmi_callback(struct dmi_system_id *id) {
+	printk(KERN_INFO MODULE_FNAME ": '%s' found\n", id->ident);
+	return 1;
+}
+
+/**
+ * struct mail_led_whitelist - List of known good models
+ *
+ * Contains the known good models this driver is compatible with.
+ * When adding a new model try to be as strict as possible. This
+ * makes it possible to keep the false positives (the model is
+ * detected as working, but in reality it is not) as low as
+ * possible.
+ */
+static struct dmi_system_id __initdata mail_led_whitelist[] =3D {
+	{
+		.callback =3D led_dmi_callback,
+		.ident =3D "Clevo D410J",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "VIA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "K8N800"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "VT8204B")
+		}
+	},
+	{
+		.callback =3D led_dmi_callback,
+		.ident =3D "Clevo M5x0N",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "CLEVO Co."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M5x0N")
+		}
+	},
+	{
+		.callback =3D led_dmi_callback,
+		.ident =3D "Positivo Mobile",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "CLEVO Co. "),
+			DMI_MATCH(DMI_BOARD_NAME, "M5X0V "),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Positivo Mobile"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "VT6198")
+		}
+	},
+	{
+		.callback =3D led_dmi_callback,
+		.ident =3D "Clevo D410V",
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Clevo, Co."),
+			DMI_MATCH(DMI_BOARD_NAME, "D400V/D470V"),
+			DMI_MATCH(DMI_BOARD_VERSION, "SS78B"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev. A1")
+		}
+	},
+	{ }
+};
+
+
+static void clevo_mail_led_set(struct led_classdev *led_cdev,
+				enum led_brightness value)
+{
+	if (value =3D=3D LED_OFF) {
+		i8042_command(NULL, CLEVO_MAIL_LED_OFF);
+	} else if (value <=3D LED_HALF) {
+		i8042_command(NULL, CLEVO_MAIL_LED_BLINK_0_5HZ);
+	} else {
+		i8042_command(NULL, CLEVO_MAIL_LED_BLINK_1HZ);
+	}
+
+}
+
+static int clevo_mail_led_blink(struct led_classdev *led_cdev,
+				int delay_on, int delay_off)
+{
+	int supported =3D 0;
+
+	if (delay_on =3D=3D 500 /* ms */ && delay_off =3D=3D 500 /* ms */) {
+		/* blink the led with 1Hz */
+		i8042_command(NULL, CLEVO_MAIL_LED_BLINK_1HZ);
+		supported =3D 1;
+
+	} else if (delay_on =3D=3D 1000 /* ms */ && delay_off =3D=3D 1000 /* =
ms */) {
+		/* blink the led with 0.5Hz */
+		i8042_command(NULL, CLEVO_MAIL_LED_BLINK_0_5HZ);
+		supported =3D 1;
+
+	} else {
+		printk(KERN_DEBUG MODULE_FNAME
+		       ": clevo_mail_led_blink(..., %u, %u),"
+		       " returning 0 (unsupported)\n", delay_on, delay_off);
+	}
+
+	return supported;
+}
+
+
+static struct led_classdev clevo_mail_led =3D {
+	.name			=3D "clevo::mail",
+	.brightness_set		=3D clevo_mail_led_set,
+	.blink_set		=3D clevo_mail_led_blink,
+};
+
+static int __init clevo_mail_led_probe(struct platform_device *pdev)
+{
+	int error;
+
+	printk(KERN_DEBUG MODULE_FNAME ": probe()\n");
+
+	error =3D led_classdev_register(&pdev->dev, &clevo_mail_led);
+	return error;
+}
+
+static int clevo_mail_led_remove(struct platform_device *pdev)
+{
+
+	printk(KERN_DEBUG MODULE_FNAME ": remove()\n");
+
+	led_classdev_unregister(&clevo_mail_led);
+	return 0;
+}
+
+
+
+#ifdef CONFIG_PM
+static int clevo_mail_led_suspend(struct platform_device *dev,
+				  pm_message_t state)
+{
+	led_classdev_suspend(&clevo_mail_led);
+	return 0;
+}
+
+static int clevo_mail_led_resume(struct platform_device *dev)
+{
+	led_classdev_resume(&clevo_mail_led);
+	return 0;
+}
+#endif
+
+static struct platform_driver clevo_mail_led_driver =3D {
+	.probe		=3D clevo_mail_led_probe,
+	.remove		=3D clevo_mail_led_remove,
+#ifdef CONFIG_PM
+	.suspend	=3D clevo_mail_led_suspend,
+	.resume		=3D clevo_mail_led_resume,
+#endif
+	.driver		=3D {
+		.name		=3D DRVNAME,
+	},
+};
+
+
+static __init void print_hints(void)
+{
+	if (!nodetect) {
+		printk_hint("Current hardware not supported:\n");
+	} else {
+		printk_hint("Current hardware is:\n");
+	}
+	printk_dmi(DMI_BIOS_VENDOR);
+	printk_dmi(DMI_BIOS_VERSION);
+	printk_dmi(DMI_BIOS_DATE);
+	printk_dmi(DMI_SYS_VENDOR);
+	printk_dmi(DMI_PRODUCT_NAME);
+	printk_dmi(DMI_PRODUCT_VERSION);
+	printk_dmi(DMI_PRODUCT_SERIAL);
+	printk_dmi(DMI_BOARD_VENDOR);
+	printk_dmi(DMI_BOARD_NAME);
+	printk_dmi(DMI_BOARD_VERSION);
+	if (!nodetect) {
+		printk_hint("Try 'nodetect' module parameter.\n");
+	}
+	printk_hint("If this driver is working with your hardware, report\n")=
;
+	printk_hint("it through the Tracker at\n");
+	printk_hint("http://sourceforge.net/projects/clevo-mailled/ in\n");
+	printk_hint("order your laptop model can be added to the detection.\n=
");
+	printk_hint("Please make sure to include in the report\n");
+	printk_hint("    - all lines starting with \"%s\"\n", MODULE_FNAME);
+	printk_hint("    - the product model of the laptop and\n");
+	printk_hint("    - the color of the mail led.\n");
+}
+
+static int __init led_init(void)
+{
+	int error =3D 0;
+	int count =3D 0;
+
+	/* Check with the help of DMI if we are running on supported hardware=
 */
+	if (!nodetect) {
+		count =3D dmi_check_system(mail_led_whitelist);
+	}
+	if (!count) {
+		print_hints();
+	}
+	if (!nodetect && !count) {
+		return -ENODEV;
+	}
+
+	pdev =3D platform_device_register_simple(DRVNAME, -1, NO_RESOURCES, 0=
);
+	if (!IS_ERR(pdev)) {
+		error =3D platform_driver_probe(&clevo_mail_led_driver,
+					      clevo_mail_led_probe);
+		if (error) {
+			printk(KERN_ERR MODULE_FNAME
+			       ": Can't probe platform driver\n");
+			platform_device_unregister(pdev);
+		}
+	} else {
+		error =3D PTR_ERR(pdev);
+	}
+
+	return error;
+}
+
+static void __exit led_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&clevo_mail_led_driver);
+
+	clevo_mail_led_set(NULL, LED_OFF);
+
+	printk(KERN_DEBUG MODULE_FNAME ": unloaded\n");
+}
+
+module_init(led_init);
+module_exit(led_exit);
diff -uprN linux-2.6.22.orig/drivers/leds/Makefile linux-2.6.22/drivers=
/leds/Makefile
--- linux-2.6.22.orig/drivers/leds/Makefile	2007-07-09 01:32:17.0000000=
00 +0200
+++ linux-2.6.22/drivers/leds/Makefile	2007-07-16 20:53:38.000000000 +0=
200
@@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_NET48XX)		+=3D leds-net4
  obj-$(CONFIG_LEDS_WRAP)			+=3D leds-wrap.o
  obj-$(CONFIG_LEDS_H1940)		+=3D leds-h1940.o
  obj-$(CONFIG_LEDS_COBALT)		+=3D leds-cobalt.o
+obj-$(CONFIG_LEDS_CLEVO_MAIL)		+=3D leds-clevo-mail.o

  # LED Triggers
  obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+=3D ledtrig-timer.o
