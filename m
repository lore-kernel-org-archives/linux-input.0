From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] HID: hyperv: Add the support of hibernation
Date: Wed, 11 Sep 2019 23:35:59 +0000
Message-ID: <1568244952-66716-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>
List-Id: linux-input@vger.kernel.org

We need mousevsc_pm_notify() to make sure the pm_wakeup_hard_event() call
does not prevent the system from entering hibernation: the hibernation
is a relatively long process, which can be aborted by the call
pm_wakeup_hard_event(), which is invoked upon mouse events.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
input subsystem's tree.

Hi Jiri, Benjamin, can you please Ack?

 drivers/hid/hid-hyperv.c | 71 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index cc5b09b8..e798740 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -12,6 +12,7 @@
 #include <linux/hid.h>
 #include <linux/hiddev.h>
 #include <linux/hyperv.h>
+#include <linux/suspend.h>
=20
=20
 struct hv_input_dev_info {
@@ -150,6 +151,9 @@ struct mousevsc_dev {
 	struct hv_input_dev_info hid_dev_info;
 	struct hid_device       *hid_device;
 	u8			input_buf[HID_MAX_BUFFER_SIZE];
+
+	struct notifier_block	pm_nb;
+	bool			hibernation_in_progress;
 };
=20
=20
@@ -192,6 +196,9 @@ static void mousevsc_on_receive_device_info(struct mous=
evsc_dev *input_device,
 	if (desc->bLength =3D=3D 0)
 		goto cleanup;
=20
+	/* The pointer is not NULL when we resume from hibernation */
+	if (input_device->hid_desc !=3D NULL)
+		kfree(input_device->hid_desc);
 	input_device->hid_desc =3D kmemdup(desc, desc->bLength, GFP_ATOMIC);
=20
 	if (!input_device->hid_desc)
@@ -203,6 +210,9 @@ static void mousevsc_on_receive_device_info(struct mous=
evsc_dev *input_device,
 		goto cleanup;
 	}
=20
+	/* The pointer is not NULL when we resume from hibernation */
+	if (input_device->report_desc !=3D NULL)
+		kfree(input_device->report_desc);
 	input_device->report_desc =3D kzalloc(input_device->report_desc_size,
 					  GFP_ATOMIC);
=20
@@ -243,7 +253,7 @@ static void mousevsc_on_receive_device_info(struct mous=
evsc_dev *input_device,
 }
=20
 static void mousevsc_on_receive(struct hv_device *device,
-				struct vmpacket_descriptor *packet)
+				const struct vmpacket_descriptor *packet)
 {
 	struct pipe_prt_msg *pipe_msg;
 	struct synthhid_msg *hid_msg;
@@ -301,7 +311,8 @@ static void mousevsc_on_receive(struct hv_device *devic=
e,
 		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
 				 input_dev->input_buf, len, 1);
=20
-		pm_wakeup_hard_event(&input_dev->device->device);
+		if (!input_dev->hibernation_in_progress)
+			pm_wakeup_hard_event(&input_dev->device->device);
=20
 		break;
 	default:
@@ -378,6 +389,8 @@ static int mousevsc_connect_to_vsp(struct hv_device *de=
vice)
 	struct mousevsc_prt_msg *request;
 	struct mousevsc_prt_msg *response;
=20
+	reinit_completion(&input_dev->wait_event);
+
 	request =3D &input_dev->protocol_req;
 	memset(request, 0, sizeof(struct mousevsc_prt_msg));
=20
@@ -475,6 +488,29 @@ static int mousevsc_hid_raw_request(struct hid_device =
*hid,
=20
 static struct hid_driver mousevsc_hid_driver;
=20
+static int mousevsc_pm_notify(struct notifier_block *nb,
+			      unsigned long val, void *ign)
+{
+	struct mousevsc_dev *input_dev;
+
+	input_dev =3D container_of(nb, struct mousevsc_dev, pm_nb);
+
+	switch (val) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		input_dev->hibernation_in_progress =3D true;
+		return NOTIFY_OK;
+
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		input_dev->hibernation_in_progress =3D false;
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int mousevsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -549,6 +585,9 @@ static int mousevsc_probe(struct hv_device *device,
 	input_dev->connected =3D true;
 	input_dev->init_complete =3D true;
=20
+	input_dev->pm_nb.notifier_call =3D mousevsc_pm_notify;
+	register_pm_notifier(&input_dev->pm_nb);
+
 	return ret;
=20
 probe_err2:
@@ -568,6 +607,8 @@ static int mousevsc_remove(struct hv_device *dev)
 {
 	struct mousevsc_dev *input_dev =3D hv_get_drvdata(dev);
=20
+	unregister_pm_notifier(&input_dev->pm_nb);
+
 	device_init_wakeup(&dev->device, false);
 	vmbus_close(dev->channel);
 	hid_hw_stop(input_dev->hid_device);
@@ -577,6 +618,30 @@ static int mousevsc_remove(struct hv_device *dev)
 	return 0;
 }
=20
+static int mousevsc_suspend(struct hv_device *dev)
+{
+	vmbus_close(dev->channel);
+
+	return 0;
+}
+
+static int mousevsc_resume(struct hv_device *dev)
+{
+	int ret;
+
+	ret =3D vmbus_open(dev->channel,
+			 INPUTVSC_SEND_RING_BUFFER_SIZE,
+			 INPUTVSC_RECV_RING_BUFFER_SIZE,
+			 NULL, 0,
+			 mousevsc_on_channel_callback,
+			 dev);
+	if (ret)
+		return ret;
+
+	ret =3D mousevsc_connect_to_vsp(dev);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] =3D {
 	/* Mouse guid */
 	{ HV_MOUSE_GUID, },
@@ -590,6 +655,8 @@ static int mousevsc_remove(struct hv_device *dev)
 	.id_table =3D id_table,
 	.probe =3D mousevsc_probe,
 	.remove =3D mousevsc_remove,
+	.suspend =3D mousevsc_suspend,
+	.resume =3D mousevsc_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
--=20
1.8.3.1
