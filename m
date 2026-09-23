Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31751DC198;
	Wed, 23 Sep 2026 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150835; cv=none; b=Na+p2gN2SXNpPbYByGz/3pkwAiYeeQQi2YYRcNiexW5HzVt5Xzq+26yUftSvX9MW9gGU73m1JV1bTdTNjVuwWbiHu4nJR3UTo3nOk/kucYLM8E8ziGB76udu2pSlFqtPoQxXzxEBa2e32b/N7SfUehJc/Vn+OeGBQ/0OfkTnE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150835; c=relaxed/simple;
	bh=WmxUholhW6kqhV+PxTrzt0xP+eD2SyU+fhb5MjZoRO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J7s3D7iemgN3fG+W+qesm/e9/ERb/p/8JRGRHPipIc41gGSRXBwiHx+FTQ5XSu0CrjI40Ku1ywX0mZvZZ6KUByqrAvxxB8bdjkoIOMpjIuj3cOcdWHIutwtPfIZqF5QUsfKvgvGopivE8y/YwSiMR85b89oiLBb0/NCu1M/jlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae+PDPqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae+PDPqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8801F000FF;
	Wed, 23 Sep 2026 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790150833;
	bh=S1R4ONy3eorSLWFe3mx63REf7woq64RmsZBaqtyJ9v4=;
	h=From:Date:Subject:To:Cc;
	b=Ae+PDPqpwIteMBNXIresMR+PeapzFCRXIgUp6AYi59xH3853iQpCOLM/ZiCiDn1jB
	 Z2xD1ygOp3TrSXfeTj/eD1f2YxqF0IjBixFo4pq4HgNcX2rozgFkfHTQrWpzoU25wZ
	 POt9ME5r8lxTbCNMwLOYadw/PpLWUl84U7QVZ1BN+VlS6enXN7seNSzoLgk8tYke6H
	 uLvrTul6Wk+JJg8HB2y73R4epW5Q1KhGMMDM2on6je90HBNxP7EYDdFjVUjoIiUWb7
	 FQ0eo7B/FzH4Il6k37gNN/D47XaZ+OVxb4h6bn5B1oWyMOh0gjx8r71rhEeO5rb9UX
	 W5JD0qxVNEd9Q==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 23 Sep 2026 10:06:58 +0200
Subject: [PATCH] Revert "HID: logitech: add Bolt receiver support for
 Logitech HID++ devices"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-revert-bolt-v1-1-52c2ef6f614d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubayCZtXkQvs4EibtpGSdzdc/
 ur7/hd4dIQe6uQChwd5siaCpwkMc2cmZKSjQWSizJTIWRyhC6y3a2C8KrRUckQpOMTH5nCk86s
 17W+/9wsO4U3AfT/y8W02bwAAAA==
X-Change-ID: 20260923-revert-bolt-175d898fe821
To: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, 
 Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790150830; l=7360;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=WmxUholhW6kqhV+PxTrzt0xP+eD2SyU+fhb5MjZoRO4=;
 b=a2cjZ0DKR8qbCq9TNzecxVfJowlK9KMnp6Dtkb2o3v8WGHJkJJIjvneGLjSGyGeEeCKvnZkul
 vvORv9Wia6bDpZnU7oC1zALbRXdq5u/aDwl8hUA4d+y3JjIfrEUxblz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This reverts commit 022eb347ff3a48281e7e69c3addcb11bf24afa53.

Introducing Bolt as a DJ receiver created a lot of troubles for users
with their scroll wheel going crazy.

This is because we have 2 issues:
- Bolt doesn't say which device sends which event, so having 2 mice
  connected on the same receiver means one will be normal and the other
  deadly slow or deadly fast
- userspace also tinker with those settings, meaning that users are not
  happy with the new default settings.

The end result is that the feature is not ready for a final kernel, and
the sensible thing to do is to revert the patch and revisit it in a
later kernel if we can work around the 2 issues I've mentioned above.

Link: https://lore.kernel.org/all/DL68726HJQCD.7PCDT9IGHUB1@rcpassos.me/
Link: https://lore.kernel.org/all/20260920094508.39682-1-roman.stingler@gmail.com/
Link: https://lore.kernel.org/all/20260904034843.1340846-1-rafael@rcpassos.me
Link: https://lore.kernel.org/all/20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-logitech-dj.c    | 48 ++++---------------------------------
 drivers/hid/hid-logitech-hidpp.c | 51 ++++------------------------------------
 2 files changed, 8 insertions(+), 91 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 1d619d2345e1..390d106d5dc1 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -121,7 +121,6 @@ enum recvr_type {
 	recvr_type_27mhz,
 	recvr_type_bluetooth,
 	recvr_type_dinovo,
-	recvr_type_bolt,
 };
 
 struct dj_report {
@@ -1157,10 +1156,6 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		workitem.reports_supported |= STD_KEYBOARD;
 		break;
-	case 0x10:
-		device_type = "Bolt";
-		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
-		break;
 	}
 
 	/* custom receiver device (eg. powerplay) */
@@ -1750,24 +1745,6 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 
 	dj_dev = djrcv_dev->paired_dj_devices[device_index];
 
-	/*
-	 * Bolt receivers send explicit unpair notifications as HID++ events;
-	 * queue device removal when we receive one.
-	 */
-	if (djrcv_dev->type == recvr_type_bolt &&
-	    hidpp_report->report_id == REPORT_ID_HIDPP_SHORT &&
-	    hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_UNPAIRED) {
-		struct dj_workitem workitem = {
-			.device_index = device_index,
-			.type = WORKITEM_TYPE_UNPAIRED,
-		};
-
-		kfifo_in(&djrcv_dev->notif_fifo, &workitem, sizeof(workitem));
-		schedule_work(&djrcv_dev->work);
-		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
-		return false;
-	}
-
 	/*
 	 * With 27 MHz receivers, we do not get an explicit unpair event,
 	 * remove the old device if the user has paired a *different* device.
@@ -1907,9 +1884,6 @@ static int logi_dj_probe(struct hid_device *hdev,
 	 * treat these as logitech-dj interfaces then this causes input events
 	 * reported through this extra interface to not be reported correctly.
 	 * To avoid this, we treat these as generic-hid devices.
-	 *
-	 * Bolt receivers only use LOGITECH_DJ_INTERFACE_NUMBER for receiver
-	 * reporting. Treat all other Bolt interfaces as generic-hid devices.
 	 */
 	switch (id->driver_data) {
 	case recvr_type_dj:		no_dj_interfaces = 3; break;
@@ -1923,20 +1897,10 @@ static int logi_dj_probe(struct hid_device *hdev,
 	}
 	if (hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
-		if (intf) {
-			bool generic_hid_interface;
-
-			if (id->driver_data == recvr_type_bolt)
-				generic_hid_interface =
-					intf->altsetting->desc.bInterfaceNumber !=
-					LOGITECH_DJ_INTERFACE_NUMBER;
-			else
-				generic_hid_interface =
-					intf->altsetting->desc.bInterfaceNumber >= no_dj_interfaces;
-			if (generic_hid_interface) {
-				hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
-				return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-			}
+		if (intf && intf->altsetting->desc.bInterfaceNumber >=
+							no_dj_interfaces) {
+			hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+			return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 		}
 	}
 
@@ -2139,10 +2103,6 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_3),
 	 .driver_data = recvr_type_gaming_hidpp_ls_1_3},
-	{ /* Logitech Bolt receiver (0xc548) */
-	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
-			 USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER),
-	 .driver_data = recvr_type_bolt},
 	{ /* Logitech lightspeed receiver (0xc54d) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED_1_4),
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 493763a12518..9646380febac 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -988,8 +988,7 @@ static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
 	}
 
 	/* the device might not be connected */
-	if (ret == HIDPP_ERROR_CONNECT_FAIL ||
-	    ret == HIDPP_ERROR_RESOURCE_ERROR ||
+	if (ret == HIDPP_ERROR_RESOURCE_ERROR ||
 	    ret == HIDPP_ERROR_UNKNOWN_DEVICE)
 		return -EIO;
 
@@ -4405,50 +4404,8 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	return ret;
 }
 
-static bool hidpp_is_bolt_child(struct hid_device *hdev)
-{
-	struct device *parent = hdev->dev.parent;
-	struct hid_device *receiver_hdev;
-
-	if (!parent)
-		return false;
-
-	receiver_hdev = to_hid_device(parent);
-	return receiver_hdev->vendor == USB_VENDOR_ID_LOGITECH &&
-	       receiver_hdev->product == USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER;
-}
-
-static int hidpp_bolt_init(struct hidpp_device *hidpp)
-{
-	struct hid_device *hdev = hidpp->hid_dev;
-	char *name;
-	int ret;
-
-	ret = hidpp_serial_init(hidpp);
-	if (ret)
-		return ret;
-
-	name = hidpp_get_device_name(hidpp);
-	if (!name)
-		return -EIO;
-
-	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
-	dbg_hid("HID++ Bolt: Got name: %s\n", name);
-
-	kfree(name);
-	return 0;
-}
-
-static int hidpp_receiver_init(struct hidpp_device *hidpp)
-{
-	if (hidpp_is_bolt_child(hidpp->hid_dev))
-		return hidpp_bolt_init(hidpp);
-
-	return hidpp_unifying_init(hidpp);
-}
-
 /* Get name + serial for USB and Bluetooth HID++ devices */
-static void hidpp_non_receiver_init(struct hidpp_device *hidpp)
+static void hidpp_non_unifying_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
 	char *name;
@@ -4800,9 +4757,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/* Get name + serial, store in hdev->name + hdev->uniq */
 	if (id->group == HID_GROUP_LOGITECH_DJ_DEVICE)
-		hidpp_receiver_init(hidpp);
+		hidpp_unifying_init(hidpp);
 	else
-		hidpp_non_receiver_init(hidpp);
+		hidpp_non_unifying_init(hidpp);
 
 	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;

---
base-commit: fe2ec83746e501645709761605c2464a44fd2929
change-id: 20260923-revert-bolt-175d898fe821

Best regards,
--  
Benjamin Tissoires <bentiss@kernel.org>

