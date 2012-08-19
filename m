From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 6/7 v2] HID: picoLCD: drop version check during probe
Date: Sun, 19 Aug 2012 18:56:31 +0200
Message-ID: <20120819185631.3a984aa4@neptune.home>
References: <20120730213656.0a9f6d30@neptune.home>
	<20120730213859.063173c1@neptune.home>
	<alpine.LNX.2.00.1208151015220.7026@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:33248 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab2HSQ5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Aug 2012 12:57:16 -0400
In-Reply-To: <alpine.LNX.2.00.1208151015220.7026@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Commit 4ea5454203d991ec85264f64f89ca8855fce69b0
[HID: Fix race condition between driver core and ll-driver] introduced
new locking around probe/remove functions that prevents any report/repl=
y
from hardware to reach driver until it returned from probe.

As such, the ask-reply way to checking picoLCD firmware version during
probe is bound to timeout and let probe fail.

Drop the check to let driver successfully probe again (until locking is=
sues
are resolved allowing to reinstate the check).

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---

Changes since v1:
- drop version check during probe instead of commenting it out.


 drivers/hid/hid-picolcd_core.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_c=
ore.c
index 7b566ee..e08ffd2 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -478,14 +478,6 @@ static int picolcd_probe_lcd(struct hid_device *hd=
ev, struct picolcd_data *data)
 {
 	int error;
=20
-	error =3D picolcd_check_version(hdev);
-	if (error)
-		return error;
-
-	if (data->version[0] !=3D 0 && data->version[1] !=3D 3)
-		hid_info(hdev, "Device with untested firmware revision, please submi=
t /sys/kernel/debug/hid/%s/rdesc for this device.\n",
-			 dev_name(&hdev->dev));
-
 	/* Setup keypad input device */
 	error =3D picolcd_init_keys(data, picolcd_in_report(REPORT_KEY_STATE,=
 hdev));
 	if (error)
@@ -534,16 +526,6 @@ err:
=20
 static int picolcd_probe_bootloader(struct hid_device *hdev, struct pi=
colcd_data *data)
 {
-	int error;
-
-	error =3D picolcd_check_version(hdev);
-	if (error)
-		return error;
-
-	if (data->version[0] !=3D 1 && data->version[1] !=3D 0)
-		hid_info(hdev, "Device with untested bootloader revision, please sub=
mit /sys/kernel/debug/hid/%s/rdesc for this device.\n",
-			 dev_name(&hdev->dev));
-
 	picolcd_init_devfs(data, NULL, NULL,
 			picolcd_out_report(REPORT_BL_READ_MEMORY, hdev),
 			picolcd_out_report(REPORT_BL_WRITE_MEMORY, hdev), NULL);
--=20
1.7.8.6

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
