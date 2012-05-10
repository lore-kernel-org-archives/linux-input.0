From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH Draft] HID: Add driver for ION iCade
Date: Fri, 11 May 2012 01:40:49 +0200
Message-ID: <1336693249.11861.3.camel@sirocco.config>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50171 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933015Ab2EJXky convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 May 2012 19:40:54 -0400
Received: from mfilter10-d.gandi.net (mfilter10-d.gandi.net [217.70.178.139])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 18CE6172087
	for <linux-input@vger.kernel.org>; Fri, 11 May 2012 01:40:52 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter10-d.gandi.net (mfilter10-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id oS6CLpkf+6WS for <linux-input@vger.kernel.org>;
	Fri, 11 May 2012 01:40:50 +0200 (CEST)
Received: from [192.168.1.91] (94-192-232-89.zone6.bethere.co.uk [94.192.232.89])
	(Authenticated sender: hadess@hadess.net)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EA107172095
	for <linux-input@vger.kernel.org>; Fri, 11 May 2012 01:40:49 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Heya,

Tried to write a driver for my iCade controller, and ended up triggerin=
g
this bug in the kernel. Am I doing something wrong?

May  6 21:39:59 sirocco kernel: [ 1444.715558] icade 0005:15E4:0132.000=
5: unknown main item tag 0x0
May  6 21:39:59 sirocco kernel: [ 1444.715597] BUG: unable to handle ke=
rnel NULL pointer dereference at           (null)
May  6 21:39:59 sirocco kernel: [ 1444.715665] IP: [<ffffffff814ab457>]=
 hidinput_connect+0x2d7/0x2860
May  6 21:39:59 sirocco kernel: [ 1444.715717] PGD 0=20
May  6 21:39:59 sirocco kernel: [ 1444.715738] Oops: 0002 [#1] SMP=20
May  6 21:39:59 sirocco kernel: [ 1444.715760] CPU 0=20
May  6 21:39:59 sirocco kernel: [ 1444.715770] Modules linked in: hid_i=
cade(+) hidp fuse rfcomm bnep be2iscsi iscsi_boot_sysfs bnx2i cnic uio =
cxgb4i cxgb4 cxgb3i cxgb3 mdio libcxgbi ib_iser rdma_cm ib_addr iw_cm i=
b_cm ib_sa ib_mad ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transpor=
t_iscsi ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntr=
ack ip6table_filter ip6_tables snd_hda_codec_hdmi snd_hda_codec_cirrus =
vfat fat arc4 btusb brcmsmac bluetooth cordic crc8 brcmutil mac80211 jo=
ydev snd_hda_intel snd_hda_codec cfg80211 uvcvideo videobuf2_vmalloc vi=
deobuf2_memops videobuf2_core videodev snd_hwdep bcm5974 media coretemp=
 snd_pcm rfkill crc32c_intel ghash_clmulni_intel snd_page_alloc applesm=
c snd_timer microcode input_polldev snd i2c_i801 bcma soundcore pcspkr =
iTCO_wdt iTCO_vendor_support apple_bl uinput i915 video i2c_algo_bit dr=
m_kms_helper drm i2c_core [last unloaded: scsi_wait_scan]
May  6 21:39:59 sirocco kernel: [ 1444.716255]=20
May  6 21:39:59 sirocco kernel: [ 1444.716265] Pid: 342, comm: udevd No=
t tainted 3.4.0-rc3+ #1 Apple Inc. MacBookAir4,1/Mac-C08A6BB70A942AC2
May  6 21:39:59 sirocco kernel: [ 1444.716311] RIP: 0010:[<ffffffff814a=
b457>]  [<ffffffff814ab457>] hidinput_connect+0x2d7/0x2860
May  6 21:39:59 sirocco kernel: [ 1444.716352] RSP: 0018:ffff8801645edb=
28  EFLAGS: 00010246
May  6 21:39:59 sirocco kernel: [ 1444.716376] RAX: 0000000000000000 RB=
X: ffff88011ba66a00 RCX: ffff8801443fc028
May  6 21:39:59 sirocco kernel: [ 1444.716407] RDX: 0000000000000000 RS=
I: ffff880148a26d40 RDI: ffff880165020000
May  6 21:39:59 sirocco kernel: [ 1444.716438] RBP: ffff8801645edbc8 R0=
8: ffff8801645edb90 R09: ffff8801645edb8c
May  6 21:39:59 sirocco kernel: [ 1444.716469] R10: 0000000000000000 R1=
1: 0000000000000000 R12: ffff8801443fc000
May  6 21:39:59 sirocco kernel: [ 1444.716499] R13: ffff880165020000 R1=
4: ffff88011ba66a70 R15: ffff880148a26d40
May  6 21:39:59 sirocco kernel: [ 1444.716531] FS:  00007fcb9b443840(00=
00) GS:ffff88016fa00000(0000) knlGS:0000000000000000
May  6 21:39:59 sirocco kernel: [ 1444.716565] CS:  0010 DS: 0000 ES: 0=
000 CR0: 000000008005003b
May  6 21:39:59 sirocco kernel: [ 1444.716591] CR2: 0000000000000000 CR=
3: 00000001645df000 CR4: 00000000000407f0
May  6 21:39:59 sirocco kernel: [ 1444.716621] DR0: 0000000000000000 DR=
1: 0000000000000000 DR2: 0000000000000000
May  6 21:39:59 sirocco kernel: [ 1444.716652] DR3: 0000000000000000 DR=
6: 00000000ffff0ff0 DR7: 0000000000000400
May  6 21:39:59 sirocco kernel: [ 1444.716683] Process udevd (pid: 342,=
 threadinfo ffff8801645ec000, task ffff8801645a2de0)
May  6 21:39:59 sirocco kernel: [ 1444.716717] Stack:
May  6 21:39:59 sirocco kernel: [ 1444.716728]  ffff880165021bf8 ffff88=
0165021b78 ffff880165020048 ffff880165020000
May  6 21:39:59 sirocco kernel: [ 1444.716767]  ffff880165021b50 ffff88=
0165020000 ffff8801443fd000 0000000000000000
May  6 21:39:59 sirocco kernel: [ 1444.716805]  ffff8801443fc028 ffff88=
01443fd018 ffff880100000000 0000000000000001
May  6 21:39:59 sirocco kernel: [ 1444.716844] Call Trace:
May  6 21:39:59 sirocco kernel: [ 1444.716859]  [<ffffffff814aa87d>] hi=
d_connect+0x31d/0x390
May  6 21:39:59 sirocco kernel: [ 1444.716886]  [<ffffffffa043034c>] ? =
hidp_send_report+0xfc/0x160 [hidp]
May  6 21:39:59 sirocco kernel: [ 1444.716917]  [<ffffffff81150c38>] ? =
vfree+0x28/0x30
May  6 21:39:59 sirocco kernel: [ 1444.716940]  [<ffffffff814aa9e5>] hi=
d_device_probe+0xf5/0x180
May  6 21:39:59 sirocco kernel: [ 1444.716969]  [<ffffffff8139efc2>] dr=
iver_probe_device+0x92/0x390
May  6 21:39:59 sirocco kernel: [ 1444.716997]  [<ffffffff8139f36b>] __=
driver_attach+0xab/0xb0
May  6 21:39:59 sirocco kernel: [ 1444.717023]  [<ffffffff8139f2c0>] ? =
driver_probe_device+0x390/0x390
May  6 21:39:59 sirocco kernel: [ 1444.717052]  [<ffffffff8139d045>] bu=
s_for_each_dev+0x55/0x90
May  6 21:39:59 sirocco kernel: [ 1444.717080]  [<ffffffffa00ef000>] ? =
0xffffffffa00eefff
May  6 21:39:59 sirocco kernel: [ 1444.717111]  [<ffffffff8139e85e>] dr=
iver_attach+0x1e/0x20
May  6 21:39:59 sirocco kernel: [ 1444.717136]  [<ffffffff8139e568>] bu=
s_add_driver+0x1a8/0x2a0
May  6 21:39:59 sirocco kernel: [ 1444.717163]  [<ffffffffa00ef000>] ? =
0xffffffffa00eefff
May  6 21:39:59 sirocco kernel: [ 1444.717188]  [<ffffffffa00ef000>] ? =
0xffffffffa00eefff
May  6 21:39:59 sirocco kernel: [ 1444.717213]  [<ffffffff8139fa37>] dr=
iver_register+0x77/0x150
May  6 21:39:59 sirocco kernel: [ 1444.717240]  [<ffffffffa00ef000>] ? =
0xffffffffa00eefff
May  6 21:39:59 sirocco kernel: [ 1444.718448]  [<ffffffff814a7e02>] __=
hid_register_driver+0x52/0x90
May  6 21:39:59 sirocco kernel: [ 1444.719653]  [<ffffffffa00ef020>] ic=
ade_init+0x20/0x1000 [hid_icade]
May  6 21:39:59 sirocco kernel: [ 1444.720843]  [<ffffffff8100212a>] do=
_one_initcall+0x12a/0x180
May  6 21:39:59 sirocco kernel: [ 1444.722027]  [<ffffffff810b5e36>] sy=
s_init_module+0x10e6/0x20a0
May  6 21:39:59 sirocco kernel: [ 1444.723206]  [<ffffffff815f6f29>] sy=
stem_call_fastpath+0x16/0x1b
May  6 21:39:59 sirocco kernel: [ 1444.724388] Code: ef ff d0 85 c0 78 =
7d 41 0f b6 46 0a 49 8d 54 24 28 48 89 55 a0 48 8b 4d a0 f0 0f ab 01 41=
 0f b7 56 08 3b 55 c4 7f 5d 48 8b 45 c8 <f0> 0f ab 10 19 d2 85 d2 75 21=
 e9 b2 01 00 00 66 2e 0f 1f 84 00=20
May  6 21:39:59 sirocco kernel: [ 1444.727065] RIP  [<ffffffff814ab457>=
] hidinput_connect+0x2d7/0x2860
May  6 21:39:59 sirocco kernel: [ 1444.728317]  RSP <ffff8801645edb28>
May  6 21:39:59 sirocco kernel: [ 1444.729517] CR2: 0000000000000000
May  6 21:39:59 sirocco kernel: [ 1444.786664] ---[ end trace dcd435117=
d911e0d ]---
May  6 21:39:59 sirocco udevd[296]: worker [342] terminated by signal 9=
 (Killed)
May  6 21:39:59 sirocco udevd[296]: worker [342] failed while handling =
'/devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1.3/1-1.1.3:1.0/bl=
uetooth/hci0/hci0:11/0005:15E4:0132.0005'

Cheers

--8<--
Add a driver for the ION iCade mini arcade cabinet [1]. The device
generates a key press and release for each joystick movement or
button press or release. For example, moving the stick to the
left will generate the "A" key being pressed and the released.

A list of all the combinations is available in the iCade
developer guide [2].

This driver hides all this and makes the device work as a generic
joystick.

[1]: http://www.ionaudio.com/products/details/icade
[2]: http://www.ionaudio.com/downloads/iCade_Dev_Resource_v1.3.pdf
---
 drivers/hid/Kconfig     |    6 ++
 drivers/hid/Makefile    |    1 +
 drivers/hid/hid-core.c  |    1 +
 drivers/hid/hid-icade.c |  156 +++++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/hid/hid-ids.h   |    3 +
 5 files changed, 167 insertions(+)
 create mode 100644 drivers/hid/hid-icade.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index ffddcba..935f5b9 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -227,6 +227,12 @@ config HID_GYRATION
 	---help---
 	Support for Gyration remote control.
=20
+config HID_ICADE
+	tristate "ION iCade arcade controller"
+	depends on (BT_HIDP)
+	---help---
+	Support for the ION iCade arcade controller to work as a joystick.
+
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 22f1d16..7a77c62 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_HID_KYE)		+=3D hid-kye.o
 obj-$(CONFIG_HID_LCPOWER)       +=3D hid-lcpower.o
 obj-$(CONFIG_HID_LOGITECH)	+=3D hid-logitech.o
 obj-$(CONFIG_HID_LOGITECH_DJ)	+=3D hid-logitech-dj.o
+obj-$(CONFIG_HID_ICADE)		+=3D hid-icade.o
 obj-$(CONFIG_HID_MAGICMOUSE)    +=3D hid-magicmouse.o
 obj-$(CONFIG_HID_MICROSOFT)	+=3D hid-microsoft.o
 obj-$(CONFIG_HID_MONTEREY)	+=3D hid-monterey.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4da66b4..ac6d67b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1438,6 +1438,7 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC665=
0) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_G=
RIP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ILITEK, USB_DEVICE_ID_ILITEK_MULTITOUC=
H) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS, USB_DEVICE_ID_IRTOUCH_=
INFRARED_USB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) =
},
diff --git a/drivers/hid/hid-icade.c b/drivers/hid/hid-icade.c
new file mode 100644
index 0000000..e7e0c9d
--- /dev/null
+++ b/drivers/hid/hid-icade.c
@@ -0,0 +1,156 @@
+/*
+ *  USB HID quirks support for Linux
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Conc=
ept2, Inc
+ *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2007 Paul Walmsley
+ *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
+ *  Copyright (c) 2012 Bastien Nocera <hadess@hadess.net>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License as published by t=
he Free
+ * Software Foundation; either version 2 of the License, or (at your o=
ption)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+struct icade_key_translation {
+	u16 from;
+	u16 to;
+	u8  press : 1;
+};
+
+/*
+ *   =E2=86=91      A C Y L
+ *  =E2=86=90 =E2=86=92
+ *   =E2=86=93      B X Z R
+ *
+ *
+ *  UP ON,OFF  =3D w,e
+ *  RT ON,OFF  =3D d,c
+ *  DN ON,OFF  =3D x,z
+ *  LT ON,OFF  =3D a,q
+ *  A  ON,OFF  =3D y,t
+ *  B  ON,OFF  =3D h,r
+ *  C  ON,OFF  =3D u,f
+ *  X  ON,OFF  =3D j,n
+ *  Y  ON,OFF  =3D i,m
+ *  Z  ON,OFF  =3D k,p
+ *  L  ON,OFF  =3D o,g
+ *  R  ON,OFF  =3D l,v
+ */
+static const struct icade_key_translation icade_keys[] =3D {
+	{ KEY_W,	KEY_UP,			1 },
+	{ KEY_E,	KEY_UP,			0 },
+	{ KEY_D,	KEY_RIGHT,		1 },
+	{ KEY_C,	KEY_RIGHT,		0 },
+	{ KEY_X,	KEY_DOWN,		1 },
+	{ KEY_Z,	KEY_DOWN,		0 },
+	{ KEY_A,	KEY_LEFT,		1 },
+	{ KEY_Q,	KEY_LEFT,		0 },
+	{ KEY_Y,	BTN_A,			1 },
+	{ KEY_T,	BTN_A,			0 },
+	{ KEY_H,	BTN_B,			1 },
+	{ KEY_R,	BTN_B,			0 },
+	{ KEY_U,	BTN_C,			1 },
+	{ KEY_F,	BTN_C,			0 },
+	{ KEY_J,	BTN_X,			1 },
+	{ KEY_N,	BTN_X,			0 },
+	{ KEY_I,	BTN_Y,			1 },
+	{ KEY_M,	BTN_Y,			0 },
+	{ KEY_K,	BTN_Z,			1 },
+	{ KEY_P,	BTN_Z,			0 },
+	{ KEY_O,	BTN_THUMBL,		1 },
+	{ KEY_G,	BTN_THUMBL,		0 },
+	{ KEY_L,	BTN_THUMBR,		1 },
+	{ KEY_V,	BTN_THUMBR,		0 },
+
+	{ }
+};
+
+static const struct icade_key_translation *icade_find_translation(
+		u16 from)
+{
+	const struct icade_key_translation *trans;
+
+	/* Look for the translation */
+	for (trans =3D icade_keys; trans->from; trans++)
+		if (trans->from =3D=3D from)
+			return trans;
+
+	return NULL;
+}
+
+static int icade_event(struct hid_device *hdev, struct hid_field *fiel=
d,
+		struct hid_usage *usage, __s32 value)
+{
+	const struct icade_key_translation *trans;
+
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
+			!usage->type)
+		return 0;
+
+	/* We ignore the fake key up, and act only on key down */
+	if (!value)
+		return 1;
+
+	trans =3D icade_find_translation (usage->code);
+
+	if (!trans)
+		return 0;
+
+	input_event(field->hidinput->input, usage->type, trans->to, trans->pr=
ess);
+	return 1;
+}
+
+static int icade_input_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	const struct icade_key_translation *trans;
+
+	/* Enable all needed keys */
+	for (trans =3D icade_keys; trans->from; trans++)
+		set_bit(trans->to, hi->input->keybit);
+
+	return 1;
+}
+
+static const struct hid_device_id icade_devices[] =3D {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
+
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, icade_devices);
+
+static struct hid_driver icade_driver =3D {
+	.name =3D "icade",
+	.id_table =3D icade_devices,
+	.event =3D icade_event,
+	.input_mapping =3D icade_input_mapping,
+};
+
+static int __init icade_init(void)
+{
+	return hid_register_driver(&icade_driver);
+}
+
+static void __exit icade_exit(void)
+{
+	hid_unregister_driver(&icade_driver);
+}
+
+module_init(icade_init);
+module_exit(icade_exit);
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e39aecb..13be916 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -395,6 +395,9 @@
 #define USB_VENDOR_ID_ILITEK		0x222a
 #define USB_DEVICE_ID_ILITEK_MULTITOUCH	0x0001
=20
+#define USB_VENDOR_ID_ION		0x15e4
+#define USB_DEVICE_ID_ICADE		0x0132
+
 #define USB_VENDOR_ID_HOLTEK		0x1241
 #define USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP	0x5015
=20
--=20
1.7.10


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
