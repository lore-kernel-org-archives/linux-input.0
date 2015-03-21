From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 10/12] HID: hid-lg4ff: Allow the driver to continue without sysfs interface.
Date: Sat, 21 Mar 2015 12:47:40 +0100
Message-ID: <1426938462-884-11-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Instead of aborting the initialization allow the driver to continue in
a degraded mode.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index ad959e2..5543728 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1226,19 +1226,14 @@ int lg4ff_init(struct hid_device *hid)
 	/* Create sysfs interface */
 	error =3D device_create_file(&hid->dev, &dev_attr_range);
 	if (error)
-		goto err_init;
+		hid_warn(hid, "Unable to create sysfs interface for \"range\", errno=
 %d\n", error);
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
 		error =3D device_create_file(&hid->dev, &dev_attr_real_id);
-		if (error) {
-			device_remove_file(&hid->dev, &dev_attr_range);
-			goto err_init;
-		}
+		if (error)
+			hid_warn(hid, "Unable to create sysfs interface for \"real_id\", er=
rno %d\n", error);
 		error =3D device_create_file(&hid->dev, &dev_attr_alternate_modes);
-		if (error) {
-			device_remove_file(&hid->dev, &dev_attr_real_id);
-			device_remove_file(&hid->dev, &dev_attr_range);
-			goto err_init;
-		}
+		if (error)
+			hid_warn(hid, "Unable to create sysfs interface for \"alternate_mod=
es\", errno %d\n", error);
 	}
 	dbg_hid("sysfs interface created\n");
=20
--=20
2.3.3
