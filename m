From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: HID: picolcd: Prevent NULL pointer dereference on _remove()
Date: Sat, 31 Aug 2013 14:07:48 +0200
Message-ID: <20130831140748.3353e7bc@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:36312 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab3HaMHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Aug 2013 08:07:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

When picolcd is switched into bootloader mode (for FW flashing) make
sure not to try to dereference NULL-pointers of feature-devices during
unplug/unbind.

This fixes following BUG:
  BUG: unable to handle kernel NULL pointer dereference at 00000298
  IP: [<f811f56b>] picolcd_exit_framebuffer+0x1b/0x80 [hid_picolcd]
  *pde =3D 00000000
  Oops: 0000 [#1]
  Modules linked in: hid_picolcd syscopyarea sysfillrect sysimgblt fb_s=
ys_fops
  CPU: 0 PID: 15 Comm: khubd Not tainted 3.11.0-rc7-00002-g50d62d4 #2
  EIP: 0060:[<f811f56b>] EFLAGS: 00010292 CPU: 0
  EIP is at picolcd_exit_framebuffer+0x1b/0x80 [hid_picolcd]
  Call Trace:
   [<f811d1ab>] picolcd_remove+0xcb/0x120 [hid_picolcd]
   [<c1469b09>] hid_device_remove+0x59/0xc0
   [<c13464ca>] __device_release_driver+0x5a/0xb0
   [<c134653f>] device_release_driver+0x1f/0x30
   [<c134603d>] bus_remove_device+0x9d/0xd0
   [<c13439a5>] device_del+0xd5/0x150
   [<c14696a4>] hid_destroy_device+0x24/0x60
   [<c1474cbb>] usbhid_disconnect+0x1b/0x40
   ...

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-picolcd_cir.c | 3 ++-
 drivers/hid/hid-picolcd_fb.c  | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-picolcd_cir.c b/drivers/hid/hid-picolcd_ci=
r.c
index e346038..59d5eb1 100644
--- a/drivers/hid/hid-picolcd_cir.c
+++ b/drivers/hid/hid-picolcd_cir.c
@@ -145,6 +145,7 @@ void picolcd_exit_cir(struct picolcd_data *data)
 	struct rc_dev *rdev =3D data->rc_dev;
=20
 	data->rc_dev =3D NULL;
-	rc_unregister_device(rdev);
+	if (rdev)
+		rc_unregister_device(rdev);
 }
=20
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.=
c
index 591f6b2..c930ab8 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -593,10 +593,14 @@ err_nomem:
 void picolcd_exit_framebuffer(struct picolcd_data *data)
 {
 	struct fb_info *info =3D data->fb_info;
-	struct picolcd_fb_data *fbdata =3D info->par;
+	struct picolcd_fb_data *fbdata;
 	unsigned long flags;
=20
+	if (!info)
+		return;
+
 	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
+	fbdata =3D info->par;
=20
 	/* disconnect framebuffer from HID dev */
 	spin_lock_irqsave(&fbdata->lock, flags);
--=20
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
