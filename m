From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [HP7XX/PATCH] - HP720 Jornada Touchscreen (Updated, please use
 this one)
Date: Wed, 19 Sep 2007 22:31:38 -0700
Message-ID: <20070919223138.1f0b79d1.Kristoffer.ericson@gmail.com>
References: <20070919204926.b29e3884.Kristoffer.ericson@gmail.com>
	<d120d5000709191219u46aca089u5a00107b848fff30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__19_Sep_2007_22_31_38_-0700_ytHrK/pk3AkkxB5w"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000709191219u46aca089u5a00107b848fff30@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__19_Sep_2007_22_31_38_-0700_ytHrK/pk3AkkxB5w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oki, believe Ive adressed all your suggestions. 

diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
new file mode 100644
index 0000000..124da74
--- /dev/null
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -0,0 +1,172 @@
+/*
+ * drivers/input/touchscreen/jornada720_ts.c
+ *
+ * Copyright (C) 2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
+ *
+ *  Copyright (C) 2006 Filip Zyzniewski <filip.zyzniewski@tefnet.pl>
+ *  based on HP Jornada 56x touchscreen driver by Alex Lange <chicken@handhelds.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * HP Jornada 710/720/729 Touchscreen Driver
+ */
+
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include <asm/hardware.h>
+#include <asm/arch/jornada720.h>
+
+MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
+MODULE_DESCRIPTION("HP Jornada 710/720/728 touchscreen driver");
+MODULE_LICENSE("GPLv2");
+
+struct jornada_ts {
+	struct input_dev *dev;
+	int X[3];		/* X sample values */
+	int Y[3];		/* Y sample values */
+	int high_x, high_y;
+	int x, y;		/* calculated value */
+};
+
+static void jornada720_ts_calculate(struct jornada_ts *jornada_ts)
+{
+    jornada_ts->X[0] |= (jornada_ts->high_x & 3) << 8;
+    jornada_ts->X[1] |= (jornada_ts->high_x & 0xc) << 6;
+    jornada_ts->X[2] |= (jornada_ts->high_x & 0x30) << 4;
+    
+    jornada_ts->Y[0] |= (jornada_ts->high_y & 3) << 8;
+    jornada_ts->Y[1] |= (jornada_ts->high_y & 0xc) << 6;
+    jornada_ts->Y[2] |= (jornada_ts->high_y & 0x30) << 4;
+    
+    jornada_ts->x = ((jornada_ts->X[0] + jornada_ts->X[1] + jornada_ts->X[2]) / 3);
+    jornada_ts->y = ((jornada_ts->Y[0] + jornada_ts->Y[1] + jornada_ts->X[2]) / 3);
+};
+
+static void jornada720_ts_collectdata(struct jornada_ts *jornada_ts)
+{
+    int i;
+
+    /* 3 low word X samples */
+    for (i = 0; i < 3; i++)
+	jornada_ts->X[i] = jornada_ssp_byte(TXDUMMY);
+    /* 3 low word Y samples */
+    for (i = 0; i < 3; i++)
+	jornada_ts->Y[i] = jornada_ssp_byte(TXDUMMY);
+
+    /* combined x samples bits */
+    jornada_ts->high_x = jornada_ssp_byte(TXDUMMY);
+    /* combined y samples bits */
+    jornada_ts->high_y = jornada_ssp_byte(TXDUMMY);
+} 
+        
+static irqreturn_t jornada720_ts_interrupt(int irq, void *dev_id)
+{
+	struct jornada_ts *jornada_ts = dev_id;
+
+	/* If GPIO_GPIO9 is set to high then report pen up */
+	if(GPLR & GPIO_GPIO(9)) {
+		input_report_key(jornada_ts->dev, BTN_TOUCH, 0);
+		input_sync(jornada_ts->dev);
+		return IRQ_HANDLED;
+	}
+
+	jornada_ssp_start();
+	
+	/* proper reply to request is always TXDUMMY */
+	if (jornada_ssp_inout(GETTOUCHSAMPLES == TXDUMMY)) {
+	    jornada720_ts_collectdata(jornada_ts);
+	    jornada720_ts_calculate(jornada_ts);
+	    
+	    input_report_key(jornada_ts->dev, BTN_TOUCH, 1);
+	    input_report_abs(jornada_ts->dev, ABS_X, jornada_ts->x);
+	    input_report_abs(jornada_ts->dev, ABS_Y, jornada_ts->y);
+	}
+	
+	jornada_ssp_end();
+	return IRQ_HANDLED;
+}
+
+static int __devinit jornada720_ts_probe(struct platform_device *pdev)
+{
+	struct jornada_ts *jornada_ts;
+	struct input_dev *input_dev;
+	int ret;
+
+	jornada_ts = kzalloc(sizeof(struct jornada_ts), GFP_KERNEL);
+	if (!jornada_ts)
+	    return -ENOMEM;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+	    goto failed1;
+
+	jornada_ts->dev = input_dev;
+	
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 180, 3700, 0, 0);
+
+	input_dev->name = "HP Jornada 710/720/728 Touchscreen driver";
+
+	ret = request_irq(IRQ_GPIO9,
+			jornada720_ts_interrupt,
+			IRQF_DISABLED | IRQF_TRIGGER_RISING,
+			"HP7XX Touchscreen driver", jornada_ts);
+	if (ret) {
+		printk(KERN_INFO "HP7XX TS : Unable to aquire irq!\n");
+		goto failed2;
+	}
+
+	if (input_register_device(input_dev))
+	    goto failed2;
+	
+	platform_set_drvdata(pdev, jornada_ts);
+	
+	return 0;
+
+failed2: 
+	input_free_device(input_dev);
+failed1: 
+	kfree(jornada_ts);
+	return -ENODEV;
+}
+
+static int __devexit jornada720_ts_remove(struct platform_device *pdev)
+{
+	struct jornada_ts *jornada_ts = platform_get_drvdata(pdev);
+
+	free_irq(IRQ_GPIO9, pdev);
+	input_unregister_device(jornada_ts->dev);
+	kfree(jornada_ts);
+	return 0;
+}
+
+static struct platform_driver jornada720_ts_driver = {
+	.probe		= jornada720_ts_probe,
+	.remove		= __devexit_p(jornada720_ts_remove),
+	.driver		= {
+		.name	= "jornada_ts",
+	},
+};
+
+static int __init jornada720_ts_init(void)
+{
+	return platform_driver_register(&jornada720_ts_driver);
+}
+
+static void __exit jornada720_ts_exit(void)
+{
+	platform_driver_unregister(&jornada720_ts_driver);
+}
+
+module_init(jornada720_ts_init);
+module_exit(jornada720_ts_exit);



On Wed, 19 Sep 2007 15:19:36 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> Hi Kristoffer,
> 
> On 9/19/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> > Greetings,
> >
> > Dmitry, I had some issues with the last patch I sent you. Something with the init sequence of devices, it basicly made it kernel panic. I've re-coded the driver to instead work as a platform driver, that way I have more control of which gets started first.
> 
> Yes, that's better. I guess the issue with the other driver was that
> you did not setup driver->bus and the kernel blew up in
> driver_register().
> 
> > +
> > +       /* start ssp and do a spinlock */
> > +       jornada_ssp_start();
> > +
> > +       /* request x & y data */
> > +       if(jornada_ssp_inout(GETTOUCHSAMPLES) != TXDUMMY) {
> > +               jornada_ssp_end();
> > +               return IRQ_HANDLED;
> > +       }
> > +
> ...
> > +       /* end ssp communication and release spinlock */
> > +       jornada_ssp_end();
> 
> I really prefer acquire/release type of functions to be in pairs. I.e.
> I'd prefer something like:
> 
> +       /* start ssp and do a spinlock */
> +       jornada_ssp_start();
> +
> +       /* request x & y data */
> +       if (jornada_ssp_inout(GETTOUCHSAMPLES) != TXDUMMY) {
> +               jornada_parse_data(...);
> +               jornada_post_data(...)
> +       }
> +       jornada_ssp_end();
> +       return IRQ_HANDLED;
> 
> > +       /* report pen down */
> > +       input_report_key(jornada_ts->dev, BTN_TOUCH, 1);
> > +       input_report_abs(jornada_ts->dev, ABS_X, jornada_ts->x);
> > +       input_report_abs(jornada_ts->dev, ABS_Y, jornada_ts->y);
> > +       input_report_abs(jornada_ts->dev, ABS_PRESSURE, 1);
> 
> The device does not really report pressure value, so I'd not report
> ABS_PRESSURE. BTN_TOUCH should be enogh.
> 
> > +
> > +static int __init jornada720_ts_probe(struct platform_device *pdev)
> 
> __devinit.
> 
> > +{
> > +       struct jornada_ts *jornada_ts;
> > +       struct input_dev *input_dev;
> > +       int ret;
> > +
> > +       input_dev = input_allocate_device();
> > +       if (!input_dev)
> > +           return -ENODEV;
> > +
> > +       jornada_ts = kzalloc(sizeof(struct jornada_ts), GFP_KERNEL);
> > +       if (!jornada_ts)
> > +           goto failed1;
> > +
> > +       platform_set_drvdata(pdev, jornada_ts);
> > +
> > +       jornada_ts->dev = input_dev;
> > +
> > +       input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
> > +       input_dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
> > +       input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
> > +
> > +       input_dev->absmin[ABS_X] = 270;
> > +       input_dev->absmin[ABS_Y] = 180;
> > +       input_dev->absmax[ABS_X] = 3900;
> > +       input_dev->absmax[ABS_Y] = 3700;
> 
> I like using input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0); ...
>
> > +
> > +       input_dev->name = "HP Jornada 710/720/728 Touchscreen driver";
> > +
> > +       ret = request_irq(IRQ_GPIO9,
> > +                       jornada720_ts_interrupt,
> > +                       IRQF_DISABLED | IRQF_TRIGGER_RISING,
> > +                       "HP7XX Touchscreen driver", jornada_ts);
> > +       if (ret) {
> > +               printk(KERN_INFO "HP7XX TS : Unable to aquire irq!\n");
> > +               goto failed2;
> > +       }
> > +
> > +       input_register_device(input_dev);
> > +       return 0;
> 
> Error handling please.
> 
> > +
> > +failed1:
> > +       input_free_device(input_dev);
> > +       return -ENOMEM;
> > +failed2:
> > +       kfree(jornada_ts);
> > +       input_free_device(input_dev);
> 
> This leaves invalid pointer in platform data structure. I'd recommend
> calling platform_set_drvdata(pdev, jornada_ts); ony after making sure
> that input_register_device() was successfull.
> 
> > +       return -ENODEV;
> 
> If you use out-of-line error handling path please make it have single
> return point. Btw, if you allocate all memity that is needed first and
> then check for success you can fold the erro handling path somewhat.
> 
> > +}
> > +
> > +static int jornada720_ts_remove(struct platform_device *pdev)
> 
> __devexit.
> 
> > +{
> > +       struct jornada_ts *jornada_ts = platform_get_drvdata(pdev);
> > +
> > +       free_irq(IRQ_GPIO9, pdev);
> > +       input_unregister_device(jornada_ts->dev);
> > +       kfree(jornada_ts);
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver jornada720_ts_driver = {
> > +       .probe          = jornada720_ts_probe,
> > +       .remove         = jornada720_ts_remove,
> 
> __devexit_p(jornada720_ts_remove)
> 
> > +       .driver         = {
> > +               .name   = "jornada_ts_driver",
> 
> I don't think platform code will match on this name. I'd expect simply
> "jornada_ts" but it really depends on how you create the platform
> device.
> 
> > +       },
> > +};
> > +
> > +static int __devinit jornada720_ts_init(void)
> 
> This one should be simply __init.
> 
> > +{
> > +       return platform_driver_register(&jornada720_ts_driver);
> > +}
> > +
> > +static void __exit jornada720_ts_exit(void)
> > +{
> > +       platform_driver_unregister(&jornada720_ts_driver);
> > +}
> > +
> > +module_init(jornada720_ts_init);
> > +module_exit(jornada720_ts_exit);
> >
> >
> 
> 
> -- 
> Dmitry

--Multipart=_Wed__19_Sep_2007_22_31_38_-0700_ytHrK/pk3AkkxB5w
Content-Type: application/octet-stream;
 name="hp7xx-touchscreen-support.patch"
Content-Disposition: attachment;
 filename="hp7xx-touchscreen-support.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jIGIv
ZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uMTI0ZGE3NAotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMv
aW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jCkBAIC0wLDAgKzEsMTcyIEBACisvKgor
ICogZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKKyAqCisgKiBDb3B5
cmlnaHQgKEMpIDIwMDcgS3Jpc3RvZmZlciBFcmljc29uIDxLcmlzdG9mZmVyLkVyaWNzb25AZ21h
aWwuY29tPgorICoKKyAqICBDb3B5cmlnaHQgKEMpIDIwMDYgRmlsaXAgWnl6bmlld3NraSA8Zmls
aXAuenl6bmlld3NraUB0ZWZuZXQucGw+CisgKiAgYmFzZWQgb24gSFAgSm9ybmFkYSA1NnggdG91
Y2hzY3JlZW4gZHJpdmVyIGJ5IEFsZXggTGFuZ2UgPGNoaWNrZW5AaGFuZGhlbGRzLm9yZz4KKyAq
CisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAqIEhQIEpvcm5hZGEgNzEwLzcyMC83MjkgVG91Y2hz
Y3JlZW4gRHJpdmVyCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgor
I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgorI2luY2x1
ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorCisjaW5j
bHVkZSA8YXNtL2hhcmR3YXJlLmg+CisjaW5jbHVkZSA8YXNtL2FyY2gvam9ybmFkYTcyMC5oPgor
CitNT0RVTEVfQVVUSE9SKCJLcmlzdG9mZmVyIEVyaWNzb24gPGtyaXN0b2ZmZXIuZXJpY3NvbkBn
bWFpbC5jb20+Iik7CitNT0RVTEVfREVTQ1JJUFRJT04oIkhQIEpvcm5hZGEgNzEwLzcyMC83Mjgg
dG91Y2hzY3JlZW4gZHJpdmVyIik7CitNT0RVTEVfTElDRU5TRSgiR1BMdjIiKTsKKworc3RydWN0
IGpvcm5hZGFfdHMgeworCXN0cnVjdCBpbnB1dF9kZXYgKmRldjsKKwlpbnQgWFszXTsJCS8qIFgg
c2FtcGxlIHZhbHVlcyAqLworCWludCBZWzNdOwkJLyogWSBzYW1wbGUgdmFsdWVzICovCisJaW50
IGhpZ2hfeCwgaGlnaF95OworCWludCB4LCB5OwkJLyogY2FsY3VsYXRlZCB2YWx1ZSAqLworfTsK
Kworc3RhdGljIHZvaWQgam9ybmFkYTcyMF90c19jYWxjdWxhdGUoc3RydWN0IGpvcm5hZGFfdHMg
Kmpvcm5hZGFfdHMpCit7CisgICAgam9ybmFkYV90cy0+WFswXSB8PSAoam9ybmFkYV90cy0+aGln
aF94ICYgMykgPDwgODsKKyAgICBqb3JuYWRhX3RzLT5YWzFdIHw9IChqb3JuYWRhX3RzLT5oaWdo
X3ggJiAweGMpIDw8IDY7CisgICAgam9ybmFkYV90cy0+WFsyXSB8PSAoam9ybmFkYV90cy0+aGln
aF94ICYgMHgzMCkgPDwgNDsKKyAgICAKKyAgICBqb3JuYWRhX3RzLT5ZWzBdIHw9IChqb3JuYWRh
X3RzLT5oaWdoX3kgJiAzKSA8PCA4OworICAgIGpvcm5hZGFfdHMtPllbMV0gfD0gKGpvcm5hZGFf
dHMtPmhpZ2hfeSAmIDB4YykgPDwgNjsKKyAgICBqb3JuYWRhX3RzLT5ZWzJdIHw9IChqb3JuYWRh
X3RzLT5oaWdoX3kgJiAweDMwKSA8PCA0OworICAgIAorICAgIGpvcm5hZGFfdHMtPnggPSAoKGpv
cm5hZGFfdHMtPlhbMF0gKyBqb3JuYWRhX3RzLT5YWzFdICsgam9ybmFkYV90cy0+WFsyXSkgLyAz
KTsKKyAgICBqb3JuYWRhX3RzLT55ID0gKChqb3JuYWRhX3RzLT5ZWzBdICsgam9ybmFkYV90cy0+
WVsxXSArIGpvcm5hZGFfdHMtPlhbMl0pIC8gMyk7Cit9OworCitzdGF0aWMgdm9pZCBqb3JuYWRh
NzIwX3RzX2NvbGxlY3RkYXRhKHN0cnVjdCBqb3JuYWRhX3RzICpqb3JuYWRhX3RzKQoreworICAg
IGludCBpOworCisgICAgLyogMyBsb3cgd29yZCBYIHNhbXBsZXMgKi8KKyAgICBmb3IgKGkgPSAw
OyBpIDwgMzsgaSsrKQorCWpvcm5hZGFfdHMtPlhbaV0gPSBqb3JuYWRhX3NzcF9ieXRlKFRYRFVN
TVkpOworICAgIC8qIDMgbG93IHdvcmQgWSBzYW1wbGVzICovCisgICAgZm9yIChpID0gMDsgaSA8
IDM7IGkrKykKKwlqb3JuYWRhX3RzLT5ZW2ldID0gam9ybmFkYV9zc3BfYnl0ZShUWERVTU1ZKTsK
KworICAgIC8qIGNvbWJpbmVkIHggc2FtcGxlcyBiaXRzICovCisgICAgam9ybmFkYV90cy0+aGln
aF94ID0gam9ybmFkYV9zc3BfYnl0ZShUWERVTU1ZKTsKKyAgICAvKiBjb21iaW5lZCB5IHNhbXBs
ZXMgYml0cyAqLworICAgIGpvcm5hZGFfdHMtPmhpZ2hfeSA9IGpvcm5hZGFfc3NwX2J5dGUoVFhE
VU1NWSk7Cit9IAorICAgICAgICAKK3N0YXRpYyBpcnFyZXR1cm5fdCBqb3JuYWRhNzIwX3RzX2lu
dGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpCit7CisJc3RydWN0IGpvcm5hZGFfdHMgKmpv
cm5hZGFfdHMgPSBkZXZfaWQ7CisKKwkvKiBJZiBHUElPX0dQSU85IGlzIHNldCB0byBoaWdoIHRo
ZW4gcmVwb3J0IHBlbiB1cCAqLworCWlmKEdQTFIgJiBHUElPX0dQSU8oOSkpIHsKKwkJaW5wdXRf
cmVwb3J0X2tleShqb3JuYWRhX3RzLT5kZXYsIEJUTl9UT1VDSCwgMCk7CisJCWlucHV0X3N5bmMo
am9ybmFkYV90cy0+ZGV2KTsKKwkJcmV0dXJuIElSUV9IQU5ETEVEOworCX0KKworCWpvcm5hZGFf
c3NwX3N0YXJ0KCk7CisJCisJLyogcHJvcGVyIHJlcGx5IHRvIHJlcXVlc3QgaXMgYWx3YXlzIFRY
RFVNTVkgKi8KKwlpZiAoam9ybmFkYV9zc3BfaW5vdXQoR0VUVE9VQ0hTQU1QTEVTID09IFRYRFVN
TVkpKSB7CisJICAgIGpvcm5hZGE3MjBfdHNfY29sbGVjdGRhdGEoam9ybmFkYV90cyk7CisJICAg
IGpvcm5hZGE3MjBfdHNfY2FsY3VsYXRlKGpvcm5hZGFfdHMpOworCSAgICAKKwkgICAgaW5wdXRf
cmVwb3J0X2tleShqb3JuYWRhX3RzLT5kZXYsIEJUTl9UT1VDSCwgMSk7CisJICAgIGlucHV0X3Jl
cG9ydF9hYnMoam9ybmFkYV90cy0+ZGV2LCBBQlNfWCwgam9ybmFkYV90cy0+eCk7CisJICAgIGlu
cHV0X3JlcG9ydF9hYnMoam9ybmFkYV90cy0+ZGV2LCBBQlNfWSwgam9ybmFkYV90cy0+eSk7CisJ
fQorCQorCWpvcm5hZGFfc3NwX2VuZCgpOworCXJldHVybiBJUlFfSEFORExFRDsKK30KKworc3Rh
dGljIGludCBfX2RldmluaXQgam9ybmFkYTcyMF90c19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQoreworCXN0cnVjdCBqb3JuYWRhX3RzICpqb3JuYWRhX3RzOworCXN0cnVjdCBp
bnB1dF9kZXYgKmlucHV0X2RldjsKKwlpbnQgcmV0OworCisJam9ybmFkYV90cyA9IGt6YWxsb2Mo
c2l6ZW9mKHN0cnVjdCBqb3JuYWRhX3RzKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFqb3JuYWRhX3Rz
KQorCSAgICByZXR1cm4gLUVOT01FTTsKKworCWlucHV0X2RldiA9IGlucHV0X2FsbG9jYXRlX2Rl
dmljZSgpOworCWlmICghaW5wdXRfZGV2KQorCSAgICBnb3RvIGZhaWxlZDE7CisKKwlqb3JuYWRh
X3RzLT5kZXYgPSBpbnB1dF9kZXY7CisJCisJaW5wdXRfZGV2LT5ldmJpdFswXSA9IEJJVChFVl9L
RVkpIHwgQklUKEVWX0FCUyk7CisJaW5wdXRfZGV2LT5hYnNiaXRbMF0gPSBCSVQoQUJTX1gpIHwg
QklUKEFCU19ZKSB8IEJJVChBQlNfUFJFU1NVUkUpOworCWlucHV0X2Rldi0+a2V5Yml0W0xPTkco
QlROX1RPVUNIKV0gPSBCSVQoQlROX1RPVUNIKTsKKworCWlucHV0X3NldF9hYnNfcGFyYW1zKGlu
cHV0X2RldiwgQUJTX1gsIDI3MCwgMzkwMCwgMCwgMCk7CisJaW5wdXRfc2V0X2Fic19wYXJhbXMo
aW5wdXRfZGV2LCBBQlNfWSwgMTgwLCAzNzAwLCAwLCAwKTsKKworCWlucHV0X2Rldi0+bmFtZSA9
ICJIUCBKb3JuYWRhIDcxMC83MjAvNzI4IFRvdWNoc2NyZWVuIGRyaXZlciI7CisKKwlyZXQgPSBy
ZXF1ZXN0X2lycShJUlFfR1BJTzksCisJCQlqb3JuYWRhNzIwX3RzX2ludGVycnVwdCwKKwkJCUlS
UUZfRElTQUJMRUQgfCBJUlFGX1RSSUdHRVJfUklTSU5HLAorCQkJIkhQN1hYIFRvdWNoc2NyZWVu
IGRyaXZlciIsIGpvcm5hZGFfdHMpOworCWlmIChyZXQpIHsKKwkJcHJpbnRrKEtFUk5fSU5GTyAi
SFA3WFggVFMgOiBVbmFibGUgdG8gYXF1aXJlIGlycSFcbiIpOworCQlnb3RvIGZhaWxlZDI7CisJ
fQorCisJaWYgKGlucHV0X3JlZ2lzdGVyX2RldmljZShpbnB1dF9kZXYpKQorCSAgICBnb3RvIGZh
aWxlZDI7CisJCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgam9ybmFkYV90cyk7CisJCisJ
cmV0dXJuIDA7CisKK2ZhaWxlZDI6IAorCWlucHV0X2ZyZWVfZGV2aWNlKGlucHV0X2Rldik7Citm
YWlsZWQxOiAKKwlrZnJlZShqb3JuYWRhX3RzKTsKKwlyZXR1cm4gLUVOT0RFVjsKK30KKworc3Rh
dGljIGludCBfX2RldmV4aXQgam9ybmFkYTcyMF90c19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKK3sKKwlzdHJ1Y3Qgam9ybmFkYV90cyAqam9ybmFkYV90cyA9IHBsYXRmb3Jt
X2dldF9kcnZkYXRhKHBkZXYpOworCisJZnJlZV9pcnEoSVJRX0dQSU85LCBwZGV2KTsKKwlpbnB1
dF91bnJlZ2lzdGVyX2RldmljZShqb3JuYWRhX3RzLT5kZXYpOworCWtmcmVlKGpvcm5hZGFfdHMp
OworCXJldHVybiAwOworfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBqb3JuYWRh
NzIwX3RzX2RyaXZlciA9IHsKKwkucHJvYmUJCT0gam9ybmFkYTcyMF90c19wcm9iZSwKKwkucmVt
b3ZlCQk9IF9fZGV2ZXhpdF9wKGpvcm5hZGE3MjBfdHNfcmVtb3ZlKSwKKwkuZHJpdmVyCQk9IHsK
KwkJLm5hbWUJPSAiam9ybmFkYV90cyIsCisJfSwKK307CisKK3N0YXRpYyBpbnQgX19pbml0IGpv
cm5hZGE3MjBfdHNfaW5pdCh2b2lkKQoreworCXJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0
ZXIoJmpvcm5hZGE3MjBfdHNfZHJpdmVyKTsKK30KKworc3RhdGljIHZvaWQgX19leGl0IGpvcm5h
ZGE3MjBfdHNfZXhpdCh2b2lkKQoreworCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZqb3Ju
YWRhNzIwX3RzX2RyaXZlcik7Cit9CisKK21vZHVsZV9pbml0KGpvcm5hZGE3MjBfdHNfaW5pdCk7
Cittb2R1bGVfZXhpdChqb3JuYWRhNzIwX3RzX2V4aXQpOwo=

--Multipart=_Wed__19_Sep_2007_22_31_38_-0700_ytHrK/pk3AkkxB5w--
