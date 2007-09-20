From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: [HP7XX/PATCH] - HP720 Jornada Touchscreen (Updated, please use this
 one)
Date: Wed, 19 Sep 2007 20:49:26 -0700
Message-ID: <20070919204926.b29e3884.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__19_Sep_2007_20_49_26_-0700_knvLMz1xTn_WEfly"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__19_Sep_2007_20_49_26_-0700_knvLMz1xTn_WEfly
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Greetings,

Dmitry, I had some issues with the last patch I sent you. Something with the init sequence of devices, it basicly made it kernel panic. I've re-coded the driver to instead work as a platform driver, that way I have more control of which gets started first. 


diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
new file mode 100644
index 0000000..fb0f665
--- /dev/null
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -0,0 +1,182 @@
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
+	int X[3];
+	int Y[3];
+	int high_x, high_y;
+	int x, y;
+};
+
+static irqreturn_t jornada720_ts_interrupt(int irq, void *dev_id)
+{
+	struct jornada_ts *jornada_ts = dev_id;
+
+	/* If GPIO_GPIO9 is set to high */
+	if(GPLR & GPIO_GPIO(9)) {
+		/* report pen up */
+		input_report_key(jornada_ts->dev, BTN_TOUCH, 0);
+		input_report_abs(jornada_ts->dev, ABS_PRESSURE, 0);
+		input_sync(jornada_ts->dev);
+
+		return IRQ_HANDLED;
+	}
+
+	/* start ssp and do a spinlock */
+	jornada_ssp_start();
+
+	/* request x & y data */
+	if(jornada_ssp_inout(GETTOUCHSAMPLES) != TXDUMMY) {
+		jornada_ssp_end();
+		return IRQ_HANDLED;
+	}
+
+	/* 3 low word X samples */
+	jornada_ts->X[0] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->X[1] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->X[2] = jornada_ssp_byte(TXDUMMY);
+
+	/* 3 low word Y samples */
+	jornada_ts->Y[0] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->Y[1] = jornada_ssp_byte(TXDUMMY);
+	jornada_ts->Y[2] = jornada_ssp_byte(TXDUMMY);
+
+	/* combined X samples bits */
+	jornada_ts->high_x = jornada_ssp_byte(TXDUMMY);
+
+	/* combined Y sample bits */
+	jornada_ts->high_y = jornada_ssp_byte(TXDUMMY);
+
+	/* end ssp communication and release spinlock */
+	jornada_ssp_end();
+
+	/* calculating actual values */
+	jornada_ts->X[0] |= (jornada_ts->high_x & 3) << 8;
+	jornada_ts->X[1] |= (jornada_ts->high_x & 0xc) << 6;
+	jornada_ts->X[2] |= (jornada_ts->high_x & 0x30) << 4;
+
+	jornada_ts->Y[0] |= (jornada_ts->high_y & 3) << 8;
+	jornada_ts->Y[1] |= (jornada_ts->high_y & 0xc) << 6;
+	jornada_ts->Y[2] |= (jornada_ts->high_y & 0x30) << 4;
+
+	/* simple averaging filter */
+	jornada_ts->x = (jornada_ts->X[0] + jornada_ts->X[1] + jornada_ts->X[2])/3;
+	jornada_ts->y = (jornada_ts->Y[0] + jornada_ts->Y[1] + jornada_ts->Y[2])/3;
+
+	/* report pen down */
+	input_report_key(jornada_ts->dev, BTN_TOUCH, 1);
+	input_report_abs(jornada_ts->dev, ABS_X, jornada_ts->x);
+	input_report_abs(jornada_ts->dev, ABS_Y, jornada_ts->y);
+	input_report_abs(jornada_ts->dev, ABS_PRESSURE, 1);
+	input_sync(jornada_ts->dev);
+
+	return IRQ_HANDLED;
+}
+
+
+static int __init jornada720_ts_probe(struct platform_device *pdev)
+{
+	struct jornada_ts *jornada_ts;
+	struct input_dev *input_dev;
+	int ret;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+	    return -ENODEV;
+
+	jornada_ts = kzalloc(sizeof(struct jornada_ts), GFP_KERNEL);
+	if (!jornada_ts)
+	    goto failed1;
+
+	platform_set_drvdata(pdev, jornada_ts);
+
+	jornada_ts->dev = input_dev;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+
+	input_dev->absmin[ABS_X] = 270;
+	input_dev->absmin[ABS_Y] = 180;
+	input_dev->absmax[ABS_X] = 3900;
+	input_dev->absmax[ABS_Y] = 3700;
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
+	input_register_device(input_dev);
+	return 0;
+
+failed1:
+	input_free_device(input_dev);
+	return -ENOMEM;
+failed2:
+	kfree(jornada_ts);
+	input_free_device(input_dev);
+	return -ENODEV;
+}
+
+static int jornada720_ts_remove(struct platform_device *pdev)
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
+	.remove		= jornada720_ts_remove,
+	.driver		= {
+		.name	= "jornada_ts_driver",
+	},
+};
+
+static int __devinit jornada720_ts_init(void)
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

--Multipart=_Wed__19_Sep_2007_20_49_26_-0700_knvLMz1xTn_WEfly
Content-Type: application/octet-stream;
 name="hp7xx-touchscreen-support.patch"
Content-Disposition: attachment;
 filename="hp7xx-touchscreen-support.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jIGIv
ZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uZmIwZjY2NQotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMv
aW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jCkBAIC0wLDAgKzEsMTgyIEBACisvKgor
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
IGpvcm5hZGFfdHMgeworCXN0cnVjdCBpbnB1dF9kZXYgKmRldjsKKwlpbnQgWFszXTsKKwlpbnQg
WVszXTsKKwlpbnQgaGlnaF94LCBoaWdoX3k7CisJaW50IHgsIHk7Cit9OworCitzdGF0aWMgaXJx
cmV0dXJuX3Qgam9ybmFkYTcyMF90c19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQor
eworCXN0cnVjdCBqb3JuYWRhX3RzICpqb3JuYWRhX3RzID0gZGV2X2lkOworCisJLyogSWYgR1BJ
T19HUElPOSBpcyBzZXQgdG8gaGlnaCAqLworCWlmKEdQTFIgJiBHUElPX0dQSU8oOSkpIHsKKwkJ
LyogcmVwb3J0IHBlbiB1cCAqLworCQlpbnB1dF9yZXBvcnRfa2V5KGpvcm5hZGFfdHMtPmRldiwg
QlROX1RPVUNILCAwKTsKKwkJaW5wdXRfcmVwb3J0X2Ficyhqb3JuYWRhX3RzLT5kZXYsIEFCU19Q
UkVTU1VSRSwgMCk7CisJCWlucHV0X3N5bmMoam9ybmFkYV90cy0+ZGV2KTsKKworCQlyZXR1cm4g
SVJRX0hBTkRMRUQ7CisJfQorCisJLyogc3RhcnQgc3NwIGFuZCBkbyBhIHNwaW5sb2NrICovCisJ
am9ybmFkYV9zc3Bfc3RhcnQoKTsKKworCS8qIHJlcXVlc3QgeCAmIHkgZGF0YSAqLworCWlmKGpv
cm5hZGFfc3NwX2lub3V0KEdFVFRPVUNIU0FNUExFUykgIT0gVFhEVU1NWSkgeworCQlqb3JuYWRh
X3NzcF9lbmQoKTsKKwkJcmV0dXJuIElSUV9IQU5ETEVEOworCX0KKworCS8qIDMgbG93IHdvcmQg
WCBzYW1wbGVzICovCisJam9ybmFkYV90cy0+WFswXSA9IGpvcm5hZGFfc3NwX2J5dGUoVFhEVU1N
WSk7CisJam9ybmFkYV90cy0+WFsxXSA9IGpvcm5hZGFfc3NwX2J5dGUoVFhEVU1NWSk7CisJam9y
bmFkYV90cy0+WFsyXSA9IGpvcm5hZGFfc3NwX2J5dGUoVFhEVU1NWSk7CisKKwkvKiAzIGxvdyB3
b3JkIFkgc2FtcGxlcyAqLworCWpvcm5hZGFfdHMtPllbMF0gPSBqb3JuYWRhX3NzcF9ieXRlKFRY
RFVNTVkpOworCWpvcm5hZGFfdHMtPllbMV0gPSBqb3JuYWRhX3NzcF9ieXRlKFRYRFVNTVkpOwor
CWpvcm5hZGFfdHMtPllbMl0gPSBqb3JuYWRhX3NzcF9ieXRlKFRYRFVNTVkpOworCisJLyogY29t
YmluZWQgWCBzYW1wbGVzIGJpdHMgKi8KKwlqb3JuYWRhX3RzLT5oaWdoX3ggPSBqb3JuYWRhX3Nz
cF9ieXRlKFRYRFVNTVkpOworCisJLyogY29tYmluZWQgWSBzYW1wbGUgYml0cyAqLworCWpvcm5h
ZGFfdHMtPmhpZ2hfeSA9IGpvcm5hZGFfc3NwX2J5dGUoVFhEVU1NWSk7CisKKwkvKiBlbmQgc3Nw
IGNvbW11bmljYXRpb24gYW5kIHJlbGVhc2Ugc3BpbmxvY2sgKi8KKwlqb3JuYWRhX3NzcF9lbmQo
KTsKKworCS8qIGNhbGN1bGF0aW5nIGFjdHVhbCB2YWx1ZXMgKi8KKwlqb3JuYWRhX3RzLT5YWzBd
IHw9IChqb3JuYWRhX3RzLT5oaWdoX3ggJiAzKSA8PCA4OworCWpvcm5hZGFfdHMtPlhbMV0gfD0g
KGpvcm5hZGFfdHMtPmhpZ2hfeCAmIDB4YykgPDwgNjsKKwlqb3JuYWRhX3RzLT5YWzJdIHw9IChq
b3JuYWRhX3RzLT5oaWdoX3ggJiAweDMwKSA8PCA0OworCisJam9ybmFkYV90cy0+WVswXSB8PSAo
am9ybmFkYV90cy0+aGlnaF95ICYgMykgPDwgODsKKwlqb3JuYWRhX3RzLT5ZWzFdIHw9IChqb3Ju
YWRhX3RzLT5oaWdoX3kgJiAweGMpIDw8IDY7CisJam9ybmFkYV90cy0+WVsyXSB8PSAoam9ybmFk
YV90cy0+aGlnaF95ICYgMHgzMCkgPDwgNDsKKworCS8qIHNpbXBsZSBhdmVyYWdpbmcgZmlsdGVy
ICovCisJam9ybmFkYV90cy0+eCA9IChqb3JuYWRhX3RzLT5YWzBdICsgam9ybmFkYV90cy0+WFsx
XSArIGpvcm5hZGFfdHMtPlhbMl0pLzM7CisJam9ybmFkYV90cy0+eSA9IChqb3JuYWRhX3RzLT5Z
WzBdICsgam9ybmFkYV90cy0+WVsxXSArIGpvcm5hZGFfdHMtPllbMl0pLzM7CisKKwkvKiByZXBv
cnQgcGVuIGRvd24gKi8KKwlpbnB1dF9yZXBvcnRfa2V5KGpvcm5hZGFfdHMtPmRldiwgQlROX1RP
VUNILCAxKTsKKwlpbnB1dF9yZXBvcnRfYWJzKGpvcm5hZGFfdHMtPmRldiwgQUJTX1gsIGpvcm5h
ZGFfdHMtPngpOworCWlucHV0X3JlcG9ydF9hYnMoam9ybmFkYV90cy0+ZGV2LCBBQlNfWSwgam9y
bmFkYV90cy0+eSk7CisJaW5wdXRfcmVwb3J0X2Ficyhqb3JuYWRhX3RzLT5kZXYsIEFCU19QUkVT
U1VSRSwgMSk7CisJaW5wdXRfc3luYyhqb3JuYWRhX3RzLT5kZXYpOworCisJcmV0dXJuIElSUV9I
QU5ETEVEOworfQorCisKK3N0YXRpYyBpbnQgX19pbml0IGpvcm5hZGE3MjBfdHNfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3Qgam9ybmFkYV90cyAqam9ybmFk
YV90czsKKwlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dF9kZXY7CisJaW50IHJldDsKKworCWlucHV0
X2RldiA9IGlucHV0X2FsbG9jYXRlX2RldmljZSgpOworCWlmICghaW5wdXRfZGV2KQorCSAgICBy
ZXR1cm4gLUVOT0RFVjsKKworCWpvcm5hZGFfdHMgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qgam9y
bmFkYV90cyksIEdGUF9LRVJORUwpOworCWlmICgham9ybmFkYV90cykKKwkgICAgZ290byBmYWls
ZWQxOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgam9ybmFkYV90cyk7CisKKwlqb3Ju
YWRhX3RzLT5kZXYgPSBpbnB1dF9kZXY7CisKKwlpbnB1dF9kZXYtPmV2Yml0WzBdID0gQklUKEVW
X0tFWSkgfCBCSVQoRVZfQUJTKTsKKwlpbnB1dF9kZXYtPmFic2JpdFswXSA9IEJJVChBQlNfWCkg
fCBCSVQoQUJTX1kpIHwgQklUKEFCU19QUkVTU1VSRSk7CisJaW5wdXRfZGV2LT5rZXliaXRbTE9O
RyhCVE5fVE9VQ0gpXSA9IEJJVChCVE5fVE9VQ0gpOworCisJaW5wdXRfZGV2LT5hYnNtaW5bQUJT
X1hdID0gMjcwOworCWlucHV0X2Rldi0+YWJzbWluW0FCU19ZXSA9IDE4MDsKKwlpbnB1dF9kZXYt
PmFic21heFtBQlNfWF0gPSAzOTAwOworCWlucHV0X2Rldi0+YWJzbWF4W0FCU19ZXSA9IDM3MDA7
CisKKwlpbnB1dF9kZXYtPm5hbWUgPSAiSFAgSm9ybmFkYSA3MTAvNzIwLzcyOCBUb3VjaHNjcmVl
biBkcml2ZXIiOworCisJcmV0ID0gcmVxdWVzdF9pcnEoSVJRX0dQSU85LAorCQkJam9ybmFkYTcy
MF90c19pbnRlcnJ1cHQsCisJCQlJUlFGX0RJU0FCTEVEIHwgSVJRRl9UUklHR0VSX1JJU0lORywK
KwkJCSJIUDdYWCBUb3VjaHNjcmVlbiBkcml2ZXIiLCBqb3JuYWRhX3RzKTsKKwlpZiAocmV0KSB7
CisJCXByaW50ayhLRVJOX0lORk8gIkhQN1hYIFRTIDogVW5hYmxlIHRvIGFxdWlyZSBpcnEhXG4i
KTsKKwkJZ290byBmYWlsZWQyOworCX0KKworCWlucHV0X3JlZ2lzdGVyX2RldmljZShpbnB1dF9k
ZXYpOworCXJldHVybiAwOworCitmYWlsZWQxOgorCWlucHV0X2ZyZWVfZGV2aWNlKGlucHV0X2Rl
dik7CisJcmV0dXJuIC1FTk9NRU07CitmYWlsZWQyOgorCWtmcmVlKGpvcm5hZGFfdHMpOworCWlu
cHV0X2ZyZWVfZGV2aWNlKGlucHV0X2Rldik7CisJcmV0dXJuIC1FTk9ERVY7Cit9CisKK3N0YXRp
YyBpbnQgam9ybmFkYTcyMF90c19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
K3sKKwlzdHJ1Y3Qgam9ybmFkYV90cyAqam9ybmFkYV90cyA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOworCisJZnJlZV9pcnEoSVJRX0dQSU85LCBwZGV2KTsKKwlpbnB1dF91bnJlZ2lzdGVy
X2RldmljZShqb3JuYWRhX3RzLT5kZXYpOworCWtmcmVlKGpvcm5hZGFfdHMpOworCXJldHVybiAw
OworfQorCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBqb3JuYWRhNzIwX3RzX2RyaXZl
ciA9IHsKKwkucHJvYmUJCT0gam9ybmFkYTcyMF90c19wcm9iZSwKKwkucmVtb3ZlCQk9IGpvcm5h
ZGE3MjBfdHNfcmVtb3ZlLAorCS5kcml2ZXIJCT0geworCQkubmFtZQk9ICJqb3JuYWRhX3RzX2Ry
aXZlciIsCisJfSwKK307CisKK3N0YXRpYyBpbnQgX19kZXZpbml0IGpvcm5hZGE3MjBfdHNfaW5p
dCh2b2lkKQoreworCXJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmpvcm5hZGE3MjBf
dHNfZHJpdmVyKTsKK30KKworc3RhdGljIHZvaWQgX19leGl0IGpvcm5hZGE3MjBfdHNfZXhpdCh2
b2lkKQoreworCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZqb3JuYWRhNzIwX3RzX2RyaXZl
cik7Cit9CisKK21vZHVsZV9pbml0KGpvcm5hZGE3MjBfdHNfaW5pdCk7Cittb2R1bGVfZXhpdChq
b3JuYWRhNzIwX3RzX2V4aXQpOwo=

--Multipart=_Wed__19_Sep_2007_20_49_26_-0700_knvLMz1xTn_WEfly--
