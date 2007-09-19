From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: [HP7XX/PATCH] : Keyboard support
Date: Wed, 19 Sep 2007 02:24:53 -0700
Message-ID: <20070919022453.1df022b2.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__19_Sep_2007_02_24_53_-0700_.zwiH___7UZngNdJ"
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

--Multipart=_Wed__19_Sep_2007_02_24_53_-0700_.zwiH___7UZngNdJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Greetings,

With hp6xx out of the way, here comes the patch for hp7xx. I've made sure this time, that it compiles and runs :) .

Shortlog:
This patch adds support to the HP Jornada 7xx (710/720/728) onboard keyboard.

Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index c97d5eb..7c3ca4e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -68,6 +68,13 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
 	  right-hand column will be interpreted as the key shown in the
 	  left-hand column.
 
+config KEYBOARD_HP7XX
+	tristate "HP7XX Keyboard Driver"
+	depends on SA1100_JORNADA720_SSP && SA1100_SSP
+	help
+	  Say Y here to add support for the HP Jornada 7xx (710/720/728) onboard
+	  keyboard. Its generally a good idea.
+
 config KEYBOARD_SUNKBD
 	tristate "Sun Type 4 and Type 5 keyboard"
 	select SERIO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 28d211b..89f708c 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keyboard.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
+obj-$(CONFIG_KEYBOARD_HP7XX)            += jornada720_kbd.o
 
diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
new file mode 100644
index 0000000..830cdbb
--- /dev/null
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -0,0 +1,177 @@
+/*
+ * drivers/input/keyboard/jornada720_kbd.c
+ *
+ * HP Jornada 720 keyboard platform driver
+ *
+ * Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
+ *
+ *    Copyright (C) 2006 jornada 720 kbd driver by Filip Zyzniewsk <Filip.Zyzniewski@tefnet.plX
+ *     based on (C) 2004 jornada 720 kbd driver by Alex Lange <chicken@handhelds.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/arch/jornada720.h>
+#include <asm/hardware.h>
+
+MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
+MODULE_DESCRIPTION("HP Jornada 710/720/728 keyboard driver");
+MODULE_LICENSE("GPLv2");
+
+static unsigned char jornada_normal_keymap[128] = {					/* ROW */
+	0, KEY_ESC, KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7,		/* #1  */
+	KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_VOLUMEUP, KEY_VOLUMEDOWN, KEY_MUTE,	/*  -> */
+	0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9,		/* #2  */
+	KEY_0, KEY_MINUS, KEY_EQUAL,0, 0, 0,						/*  -> */
+	0, KEY_Q, KEY_W, KEY_E, KEY_R, KEY_T, KEY_Y, KEY_U, KEY_I, KEY_O,		/* #3  */
+	KEY_P, KEY_BACKSLASH, KEY_BACKSPACE, 0, 0, 0,					/*  -> */
+	0, KEY_A, KEY_S, KEY_D, KEY_F, KEY_G, KEY_H, KEY_J, KEY_K, KEY_L,		/* #4  */
+	KEY_SEMICOLON, KEY_LEFTBRACE, KEY_RIGHTBRACE, 0, 0, 0,				/*  -> */
+	0, KEY_Z, KEY_X, KEY_C, KEY_V, KEY_B, KEY_N, KEY_M, KEY_COMMA,			/* #5  */
+	KEY_DOT, KEY_KPMINUS, KEY_APOSTROPHE, KEY_ENTER, 0, 0,0,			/*  -> */
+	0, KEY_TAB, 0, KEY_LEFTSHIFT, 0, KEY_APOSTROPHE, 0, 0, 0, 0,			/* #6  */
+	KEY_UP, 0, KEY_RIGHTSHIFT, 0, 0, 0,0, 0, 0, 0, 0, KEY_LEFTALT, KEY_GRAVE,	/*  -> */
+	0, 0, KEY_LEFT, KEY_DOWN, KEY_RIGHT, 0, 0, 0, 0,0, KEY_KPASTERISK,		/*  -> */
+	KEY_LEFTCTRL, 0, KEY_SPACE, 0, 0, 0, KEY_SLASH, KEY_DELETE, 0, 0,		/*  -> */
+	0, 0, 0, KEY_POWER,								/*  -> */
+};
+
+struct jornadakbd {
+	unsigned char jornada_keymap[ARRAY_SIZE(jornada_normal_keymap)];
+	struct input_dev *input;
+};
+
+static irqreturn_t jornada720_kbd_interrupt(int irq, void *dev_id)
+{
+	u8 ret, count, kbd_data;
+	struct jornadakbd *jornadakbd = dev_id;
+
+	/* startup ssp with spinlock */
+	jornada_ssp_start();
+
+	ret = jornada_ssp_inout(GETSCANKEYCODE);
+
+	if (ret != TXDUMMY) {
+		printk(KERN_INFO "jornada720_kdb:GetKeycode command failed with ETIMEDOUT, flushed bus\n");
+		jornada_ssp_end();
+		return IRQ_HANDLED;
+	}
+
+	/* How many keycodes are waiting for us? */
+	count = jornada_ssp_byte(TXDUMMY);
+
+	/* Lets drag them out one at a time */
+	while (count-- != 0) {
+		/* Exchange TxDummy for location (keymap[kbddata]) */
+		kbd_data = jornada_ssp_byte(TXDUMMY);
+
+		input_report_key(jornadakbd->input,
+				    jornadakbd->jornada_keymap[kbd_data & 0x7f],
+				    !(kbd_data & 0x80));
+
+		input_sync(jornadakbd->input);
+	}
+
+	/* release spinlock and turn off ssp */
+	jornada_ssp_end();
+
+	return IRQ_HANDLED;
+};
+
+static int __init jornada720_kbd_probe(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd;
+	struct input_dev *input_dev;
+	int i, ret, err;
+
+	jornadakbd = kzalloc(sizeof(struct jornadakbd), GFP_KERNEL);
+	if (!jornadakbd)
+		return -ENOMEM;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, jornadakbd);
+
+	input_dev->dev.parent = &pdev->dev;
+	jornadakbd->input = input_dev;
+
+	memcpy(jornadakbd->jornada_keymap, jornada_normal_keymap, sizeof(jornada_normal_keymap));
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	input_dev->name = "HP Jornada 720 keyboard";
+	input_dev->phys = "jornadakbd/input0";
+	input_dev->keycode = jornadakbd->jornada_keymap;
+	input_dev->keycodesize = sizeof(unsigned char);
+	input_dev->keycodemax = ARRAY_SIZE(jornada_normal_keymap);
+
+	for (i = 0; i < ARRAY_SIZE(jornadakbd->jornada_keymap); i++)
+			set_bit(jornadakbd->jornada_keymap[i], input_dev->keybit);
+
+	ret = request_irq(IRQ_GPIO0,
+			jornada720_kbd_interrupt,
+			IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+			"jornadakbd", jornadakbd);
+	if (ret) {
+		printk(KERN_INFO "jornadakbd : Unable to grab IRQ\n");
+		goto failed1;
+	}
+
+	err = input_register_device(jornadakbd->input);
+	if (err)
+		goto failed2;
+
+	return 0;
+
+failed2: /* IRQ, DEVICE, MEMORY */
+	free_irq(IRQ_GPIO0, input_dev);
+failed1: /* DEVICE, MEMORY */
+	input_free_device(input_dev);
+	kfree(jornadakbd);
+	return err;
+};
+
+static int jornada720_kbd_remove(struct platform_device *pdev)
+{
+	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
+
+	free_irq(IRQ_GPIO0, jornadakbd->input);
+	input_unregister_device(jornadakbd->input);
+	kfree(jornadakbd);
+
+	return 0;
+}
+
+static struct platform_driver jornada720_kbd_driver = {
+	.driver  = {
+		.name    = "jornada720_kbd",
+		 },
+	.probe   = jornada720_kbd_probe,
+	.remove  = jornada720_kbd_remove,
+};
+
+static int __init jornada720_kbd_init(void)
+{
+		return platform_driver_register(&jornada720_kbd_driver);
+}
+
+static void __exit jornada720_kbd_exit(void)
+{
+	platform_driver_unregister(&jornada720_kbd_driver);
+}
+
+module_init(jornada720_kbd_init);
+module_exit(jornada720_kbd_exit);

--Multipart=_Wed__19_Sep_2007_02_24_53_-0700_.zwiH___7UZngNdJ
Content-Type: application/octet-stream;
 name="hp7xx-keyboard-support.patch"
Content-Disposition: attachment;
 filename="hp7xx-keyboard-support.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvS2NvbmZpZyBiL2RyaXZlcnMvaW5w
dXQva2V5Ym9hcmQvS2NvbmZpZwppbmRleCBjOTdkNWViLi43YzNjYTRlIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2lucHV0L2tleWJvYXJkL0tjb25maWcKKysrIGIvZHJpdmVycy9pbnB1dC9rZXlib2Fy
ZC9LY29uZmlnCkBAIC02OCw2ICs2OCwxMyBAQCBjb25maWcgS0VZQk9BUkRfQVRLQkRfUkRJX0tF
WUNPREVTCiAJICByaWdodC1oYW5kIGNvbHVtbiB3aWxsIGJlIGludGVycHJldGVkIGFzIHRoZSBr
ZXkgc2hvd24gaW4gdGhlCiAJICBsZWZ0LWhhbmQgY29sdW1uLgogCitjb25maWcgS0VZQk9BUkRf
SFA3WFgKKwl0cmlzdGF0ZSAiSFA3WFggS2V5Ym9hcmQgRHJpdmVyIgorCWRlcGVuZHMgb24gU0Ex
MTAwX0pPUk5BREE3MjBfU1NQICYmIFNBMTEwMF9TU1AKKwloZWxwCisJICBTYXkgWSBoZXJlIHRv
IGFkZCBzdXBwb3J0IGZvciB0aGUgSFAgSm9ybmFkYSA3eHggKDcxMC83MjAvNzI4KSBvbmJvYXJk
CisJICBrZXlib2FyZC4gSXRzIGdlbmVyYWxseSBhIGdvb2QgaWRlYS4KKwogY29uZmlnIEtFWUJP
QVJEX1NVTktCRAogCXRyaXN0YXRlICJTdW4gVHlwZSA0IGFuZCBUeXBlIDUga2V5Ym9hcmQiCiAJ
c2VsZWN0IFNFUklPCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxl
IGIvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9NYWtlZmlsZQppbmRleCAyOGQyMTFiLi44OWY3MDhj
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL01ha2VmaWxlCisrKyBiL2RyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvTWFrZWZpbGUKQEAgLTIxLDQgKzIxLDUgQEAgb2JqLSQoQ09ORklH
X0tFWUJPQVJEX09NQVApCQkrPSBvbWFwLWtleXBhZC5vCiBvYmotJChDT05GSUdfS0VZQk9BUkRf
UFhBMjd4KQkJKz0gcHhhMjd4X2tleWJvYXJkLm8KIG9iai0kKENPTkZJR19LRVlCT0FSRF9BQUVE
MjAwMCkJCSs9IGFhZWQyMDAwX2tiZC5vCiBvYmotJChDT05GSUdfS0VZQk9BUkRfR1BJTykJCSs9
IGdwaW9fa2V5cy5vCitvYmotJChDT05GSUdfS0VZQk9BUkRfSFA3WFgpICAgICAgICAgICAgKz0g
am9ybmFkYTcyMF9rYmQubwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2pv
cm5hZGE3MjBfa2JkLmMgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2pvcm5hZGE3MjBfa2JkLmMK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uODMwY2RiYgotLS0gL2Rldi9udWxs
CisrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvam9ybmFkYTcyMF9rYmQuYwpAQCAtMCwwICsx
LDE3NyBAQAorLyoKKyAqIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvam9ybmFkYTcyMF9rYmQuYwor
ICoKKyAqIEhQIEpvcm5hZGEgNzIwIGtleWJvYXJkIHBsYXRmb3JtIGRyaXZlcgorICoKKyAqIENv
cHlyaWdodCAoQykgMjAwNi8yMDA3IEtyaXN0b2ZmZXIgRXJpY3NvbiA8S3Jpc3RvZmZlci5Fcmlj
c29uQEdtYWlsLmNvbT4KKyAqCisgKiAgICBDb3B5cmlnaHQgKEMpIDIwMDYgam9ybmFkYSA3MjAg
a2JkIGRyaXZlciBieSBGaWxpcCBaeXpuaWV3c2sgPEZpbGlwLlp5em5pZXdza2lAdGVmbmV0LnBs
WAorICogICAgIGJhc2VkIG9uIChDKSAyMDA0IGpvcm5hZGEgNzIwIGtiZCBkcml2ZXIgYnkgQWxl
eCBMYW5nZSA8Y2hpY2tlbkBoYW5kaGVsZHMub3JnPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBm
cmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBp
dCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNp
b24gMiBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisg
KgorICovCisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgvZXJybm8u
aD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+
CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CisjaW5j
bHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisKKyNpbmNsdWRlIDxhc20vYXJjaC9qb3JuYWRh
NzIwLmg+CisjaW5jbHVkZSA8YXNtL2hhcmR3YXJlLmg+CisKK01PRFVMRV9BVVRIT1IoIktyaXN0
b2ZmZXIgRXJpY3NvbiA8S3Jpc3RvZmZlci5Fcmljc29uQGdtYWlsLmNvbT4iKTsKK01PRFVMRV9E
RVNDUklQVElPTigiSFAgSm9ybmFkYSA3MTAvNzIwLzcyOCBrZXlib2FyZCBkcml2ZXIiKTsKK01P
RFVMRV9MSUNFTlNFKCJHUEx2MiIpOworCitzdGF0aWMgdW5zaWduZWQgY2hhciBqb3JuYWRhX25v
cm1hbF9rZXltYXBbMTI4XSA9IHsJCQkJCS8qIFJPVyAqLworCTAsIEtFWV9FU0MsIEtFWV9GMSwg
S0VZX0YyLCBLRVlfRjMsIEtFWV9GNCwgS0VZX0Y1LCBLRVlfRjYsIEtFWV9GNywJCS8qICMxICAq
LworCUtFWV9GOCwgS0VZX0Y5LCBLRVlfRjEwLCBLRVlfRjExLCBLRVlfVk9MVU1FVVAsIEtFWV9W
T0xVTUVET1dOLCBLRVlfTVVURSwJLyogIC0+ICovCisJMCwgS0VZXzEsIEtFWV8yLCBLRVlfMywg
S0VZXzQsIEtFWV81LCBLRVlfNiwgS0VZXzcsIEtFWV84LCBLRVlfOSwJCS8qICMyICAqLworCUtF
WV8wLCBLRVlfTUlOVVMsIEtFWV9FUVVBTCwwLCAwLCAwLAkJCQkJCS8qICAtPiAqLworCTAsIEtF
WV9RLCBLRVlfVywgS0VZX0UsIEtFWV9SLCBLRVlfVCwgS0VZX1ksIEtFWV9VLCBLRVlfSSwgS0VZ
X08sCQkvKiAjMyAgKi8KKwlLRVlfUCwgS0VZX0JBQ0tTTEFTSCwgS0VZX0JBQ0tTUEFDRSwgMCwg
MCwgMCwJCQkJCS8qICAtPiAqLworCTAsIEtFWV9BLCBLRVlfUywgS0VZX0QsIEtFWV9GLCBLRVlf
RywgS0VZX0gsIEtFWV9KLCBLRVlfSywgS0VZX0wsCQkvKiAjNCAgKi8KKwlLRVlfU0VNSUNPTE9O
LCBLRVlfTEVGVEJSQUNFLCBLRVlfUklHSFRCUkFDRSwgMCwgMCwgMCwJCQkJLyogIC0+ICovCisJ
MCwgS0VZX1osIEtFWV9YLCBLRVlfQywgS0VZX1YsIEtFWV9CLCBLRVlfTiwgS0VZX00sIEtFWV9D
T01NQSwJCQkvKiAjNSAgKi8KKwlLRVlfRE9ULCBLRVlfS1BNSU5VUywgS0VZX0FQT1NUUk9QSEUs
IEtFWV9FTlRFUiwgMCwgMCwwLAkJCS8qICAtPiAqLworCTAsIEtFWV9UQUIsIDAsIEtFWV9MRUZU
U0hJRlQsIDAsIEtFWV9BUE9TVFJPUEhFLCAwLCAwLCAwLCAwLAkJCS8qICM2ICAqLworCUtFWV9V
UCwgMCwgS0VZX1JJR0hUU0hJRlQsIDAsIDAsIDAsMCwgMCwgMCwgMCwgMCwgS0VZX0xFRlRBTFQs
IEtFWV9HUkFWRSwJLyogIC0+ICovCisJMCwgMCwgS0VZX0xFRlQsIEtFWV9ET1dOLCBLRVlfUklH
SFQsIDAsIDAsIDAsIDAsMCwgS0VZX0tQQVNURVJJU0ssCQkvKiAgLT4gKi8KKwlLRVlfTEVGVENU
UkwsIDAsIEtFWV9TUEFDRSwgMCwgMCwgMCwgS0VZX1NMQVNILCBLRVlfREVMRVRFLCAwLCAwLAkJ
LyogIC0+ICovCisJMCwgMCwgMCwgS0VZX1BPV0VSLAkJCQkJCQkJLyogIC0+ICovCit9OworCitz
dHJ1Y3Qgam9ybmFkYWtiZCB7CisJdW5zaWduZWQgY2hhciBqb3JuYWRhX2tleW1hcFtBUlJBWV9T
SVpFKGpvcm5hZGFfbm9ybWFsX2tleW1hcCldOworCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0Owor
fTsKKworc3RhdGljIGlycXJldHVybl90IGpvcm5hZGE3MjBfa2JkX2ludGVycnVwdChpbnQgaXJx
LCB2b2lkICpkZXZfaWQpCit7CisJdTggcmV0LCBjb3VudCwga2JkX2RhdGE7CisJc3RydWN0IGpv
cm5hZGFrYmQgKmpvcm5hZGFrYmQgPSBkZXZfaWQ7CisKKwkvKiBzdGFydHVwIHNzcCB3aXRoIHNw
aW5sb2NrICovCisJam9ybmFkYV9zc3Bfc3RhcnQoKTsKKworCXJldCA9IGpvcm5hZGFfc3NwX2lu
b3V0KEdFVFNDQU5LRVlDT0RFKTsKKworCWlmIChyZXQgIT0gVFhEVU1NWSkgeworCQlwcmludGso
S0VSTl9JTkZPICJqb3JuYWRhNzIwX2tkYjpHZXRLZXljb2RlIGNvbW1hbmQgZmFpbGVkIHdpdGgg
RVRJTUVET1VULCBmbHVzaGVkIGJ1c1xuIik7CisJCWpvcm5hZGFfc3NwX2VuZCgpOworCQlyZXR1
cm4gSVJRX0hBTkRMRUQ7CisJfQorCisJLyogSG93IG1hbnkga2V5Y29kZXMgYXJlIHdhaXRpbmcg
Zm9yIHVzPyAqLworCWNvdW50ID0gam9ybmFkYV9zc3BfYnl0ZShUWERVTU1ZKTsKKworCS8qIExl
dHMgZHJhZyB0aGVtIG91dCBvbmUgYXQgYSB0aW1lICovCisJd2hpbGUgKGNvdW50LS0gIT0gMCkg
eworCQkvKiBFeGNoYW5nZSBUeER1bW15IGZvciBsb2NhdGlvbiAoa2V5bWFwW2tiZGRhdGFdKSAq
LworCQlrYmRfZGF0YSA9IGpvcm5hZGFfc3NwX2J5dGUoVFhEVU1NWSk7CisKKwkJaW5wdXRfcmVw
b3J0X2tleShqb3JuYWRha2JkLT5pbnB1dCwKKwkJCQkgICAgam9ybmFkYWtiZC0+am9ybmFkYV9r
ZXltYXBba2JkX2RhdGEgJiAweDdmXSwKKwkJCQkgICAgIShrYmRfZGF0YSAmIDB4ODApKTsKKwor
CQlpbnB1dF9zeW5jKGpvcm5hZGFrYmQtPmlucHV0KTsKKwl9CisKKwkvKiByZWxlYXNlIHNwaW5s
b2NrIGFuZCB0dXJuIG9mZiBzc3AgKi8KKwlqb3JuYWRhX3NzcF9lbmQoKTsKKworCXJldHVybiBJ
UlFfSEFORExFRDsKK307CisKK3N0YXRpYyBpbnQgX19pbml0IGpvcm5hZGE3MjBfa2JkX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IGpvcm5hZGFrYmQgKmpv
cm5hZGFrYmQ7CisJc3RydWN0IGlucHV0X2RldiAqaW5wdXRfZGV2OworCWludCBpLCByZXQsIGVy
cjsKKworCWpvcm5hZGFrYmQgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qgam9ybmFkYWtiZCksIEdG
UF9LRVJORUwpOworCWlmICgham9ybmFkYWtiZCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlpbnB1
dF9kZXYgPSBpbnB1dF9hbGxvY2F0ZV9kZXZpY2UoKTsKKwlpZiAoIWlucHV0X2RldikKKwkJcmV0
dXJuIC1FTk9ERVY7CisKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBqb3JuYWRha2JkKTsK
KworCWlucHV0X2Rldi0+ZGV2LnBhcmVudCA9ICZwZGV2LT5kZXY7CisJam9ybmFkYWtiZC0+aW5w
dXQgPSBpbnB1dF9kZXY7CisKKwltZW1jcHkoam9ybmFkYWtiZC0+am9ybmFkYV9rZXltYXAsIGpv
cm5hZGFfbm9ybWFsX2tleW1hcCwgc2l6ZW9mKGpvcm5hZGFfbm9ybWFsX2tleW1hcCkpOworCisJ
aW5wdXRfZGV2LT5ldmJpdFswXSA9IEJJVChFVl9LRVkpIHwgQklUKEVWX1JFUCk7CisJaW5wdXRf
ZGV2LT5uYW1lID0gIkhQIEpvcm5hZGEgNzIwIGtleWJvYXJkIjsKKwlpbnB1dF9kZXYtPnBoeXMg
PSAiam9ybmFkYWtiZC9pbnB1dDAiOworCWlucHV0X2Rldi0+a2V5Y29kZSA9IGpvcm5hZGFrYmQt
Pmpvcm5hZGFfa2V5bWFwOworCWlucHV0X2Rldi0+a2V5Y29kZXNpemUgPSBzaXplb2YodW5zaWdu
ZWQgY2hhcik7CisJaW5wdXRfZGV2LT5rZXljb2RlbWF4ID0gQVJSQVlfU0laRShqb3JuYWRhX25v
cm1hbF9rZXltYXApOworCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoam9ybmFkYWtiZC0+
am9ybmFkYV9rZXltYXApOyBpKyspCisJCQlzZXRfYml0KGpvcm5hZGFrYmQtPmpvcm5hZGFfa2V5
bWFwW2ldLCBpbnB1dF9kZXYtPmtleWJpdCk7CisKKwlyZXQgPSByZXF1ZXN0X2lycShJUlFfR1BJ
TzAsCisJCQlqb3JuYWRhNzIwX2tiZF9pbnRlcnJ1cHQsCisJCQlJUlFGX0RJU0FCTEVEIHwgSVJR
Rl9UUklHR0VSX0ZBTExJTkcsCisJCQkiam9ybmFkYWtiZCIsIGpvcm5hZGFrYmQpOworCWlmIChy
ZXQpIHsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiam9ybmFkYWtiZCA6IFVuYWJsZSB0byBncmFiIElS
UVxuIik7CisJCWdvdG8gZmFpbGVkMTsKKwl9CisKKwllcnIgPSBpbnB1dF9yZWdpc3Rlcl9kZXZp
Y2Uoam9ybmFkYWtiZC0+aW5wdXQpOworCWlmIChlcnIpCisJCWdvdG8gZmFpbGVkMjsKKworCXJl
dHVybiAwOworCitmYWlsZWQyOiAvKiBJUlEsIERFVklDRSwgTUVNT1JZICovCisJZnJlZV9pcnEo
SVJRX0dQSU8wLCBpbnB1dF9kZXYpOworZmFpbGVkMTogLyogREVWSUNFLCBNRU1PUlkgKi8KKwlp
bnB1dF9mcmVlX2RldmljZShpbnB1dF9kZXYpOworCWtmcmVlKGpvcm5hZGFrYmQpOworCXJldHVy
biBlcnI7Cit9OworCitzdGF0aWMgaW50IGpvcm5hZGE3MjBfa2JkX3JlbW92ZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBqb3JuYWRha2JkICpqb3JuYWRha2JkID0g
cGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisKKwlmcmVlX2lycShJUlFfR1BJTzAsIGpvcm5h
ZGFrYmQtPmlucHV0KTsKKwlpbnB1dF91bnJlZ2lzdGVyX2RldmljZShqb3JuYWRha2JkLT5pbnB1
dCk7CisJa2ZyZWUoam9ybmFkYWtiZCk7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgam9ybmFkYTcyMF9rYmRfZHJpdmVyID0geworCS5kcml2ZXIgID0g
eworCQkubmFtZSAgICA9ICJqb3JuYWRhNzIwX2tiZCIsCisJCSB9LAorCS5wcm9iZSAgID0gam9y
bmFkYTcyMF9rYmRfcHJvYmUsCisJLnJlbW92ZSAgPSBqb3JuYWRhNzIwX2tiZF9yZW1vdmUsCit9
OworCitzdGF0aWMgaW50IF9faW5pdCBqb3JuYWRhNzIwX2tiZF9pbml0KHZvaWQpCit7CisJCXJl
dHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmpvcm5hZGE3MjBfa2JkX2RyaXZlcik7Cit9
CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBqb3JuYWRhNzIwX2tiZF9leGl0KHZvaWQpCit7CisJcGxh
dGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmpvcm5hZGE3MjBfa2JkX2RyaXZlcik7Cit9CisKK21v
ZHVsZV9pbml0KGpvcm5hZGE3MjBfa2JkX2luaXQpOworbW9kdWxlX2V4aXQoam9ybmFkYTcyMF9r
YmRfZXhpdCk7Cg==

--Multipart=_Wed__19_Sep_2007_02_24_53_-0700_.zwiH___7UZngNdJ--
