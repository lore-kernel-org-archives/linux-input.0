From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 05/15] HID: hid-lg4ff: (Cleanup) Explicit casts from void * are not necessary
Date: Wed,  8 Apr 2015 22:56:43 +0200
Message-ID: <1428526613-24239-6-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap.devoid-pointer.net ([31.31.77.140]:33004 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbDHU50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:26 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Explicit casts from void * are not necessary.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index d1d5d45..5a3b3be 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -847,7 +847,7 @@ static void lg4ff_led_set_brightness(struct led_cla=
ssdev *led_cdev,
 		return;
 	}
=20
-	entry =3D (struct lg4ff_device_entry *)drv_data->device_props;
+	entry =3D drv_data->device_props;
=20
 	if (!entry) {
 		hid_err(hid, "Device properties not found.");
@@ -882,7 +882,7 @@ static enum led_brightness lg4ff_led_get_brightness=
(struct led_classdev *led_cde
 		return LED_OFF;
 	}
=20
-	entry =3D (struct lg4ff_device_entry *)drv_data->device_props;
+	entry =3D drv_data->device_props;
=20
 	if (!entry) {
 		hid_err(hid, "Device properties not found.");
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
