From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH] add antec-branded soundgraph imon devices to hid_ignore_list
Date: Wed, 28 Jan 2009 10:49:28 -0500
Message-ID: <200901281049.28799.jarod@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:51830 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbZA1Ptd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 10:49:33 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

hid_ignore_list additions for the Antec-branded SoundGraph iMon VFD and LCD
devices (0x15c2:0x0044 and 0x0045).

Signed-off-by: Jarod Wilson <jarod@redhat.com>

---

 drivers/hid/hid-core.c |    2 ++
 drivers/hid/hid-ids.h  |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5d7640e..7001c31 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1606,6 +1606,8 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD4) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SOUNDGRAPH, USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TENX, USB_DEVICE_ID_TENX_IBUDDY2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index acc1abc..e899f51 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -362,6 +362,8 @@
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD	0x0038
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD2	0x0036
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD3	0x0034
+#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD4	0x0044
+#define USB_DEVICE_ID_SOUNDGRAPH_IMON_LCD5	0x0045
 
 #define USB_VENDOR_ID_SUN		0x0430
 #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab


-- 
Jarod Wilson
jarod@redhat.com

