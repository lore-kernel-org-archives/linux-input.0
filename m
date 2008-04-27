From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: [HP7xx/patch] - Fix broken ABS values + minor changes
Date: Sun, 27 Apr 2008 16:55:25 +0200
Message-ID: <20080427165525.95eb4bd2.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Sun__27_Apr_2008_16_55_25_+0200_LASJxkC0Ra9R4.Y4"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: dmitry <dtor@insightbb.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__27_Apr_2008_16_55_25_+0200_LASJxkC0Ra9R4.Y4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


This patch fixes MAX/MIN values of ABSX/ABSY. This is needed because we earlier dependend on tsdev
emulation layer. We also change :
* all error output is going through KERN_ERR and not KERN_INFO.
* added comment regarding usage with tslib.
* use BIT_MASK() instead of BIT()

Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index 7422421..26e85e8 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -1,7 +1,8 @@
 /*
  * drivers/input/touchscreen/jornada720_ts.c
  *
- * Copyright (C) 2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
+ * HP Jornada 710/720/728 Touchscreen Driver
+ * Copyright (C) 2007-2008 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
  *
  *  Copyright (C) 2006 Filip Zyzniewski <filip.zyzniewski@tefnet.pl>
  *  based on HP Jornada 56x touchscreen driver by Alex Lange <chicken@handhelds.org>
@@ -10,7 +11,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * HP Jornada 710/720/729 Touchscreen Driver
  */
 
 #include <linux/platform_device.h>
@@ -72,6 +72,7 @@ static irqreturn_t jornada720_ts_interrupt(int irq, void *dev_id)
 
 	/* If GPIO_GPIO9 is set to high then report pen up */
 	if (GPLR & GPIO_GPIO(9)) {
+		/* note tslib currently expects ABS_PRESSURE report */
 		input_report_key(input, BTN_TOUCH, 0);
 		input_sync(input);
 	} else {
@@ -84,9 +85,10 @@ static irqreturn_t jornada720_ts_interrupt(int irq, void *dev_id)
 			x = jornada720_ts_average(jornada_ts->x_data);
 			y = jornada720_ts_average(jornada_ts->y_data);
 
-			input_report_key(input, BTN_TOUCH, 1);
+			/* note tslib currently expects ABS_PRESSURE report */
 			input_report_abs(input, ABS_X, x);
 			input_report_abs(input, ABS_Y, y);
+			input_report_key(input, BTN_TOUCH, 1);
 			input_sync(input);
 		}
 
@@ -118,24 +120,26 @@ static int __devinit jornada720_ts_probe(struct platform_device *pdev)
 	input_dev->phys = "jornadats/input0";
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->dev.parent = &pdev->dev;
-
-	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-	input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, 180, 3700, 0, 0);
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, 79, 995, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 75, 910, 0, 0);
 
 	error = request_irq(IRQ_GPIO9,
 			jornada720_ts_interrupt,
 			IRQF_DISABLED | IRQF_TRIGGER_RISING,
 			"HP7XX Touchscreen driver", pdev);
 	if (error) {
-		printk(KERN_INFO "HP7XX TS : Unable to acquire irq!\n");
+		printk(KERN_ERR "ts: unable to acquire irq!\n");
 		goto fail1;
 	}
 
 	error = input_register_device(jornada_ts->dev);
-	if (error)
+	if (error) {
+		printk(KERN_ERR "ts: unable to register device\n");
 		goto fail2;
+	}
 
 	return 0;
 

-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>

--Multipart=_Sun__27_Apr_2008_16_55_25_+0200_LASJxkC0Ra9R4.Y4
Content-Type: application/octet-stream;
 name="jornada720_ts_fix.patch"
Content-Disposition: attachment;
 filename="jornada720_ts_fix.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jIGIv
ZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKaW5kZXggNzQyMjQyMS4u
MjZlODVlOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIw
X3RzLmMKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKQEAg
LTEsNyArMSw4IEBACiAvKgogICogZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIw
X3RzLmMKICAqCi0gKiBDb3B5cmlnaHQgKEMpIDIwMDcgS3Jpc3RvZmZlciBFcmljc29uIDxLcmlz
dG9mZmVyLkVyaWNzb25AZ21haWwuY29tPgorICogSFAgSm9ybmFkYSA3MTAvNzIwLzcyOCBUb3Vj
aHNjcmVlbiBEcml2ZXIKKyAqIENvcHlyaWdodCAoQykgMjAwNy0yMDA4IEtyaXN0b2ZmZXIgRXJp
Y3NvbiA8S3Jpc3RvZmZlci5Fcmljc29uQGdtYWlsLmNvbT4KICAqCiAgKiAgQ29weXJpZ2h0IChD
KSAyMDA2IEZpbGlwIFp5em5pZXdza2kgPGZpbGlwLnp5em5pZXdza2lAdGVmbmV0LnBsPgogICog
IGJhc2VkIG9uIEhQIEpvcm5hZGEgNTZ4IHRvdWNoc2NyZWVuIGRyaXZlciBieSBBbGV4IExhbmdl
IDxjaGlja2VuQGhhbmRoZWxkcy5vcmc+CkBAIC0xMCw3ICsxMSw2IEBACiAgKiBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcwog
ICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCiAgKgotICogSFAg
Sm9ybmFkYSA3MTAvNzIwLzcyOSBUb3VjaHNjcmVlbiBEcml2ZXIKICAqLwogCiAjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CkBAIC03Miw2ICs3Miw3IEBAIHN0YXRpYyBpcnFyZXR1
cm5fdCBqb3JuYWRhNzIwX3RzX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpCiAKIAkv
KiBJZiBHUElPX0dQSU85IGlzIHNldCB0byBoaWdoIHRoZW4gcmVwb3J0IHBlbiB1cCAqLwogCWlm
IChHUExSICYgR1BJT19HUElPKDkpKSB7CisJCS8qIG5vdGUgdHNsaWIgY3VycmVudGx5IGV4cGVj
dHMgQUJTX1BSRVNTVVJFIHJlcG9ydCAqLwogCQlpbnB1dF9yZXBvcnRfa2V5KGlucHV0LCBCVE5f
VE9VQ0gsIDApOwogCQlpbnB1dF9zeW5jKGlucHV0KTsKIAl9IGVsc2UgewpAQCAtODQsOSArODUs
MTAgQEAgc3RhdGljIGlycXJldHVybl90IGpvcm5hZGE3MjBfdHNfaW50ZXJydXB0KGludCBpcnEs
IHZvaWQgKmRldl9pZCkKIAkJCXggPSBqb3JuYWRhNzIwX3RzX2F2ZXJhZ2Uoam9ybmFkYV90cy0+
eF9kYXRhKTsKIAkJCXkgPSBqb3JuYWRhNzIwX3RzX2F2ZXJhZ2Uoam9ybmFkYV90cy0+eV9kYXRh
KTsKIAotCQkJaW5wdXRfcmVwb3J0X2tleShpbnB1dCwgQlROX1RPVUNILCAxKTsKKwkJCS8qIG5v
dGUgdHNsaWIgY3VycmVudGx5IGV4cGVjdHMgQUJTX1BSRVNTVVJFIHJlcG9ydCAqLwogCQkJaW5w
dXRfcmVwb3J0X2FicyhpbnB1dCwgQUJTX1gsIHgpOwogCQkJaW5wdXRfcmVwb3J0X2FicyhpbnB1
dCwgQUJTX1ksIHkpOworCQkJaW5wdXRfcmVwb3J0X2tleShpbnB1dCwgQlROX1RPVUNILCAxKTsK
IAkJCWlucHV0X3N5bmMoaW5wdXQpOwogCQl9CiAKQEAgLTExOCwyNCArMTIwLDI2IEBAIHN0YXRp
YyBpbnQgX19kZXZpbml0IGpvcm5hZGE3MjBfdHNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKIAlpbnB1dF9kZXYtPnBoeXMgPSAiam9ybmFkYXRzL2lucHV0MCI7CiAJaW5wdXRf
ZGV2LT5pZC5idXN0eXBlID0gQlVTX0hPU1Q7CiAJaW5wdXRfZGV2LT5kZXYucGFyZW50ID0gJnBk
ZXYtPmRldjsKLQotCWlucHV0X2Rldi0+ZXZiaXRbMF0gPSBCSVQoRVZfS0VZKSB8IEJJVChFVl9B
QlMpOwotCWlucHV0X2Rldi0+a2V5Yml0W0xPTkcoQlROX1RPVUNIKV0gPSBCSVQoQlROX1RPVUNI
KTsKLQlpbnB1dF9zZXRfYWJzX3BhcmFtcyhpbnB1dF9kZXYsIEFCU19YLCAyNzAsIDM5MDAsIDAs
IDApOwotCWlucHV0X3NldF9hYnNfcGFyYW1zKGlucHV0X2RldiwgQUJTX1ksIDE4MCwgMzcwMCwg
MCwgMCk7CisJaW5wdXRfZGV2LT5ldmJpdFswXSA9IEJJVF9NQVNLKEVWX0tFWSkgfCBCSVRfTUFT
SyhFVl9BQlMpOworCWlucHV0X2Rldi0+YWJzYml0WzBdID0gQklUX01BU0soQUJTX1gpIHwgQklU
X01BU0soQUJTX1kpOworCWlucHV0X2Rldi0+a2V5Yml0W0JJVF9XT1JEKEJUTl9UT1VDSCldID0g
QklUX01BU0soQlROX1RPVUNIKTsKKwlpbnB1dF9zZXRfYWJzX3BhcmFtcyhpbnB1dF9kZXYsIEFC
U19YLCA3OSwgOTk1LCAwLCAwKTsKKwlpbnB1dF9zZXRfYWJzX3BhcmFtcyhpbnB1dF9kZXYsIEFC
U19ZLCA3NSwgOTEwLCAwLCAwKTsKIAogCWVycm9yID0gcmVxdWVzdF9pcnEoSVJRX0dQSU85LAog
CQkJam9ybmFkYTcyMF90c19pbnRlcnJ1cHQsCiAJCQlJUlFGX0RJU0FCTEVEIHwgSVJRRl9UUklH
R0VSX1JJU0lORywKIAkJCSJIUDdYWCBUb3VjaHNjcmVlbiBkcml2ZXIiLCBwZGV2KTsKIAlpZiAo
ZXJyb3IpIHsKLQkJcHJpbnRrKEtFUk5fSU5GTyAiSFA3WFggVFMgOiBVbmFibGUgdG8gYWNxdWly
ZSBpcnEhXG4iKTsKKwkJcHJpbnRrKEtFUk5fRVJSICJ0czogdW5hYmxlIHRvIGFjcXVpcmUgaXJx
IVxuIik7CiAJCWdvdG8gZmFpbDE7CiAJfQogCiAJZXJyb3IgPSBpbnB1dF9yZWdpc3Rlcl9kZXZp
Y2Uoam9ybmFkYV90cy0+ZGV2KTsKLQlpZiAoZXJyb3IpCisJaWYgKGVycm9yKSB7CisJCXByaW50
ayhLRVJOX0VSUiAidHM6IHVuYWJsZSB0byByZWdpc3RlciBkZXZpY2VcbiIpOwogCQlnb3RvIGZh
aWwyOworCX0KIAogCXJldHVybiAwOwogCg==

--Multipart=_Sun__27_Apr_2008_16_55_25_+0200_LASJxkC0Ra9R4.Y4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--Multipart=_Sun__27_Apr_2008_16_55_25_+0200_LASJxkC0Ra9R4.Y4--
