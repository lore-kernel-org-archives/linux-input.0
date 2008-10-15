From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH] additional SoundGraph iMon LCD devices for hid_ignore_list
Date: Wed, 15 Oct 2008 15:00:20 -0400
Message-ID: <200810151500.21023.jarod@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:48983 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbYJOTAZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2008 15:00:25 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

hid_ignore_list additions for more SoundGraph iMon LCD devices

Signed-off-by: Jarod Wilson <jarod@redhat.com>

---

 drivers/hid/hid-core.c |    2 ++
 drivers/hid/hid-ids.h  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8a7d9db..721a36d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1518,6 +1518,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0003) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PANJIT, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD2) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index aad9ed1..d9a1ba9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -354,6 +354,8 @@
 
 #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD	0x0038
+#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD2	0x0036
+#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD3	0x0034
 
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab


-- 
Jarod Wilson
jarod@redhat.com

