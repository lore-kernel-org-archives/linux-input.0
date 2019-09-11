From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Date: Wed, 11 Sep 2019 23:36:20 +0000
Message-ID: <1568244975-66795-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>
List-Id: linux-input@vger.kernel.org

We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event() call
does not prevent the system from entering hibernation: the hibernation
is a relatively long process, which can be aborted by the call
pm_wakeup_hard_event(), which is invoked upon keyboard events.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
input subsystemi's tree.

Hi Dmitry, can you please Ack?

 drivers/input/serio/hyperv-keyboard.c | 68 +++++++++++++++++++++++++++++++=
+---
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hy=
perv-keyboard.c
index 88ae7c2..277dc4c 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -10,6 +10,7 @@
 #include <linux/hyperv.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
=20
 /*
  * Current version 1.0
@@ -95,6 +96,9 @@ struct hv_kbd_dev {
 	struct completion wait_event;
 	spinlock_t lock; /* protects 'started' field */
 	bool started;
+
+	struct notifier_block pm_nb;
+	bool hibernation_in_progress;
 };
=20
 static void hv_kbd_on_receive(struct hv_device *hv_dev,
@@ -168,7 +172,7 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 		 * "echo freeze > /sys/power/state" can't really enter the
 		 * state because the Enter-UP can trigger a wakeup at once.
 		 */
-		if (!(info & IS_BREAK))
+		if (!(info & IS_BREAK) && !kbd_dev->hibernation_in_progress)
 			pm_wakeup_hard_event(&hv_dev->device);
=20
 		break;
@@ -179,10 +183,10 @@ static void hv_kbd_on_receive(struct hv_device *hv_de=
v,
 	}
 }
=20
-static void hv_kbd_handle_received_packet(struct hv_device *hv_dev,
-					  struct vmpacket_descriptor *desc,
-					  u32 bytes_recvd,
-					  u64 req_id)
+static void
+hv_kbd_handle_received_packet(struct hv_device *hv_dev,
+			      const struct vmpacket_descriptor *desc,
+			      u32 bytes_recvd, u64 req_id)
 {
 	struct synth_kbd_msg *msg;
 	u32 msg_sz;
@@ -282,6 +286,8 @@ static int hv_kbd_connect_to_vsp(struct hv_device *hv_d=
ev)
 	u32 proto_status;
 	int error;
=20
+	reinit_completion(&kbd_dev->wait_event);
+
 	request =3D &kbd_dev->protocol_req;
 	memset(request, 0, sizeof(struct synth_kbd_protocol_request));
 	request->header.type =3D __cpu_to_le32(SYNTH_KBD_PROTOCOL_REQUEST);
@@ -332,6 +338,29 @@ static void hv_kbd_stop(struct serio *serio)
 	spin_unlock_irqrestore(&kbd_dev->lock, flags);
 }
=20
+static int hv_kbd_pm_notify(struct notifier_block *nb,
+			    unsigned long val, void *ign)
+{
+	struct hv_kbd_dev *kbd_dev;
+
+	kbd_dev =3D container_of(nb, struct hv_kbd_dev, pm_nb);
+
+	switch (val) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		kbd_dev->hibernation_in_progress =3D true;
+		return NOTIFY_OK;
+
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		kbd_dev->hibernation_in_progress =3D false;
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int hv_kbd_probe(struct hv_device *hv_dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -380,6 +409,9 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
=20
 	device_init_wakeup(&hv_dev->device, true);
=20
+	kbd_dev->pm_nb.notifier_call =3D hv_kbd_pm_notify;
+	register_pm_notifier(&kbd_dev->pm_nb);
+
 	return 0;
=20
 err_close_vmbus:
@@ -394,6 +426,7 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 {
 	struct hv_kbd_dev *kbd_dev =3D hv_get_drvdata(hv_dev);
=20
+	unregister_pm_notifier(&kbd_dev->pm_nb);
 	serio_unregister_port(kbd_dev->hv_serio);
 	vmbus_close(hv_dev->channel);
 	kfree(kbd_dev);
@@ -403,6 +436,29 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 	return 0;
 }
=20
+static int hv_kbd_suspend(struct hv_device *hv_dev)
+{
+	vmbus_close(hv_dev->channel);
+
+	return 0;
+}
+
+static int hv_kbd_resume(struct hv_device *hv_dev)
+{
+	int ret;
+
+	ret =3D vmbus_open(hv_dev->channel,
+			 KBD_VSC_SEND_RING_BUFFER_SIZE,
+			 KBD_VSC_RECV_RING_BUFFER_SIZE,
+			 NULL, 0,
+			 hv_kbd_on_channel_callback,
+			 hv_dev);
+	if (ret =3D=3D 0)
+		ret =3D hv_kbd_connect_to_vsp(hv_dev);
+
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] =3D {
 	/* Keyboard guid */
 	{ HV_KBD_GUID, },
@@ -416,6 +472,8 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 	.id_table =3D id_table,
 	.probe =3D hv_kbd_probe,
 	.remove =3D hv_kbd_remove,
+	.suspend =3D hv_kbd_suspend,
+	.resume =3D hv_kbd_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
--=20
1.8.3.1
