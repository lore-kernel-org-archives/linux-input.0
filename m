From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] HID: fix some indenting issues
Date: Sun, 11 Oct 2015 16:18:22 +0200
Message-ID: <1444573102-10744-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58076 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbbJKOS0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Oct 2015 10:18:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Josenivaldo Benito Junior <jrbenito@benito.qsl.br>, Franco Catrin <fcatrin@gmail.com>, Nikolai Kondrashov <spbnick@gmail.com>, Don Prince <dhprince-devel@yahoo.co.uk>, srinivas pandruvada <srinivas.pandruvada@intel.com>

Some drivers indent some lines in a very weird manner. Fix that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Josenivaldo Benito Junior <jrbenito@benito.qsl.br>
Cc: Franco Catrin <fcatrin@gmail.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Don Prince <dhprince-devel@yahoo.co.uk>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/hid/hid-aureal.c     | 3 ++-
 drivers/hid/hid-elecom.c     | 2 +-
 drivers/hid/hid-prodikeys.c  | 4 ++--
 drivers/hid/hid-sensor-hub.c | 8 ++++----
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-aureal.c b/drivers/hid/hid-aureal.c
index 340ba9d394a0..3280aff28e90 100644
--- a/drivers/hid/hid-aureal.c
+++ b/drivers/hid/hid-aureal.c
@@ -23,7 +23,8 @@ static __u8 *aureal_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	if (*rsize >= 54 && rdesc[52] == 0x25 && rdesc[53] == 0x01) {
 		dev_info(&hdev->dev, "fixing Aureal Cy se W-01RN USB_V3.1 report descriptor.\n");
 		rdesc[53] = 0x65;
-	} return rdesc;
+	}
+	return rdesc;
 }
 
 static const struct hid_device_id aureal_devices[] = {
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index d0bd13b62dc2..6e3848a8d8dd 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -27,7 +27,7 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Elecom BM084 report descriptor\n");
 		rdesc[47] = 0x00;
 	}
-    return rdesc;
+	return rdesc;
 }
 
 static const struct hid_device_id elecom_devices[] = {
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index e3e98ccf137b..3a207c0ac0e3 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -427,7 +427,7 @@ static int pcmidi_handle_report4(struct pcmidi_snd *pm, u8 *data)
 					pm->midi_octave = 2;
 				dbg_hid("pcmidi mode: %d octave: %d\n",
 					pm->midi_mode, pm->midi_octave);
-			    continue;
+				continue;
 			} else
 				key = KEY_MESSENGER;
 			break;
@@ -695,7 +695,7 @@ static int pcmidi_snd_initialise(struct pcmidi_snd *pm)
 	if (err < 0) {
 		pk_error("failed to register pc-midi sound card: error %d\n",
 			 err);
-			 goto fail_register;
+		goto fail_register;
 	}
 
 	dbg_hid("pcmidi_snd_initialise finished ok\n");
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 90116ee1624e..92870cdb52d9 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -660,8 +660,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 						      GFP_KERNEL);
 	if (sd->hid_sensor_hub_client_devs == NULL) {
 		hid_err(hdev, "Failed to allocate memory for mfd cells\n");
-			ret = -ENOMEM;
-			goto err_stop_hw;
+		ret = -ENOMEM;
+		goto err_stop_hw;
 	}
 
 	for (i = 0; i < hdev->maxcollection; ++i) {
@@ -698,8 +698,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 					      collection->usage);
 			if (name == NULL) {
 				hid_err(hdev, "Failed MFD device name\n");
-					ret = -ENOMEM;
-					goto err_stop_hw;
+				ret = -ENOMEM;
+				goto err_stop_hw;
 			}
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].name = name;
-- 
2.6.1

