From: Laura Abbott <labbott@fedoraproject.org>
Subject: [PATCHv2] Input: xpad - Fix double URB submission races
Date: Mon, 10 Aug 2015 17:26:12 -0700
Message-ID: <1439252772-28482-1-git-send-email-labbott@fedoraproject.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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
by creating a queue for urb submission. This will serialize requests to
ensure only one is submitted at a time.

Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
---
v2: Created a proper queue for events instead of just dropping them
---
 drivers/input/joystick/xpad.c | 273 ++++++++++++++++++++++++++++++------------
 1 file changed, 194 insertions(+), 79 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f8850f9..e94cc49 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -100,6 +100,9 @@
 #define XTYPE_XBOXONE     3
 #define XTYPE_UNKNOWN     4
 
+#define OUT_IRQ_SUBMITTED	0
+#define OUT_IRQ_QUEUE_EMPTY	1
+
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
 MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than axes for unknown pads");
@@ -334,7 +337,9 @@ struct usb_xpad {
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
-	struct mutex odata_mutex;
+	unsigned long odata_flags;
+	spinlock_t queue_lock;
+	struct list_head odata_queue;	/* queue of commands */
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -347,6 +352,94 @@ struct usb_xpad {
 	unsigned long led_no;		/* led to lit on xbox360 controllers */
 };
 
+struct xpad_queue_item {
+	char odata[XPAD_PKT_LEN];
+	int transfer_length;
+	struct list_head entry;
+};
+
+static void __xpad_remove_urb(struct usb_xpad *xpad, struct xpad_queue_item *item)
+{
+	list_del(&item->entry);
+	kfree(item);
+}
+
+/*
+ * This function must be called with the queue lock held
+ *
+ * returns
+ *  0 - urb successfully submitted
+ *  OUT_IRQ_QUEUE_EMPTY - queue was empty
+ *  negative - error submitting urb
+ */
+static int __xpad_submit_urb(struct usb_xpad *xpad, bool safe_submit)
+{
+	int ret = 0;
+
+	if (list_empty(&xpad->odata_queue))
+		return OUT_IRQ_QUEUE_EMPTY;
+
+	if (safe_submit || !test_and_set_bit( OUT_IRQ_SUBMITTED, &xpad->odata_flags)) {
+		struct xpad_queue_item *head =
+			list_first_entry(&xpad->odata_queue,
+					 struct xpad_queue_item, entry);
+
+		memcpy(xpad->odata, head->odata, head->transfer_length);
+		xpad->irq_out->transfer_buffer_length = head->transfer_length;
+		ret = usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+		if (ret)
+			__xpad_remove_urb(xpad, head);
+	}
+
+	return ret;
+}
+
+static int xpad_add_and_submit_urb(struct usb_xpad *xpad,
+				   struct xpad_queue_item *item)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&xpad->queue_lock, flags);
+	list_add_tail(&item->entry, &xpad->odata_queue);
+	ret = __xpad_submit_urb(xpad, false);
+	spin_unlock_irqrestore(&xpad->queue_lock, flags);
+
+	return ret;
+}
+
+static int xpad_remove_urb(struct usb_xpad *xpad)
+{
+	unsigned long flags;
+	struct xpad_queue_item *head;
+	int ret = 0;
+
+	spin_lock_irqsave(&xpad->queue_lock, flags);
+	if (list_empty(&xpad->odata_queue)) {
+		ret = OUT_IRQ_QUEUE_EMPTY;
+		goto out;
+	}
+
+	head = list_first_entry(&xpad->odata_queue, struct xpad_queue_item,
+					entry);
+	__xpad_remove_urb(xpad, head);
+out:
+	spin_unlock_irqrestore(&xpad->queue_lock, flags);
+	return ret;
+}
+
+static int xpad_resubmit_urb(struct usb_xpad *xpad)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&xpad->queue_lock, flags);
+	ret = __xpad_submit_urb(xpad, true);
+	spin_unlock_irqrestore(&xpad->queue_lock, flags);
+
+	return ret;
+}
+
 /*
  *	xpad_process_packet
  *
@@ -707,7 +800,8 @@ static void xpad_irq_out(struct urb *urb)
 	switch (status) {
 	case 0:
 		/* success */
-		return;
+		xpad_remove_urb(xpad);
+		break;
 
 	case -ECONNRESET:
 	case -ENOENT:
@@ -720,14 +814,21 @@ static void xpad_irq_out(struct urb *urb)
 	default:
 		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
 			__func__, status);
-		goto exit;
+		break;
 	}
 
-exit:
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval)
-		dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
-			__func__, retval);
+
+	/*
+	 * We must keep resubmitting, otherwise the other items in the
+	 * queue will stall until until the next urb submit which may
+	 * be indefinitely
+	 */
+	do {
+		retval = xpad_resubmit_urb(xpad);
+	} while (retval < 0);
+
+	if (retval == OUT_IRQ_QUEUE_EMPTY)
+		clear_bit(OUT_IRQ_SUBMITTED, &xpad->odata_flags);
 }
 
 static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
@@ -746,7 +847,8 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		goto fail1;
 	}
 
-	mutex_init(&xpad->odata_mutex);
+	xpad->odata_flags = 0;
+	INIT_LIST_HEAD(&xpad->odata_queue);
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
@@ -780,9 +882,14 @@ static void xpad_stop_output(struct usb_xpad *xpad)
 static void xpad_deinit_output(struct usb_xpad *xpad)
 {
 	if (xpad->xtype != XTYPE_UNKNOWN) {
+		int ret;
+
 		usb_free_urb(xpad->irq_out);
 		usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 				xpad->odata, xpad->odata_dma);
+		do {
+			ret = xpad_remove_urb(xpad);
+		} while (ret != OUT_IRQ_QUEUE_EMPTY);
 	}
 }
 
@@ -790,6 +897,11 @@ static void xpad_deinit_output(struct usb_xpad *xpad)
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
+	struct xpad_queue_item *item;
+
+	item = kzalloc(sizeof(*item), GFP_ATOMIC);
+	if (!item)
+		return -ENOMEM;
 
 	if (effect->type == FF_RUMBLE) {
 		__u16 strong = effect->u.rumble.strong_magnitude;
@@ -798,62 +910,62 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		switch (xpad->xtype) {
 
 		case XTYPE_XBOX:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x06;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = strong / 256;	/* left actuator */
-			xpad->odata[4] = 0x00;
-			xpad->odata[5] = weak / 256;	/* right actuator */
-			xpad->irq_out->transfer_buffer_length = 6;
+			item->odata[0] = 0x00;
+			item->odata[1] = 0x06;
+			item->odata[2] = 0x00;
+			item->odata[3] = strong / 256;	/* left actuator */
+			item->odata[4] = 0x00;
+			item->odata[5] = weak / 256;	/* right actuator */
+			item->transfer_length = 6;
 
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+			return xpad_add_and_submit_urb(xpad, item);
 
 		case XTYPE_XBOX360:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x08;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = strong / 256;  /* left actuator? */
-			xpad->odata[4] = weak / 256;	/* right actuator? */
-			xpad->odata[5] = 0x00;
-			xpad->odata[6] = 0x00;
-			xpad->odata[7] = 0x00;
-			xpad->irq_out->transfer_buffer_length = 8;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+			item->odata[0] = 0x00;
+			item->odata[1] = 0x08;
+			item->odata[2] = 0x00;
+			item->odata[3] = strong / 256;  /* left actuator? */
+			item->odata[4] = weak / 256;	/* right actuator? */
+			item->odata[5] = 0x00;
+			item->odata[6] = 0x00;
+			item->odata[7] = 0x00;
+			item->transfer_length = 8;
+
+			return xpad_add_and_submit_urb(xpad, item);
 
 		case XTYPE_XBOX360W:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x01;
-			xpad->odata[2] = 0x0F;
-			xpad->odata[3] = 0xC0;
-			xpad->odata[4] = 0x00;
-			xpad->odata[5] = strong / 256;
-			xpad->odata[6] = weak / 256;
-			xpad->odata[7] = 0x00;
-			xpad->odata[8] = 0x00;
-			xpad->odata[9] = 0x00;
-			xpad->odata[10] = 0x00;
-			xpad->odata[11] = 0x00;
-			xpad->irq_out->transfer_buffer_length = 12;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+			item->odata[0] = 0x00;
+			item->odata[1] = 0x01;
+			item->odata[2] = 0x0F;
+			item->odata[3] = 0xC0;
+			item->odata[4] = 0x00;
+			item->odata[5] = strong / 256;
+			item->odata[6] = weak / 256;
+			item->odata[7] = 0x00;
+			item->odata[8] = 0x00;
+			item->odata[9] = 0x00;
+			item->odata[10] = 0x00;
+			item->odata[11] = 0x00;
+			item->transfer_length = 12;
+
+			return pad_add_and_submit_urb(xpad, item);
 
 		case XTYPE_XBOXONE:
-			xpad->odata[0] = 0x09; /* activate rumble */
-			xpad->odata[1] = 0x08;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = 0x08; /* continuous effect */
-			xpad->odata[4] = 0x00; /* simple rumble mode */
-			xpad->odata[5] = 0x03; /* L and R actuator only */
-			xpad->odata[6] = 0x00; /* TODO: LT actuator */
-			xpad->odata[7] = 0x00; /* TODO: RT actuator */
-			xpad->odata[8] = strong / 256;	/* left actuator */
-			xpad->odata[9] = weak / 256;	/* right actuator */
-			xpad->odata[10] = 0x80;	/* length of pulse */
-			xpad->odata[11] = 0x00;	/* stop period of pulse */
-			xpad->irq_out->transfer_buffer_length = 12;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+			item->odata[0] = 0x09; /* activate rumble */
+			item->odata[1] = 0x08;
+			item->odata[2] = 0x00;
+			item->odata[3] = 0x08; /* continuous effect */
+			item->odata[4] = 0x00; /* simple rumble mode */
+			item->odata[5] = 0x03; /* L and R actuator only */
+			item->odata[6] = 0x00; /* TODO: LT actuator */
+			item->odata[7] = 0x00; /* TODO: RT actuator */
+			item->odata[8] = strong / 256;	/* left actuator */
+			item->odata[9] = weak / 256;	/* right actuator */
+			item->odata[10] = 0x80;	/* length of pulse */
+			item->odata[11] = 0x00;	/* stop period of pulse */
+			item->transfer_length = 12;
+
+			return xpad_add_and_submit_urb(xpad, item);
 
 		default:
 			dev_dbg(&xpad->dev->dev,
@@ -910,36 +1022,39 @@ struct xpad_led {
  */
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
-	command %= 16;
+	struct xpad_queue_item *item;
 
-	mutex_lock(&xpad->odata_mutex);
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		return;
+
+	command %= 16;
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
-		xpad->odata[0] = 0x01;
-		xpad->odata[1] = 0x03;
-		xpad->odata[2] = command;
-		xpad->irq_out->transfer_buffer_length = 3;
+		item->odata[0] = 0x01;
+		item->odata[1] = 0x03;
+		item->odata[2] = command;
+		item->transfer_length = 3;
 		break;
 	case XTYPE_XBOX360W:
-		xpad->odata[0] = 0x00;
-		xpad->odata[1] = 0x00;
-		xpad->odata[2] = 0x08;
-		xpad->odata[3] = 0x40 + command;
-		xpad->odata[4] = 0x00;
-		xpad->odata[5] = 0x00;
-		xpad->odata[6] = 0x00;
-		xpad->odata[7] = 0x00;
-		xpad->odata[8] = 0x00;
-		xpad->odata[9] = 0x00;
-		xpad->odata[10] = 0x00;
-		xpad->odata[11] = 0x00;
-		xpad->irq_out->transfer_buffer_length = 12;
+		item->odata[0] = 0x00;
+		item->odata[1] = 0x00;
+		item->odata[2] = 0x08;
+		item->odata[3] = 0x40 + command;
+		item->odata[4] = 0x00;
+		item->odata[5] = 0x00;
+		item->odata[6] = 0x00;
+		item->odata[7] = 0x00;
+		item->odata[8] = 0x00;
+		item->odata[9] = 0x00;
+		item->odata[10] = 0x00;
+		item->odata[11] = 0x00;
+		item->transfer_length = 12;
 		break;
 	}
 
-	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-	mutex_unlock(&xpad->odata_mutex);
+	xpad_add_and_submit_urb(xpad, item);
 }
 
 static void xpad_identify_controller(struct usb_xpad *xpad)
-- 
2.4.3
