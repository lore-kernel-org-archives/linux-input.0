From: Laura Abbott <labbott@fedoraproject.org>
Subject: [PATCH] Input: xpad - Fix double URB submission races
Date: Wed, 29 Jul 2015 14:27:23 -0700
Message-ID: <1438205243-14722-1-git-send-email-labbott@fedoraproject.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbbG2V1b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 17:27:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

The xpad driver has several races with respect to URB submission which
make it easy to end up with submission while active:

------------[ cut here ]------------
WARNING: CPU: 3 PID: 3563 at drivers/usb/core/urb.c:339
usb_submit_urb+0x2ad/0x5a0()
URB ffff8804078ac240 submitted while active
Modules linked in: fuse xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_nat ebtable_broute bridge ebtable_filter
ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6
ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables
iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
iptable_mangle iptable_security iptable_raw bnep xpadsnd_hda_codec_realtek
snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec
snd_hda_core snd_hwdep snd_seq intel_rapl iosf_mbi snd_seq_device
x86_pkg_temp_thermal coretemp snd_pcm kvm uvcvideo iTCO_wdt iTCO_vendor_support
iwlwifi videobuf2_vmalloc videobuf2_core videobuf2_memops
v4l2_common btusb videodev btrtl btbcm thinkpad_acpi snd_timer btintel
mei_me rtsx_pci_ms cfg80211 bluetooth pcspkr mei media memstick joydev snd
tpm_tis shpchp ie31200_edac i2c_i801 tpm lpc_ich edac_core nfsd rfkill wmi
soundcore auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc dm_crypt i915 8021q
garp stp llc mrp i2c_algo_bit drm_kms_helper drm rtsx_pci_sdmmc mmc_core e1000e
crct10dif_pclmul crc32_pclmul crc32c_intel rtsx_pci ghash_clmulni_intel
ptp serio_raw pps_core mfd_core video
CPU: 3 PID: 3563 Comm: led_test.sh Not tainted 4.2.0-rc4-xpad+ #14
Hardware name: LENOVO 20BFS0EC00/20BFS0EC00, BIOS GMET62WW (2.10 )
03/19/2014
0000000000000000 0000000017a45bc6 ffff8800c9a0fbd8 ffffffff81758a11
0000000000000000 ffff8800c9a0fc30 ffff8800c9a0fc18 ffffffff8109b656
0000000000000002 ffff8804078ac240 00000000000000d0 ffff8800c9806d60
Call Trace:
[<ffffffff81758a11>] dump_stack+0x45/0x57
[<ffffffff8109b656>] warn_slowpath_common+0x86/0xc0
[<ffffffff8109b6e5>] warn_slowpath_fmt+0x55/0x70
[<ffffffff8120f218>] ? do_truncate+0x88/0xc0
[<ffffffff815427fd>] usb_submit_urb+0x2ad/0x5a0
[<ffffffff81230df4>] ? mntput+0x24/0x40
[<ffffffff8121b667>] ? terminate_walk+0xc7/0xe0
[<ffffffffa0430877>] xpad_send_led_command+0xc7/0x110 [xpad]
[<ffffffffa04308d5>] xpad_led_set+0x15/0x20 [xpad]
[<ffffffff815f9678>] led_set_brightness+0x88/0xc0
[<ffffffff815f9b0e>] brightness_store+0x7e/0xc0
[<ffffffff814b7478>] dev_attr_store+0x18/0x30
[<ffffffff8128bba7>] sysfs_kf_write+0x37/0x40
[<ffffffff8128b15d>] kernfs_fop_write+0x11d/0x170
[<ffffffff81210d17>] __vfs_write+0x37/0x100
[<ffffffff81213b28>] ? __sb_start_write+0x58/0x110
[<ffffffff813124dd>] ? security_file_permission+0x3d/0xc0
[<ffffffff81211696>] vfs_write+0xa6/0x1a0
[<ffffffff8120e93a>] ? filp_close+0x5a/0x80
[<ffffffff81212385>] SyS_write+0x55/0xc0
[<ffffffff8175f0ae>] entry_SYSCALL_64_fastpath+0x12/0x71
---[ end trace f573b768c94a66d6 ]---

This is easily reproducible with

while true; do
        for i in $(seq 0 5); do
                echo $i > /sys/class/leds/xpad0/subsystem/xpad0/brightness
        done
done

xpad_send_led_command attempts to protect against races by locking
around usb_submit_urb. This is not sufficent since usb_submit_urb
is asynchronous; the urb is considered to be in use until the callback
(xpad_irq_out) returns appropriately. Additionally, there is no
protection at all in xpad_play_effect which uses the same urb. Fix this
by adding a flag to indicate when the urb submission is in progress.
The flag is cleared in the xpad_irq_out callback.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
 drivers/input/joystick/xpad.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f8850f9..f15d037 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -100,6 +100,8 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
+#define OUT_IRQ_SUBMITTED	0
+
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
 MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than axes for unknown pads");
@@ -334,7 +336,7 @@ struct usb_xpad {
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
-	struct mutex odata_mutex;
+	unsigned long odata_flags;
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -707,6 +709,7 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
+		clear_bit(OUT_IRQ_SUBMITTED, &xpad->odata_flags);
 		return;
 
 	case -ECONNRESET:
@@ -725,9 +728,11 @@ static void xpad_irq_out(struct urb *urb)
 
 exit:
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval)
+	if (retval) {
+		clear_bit(OUT_IRQ_SUBMITTED, &xpad->odata_flags);
 		dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
 			__func__, retval);
+	}
 }
 
 static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
@@ -746,7 +751,7 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		goto fail1;
 	}
 
-	mutex_init(&xpad->odata_mutex);
+	xpad->odata_flags = 0;
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
@@ -791,6 +796,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 
+	if (test_and_set_bit(OUT_IRQ_SUBMITTED, &xpad->odata_flags))
+		return 0;
+
 	if (effect->type == FF_RUMBLE) {
 		__u16 strong = effect->u.rumble.strong_magnitude;
 		__u16 weak = effect->u.rumble.weak_magnitude;
@@ -912,7 +920,8 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
 	command %= 16;
 
-	mutex_lock(&xpad->odata_mutex);
+	if (test_and_set_bit(OUT_IRQ_SUBMITTED, &xpad->odata_flags))
+		return;
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
@@ -939,7 +948,6 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 	}
 
 	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-	mutex_unlock(&xpad->odata_mutex);
 }
 
 static void xpad_identify_controller(struct usb_xpad *xpad)
-- 
2.4.3

