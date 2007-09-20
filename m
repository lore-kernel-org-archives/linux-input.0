From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: [HP7XX/PATCH] : Touchscreen support
Date: Wed, 19 Sep 2007 18:24:44 -0700
Message-ID: <20070919182444.1c9360e5.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__19_Sep_2007_18_24_44_-0700_eik3k36fvY3slWW6"
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

--Multipart=_Wed__19_Sep_2007_18_24_44_-0700_eik3k36fvY3slWW6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Dmitry,

This is the hp7xx touchscreen driver. Any feedback appreciated.

diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
new file mode 100644
index 0000000..e45227a
--- /dev/null
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -0,0 +1,156 @@
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
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/hardware.h>
+#include <asm/arch/jornada720.h>
+
+MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
+MODULE_DESCRIPTION("HP Jornada 710/720/728 touchscreen driver");
+MODULE_LICENSE("GPLv2");
+
+struct input_dev *dev;
+
+static irqreturn_t jornada720_ts_interrupt(int irq, void *dev_id)
+{
+	int X[3], Y[3], high_x, high_y, x, y;
+
+	/* If GPIO_GPIO9 is set to high */
+	if(GPLR & GPIO_GPIO(9)) {
+		/* report pen up */
+		input_report_key(dev, BTN_TOUCH, 0);
+		input_report_abs(dev, ABS_PRESSURE, 0);
+		input_sync(dev);
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
+	X[0] = jornada_ssp_byte(TXDUMMY);
+	X[1] = jornada_ssp_byte(TXDUMMY);
+	X[2] = jornada_ssp_byte(TXDUMMY);
+
+	/* 3 low word Y samples */
+	Y[0] = jornada_ssp_byte(TXDUMMY);
+	Y[1] = jornada_ssp_byte(TXDUMMY);
+	Y[2] = jornada_ssp_byte(TXDUMMY);
+
+	/* combined X samples bits */
+	high_x = jornada_ssp_byte(TXDUMMY);
+
+	/* combined Y sample bits */
+	high_y = jornada_ssp_byte(TXDUMMY);
+
+	/* end ssp communication and release spinlock */
+	jornada_ssp_end();
+
+	/* calculating actual values */
+	X[0] |= (high_x & 3) << 8;
+	X[1] |= (high_x & 0xc) << 6;
+	X[2] |= (high_x & 0x30) << 4;
+
+	Y[0] |= (high_y & 3) << 8;
+	Y[1] |= (high_y & 0xc) << 6;
+	Y[2] |= (high_y & 0x30) << 4;
+
+	/* simple averaging filter */
+	x = (X[0] + X[1] + X[2])/3;
+	y = (Y[0] + Y[1] + Y[2])/3;
+
+	/* report pen down */
+	input_report_key(dev, BTN_TOUCH, 1);
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_report_abs(dev, ABS_PRESSURE, 1);
+	input_sync(dev);
+
+	return IRQ_HANDLED;
+}
+
+
+static int jornada720_ts_probe(struct device *_dev)
+{
+	int ret;
+
+	dev = input_allocate_device();
+	if (!dev)
+		return -ENOMEM;
+
+	dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	dev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+
+	dev->absmin[ABS_X] = 270; dev->absmin[ABS_Y] = 180;
+	dev->absmax[ABS_X] = 3900; dev->absmax[ABS_Y] = 3700;
+
+	dev->name = "HP Jornada 710/720/728 Touchscreen driver";
+
+	ret = request_irq(IRQ_GPIO9,
+			jornada720_ts_interrupt,
+			IRQF_DISABLED | IRQF_TRIGGER_RISING,
+			"HP Jornada 710/720/728 Touchscreen driver", dev);
+	if (ret) {
+		printk("Unable to grab IRQ for %s: %d\n", "HP Jornada 7XX Touchscreen driver", ret);
+		input_free_device(dev);
+		return ret;
+	}
+
+	input_register_device(dev);
+
+	return 0;
+}
+
+
+static int jornada720_ts_remove(struct device *_dev)
+{
+	free_irq(IRQ_GPIO9, dev);
+	input_unregister_device(dev);
+	return 0;
+}
+
+static struct device_driver jornada720_ts_driver = {
+	.name	= "jornada_ts_driver",
+	.probe	= jornada720_ts_probe,
+	.remove	= jornada720_ts_remove,
+	.owner	= THIS_MODULE
+};
+
+static int __init jornada720_ts_init(void)
+{
+	return driver_register(&jornada720_ts_driver);
+}
+
+static void __exit jornada720_ts_exit(void)
+{
+	driver_unregister(&jornada720_ts_driver);
+}
+
+module_init(jornada720_ts_init);
+module_exit(jornada720_ts_exit);

--Multipart=_Wed__19_Sep_2007_18_24_44_-0700_eik3k36fvY3slWW6
Content-Type: application/octet-stream;
 name="hp7xx-touchscreen-support.patch"
Content-Disposition: attachment;
 filename="hp7xx-touchscreen-support.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jIGIv
ZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uZTQ1MjI3YQotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZlcnMv
aW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jCkBAIC0wLDAgKzEsMTU2IEBACisvKgor
ICogZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKKyAqCisgKiBDb3B5
cmlnaHQgKEMpIDIwMDcgS3Jpc3RvZmZlciBFcmljc29uIDxLcmlzdG9mZmVyLkVyaWNzb25AZ21h
aWwuY29tPgorICoKKyAqICBDb3B5cmlnaHQgKEMpIDIwMDYgRmlsaXAgWnl6bmlld3NraSA8Zmls
aXAuenl6bmlld3NraUB0ZWZuZXQucGw+CisgKiAgYmFzZWQgb24gSFAgSm9ybmFkYSA1NnggdG91
Y2hzY3JlZW4gZHJpdmVyIGJ5IEFsZXggTGFuZ2UgPGNoaWNrZW5AaGFuZGhlbGRzLm9yZz4KKyAq
CisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAqIEhQIEpvcm5hZGEgNzEwLzcyMC83MjkgVG91Y2hz
Y3JlZW4gRHJpdmVyCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgorI2luY2x1ZGUg
PGxpbnV4L2luaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgorI2luY2x1ZGUgPGxpbnV4
L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPgorCisjaW5jbHVkZSA8YXNtL2hhcmR3YXJlLmg+CisjaW5jbHVkZSA8YXNtL2Fy
Y2gvam9ybmFkYTcyMC5oPgorCitNT0RVTEVfQVVUSE9SKCJLcmlzdG9mZmVyIEVyaWNzb24gPGty
aXN0b2ZmZXIuZXJpY3NvbkBnbWFpbC5jb20+Iik7CitNT0RVTEVfREVTQ1JJUFRJT04oIkhQIEpv
cm5hZGEgNzEwLzcyMC83MjggdG91Y2hzY3JlZW4gZHJpdmVyIik7CitNT0RVTEVfTElDRU5TRSgi
R1BMdjIiKTsKKworc3RydWN0IGlucHV0X2RldiAqZGV2OworCitzdGF0aWMgaXJxcmV0dXJuX3Qg
am9ybmFkYTcyMF90c19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQoreworCWludCBY
WzNdLCBZWzNdLCBoaWdoX3gsIGhpZ2hfeSwgeCwgeTsKKworCS8qIElmIEdQSU9fR1BJTzkgaXMg
c2V0IHRvIGhpZ2ggKi8KKwlpZihHUExSICYgR1BJT19HUElPKDkpKSB7CisJCS8qIHJlcG9ydCBw
ZW4gdXAgKi8KKwkJaW5wdXRfcmVwb3J0X2tleShkZXYsIEJUTl9UT1VDSCwgMCk7CisJCWlucHV0
X3JlcG9ydF9hYnMoZGV2LCBBQlNfUFJFU1NVUkUsIDApOworCQlpbnB1dF9zeW5jKGRldik7CisK
KwkJcmV0dXJuIElSUV9IQU5ETEVEOworCX0KKworCS8qIHN0YXJ0IHNzcCBhbmQgZG8gYSBzcGlu
bG9jayAqLworCWpvcm5hZGFfc3NwX3N0YXJ0KCk7CisKKwkvKiByZXF1ZXN0IHggJiB5IGRhdGEg
Ki8KKwlpZihqb3JuYWRhX3NzcF9pbm91dChHRVRUT1VDSFNBTVBMRVMpICE9IFRYRFVNTVkpIHsK
KwkJam9ybmFkYV9zc3BfZW5kKCk7CisJCXJldHVybiBJUlFfSEFORExFRDsKKwl9CisKKwkvKiAz
IGxvdyB3b3JkIFggc2FtcGxlcyAqLworCVhbMF0gPSBqb3JuYWRhX3NzcF9ieXRlKFRYRFVNTVkp
OworCVhbMV0gPSBqb3JuYWRhX3NzcF9ieXRlKFRYRFVNTVkpOworCVhbMl0gPSBqb3JuYWRhX3Nz
cF9ieXRlKFRYRFVNTVkpOworCisJLyogMyBsb3cgd29yZCBZIHNhbXBsZXMgKi8KKwlZWzBdID0g
am9ybmFkYV9zc3BfYnl0ZShUWERVTU1ZKTsKKwlZWzFdID0gam9ybmFkYV9zc3BfYnl0ZShUWERV
TU1ZKTsKKwlZWzJdID0gam9ybmFkYV9zc3BfYnl0ZShUWERVTU1ZKTsKKworCS8qIGNvbWJpbmVk
IFggc2FtcGxlcyBiaXRzICovCisJaGlnaF94ID0gam9ybmFkYV9zc3BfYnl0ZShUWERVTU1ZKTsK
KworCS8qIGNvbWJpbmVkIFkgc2FtcGxlIGJpdHMgKi8KKwloaWdoX3kgPSBqb3JuYWRhX3NzcF9i
eXRlKFRYRFVNTVkpOworCisJLyogZW5kIHNzcCBjb21tdW5pY2F0aW9uIGFuZCByZWxlYXNlIHNw
aW5sb2NrICovCisJam9ybmFkYV9zc3BfZW5kKCk7CisKKwkvKiBjYWxjdWxhdGluZyBhY3R1YWwg
dmFsdWVzICovCisJWFswXSB8PSAoaGlnaF94ICYgMykgPDwgODsKKwlYWzFdIHw9IChoaWdoX3gg
JiAweGMpIDw8IDY7CisJWFsyXSB8PSAoaGlnaF94ICYgMHgzMCkgPDwgNDsKKworCVlbMF0gfD0g
KGhpZ2hfeSAmIDMpIDw8IDg7CisJWVsxXSB8PSAoaGlnaF95ICYgMHhjKSA8PCA2OworCVlbMl0g
fD0gKGhpZ2hfeSAmIDB4MzApIDw8IDQ7CisKKwkvKiBzaW1wbGUgYXZlcmFnaW5nIGZpbHRlciAq
LworCXggPSAoWFswXSArIFhbMV0gKyBYWzJdKS8zOworCXkgPSAoWVswXSArIFlbMV0gKyBZWzJd
KS8zOworCisJLyogcmVwb3J0IHBlbiBkb3duICovCisJaW5wdXRfcmVwb3J0X2tleShkZXYsIEJU
Tl9UT1VDSCwgMSk7CisJaW5wdXRfcmVwb3J0X2FicyhkZXYsIEFCU19YLCB4KTsKKwlpbnB1dF9y
ZXBvcnRfYWJzKGRldiwgQUJTX1ksIHkpOworCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBBQlNfUFJF
U1NVUkUsIDEpOworCWlucHV0X3N5bmMoZGV2KTsKKworCXJldHVybiBJUlFfSEFORExFRDsKK30K
KworCitzdGF0aWMgaW50IGpvcm5hZGE3MjBfdHNfcHJvYmUoc3RydWN0IGRldmljZSAqX2RldikK
K3sKKwlpbnQgcmV0OworCisJZGV2ID0gaW5wdXRfYWxsb2NhdGVfZGV2aWNlKCk7CisJaWYgKCFk
ZXYpCisJCXJldHVybiAtRU5PTUVNOworCisJZGV2LT5ldmJpdFswXSA9IEJJVChFVl9LRVkpIHwg
QklUKEVWX0FCUyk7CisJZGV2LT5hYnNiaXRbMF0gPSBCSVQoQUJTX1gpIHwgQklUKEFCU19ZKSB8
IEJJVChBQlNfUFJFU1NVUkUpOworCWRldi0+a2V5Yml0W0xPTkcoQlROX1RPVUNIKV0gPSBCSVQo
QlROX1RPVUNIKTsKKworCWRldi0+YWJzbWluW0FCU19YXSA9IDI3MDsgZGV2LT5hYnNtaW5bQUJT
X1ldID0gMTgwOworCWRldi0+YWJzbWF4W0FCU19YXSA9IDM5MDA7IGRldi0+YWJzbWF4W0FCU19Z
XSA9IDM3MDA7CisKKwlkZXYtPm5hbWUgPSAiSFAgSm9ybmFkYSA3MTAvNzIwLzcyOCBUb3VjaHNj
cmVlbiBkcml2ZXIiOworCisJcmV0ID0gcmVxdWVzdF9pcnEoSVJRX0dQSU85LAorCQkJam9ybmFk
YTcyMF90c19pbnRlcnJ1cHQsCisJCQlJUlFGX0RJU0FCTEVEIHwgSVJRRl9UUklHR0VSX1JJU0lO
RywKKwkJCSJIUCBKb3JuYWRhIDcxMC83MjAvNzI4IFRvdWNoc2NyZWVuIGRyaXZlciIsIGRldik7
CisJaWYgKHJldCkgeworCQlwcmludGsoIlVuYWJsZSB0byBncmFiIElSUSBmb3IgJXM6ICVkXG4i
LCAiSFAgSm9ybmFkYSA3WFggVG91Y2hzY3JlZW4gZHJpdmVyIiwgcmV0KTsKKwkJaW5wdXRfZnJl
ZV9kZXZpY2UoZGV2KTsKKwkJcmV0dXJuIHJldDsKKwl9CisKKwlpbnB1dF9yZWdpc3Rlcl9kZXZp
Y2UoZGV2KTsKKworCXJldHVybiAwOworfQorCisKK3N0YXRpYyBpbnQgam9ybmFkYTcyMF90c19y
ZW1vdmUoc3RydWN0IGRldmljZSAqX2RldikKK3sKKwlmcmVlX2lycShJUlFfR1BJTzksIGRldik7
CisJaW5wdXRfdW5yZWdpc3Rlcl9kZXZpY2UoZGV2KTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGlj
IHN0cnVjdCBkZXZpY2VfZHJpdmVyIGpvcm5hZGE3MjBfdHNfZHJpdmVyID0geworCS5uYW1lCT0g
Impvcm5hZGFfdHNfZHJpdmVyIiwKKwkucHJvYmUJPSBqb3JuYWRhNzIwX3RzX3Byb2JlLAorCS5y
ZW1vdmUJPSBqb3JuYWRhNzIwX3RzX3JlbW92ZSwKKwkub3duZXIJPSBUSElTX01PRFVMRQorfTsK
Kworc3RhdGljIGludCBfX2luaXQgam9ybmFkYTcyMF90c19pbml0KHZvaWQpCit7CisJcmV0dXJu
IGRyaXZlcl9yZWdpc3Rlcigmam9ybmFkYTcyMF90c19kcml2ZXIpOworfQorCitzdGF0aWMgdm9p
ZCBfX2V4aXQgam9ybmFkYTcyMF90c19leGl0KHZvaWQpCit7CisJZHJpdmVyX3VucmVnaXN0ZXIo
Jmpvcm5hZGE3MjBfdHNfZHJpdmVyKTsKK30KKworbW9kdWxlX2luaXQoam9ybmFkYTcyMF90c19p
bml0KTsKK21vZHVsZV9leGl0KGpvcm5hZGE3MjBfdHNfZXhpdCk7Cg==

--Multipart=_Wed__19_Sep_2007_18_24_44_-0700_eik3k36fvY3slWW6--
