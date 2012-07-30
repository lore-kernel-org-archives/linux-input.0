From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH 6/7] HID: picoLCD: disable version check during probe
Date: Mon, 30 Jul 2012 21:38:59 +0200
Message-ID: <20120730213859.063173c1@neptune.home>
References: <20120730213656.0a9f6d30@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Jaya Kumar <jayalk@intworks.biz>, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Commit 4ea5454203d991ec85264f64f89ca8855fce69b0
[HID: Fix race condition between driver core and ll-driver] introduced
new locking around proce/remove functions that prevent any report/reply
from hardware to reach driver until it returned from probe.

As such, the ask-reply way to checking picoLCD firmware version during
probe is bound to timeout and let probe fail.

Disabling the check lets driver sucessfully probe again.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_c=
ore.c
index 2d7ef68..42d0791 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -478,13 +478,13 @@ static int picolcd_probe_lcd(struct hid_device *h=
dev, struct picolcd_data *data)
 {
 	int error;
=20
-	error =3D picolcd_check_version(hdev);
+/*	error =3D picolcd_check_version(hdev);
 	if (error)
 		return error;
=20
 	if (data->version[0] !=3D 0 && data->version[1] !=3D 3)
 		hid_info(hdev, "Device with untested firmware revision, please submi=
t /sys/kernel/debug/hid/%s/rdesc for this device.\n",
-			 dev_name(&hdev->dev));
+			 dev_name(&hdev->dev)); */
=20
 	/* Setup keypad input device */
 	error =3D picolcd_init_keys(data, picolcd_in_report(REPORT_KEY_STATE,=
 hdev));
@@ -534,7 +534,7 @@ err:
=20
 static int picolcd_probe_bootloader(struct hid_device *hdev, struct pi=
colcd_data *data)
 {
-	int error;
+/*	int error;
=20
 	error =3D picolcd_check_version(hdev);
 	if (error)
@@ -542,7 +542,7 @@ static int picolcd_probe_bootloader(struct hid_devi=
ce *hdev, struct picolcd_data
=20
 	if (data->version[0] !=3D 1 && data->version[1] !=3D 0)
 		hid_info(hdev, "Device with untested bootloader revision, please sub=
mit /sys/kernel/debug/hid/%s/rdesc for this device.\n",
-			 dev_name(&hdev->dev));
+			 dev_name(&hdev->dev)); */
=20
 	picolcd_init_devfs(data, NULL, NULL,
 			picolcd_out_report(REPORT_BL_READ_MEMORY, hdev),
--=20
1.7.8.6
