From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 13/15] HID: hid-lg4ff: Allow the driver to continue without sysfs interface.
Date: Wed,  8 Apr 2015 22:56:51 +0200
Message-ID: <1428526613-24239-14-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imap.devoid-pointer.net ([31.31.77.140]:33004 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752AbbDHU52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:28 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Allow the driver to continue without sysfs interface. Instead of bailin=
g out
allow the driver to continue in a degraded mode.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index dcaf481..02cec83 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1229,15 +1229,14 @@ int lg4ff_init(struct hid_device *hid)
 	/* Create sysfs interface */
 	error =3D device_create_file(&hid->dev, &dev_attr_range);
 	if (error)
-		goto err_init;
+		hid_warn(hid, "Unable to create sysfs interface for \"range\", errno=
 %d\n", error);
 	if (mmode_ret =3D=3D LG4FF_MMODE_IS_MULTIMODE) {
 		error =3D device_create_file(&hid->dev, &dev_attr_real_id);
 		if (error)
-			goto err_init;
-
+			hid_warn(hid, "Unable to create sysfs interface for \"real_id\", er=
rno %d\n", error);
 		error =3D device_create_file(&hid->dev, &dev_attr_alternate_modes);
 		if (error)
-			goto err_init;
+			hid_warn(hid, "Unable to create sysfs interface for \"alternate_mod=
es\", errno %d\n", error);
 	}
 	dbg_hid("sysfs interface created\n");
=20
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
